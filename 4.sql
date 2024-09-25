CREATE DATABASE ThesisRepo;
USE ThesisRepo;

CREATE TABLE Student(
      name varchar(50),
      rollNo int,
      age int,
      department varchar(20),
      mobileNo bigint,
      emailId varchar(30),
      PRIMARY KEY(rollNo)
);

CREATE TABLE Guide(
      id int,
      guide_name varchar(50),
      researchArea varchar(50),
      designation varchar(50),
      dept varchar(20),
      guide_mobileNo bigint,
      guide_emailId varchar(30),
      PRIMARY KEY(id)
);

CREATE TABLE Thesis(
      title varchar(50),
      central_area varchar(50),
      student_rollNo int,
      guide_id int,
      sub_date DATE,
      FOREIGN KEY (student_rollNo) REFERENCES Student(rollNo),
      FOREIGN KEY (guide_id) REFERENCES Guide(id),
      PRIMARY KEY(title, student_rollNo, guide_id)
);

CREATE TABLE IndexTable(
      t_title varchar(50),
      t_student_rollNo int,
      t_guide_id int,
      keyword varchar(50),
      FOREIGN KEY (t_student_rollNo) REFERENCES Student(rollNo),
      FOREIGN KEY (t_guide_id) REFERENCES Guide(id),
      FOREIGN KEY (t_title) REFERENCES Thesis(title),
      PRIMARY KEY(t_title, t_student_rollNo, t_guide_id, keyword)
);

INSERT INTO Student VALUES
      ('Ajay', 1254, 22, 'CSE', 9536214568, 'ajay@gmail.com'),
      ('Sanjay', 1274, 25, 'ECE', 9523914568, 'sanjay@gmail.com'),
      ('Indraj', 2244, 27, 'CSE', 9623147895, 'indraj@gmail.com'),
      ('Ashiq', 2517, 23, 'ME', 6122785314, 'ashiq@gmail.com'),
      ('Manu', 3004, 22, 'CE', 8185862342, 'manu@gmail.com');
      

INSERT INTO Guide VALUES
      (51523, 'Abhinav', 'Meachine Learning', 'prof', 'CSE', 9592934568, 'abhinav@gmail.com'),      
      (62841, 'Anirudh', 'Cyber Security', 'prof', 'CSE', 9275543214, 'anirudh@gmail.com'),      
      (45623, 'Ameliya', 'Building Architechture', 'prof', 'CE', 9592934568, 'ameliya@gmail.com'),      
      (18785, 'Jacob', 'Semiconductor Theory', 'prof', 'ECE', 9592934568, 'jacob@gmail.com'),      
      (23761, 'Niranjan', 'Artificial Intelligence', 'Assist prof', 'CSE', 6257894130, 'niranjan@gmail.com');     
      
      
INSERT INTO Thesis VALUES
      ('Is AI Essential', 'AI', 1254, 23761, '2024-05-10'),
      ('Security Matters', 'Cyber Security', 2244, 62841, '2024-07-10'),
      ('Intelligent Meachine', 'AI', 2244, 23761, '2024-02-15'),
      ('Construction Theory', 'Architecture of Building', 3004, 45623, '2024-01-20'),
      ('Algorithm Analysis and Development', 'Computer Algorithms', 2244, 23761, '2024-05-22');
      
INSERT INTO IndexTable VALUES
      ('Is AI Essential', 1254, 23761, 'AI, Future Technology'),
      ('Algorithm Analysis and Development', 2244, 23761, 'Approximation algorithms, Hashing Algorithms'),
      ('Construction Theory', 3004, 45623, 'Construction'),  
      ('Security Matters', 2244, 62841, 'Hacking, Cyber Security'),
      ('Intelligent Meachine', 2244, 23761, 'AI');
         
      
SELECT * FROM Student;      
SELECT * FROM Guide;
SELECT * FROM Thesis;
SELECT * FROM IndexTable;

-- (a)

SELECT *
FROM Guide
WHERE id IN (
      SELECT it.t_guide_id
      FROM IndexTable AS it
      WHERE it.keyword LIKE '%Approximation Algorithms%'
);

-- (b)

CREATE VIEW guide_thesis AS
SELECT *
FROM Guide AS g JOIN Thesis AS t
ON g.id=t.guide_id;

SELECT gt.id, gt.guide_name, gt.researchArea, gt.designation, gt.dept, gt.guide_mobileNo, gt.guide_emailId, COUNT(*) as Max_Count
FROM guide_thesis AS gt
GROUP BY gt.guide_id
HAVING COUNT(*) =(
      SELECT MAX(thesis_count)
      FROM(
            SELECT COUNT(*) AS thesis_count
            FROM guide_thesis AS gt
            GROUP BY gt.guide_id      
      )AS subq
);

SELECT gt.id, gt.guide_name, gt.researchArea, gt.designation, gt.dept, gt.guide_mobileNo, gt.guide_emailId, COUNT(*) as Min_Count
FROM guide_thesis AS gt
GROUP BY gt.guide_id
HAVING COUNT(*) =(
      SELECT MIN(thesis_count)
      FROM(
            SELECT COUNT(*) AS thesis_count
            FROM guide_thesis AS gt
            GROUP BY gt.guide_id      
      )AS subq
);

DROP DATABASE ThesisRepo;