-- QUERIES
-- Join queries
-- #1
select p.name, p.address, a.room_number, a.checkin_date, a.checkout_date
from patient p
join assigned_to a 
on p.patient_id = a.patient_id;

-- #2
select ph.name AS physician_name, pa.name AS patient_name, m.start_date, m.end_date
from physician ph
join monitors m 
on ph.physician_id = m.physician_id
join patient pa 
on m.patient_id = pa.patient_id;

-- #3
select o.physician_id, ph.name as physician_name, o.patient_id, i.description AS instruction_description, o.status
from orders o
join physician ph 
on o.physician_id = ph.physician_id
join instruction i 
on o.instruction_code = i.instruction_code;

-- #4
select n.name AS nurse_name, e.patient_id, i.description AS instruction_description, e.status
from executes e
join nurse n 
on e.nurse_id = n.nurse_id
join instruction i 
on e.instruction_code = i.instruction_code;

-- Aggregation Queries
-- #5
select room_number, COUNT(patient_id) AS patient_count
from assigned_to
group by room_number;

-- #6
select SUM(total_amount) AS total_invoice_amount
from invoice;

-- #7
select physician_id, COUNT(*) AS order_count
from orders
group by physician_id;

-- #8
SELECT AVG(fee) AS average_instruction_fee
FROM instruction;

-- Nested Queries
-- #9
SELECT name
FROM patient
WHERE patient_id IN (
    SELECT patient_id
    FROM monitors
    WHERE physician_id = (SELECT physician_id FROM physician WHERE name = 'Dr. Patel')
);

-- #10
SELECT name
FROM physician
WHERE physician_id NOT IN (
    SELECT physician_id
    FROM orders
    WHERE instruction_code = 'I002'
);

-- #11
SELECT name
FROM nurse
WHERE nurse_id IN (
    SELECT nurse_id
    FROM administers
    WHERE medication_id = 'Medication 1'
);

-- #12
SELECT room_number
FROM assigned_to
WHERE patient_id IN (
    SELECT patient_id
    FROM patient
    WHERE name LIKE 'A%'
);

-- Random Queries
-- #13
SELECT *
FROM healthrecord
WHERE patient_id = (SELECT patient_id FROM patient WHERE name = 'Jackie Chan');

-- #14
SELECT i.*, p.name AS patient_name
FROM invoice i
JOIN patient p ON i.patient_id = p.patient_id;

-- #15
SELECT *
FROM administers
WHERE status = 'Pending';

-- #16
SELECT *
FROM payment
WHERE date BETWEEN '2024-08-01' AND '2024-08-31';

-- #17
SELECT account_num, SUM(amount) AS total_payable
FROM payable
GROUP BY account_num;

-- #18
SELECT nurse_id, COUNT(*) AS instruction_count
FROM executes
GROUP BY nurse_id
ORDER BY instruction_count DESC
LIMIT 1;

-- #19
SELECT patient_id, COUNT(*) AS record_count
FROM healthrecord
GROUP BY patient_id
ORDER BY record_count DESC
LIMIT 1;

-- #20
SELECT *
FROM administers
WHERE type = 'Oral';

-- VIEWS
-- #1
CREATE VIEW patient_rooms as
SELECT patient.name as patient_name, assigned_to.room_number
FROM patient
JOIN assigned_to ON patient.patient_id = assigned_to.patient_id;

SELECT *
FROM patient_rooms;

-- #2
CREATE VIEW physician_order as
SELECT physician.name as physician_name, instruction.description, orders.status
FROM physician
JOIN orders ON physician.physician_id = orders.physician_id
JOIN instruction ON orders.instruction_code = instruction.instruction_code;

SELECT *
FROM physician_order;

-- #3
CREATE VIEW patient_balance as
SELECT patient.name as patient_name, SUM(invoice.total_amount) - SUM(payment.amount) as balance
FROM patient
LEFT JOIN invoice ON patient.patient_id = invoice.patient_id
LEFT JOIN payment ON invoice.patient_id = payment.patient_id
GROUP BY patient.name;

SELECT *
FROM patient_balance;

-- TRIGGERS
-- #1
DELIMITER //
CREATE TRIGGER update_invoice_total
AFTER INSERT ON payable
FOR EACH ROW
BEGIN
    UPDATE invoice
    SET total_amount = total_amount + NEW.amount
    WHERE account_num = NEW.account_num;
END;
//
DELIMITER ;

-- #2
DELIMITER //
CREATE TRIGGER check_patient_checkin
BEFORE INSERT ON assigned_to
FOR EACH ROW
BEGIN
    IF EXISTS ( SELECT * 
        FROM assigned_to 
        WHERE patient_id = NEW.patient_id 
        AND checkout_date > NEW.checkin_date
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Patient already assigned to a room during this period';
    END IF;
END; //
DELIMITER ;

-- #3
DELIMITER //
CREATE TRIGGER update_status_to_not_completed
BEFORE UPDATE ON executes
FOR EACH ROW
BEGIN
    IF OLD.status = 'Completed' AND NEW.status != 'Completed' THEN
        SET NEW.status = 'Not Completed';
    END IF;
END; //
DELIMITER ;


-- TRANSACTIONS
-- #1
START TRANSACTION;
INSERT INTO patient (patient_id, name, address, phone)
VALUES (006, 'Bruce Wayne', '1007 Mountain Drive', '555-123-4567');

INSERT INTO assigned_to (patient_id, room_number, checkin_date, checkout_date)
VALUES (006, 11, '2024-07-26', '2024-07-27'); -- Providing a temporary checkout date
INSERT INTO invoice (account_num, patient_id, issue_date, start_date, end_date, total_amount)
VALUES (1006, 006, '2024-07-26', '2024-07-26', '2024-07-27', 0); 
COMMIT;

-- #2
START TRANSACTION;
INSERT INTO executes (nurse_id, patient_id, instruction_code, status)
VALUES (7, 006, 'I002', 'Completed');
UPDATE invoice
SET total_amount = total_amount + (SELECT fee FROM instruction WHERE instruction_code = 'I002')
WHERE account_num = 1006;
COMMIT;

