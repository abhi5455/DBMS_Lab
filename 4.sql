CREATE DATABASE ThesisRepo;
USE ThesisRepo;

CREATE TABLE Student(
      name varchar(50),
      rollNo varchar(10),
      age int,
      department varchar(20),
      mobileNo bigint,
      emailId varchar(50),
      PRIMARY KEY(rollNo)
);

CREATE TABLE Guide(
      GuideId int,
      guide_name varchar(50),
      researchArea varchar(50),
      designation varchar(50),
      dept varchar(20),
      guide_mobileNo bigint,
      guide_emailId varchar(30),
      PRIMARY KEY(GuideId)
);

CREATE TABLE Thesis(
      Id int,
      title varchar(50),
      central_area varchar(50),
      PRIMARY KEY(Id)
);

CREATE TABLE Submission(      
      student_rollNo varchar(10),
      guide_id int,
      thesisId int,
      sub_date DATE,     
      FOREIGN KEY (student_rollNo) REFERENCES Student(rollNo),
      FOREIGN KEY (guide_id) REFERENCES Guide(GuideId),
      FOREIGN KEY (thesisId) REFERENCES Thesis(Id),
      PRIMARY KEY (student_rollNo, guide_id, thesisId)
);

CREATE TABLE IndexTable(
      t_Id int,
      keyword varchar(50),
      FOREIGN KEY (t_Id) REFERENCES Thesis(Id),
      PRIMARY KEY(t_Id)
);


INSERT INTO Student VALUES
      ('Ajay', 'CS24P05', 22, 'CS', 9536214568, 'ajay@gmail.com'),
      ('Sanjay', 'AI24P10', 25, 'AI', 9523914568, 'sanjay@gmail.com'),
      ('Indraj', 'EC25MS23', 27, 'EC', 9623147895, 'indraj@gmail.com'),
      ('Ashiq', 'ME23P18', 23, 'ME', 6122785314, 'ashiq@gmail.com'),
      ('Manu', 'CE22MS02', 22, 'CE', 8185862342, 'manu@gmail.com'),
      ('Ameer', 'CS23MS01', 23, 'CS', 9285647123, 'ameer@gmail.com'),
      ('Dileep', 'AI23P15', 24, 'AI', 9112346789, 'dileep@gmail.com');
      

INSERT INTO Guide VALUES
      (51523, 'Abhinav', 'Machine Learning', 'prof', 'CSE', 9592934568, 'abhinav@gmail.com'),      
      (62841, 'Anirudh', 'Cyber Security', 'prof', 'CSE', 9275543214, 'anirudh@gmail.com'),      
      (45623, 'Ameliya', 'Building Architecture', 'prof', 'CE', 9592934568, 'ameliya@gmail.com'),      
      (18785, 'Jacob', 'Semiconductor Theory', 'prof', 'ECE', 9592934568, 'jacob@gmail.com'),      
      (23761, 'Niranjan', 'Artificial Intelligence', 'Assist prof', 'CSE', 6257894130, 'niranjan@gmail.com'),    
      (32451, 'Pravin', 'Software Engineering', 'Assist prof', 'IT', 9876543210, 'pravin@gmail.com'),
      (42134, 'Diana', 'Algorithms', 'prof', 'CSE', 9002345671, 'diana@gmail.com');        
      
INSERT INTO Thesis VALUES
      (1254, 'Is AI Essential', 'AI'),
      (2244, 'Security Matters', 'Cyber Security'),
      (2245, 'Privacy Matters', 'Cyber Security'),
      (1571, 'Intelligent Machine', 'AI'),
      (3004, 'Construction Theory', 'Architecture of Building'),
      (1113, 'Algorithm Analysis and Development', 'Computer Algorithms'),
      (2111, 'Neural Networks', 'AI'),
      (3322, 'Digital Architecture', 'Architecture of Building'),
      (4105, 'Advanced Cyber Security', 'Cyber Security'),
      (5123, 'AI in Healthcare', 'Artificial Intelligence');

INSERT INTO Submission VALUES
      ('CS24P05', 51523, 1254, '2024-05-07'),  
      ('CE22MS02', 45623, 1571, '2024-05-07'),  
      ('AI24P10', 45623, 2244, '2024-05-07'),  
      ('AI24P10', 18785, 2245, '2024-06-12'),
      ('CS23MS01', 42134, 1113, '2024-07-19'),
      ('CS23MS01', 42134, 1571, '2024-07-19'),
      ('AI23P15', 23761, 2111, '2024-08-25'),
      ('ME23P18', 32451, 3322, '2024-09-15'),
      ('CS24P05', 51523, 4105, '2024-09-20'),
      ('AI23P15', 23761, 5123, '2024-09-25'),
      ('AI23P15', 23761, 3004, '2024-09-25'),
      ('AI23P15', 23761, 1571, '2024-09-25');

INSERT INTO IndexTable VALUES
      (1254, 'AI, Future Technology'),
      (2244, 'Approximation Algorithms, Hashing Algorithms'),
      (3004, 'Construction'),
      (1571, 'AI, Deep Learning, Neural Networks'),
      (1113, 'Algorithms'),
      (2111, 'Neural Networks'),
      (3322, 'Architecture');


