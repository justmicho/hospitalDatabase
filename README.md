# Hospital Management Database Schema

This project defines a comprehensive relational database schema for managing hospital operations, patient care, staff assignments, financial transactions, and medical processes using **MySQL**.

---

## Overview

The schema is designed to support the key activities of a hospital, including:
- Patient registration and health records
- Room assignments
- Nurse and physician management
- Medication administration
- Instructions and procedures
- Financial operations (invoices, payables, payments)

---

## Database Structure

### Core Entities
- `patient`: Stores patient demographic and contact information.
- `physician`: Contains details about hospital physicians, including certification and specialties.
- `nurse`: Contains nurse details and credentials.
- `room`: Represents available hospital rooms and their capacity and rates.
- `medication`: Lists medication administered to patients.
- `instruction`: Stores medical procedures or instructions, including fees.

### Operational Records
- `healthrecord`: Tracks patient diseases, diagnoses, and condition status.
- `assigned_to`: Logs patient check-in/check-out and room assignments.
- `monitors`: Logs physician oversight periods for patients.
- `executes`: Tracks which nurses carry out which instructions on which patients.
- `administers`: Records nurse-administered medications with dosages and instructions.
- `orders`: Tracks physician-ordered procedures for patients.

### Financial Transactions
- `invoice`: Manages patient billing including time periods and amounts.
- `payable`: Tracks individual charges related to invoices.
- `payment`: Records patient payments and dates.

---

## Setup Instructions

1. Open your MySQL client or terminal.
2. Run the script in your MySQL environment:
   ```sql
   SOURCE hospital_schema.sql;
