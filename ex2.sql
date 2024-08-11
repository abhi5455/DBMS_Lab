CREATE DATABASE Laboratory;
USE Laboratory;

CREATE TABLE Employee(
    Name VARCHAR(50),
    address VARCHAR(100),
    adhNo VARCHAR(12),
    mobile BIGINT,
    email VARCHAR(50),
    PRIMARY KEY (adhNo)
);

CREATE TABLE Test(
    Test_name VARCHAR(20),
    Test_Desc VARCHAR(1000),
    PRIMARY KEY (Test_name)
);

CREATE TABLE Patients(
    Name VARCHAR(50),
    address VARCHAR(100),
    adhNo VARCHAR(12),
    age INT,
    mobile BIGINT,
    email VARCHAR(50),
    PRIMARY KEY (adhNo)
);

CREATE TABLE Scan(
    Scan_name VARCHAR(20),
    Scan_Desc VARCHAR(1000),
    PRIMARY KEY (Scan_name)
);

CREATE TABLE Doctor(
    Name VARCHAR(50),
    adhNo VARCHAR(12),
    address VARCHAR(100),
    Spec VARCHAR(20),
    Hospital_name VARCHAR(50),
    PRIMARY KEY (adhNo)
);

CREATE TABLE Patients_test(
    Patient_adhNo VARCHAR(12),
    Test_name VARCHAR(20),
    Doct_adhNo VARCHAR(12),
    Test_date DATE,
    Amount BIGINT,
    PRIMARY KEY (Patient_adhNo, Test_name, Test_date, Doct_adhNo),
    FOREIGN KEY (Patient_adhNo) REFERENCES Patients(adhNo),
    FOREIGN KEY (Test_name) REFERENCES Test(Test_name),
    FOREIGN KEY (Doct_adhNo) REFERENCES Doctor(adhNo)
);

CREATE TABLE Patients_scan(
    Patient_adhNo VARCHAR(12),
    Scan_name VARCHAR(20),
    Scan_date DATE,
    Doct_adhNo VARCHAR(12),
    Amount BIGINT,
    presc_path VARCHAR(50),
    result_path VARCHAR(50),
    PRIMARY KEY (Patient_adhNo, Scan_name, Scan_date, Doct_adhNo),
    FOREIGN KEY (Patient_adhNo) REFERENCES Patients(adhNo),
    FOREIGN KEY (Scan_name) REFERENCES Scan(Scan_name),
    FOREIGN KEY (Doct_adhNo) REFERENCES Doctor(adhNo)
);

INSERT INTO Employee VALUES
    ("Arun","Flat No 12, Girinagar Street","622547891234",9587652314,"arun@gmail.com"),
    ("Sanjay","Flat No 15, Girinagar Street","625784931245",9275146312,"sanjay@gmail.com"),
    ("Hima","Flat No 11, Gandhinagar 2nd Street","622547782114",9227546310,"hima@gmail.com"),
    ("Elizabeth","Flat No 22, Gandhinagar 2nd Street","622478579645",9110205355,"elizabeth@gmail.com"),
    ("Abhijith","Flat No 17, Girinagar Street","759123456874",9192954563,"abhijith@gmail.com");

INSERT INTO Test VALUES
    ("Blood Test","Analyze various components of Blood such as rbc, wbc, platelets, diagnose conditions like anemia, infections, etc."),
    ("Urinanalysis","Examines the physical, chemical, and microscopic properties of urine to assess kidney function and detect diseases."),
    ("Genetic Testing","Analyzing DNA to detect genetic disorders, mutations, or predispositions to certain diseases."),
    ("Biopsy","Involves taking a sample tissue from the body for examination to diagnose diseases like cancer or inflammatory conditions."),
    ("Allergy Testing","Identifies allergens by exposing the patients to various substances and monitoring reactions, helping diagnose allergies and sensitivities.");

INSERT INTO Patients VALUES
    ("Adwaith","Flat no 15, Vyasanagar colony","111111111111",25,9854623174,"adwaith@gmail.com"),
    ("Akshay","Flat No 10, ABX street","121212121212",31,9100121475,"akshay@gmail.com"),
    ("Fidha","Flat No 17, JSX street","323232323232",35,9100121475,"fidha@gmail.com"),
    ("Amrutha","Flat No 22, JSX street","757575757575",40,7895552422,"amrutha@gmail.com"),
    ("Dipesh","Flat No 25, JSW street","545454545454",51,7584961200,"dipesh@gmail.com");

