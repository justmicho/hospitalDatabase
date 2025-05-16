insert into room (room_number, capacity, nightly_fee) values 
(10, 2, 1000),
(11, 1, 750),
(12, 1, 750),
(13, 3, 1200),
(14, 2, 1000);

insert into patient (patient_id, name, address, phone) values 
(001, 'Jackie Chan', '123 Main St', '999-888-7777'),
(002, 'Angelina Jolie', '456 Oak St', '777-888-9999'),
(003, 'Jet Li', '789 Pine St', '888-888-7777'),
(004, 'Cristiano Ronaldo', '321 Cedar St', '777-777-5555'),
(005, 'Lionel Messi', '654 Maple St', '555-123-3221');

INSERT INTO physician (physician_id, name, certification_number, field_of_expertise, address, phone_number)
VALUES 
(1, 'Dr. Patel', 12345, 'Cardiology', '123 Doctor St', '555-444-3333'),
(2, 'Dr. White', 17890, 'Neurology', '456 Doctor Ave', '555-333-4444'),
(3, 'Dr. Brown', 14321, 'Pediatrics', '789 Doctor Blvd', '555-777-2222'),
(4, 'Dr. Black', 18765, 'Orthopedics', '321 Doctor Rd', '555-999-8888'),
(5, 'Dr. Green', 11223, 'Dermatology', '654 Doctor Ln', '555-111-2222');

INSERT INTO nurse (nurse_id, certification_number, name, address, phone_number)
VALUES 
(6, 22345, 'Joy', '123 Nurse St', '555-123-4567'),
(7, 27890, 'Bell','456 Nurse Ave', '555-987-6543'),
(8, 24321, 'Jane','789 Nurse Blvd', '555-654-3210'),
(9, 28765, 'Jackson','321 Nurse Rd', '555-112-2334'),
(10, 21223,'Walker', '654 Nurse Ln', '555-443-3221');

INSERT INTO medication (medication_id)
VALUES 
('Medication 1'),
('Medication 2'),
('Medication 3'),
('Medication 4'),
('Medication 5');

INSERT INTO invoice (account_num, patient_id, issue_date, start_date, end_date, total_amount)
VALUES 
(1001, 001, '2024-07-01', '2024-06-25', '2024-06-30', 2000),
(1002, 002, '2024-07-02', '2024-06-20', '2024-06-29', 1500),
(1003, 003, '2024-07-03', '2024-06-15', '2024-06-25', 3000),
(1004, 004, '2024-07-04', '2024-06-10', '2024-06-20', 1000),
(1005, 005, '2024-07-05', '2024-06-05', '2024-06-15', 4000);

INSERT INTO instruction (instruction_code, description, fee)
VALUES 
('I001', 'Blood Test', 50),
('I002', 'X-Ray', 100),
('I003', 'MRI', 300),
('I004', 'CT Scan', 200),
('I005', 'Ultrasound', 150);

INSERT INTO payable (payable_id, account_num, date, description, amount)
VALUES 
(0001, 1001, '2024-08-01', 'Service Fee', 250),
(0002, 1002, '2024-08-02', 'Medication Fee', 350),
(0003, 1003, '2024-08-03', 'Room Fee', 500),
(0004, 1004, '2024-08-04', 'Consultation Fee', 100),
(0005, 1005, '2024-08-05', 'Procedure Fee', 450);

INSERT INTO healthrecord (record_id, patient_id, disease, diagnosis_date, status, description)
VALUES 
(001, 001, 'Flu', '2024-06-20', 'Recovered', 'Flu symptoms, treated with rest'),
(002, 002, 'Asthma', '2024-06-15', 'Stable', 'Asthma management with inhalers'),
(003, 003, 'Diabetes', '2024-06-10', 'Under Control', 'Diabetes management with insulin'),
(004, 004, 'Hypertension', '2024-06-05', 'Under Control', 'Blood pressure management with medication'),
(005, 005, 'Allergy', '2024-06-01', 'Recovered', 'Allergy treatment with alegra');

INSERT INTO payment (payment_id, patient_id, date, amount)
VALUES 
(01, 001, '2024-08-01', 500),
(02, 002, '2024-08-02', 300),
(03, 003, '2024-08-03', 450),
(04, 004, '2024-08-04', 600),
(05, 005, '2024-08-05', 700);

INSERT INTO assigned_to (patient_id, room_number, checkin_date, checkout_date)
VALUES 
(001, 10, '2024-06-25', '2024-06-30'),
(002, 11, '2024-06-20', '2024-06-29'),
(003, 12, '2024-06-15', '2024-06-25'),
(004, 13, '2024-06-10', '2024-06-20'),
(005, 14, '2024-06-05', '2024-06-15');

INSERT INTO monitors (physician_id, patient_id, start_date, end_date)
VALUES 
(1, 001, '2024-06-25', '2024-06-30'),
(2, 002, '2024-06-20', '2024-06-29'),
(3, 003, '2024-06-15', '2024-06-25'),
(4, 004, '2024-06-10', '2024-06-20'),
(5, 005, '2024-06-05', '2024-06-15');

INSERT INTO executes (nurse_id, patient_id, instruction_code, status)
VALUES 
(6,  001, 'I001', 'Completed'),
(7,  002, 'I002', 'Completed'),
(8,  003, 'I003', 'Completed'),
(9,  004, 'I004', 'Completed'),
(10, 005, 'I005', 'Completed');

INSERT INTO administers (nurse_id, patient_id, medication_id, administration_date, type, amount, instruction_code, status)
VALUES 
(6, 001, 'Medication 1', '2024-06-25', 'Oral', 1, 'I001', 'Completed'),
(7, 002, 'Medication 2', '2024-06-20', 'Injection', 2, 'I002', 'Pending'),
(8, 003, 'Medication 3', '2024-06-15', 'Oral', 1, 'I003', 'Completed'),
(9, 004, 'Medication 4', '2024-06-10', 'Oral', 1, 'I004', 'Completed'),
(10, 005, 'Medication 5', '2024-06-05', 'Injection', 2, 'I005', 'Pending');

INSERT INTO orders (physician_id, patient_id, instruction_code, status)
VALUES 
(1, 001, 'I001', 'Ordered'),
(2, 002, 'I002', 'Ordered'),
(3, 003, 'I003', 'Ordered'),
(4, 004, 'I004', 'Ordered'),
(5, 005, 'I005', 'Ordered');