SELECT * FROM Student;      
SELECT * FROM Guide;
SELECT * FROM Thesis;
SELECT * FROM Submission;
SELECT * FROM IndexTable;

-- --

CREATE VIEW Thesis_Details AS
SELECT *
FROM Submission AS s JOIN Thesis  AS t ON s.thesisId = t.Id 
JOIN Student AS st ON s.student_rollNo = st.rollNo 
JOIN Guide AS g ON s.guide_id = g.GuideId;

SELECT * FROM Thesis_Details;

-- --

CREATE VIEW Thesis_keyword AS
SELECT *
FROM Submission JOIN (
      SELECT t_Id, SUBSTRING_INDEX(keyword,',',1) AS keyword
      FROM IndexTable
      UNION
      SELECT t_Id, SUBSTRING_INDEX(SUBSTRING_INDEX(keyword,',',2),', ',-1) AS keyword
      FROM IndexTable
      UNION
      SELECT t_Id, SUBSTRING_INDEX(keyword,', ',-1) AS keyword
      FROM IndexTable) AS subq
ON subq.t_Id=Submission.thesisId
ORDER BY Submission.thesisId;

SELECT * FROM Thesis_keyword;

-- (a)

SELECT DISTINCT g.* 
FROM Thesis_keyword AS tk JOIN Guide AS g
ON tk.guide_id = g.GuideId
WHERE tk.keyword = 'Approximation Algorithms';

-- (b)

SELECT *, 'Max_Thesis' AS status
FROM Guide
WHERE GuideId IN (
      SELECT guide_id
      FROM Submission
      GROUP BY guide_id
      HAVING COUNT(*) = (
            SELECT MAX(thesisNo)
            FROM (
                  SELECT COUNT(*) AS thesisNo
                  FROM Submission
                  GROUP BY guide_id
            ) AS subq
      )
);

SELECT *, 'Min_Thesis' AS status
FROM Guide
WHERE GuideId IN (
      SELECT guide_id
      FROM Submission
      GROUP BY guide_id
      HAVING COUNT(*) = (
            SELECT MIN(thesisNo)
            FROM (
                  SELECT COUNT(*) AS thesisNo
                  FROM Submission
                  GROUP BY guide_id
            ) AS subq
      )
);

-- (c)

SELECT name, rollNo, age, department, mobileNo, emailId, central_area, title 
FROM Thesis_Details
WHERE rollNo IN (
      SELECT student_rollNo 
      FROM Thesis_Details
      GROUP BY student_rollNo, central_area
      HAVING COUNT(DISTINCT guide_id) >= 2
);


-- (d)

SELECT *
FROM Guide
WHERE GuideId IN (
      SELECT guide_id
      FROM Thesis_Details
      WHERE SUBSTRING(rollNo, 5,1) = 'P'
      GROUP BY guide_id
      HAVING COUNT(DISTINCT central_area)>1
);

-- (e)

SELECT keyword, COUNT(CASE WHEN SUBSTRING(student_rollNo, 5, 1) = 'P' THEN 1 END) AS  'PhD Count', COUNT(CASE WHEN SUBSTRING(student_rollNo,5,2) = 'MS' THEN 1 END) AS 'MS Count'
FROM Thesis_keyword
GROUP BY keyword;

-- (f)

SELECT *
FROM Guide
WHERE GuideId NOT IN (
      SELECT guide_id
      FROM Submission
      WHERE sub_date BETWEEN '2024-05-07' AND '2024-06-07'
);

-- (g)(1)

SELECT central_area, COUNT(*) AS Count, 'Most trending area' AS category
FROM Thesis_Details AS t
GROUP BY t.central_area
HAVING COUNT(*) = (
      SELECT MAX(max_count)
      FROM (
            SELECT COUNT(*) AS max_count
            FROM Thesis_Details AS t
            GROUP BY t.central_area
      ) AS subq
);

-- (g)(2)

SELECT central_area, COUNT(*) AS Count, 'Least trending area' AS category
FROM Thesis_Details AS t
GROUP BY t.central_area
HAVING COUNT(*) = (
      SELECT MIN(min_count)
      FROM (
            SELECT COUNT(*) AS min_count
            FROM Thesis_Details AS t
            GROUP BY t.central_area
      ) AS subq
);

-- (h)

SELECT *
FROM Guide
WHERE GuideId IN (
      SELECT DISTINCT guide_id
      FROM Thesis_Details
      WHERE SUBSTRING(rollNo, 5,2) = 'MS'
      GROUP BY guide_id
      HAVING COUNT(DISTINCT central_area) = 1
);

-- (i)

SELECT * 
FROM Student
WHERE rollNo IN (
      SELECT student_rollNo
      FROM Thesis_keyword AS tk 
      GROUP BY student_rollNo
      HAVING COUNT(DISTINCT thesisId) > 1 AND COUNT(keyword) = COUNT(DISTINCT keyword)
);

-- Here (DISTINCT Thesis id) is taken because thesis id is repeated in the view if it contains more than 1 keyword, but not taken in 2nd conditon of HAVING clause as no 2 keyword should be repeated


DROP DATABASE ThesisRepo;