INSERT INTO Scan VALUES
    ("X-Ray","Uses EM radiation to create images of the inside of the body, particularly bones and dense tissues."),
    ("MRI","Uses strong magnetic fields and radio waves to create detailed images of soft tissues, including brain, muscles, and organs."),
    ("Ultrasound","Utilizes high-frequency sound waves to produce images of organs and structures inside the body."),
    ("Bone Scan","Involves injecting a radioactive tracer that accumulates in areas of high bone activity, allowing for the detection of bone diseases and cancers."),
    ("Mammography","A specialized X-ray technique used to screen for and diagnose breast abnormalities, including tumors and cysts.");

INSERT INTO Doctor VALUES
    ("Kiran","102030405060","Mundakkal House","Pulmonologist","Amirtha Hospital"),
    ("Sahadevan","112131415161","Moolamkuzhiyil House","Dentist","Kottayam General Hospital"),
    ("Radhika","122232425262","Flat No 15 XYZ Street","Cardiologist","Kottayam General Hospital"),
    ("Rajesh","234567890123","Gokulam House","Pediatrician","Little Hearts Clinic"),
    ("Nandini","345678901234","Kairali House","Gynecologist","Shine Hospital"),
    ("Suresh","456789012345","Vijayan House","Surgeon","Prime Care Hospital"),
    ("Divya","567890123456","Sasthamcotta House","Ophthalmologist","Vision Plus Clinic"),
    ("Ravi","678901234567","Ganga House","Dermatologist","Clear Skin Center");

INSERT INTO Patients_test VALUES
    ("111111111111","Blood Test","102030405060",'2024-08-05',300),
    ("323232323232","Blood Test","122232425262",'2024-08-20',300),
    ("121212121212","Biopsy","112131415161",'2024-09-11',1000),
    ("121212121212","Blood Test","112131415161",'2024-10-1',300),
    ("323232323232","Urinanalysis","122232425262",'2024-08-20',250),
    ("757575757575","Genetic Testing","345678901234",'2024-09-10',800),
    ("545454545454","Allergy Testing","678901234567",'2024-08-25',1000),
    ("121212121212","Allergy Testing","112131415161",'2024-09-11',1000),
    ("111111111111","Biopsy","102030405060",'2024-09-15',1000);


INSERT INTO Patients_scan VALUES
    ("111111111111","MRI",'2024-10-15',"122232425262",2000,"./result1","./description1"),
    ("757575757575","MRI",'2024-10-15',"122232425262",2000,"./result1","./description1"),
    ("545454545454","Bone Scan",'2024-11-02',"112131415161",1500,"./result2","./description2"),
    ("545454545454","Bone Scan",'2024-11-05',"112131415161",1500,"./result2","./description2"),
    ("121212121212","Ultrasound",'2024-09-20',"345678901234",5000,"./result3","./description3"),
    ("323232323232","X-Ray",'2024-10-05',"678901234567",1000,"./result4","./description4"),
    ("757575757575","MRI",'2024-10-22',"102030405060",2000,"./result5","./description5"),
    ("121212121212","Ultrasound",'2024-12-01',"456789012345",5000,"./result10","./description10"),
    ("121212121212","MRI",'2024-12-25',"456789012345",2000,"./result12","./description10"),
    ("121212121212","Ultrasound",'2024-12-11',"456789012345",5000,"./result10","./description10"),
    ("111111111111","Bone Scan",'2024-12-10',"567890123456",1500,"./result11","./description11");


SELECT * FROM Employee;
SELECT * FROM Test;
SELECT * FROM Patients;
SELECT * FROM Scan;
SELECT * FROM Doctor;
SELECT * FROM Patients_test;
SELECT * FROM Patients_scan;

-- (a)

SELECT Test_name,Amount,Test_date
FROM Patients_test as pt
WHERE pt.Patient_adhNo="121212121212" and Test_date between '2024-08-01' and '2024-11-22';

-- (b)

SELECT pt.Test_name,p.*
FROM Patients_test as pt JOIN Patients as p
ON p.adhNo=pt.Patient_adhNo
ORDER BY pt.Test_name;

-- (c)(1)

WITH TestCounts AS(
    SELECT pt.Test_name, COUNT(pt.Test_name) AS Test_Count
    FROM Patients_test AS pt
    GROUP BY pt.Test_name
),
MaxCount AS(
    SELECT MAX(Test_Count) AS Max_Count
    FROM TestCounts
)
SELECT tc.Test_name, tc.Test_Count as Max_Count
From TestCounts AS tc JOIN MaxCount AS mc
WHERE (tc.Test_Count=mc.Max_Count);

-- (c)(2)

WITH TestCounts AS(
    SELECT pt.Test_name,COUNT(pt.Test_name) AS Test_Count
    FROM Patients_test AS pt
    GROUP BY pt.Test_name
),
MinCount AS(
    SELECT MIN(Test_Count) AS Min_Count
    FROM TestCounts
)
SELECT tc.Test_name, tc.Test_Count AS Min_Count
From TestCounts AS tc JOIN MinCount AS mc
WHERE tc.Test_Count = mc.Min_Count;

