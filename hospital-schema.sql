DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

DROP TABLE IF EXISTS  payable CASCADE;
DROP TABLE IF EXISTS  invoice CASCADE;
DROP TABLE IF EXISTS  nurse CASCADE; 
DROP TABLE IF EXISTS  medication CASCADE;
DROP TABLE IF EXISTS  patient CASCADE;
DROP TABLE IF EXISTS  payment CASCADE;
DROP TABLE IF EXISTS  healthrecord CASCADE;
DROP TABLE IF EXISTS  physician CASCADE;
DROP TABLE IF EXISTS  instruction CASCADE;
DROP TABLE IF EXISTS  room CASCADE;
DROP TABLE IF EXISTS  assigned_to CASCADE;
DROP TABLE IF EXISTS  monitors CASCADE;
DROP TABLE IF EXISTS  executes CASCADE;
DROP TABLE IF EXISTS  administers CASCADE;
DROP TABLE IF EXISTS  orders CASCADE;

CREATE TABLE patient (
	patient_id 	INT NOT NULL,
	name 	  	CHAR(50) NOT NULL,
    address 	CHAR(50) NOT NULL,
	phone  		CHAR(15) NOT NULL,
	PRIMARY KEY (patient_id)
);
CREATE TABLE room (
	room_number 	  	INT NOT NULL,
	capacity  			INT NOT NULL,
	nightly_fee 		INT NOT NULL,
	PRIMARY KEY (room_number)
);
CREATE TABLE physician  (
	physician_id 			INT NOT NULL,
	name  					CHAR(50) NOT NULL,
    certification_number 	INT NOT NULL,
    field_of_expertise 		CHAR(50) NOT NULL,
    address 				CHAR(50) NOT NULL,
    phone_number 			CHAR(15) NOT NULL,
    PRIMARY KEY(physician_id)
);
CREATE TABLE nurse (
	nurse_id 	  	        INT NOT NULL,
    name 					CHAR(50),
	certification_number    INT NOT NULL,
    address                 CHAR(50) NOT NULL,
    phone_number            CHAR(15),
    PRIMARY KEY(nurse_id)
);
CREATE TABLE instruction (
	instruction_code        CHAR(20) NOT NULL,
	description             CHAR(250) NOT NULL,
    fee                     INT NOT NULL,
	PRIMARY KEY (instruction_code)
);
CREATE TABLE medication (
	medication_id 	  	CHAR(50) NOT NULL,
	PRIMARY KEY (medication_id)
);
CREATE TABLE healthrecord  (
	record_id 	  		INT NOT NULL,
	patient_id  		INT NOT NULL,
    disease 			CHAR(50) NOT NULL,
    diagnosis_date 		DATE NOT NULL,
    status 				CHAR(20) NOT NULL,
    description 		CHAR(250) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
	PRIMARY KEY (record_id, patient_id)
);
CREATE TABLE invoice (
	account_num 	 INT NOT NULL,
	patient_id  	 INT NOT NULL,
    issue_date 		 DATE NOT NULL,
    start_date 		 DATE NOT NULL,
    end_date 		 DATE NOT NULL,
    total_amount 	 INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
	PRIMARY KEY (account_num)
);
CREATE TABLE payable (
	payable_id          INT NOT NULL,
    account_num         INT NOT NULL,
	date 	            DATE,
	description         CHAR(250) NOT NULL,
    amount              INT NOT NULL,
    FOREIGN KEY (account_num) REFERENCES invoice(account_num),
	PRIMARY KEY (payable_id)
);
CREATE TABLE payment (
	payment_id 		INT NOT NULL,
	patient_id 		INT NOT NULL,
    date 			DATE NOT NULL,
    amount 			INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
	PRIMARY KEY (payment_id)
);
CREATE TABLE assigned_to (
	patient_id 		INT NOT NULL,
	room_number 	INT NOT NULL,
    checkin_date 	DATE NOT NULL,
    checkout_date 	DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
	FOREIGN KEY (room_number) REFERENCES room(room_number),
	PRIMARY KEY (patient_id, room_number, checkin_date)
);
CREATE TABLE monitors (
	physician_id 	INT NOT NULL,
	patient_id 		INT NOT NULL,
    start_date 		DATE NOT NULL,
    end_date 		DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
	FOREIGN KEY (physician_id) REFERENCES physician(physician_id),
	PRIMARY KEY (physician_id, patient_id)
);
CREATE TABLE executes (
	nurse_id            INT NOT NULL,
	patient_id          INT NOT NULL,
    instruction_code    CHAR(20) NOT NULL,
    status              CHAR(20) NOT NULL,
    FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id),
	FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (instruction_code) REFERENCES instruction(instruction_code),
	PRIMARY KEY (nurse_id, patient_id, instruction_code)
);
CREATE TABLE administers (
	nurse_id                INT NOT NULL,
	patient_id              INT NOT NULL,
    medication_id           CHAR(50) NOT NULL,
    administration_date     DATE NOT NULL,
    type                    CHAR(10) NOT NULL, 
    amount                  INT NOT NULL,
    instruction_code        CHAR(20) NOT NULL,
    status                  CHAR(20) NOT NULL,
    FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id),
	FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (medication_id) REFERENCES medication(medication_id),
	PRIMARY KEY (nurse_id, patient_id, medication_id, administration_date)
);
CREATE TABLE orders (
	physician_id        INT NOT NULL,
	patient_id          INT NOT NULL, 
    instruction_code    CHAR(20) NOT NULL,
    status              CHAR(20) NOT NULL,
    FOREIGN KEY (physician_id) REFERENCES physician(physician_id),
	FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (instruction_code) REFERENCES instruction(instruction_code),
	PRIMARY KEY (physician_id, patient_id, instruction_code)
);


