CREATE DATABASE IF NOT EXISTS ksfe;
USE ksfe;

CREATE TABLE Customer (
    name VARCHAR(20),
    adhNo CHAR(12) PRIMARY KEY,
    panNo VARCHAR(10),
    mobileNo CHAR(10),
    address VARCHAR(50),
    emailId VARCHAR(20)
);

CREATE TABLE Chitty (
    chittyNo INT,
    chittyBranch VARCHAR(255),
    chittyAmount INT,
    startDate DATE,
    no_of_Install INT,
    chittyStatus VARCHAR(10),
    PRIMARY KEY (chittyNo, chittyBranch)
);

CREATE TABLE Loan (
    loanNo INT,
    loanType VARCHAR(20),
    adhNo CHAR(12),
    chittyNo INT,
    loanAmount INT,
    loanPeriod VARCHAR(10),
    EMI INT,
    PRIMARY KEY (loanNo, chittyNo, adhNo),
    FOREIGN KEY (adhNo) REFERENCES Customer (adhNo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (chittyNo) REFERENCES Chitty (chittyNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Customer_chitty (
    adhNo CHAR(12),
    chittyBranch VARCHAR(255),
    chittyNo INT,
    chittalNo INT PRIMARY KEY,
    FOREIGN KEY (adhNo) REFERENCES Customer (adhNo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (chittyNo, chittyBranch) REFERENCES Chitty (chittyNo, chittyBranch) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Chitty_payment (
    chittyNo INT,
    chittalNo INT,
    chittyBranch VARCHAR(255),
    paymentStatus ENUM ('paid', 'not paid') NOT NULL,
    paidAmount INT NOT NULL,
    paymentDate DATE NOT NULL,
    paymentMode VARCHAR(50) NOT NULL,
    paymentBranch VARCHAR(255) NOT NULL,
    PRIMARY KEY (chittyNo, chittalNo, chittyBranch, paymentDate),
    FOREIGN KEY (chittyNo, chittyBranch) REFERENCES Chitty (chittyNo, chittyBranch) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (chittalNo) REFERENCES Customer_chitty (chittalNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Chitty_auction (
    adhNo CHAR(12),
    chittyNo INT,
    chittalNo INT,
    chittyBranch VARCHAR(255),
    auctionAmount INT,
    PRIMARY KEY (adhNo, chittyNo, chittalNo, chittyBranch),
    FOREIGN KEY (adhNo) REFERENCES Customer (adhNo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (chittalNo) REFERENCES Customer_chitty (chittalNo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (chittyNo, chittyBranch) REFERENCES Chitty (chittyNo, chittyBranch) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Loan_payment (
    adhNo CHAR(12),
    loanNo INT NOT NULL,
    loanBranch VARCHAR(255) NOT NULL,
    loanAmount INT NOT NULL,
    paymentDate DATE NOT NULL,
    paymentBranch VARCHAR(255) NOT NULL,
    PRIMARY KEY (adhNo, loanNo, loanBranch, paymentDate),
    FOREIGN KEY (adhNo) REFERENCES Customer (adhNo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (loanNo) REFERENCES Loan (loanNo) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Customer (name, adhNo, panNo, mobileNo, address, emailId) VALUES 
    ("Sanjay", "9876543210", "ABCD159", "9505248620", "House no 22 xyz street", "sanjay@gmail.com"),
    ("Ravi", "1234567890", "EFGH456", "9845123456", "Apartment 12 abc avenue", "ravi@gmail.com"),
    ("Anjali", "1122334455", "IJKL789", "9876543210", "Villa 7 qwe road", "anjali@gmail.com"),
    ("Vikram", "6677889900", "MNOP123", "9123456780", "Plot 56 pqr lane", "vikram@gmail.com"),
    ("Athul", "5544332211", "QRST456", "8998765432", "Flat 22 stu street", "neha@gmail.com"),
    ("Gautham", "4455667788", "UVWX789", "9345678123", "House 9 vwx avenue", "priya@gmail.com");

INSERT INTO Chitty VALUES 
    (21, "Haripad", 50000, '2023-10-01', 30, 'not closed'),
    (10, "Haripad", 10000, '2023-10-01', 20, 'not closed'),
    (1, "Haripad", 10000, '2023-10-05', 25, 'not closed'),
    (5, "Haripad", 15000, '2023-10-20', 28, 'closed');

INSERT INTO Loan VALUES 
    (1, 'Home Loan', "9876543210", 1, 200000, "150 days", 10000),
    (15, 'Business Loan', "1122334455", 1, 500000, "300 days", 10000),
    (20, 'Business Loan', "4455667788", 1, 500000, "300 days", 10000),
    (1, "Car Loan", "6677889900", 10, 500000, "300 days", 10000);

INSERT INTO Customer_chitty (adhNo, chittyBranch, chittyNo, chittalNo) VALUES
    ('9876543210', 'Haripad', 21, 1001),
    ('1234567890', 'Haripad', 10, 1002),
    ('1122334455', 'Haripad', 1, 1003),
    ('6677889900', 'Haripad', 5, 1004),
    ('5544332211', 'Haripad', 21, 1005),
    ('4455667788', 'Haripad', 10, 1006); 

INSERT INTO Chitty_payment (chittyNo, chittalNo, chittyBranch, paymentStatus, paidAmount, paymentDate, paymentMode, paymentBranch) VALUES
    (21, 1001, 'Haripad', 'paid', 5000, '2023-10-10', 'Online', 'Haripad'),
    (10, 1002, 'Haripad', 'not paid', 0, '2023-10-15', 'Cash', 'Haripad'),
    (1, 1003, 'Haripad', 'paid', 2000, '2023-10-20', 'Bank Transfer', 'Haripad'),
    (5, 1004, 'Haripad', 'paid', 3000, '2023-10-25', 'Cheque', 'Haripad'),
    (21, 1005, 'Haripad', 'paid', 5000, '2023-11-10', 'Online', 'Haripad'),
    (10, 1006, 'Haripad', 'not paid', 0, '2023-11-15', 'Cash', 'Haripad'); 

INSERT INTO Chitty_auction (adhNo, chittyNo, chittalNo, chittyBranch, auctionAmount) VALUES
    ('9876543210', 21, 1001, 'Haripad', 45000),
    ('1234567890', 10, 1002, 'Haripad', 9000),
    ('1122334455', 1, 1003, 'Haripad', 8500),
    ('6677889900', 5, 1004, 'Haripad', 14000),
    ('5544332211', 21, 1005, 'Haripad', 46000),
    ('4455667788', 10, 1006, 'Haripad', 9500);    

INSERT INTO Loan_payment (adhNo, loanNo, loanBranch, loanAmount, paymentDate, paymentBranch) VALUES
    ('9876543210', 1, 'Haripad', 200000, '2023-11-01', 'Haripad'),
    ('1122334455', 15, 'Haripad', 500000, '2023-11-05', 'Haripad'),
    ('4455667788', 20, 'Haripad', 500000, '2023-11-10', 'Haripad'),
    ('6677889900', 1, 'Haripad', 500000, '2023-11-15', 'Haripad'),
    ('9876543210', 1, 'Haripad', 200000, '2023-12-01', 'Haripad'),
    ('1122334455', 15, 'Haripad', 500000, '2023-12-05', 'Haripad');    

SELECT * FROM Customer;
SELECT * FROM Chitty;
SELECT * FROM Loan;
SELECT * FROM Customer_chitty;
SELECT * FROM Chitty_payment;
SELECT * FROM Chitty_auction;
SELECT * FROM Loan_payment;

#Loan as well as chitty
SELECT DISTINCT Customer.* FROM Customer
JOIN Customer_chitty ON Customer.adhNo = Customer_chitty.adhNo
JOIN Loan ON Customer.adhNo = Loan.adhNo;

SELECT DISTINCT Customer.*
FROM Customer
JOIN Customer_chitty ON Customer.adhNo = Customer_chitty.adhNo
LEFT JOIN Loan ON Customer.adhNo = Loan.adhNo
WHERE Loan.adhNo IS NULL;

SELECT Customer.*
FROM Customer
JOIN Loan ON Customer.adhNo = Loan.adhNo
ORDER BY Loan.loanAmount DESC;

SELECT Loan_payment.loanBranch, Loan.loanType, COUNT(*) AS No_of_Loans
FROM Loan_payment , Loan
GROUP BY Loan_payment.loanBranch, Loan.loanType;

SELECT DISTINCT C.*
FROM Customer C
JOIN Customer_chitty CC ON C.adhNo = CC.adhNo
JOIN Chitty_payment CP ON CC.chittalNo = CP.chittalNo
JOIN Chitty ON CC.chittyNo = Chitty.chittyNo AND CC.chittyBranch = Chitty.chittyBranch
WHERE CP.paymentBranch <> Chitty.chittyBranch;

DROP DATABASE ksfe;