-- (d)

WITH ScanCounts AS(
    SELECT ps.Patient_adhNo,ps.Scan_name, COUNT(ps.Scan_name) AS Scan_Count
    FROM Patients_scan AS ps
    GROUP BY ps.Patient_adhNo, ps.Scan_name
),
Exception AS(
    SELECT sc.Patient_adhNo
    FROM ScanCounts AS sc
    WHERE sc.Scan_Count > 2
),
Derrived AS(SELECT DISTINCT sc.Patient_adhNo AS adhNo
FROM ScanCounts AS sc JOIN Exception AS e
ON sc.Patient_adhNo <> e.Patient_adhNo
)
SELECT pt.Test_name, p.*
FROM Patients_test pt JOIN Derrived d JOIN Patients AS p
ON pt.Patient_adhNo=d.adhNo AND d.adhNo=p.adhNo;

-- (e)(1)

SELECT pt.Test_name, pt.Amount, COUNT(pt.Test_name) AS Test_Count, COUNT(pt.Test_name) * pt.Amount AS Test_Revenue
FROM Patients_test AS pt
GROUP BY pt.Test_name, pt.Amount;

-- (e)(2)

SELECT ps.Scan_name, ps.Amount,  COUNT(ps.Scan_name)AS Scan_Count, COUNT(ps.Scan_name) * ps.Amount AS Scan_Revenue
FROM Patients_scan AS ps
GROUP BY ps.Scan_name,ps.Amount;

-- (g)(1)

WITH Doct AS(
    SELECT pt.Doct_adhNo, COUNT(pt.Doct_adhNo) AS Doct_Count
    FROM Patients_test AS pt
    WHERE pt.Test_date between '2023-01-01' AND '2024-11-05'
    GROUP BY pt.Doct_adhNo
),
Max_Count AS(
    SELECT MAX(Doct_Count) AS Max_Count
    FROM Doct
),
DoctID AS(
    SELECT d.Doct_adhNo, mc.Max_Count AS Max_Count
    FROM Doct AS d JOIN Max_Count AS mc
    WHERE d.Doct_Count= mc.Max_Count
)
SELECT d.*, di.Max_Count AS Test_Count
FROM Doctor AS d JOIN DoctID AS di
ON d.adhNo = di.Doct_adhNo;

-- (g)(2)

WITH Doct AS(
    SELECT pt.Doct_adhNo, COUNT(pt.Doct_adhNo) AS Doct_Count
    FROM Patients_test AS pt
    WHERE pt.Test_date between '2023-01-01' AND '2024-08-28'
    GROUP BY pt.Doct_adhNo
),
Min_Count AS(
    SELECT MIN(Doct_Count) AS Min_Count
    FROM Doct
),
DoctID AS(
    SELECT d.Doct_adhNo, mc.Min_Count
    FROM Doct AS d JOIN Min_Count AS mc
    ON d.Doct_Count = mc.Min_Count
)
SELECT d.*, di.Min_Count AS Scan_Count
FROM DoctID AS di JOIN Doctor AS d
ON d.adhNo = di.Doct_adhNo;


-- (h)

WITH Doct_Test AS (
    SELECT pt.Doct_adhNo, pt.Test_name, COUNT(pt.Test_name) * pt.Amount AS Revenue
    FROM Patients_test AS pt
    GROUP BY pt.Doct_adhNo, pt.Test_name, pt.Amount
),
Doct_Test_Rev AS (
    SELECT Doct_adhNo,SUM(Revenue) AS Test_Revenue
    FROM Doct_Test
    GROUP BY Doct_Test.Doct_adhNo
),
Doct_Scan AS (
    SELECT ps.Doct_adhNo, COUNT(ps.Scan_name) * ps.Amount AS Revenue
    FROM Patients_scan AS ps
    GROUP BY ps.Doct_adhNo, ps.Scan_name, ps.Amount
),
Doct_Scan_Rev AS(
    SELECT Doct_adhNo, SUM(Revenue) AS Scan_Revenue
    FROM Doct_Scan
    GROUP BY Doct_Scan.Doct_adhNo
)
SELECT d.*,dtr.Test_Revenue, dsr.Scan_Revenue
FROM Doct_Test_Rev AS dtr JOIN Doct_Scan_Rev AS dsr JOIN Doctor AS d
ON dtr.Doct_adhNo = dsr.Doct_adhNo AND dtr.Doct_adhNo = d.adhNo
ORDER BY dtr.Test_Revenue;


DROP DATABASE Laboratory;
