create database BLMS;
use BLMS;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL
);
CREATE TABLE Accounts (
    account_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_type ENUM('Savings','Current','Loan') NOT NULL,
    balance DECIMAL(15,2) CHECK(balance >= 0),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT NOT NULL,
    loan_type ENUM('Personal','Home','Auto','Business') NOT NULL,
    principal_amount DECIMAL(15,2) CHECK(principal_amount > 0),
    interest_rate DECIMAL(5,2) CHECK(interest_rate > 0),
    start_date DATE NOT NULL,
    term_months INT CHECK(term_months > 0),
    status ENUM('Active','Closed','Default') DEFAULT 'Active',
    FOREIGN KEY (account_number) REFERENCES Accounts(account_number)
);
CREATE TABLE Collaterals (
    collateral_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    type ENUM('Property','Vehicle','Gold','Other') NOT NULL,
    value DECIMAL(15,2) CHECK(value >= 0),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT NOT NULL,
    transaction_type ENUM('Deposit','Withdrawal','Loan Disbursement','Repayment') NOT NULL,
    amount DECIMAL(15,2) CHECK(amount > 0),
    transaction_date DATE NOT NULL,
    FOREIGN KEY (account_number) REFERENCES Accounts(account_number)
);
CREATE TABLE Fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT,
    loan_id INT,
    fee_type ENUM('Overdraft','Late Repayment') NOT NULL,
    amount DECIMAL(10,2) CHECK(amount > 0),
    FOREIGN KEY (account_number) REFERENCES Accounts(account_number),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    branch_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);