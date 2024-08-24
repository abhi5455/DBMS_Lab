CREATE DATABASE Resort;
USE Resort;

CREATE TABLE Employee(
    Name VARCHAR(30),
    address VARCHAR(50),
    adhNo BIGINT,
    mobile BIGINT,
    email VARCHAR(30),
    joinDate DATE,
    salary BIGINT,
    PRIMARY KEY (adhNo)
);

CREATE TABLE Residents(
    Name VARCHAR(30),
    address VARCHAR(50),
    adhNo BIGINT,
    Gender VARCHAR(10),
    age INT,
    mobile BIGINT,
    email VARCHAR(30),
    PRIMARY KEY (adhNo)
);

CREATE TABLE Rooms(
    roomNo INT,
    roomType VARCHAR(7) CHECK (roomType IN ('AC','NON-AC')),
    capacity VARCHAR(15) CHECK (capacity IN ('Single Bed', 'Double Bed')),
    PRIMARY KEY (roomNo)
);

CREATE TABLE Booking(
    booking_ID BIGINT,
    resident_adhNo BIGINT,
    roomNo INT,
    booking_date DATE,
    checkin_date DATE,
    checkout_date DATE,
    status VARCHAR(15) CHECK (status IN ('Pending','Confirmed','Cancelled')),
    PRIMARY KEY (booking_ID,roomNo),
    FOREIGN KEY (roomNo) REFERENCES Rooms(roomNo),
    FOREIGN KEY (resident_adhNo) REFERENCES Residents(adhNo) 
);

CREATE TABLE Companions(
    Companion_Name VARCHAR(30),
    Companion_Gender VARCHAR(10),
    Companion_mobile BIGINT,
    C_booking_ID BIGINT,
    PRIMARY KEY (Companion_Name,C_booking_ID),
    FOREIGN KEY (C_booking_ID) REFERENCES Booking(booking_ID)
);

CREATE TABLE Food(
    foodItem VARCHAR(100),
    type VARCHAR(20) CHECK (type IN ('Vegetarian','Non-Vegetarian')),
    price INT,
    PRIMARY KEY (foodItem)
);

CREATE TABLE FoodOrders(
    foodItem VARCHAR(100),
    roomNo INT,
    resident_adhNo BIGINT,
    date DATE,
    orderedTime TIME,
    PRIMARY KEY (foodItem,roomNo,resident_adhNo,date,orderedTime),
    FOREIGN KEY (foodItem) REFERENCES Food(foodItem),
    FOREIGN KEY (roomNo) REFERENCES Rooms(roomNo),
    FOREIGN KEY (resident_adhNo) REFERENCES Residents(adhNo)
);


INSERT INTO Employee (Name, address, adhNo, mobile, email, joinDate, salary) VALUES 
    ('John Doe', '1234 Elm Street', 123456789012, 9876543210, 'john.doe@example.com', '2022-01-15', 50000),
    ('Jane Smith', '5678 Oak Avenue', 987654321098, 8765432109, 'jane.smith@example.com', '2022-02-20', 55000),
    ('Alice Johnson', '4321 Pine Lane', 112233445566, 7654321098, 'alice.johnson@example.com', '2023-03-10', 60000),
    ('Bob Brown', '8765 Maple Drive', 998877665544, 6543210987, 'bob.brown@example.com', '2023-04-05', 52000),
    ('Charlie White', '3456 Birch Boulevard', 554433221100, 5432109876, 'charlie.white@example.com', '2024-05-15', 58000);

INSERT INTO Residents (Name, address, adhNo, Gender, age, mobile, email) VALUES 
    ('Emily Davis', '1357 Cedar Street', 667788990011, 'Female', 32, 9012345678, 'emily.davis@example.com'),
    ('Michael Taylor', '2468 Spruce Road', 778899001122, 'Male', 45, 8123456789, 'michael.taylor@example.com'),
    ('Sophia Miller', '9753 Willow Way', 889900112233, 'Female', 28, 7234567890, 'sophia.miller@example.com'),
    ('William Wilson', '8642 Ash Avenue', 990011223344, 'Male', 55, 6345678901, 'william.wilson@example.com'),
    ('Olivia Brown', '7531 Fir Lane', 101112131415, 'Female', 40, 5456789012, 'olivia.brown@example.com');

INSERT INTO Rooms (roomNo, roomType, capacity) VALUES 
    (101, 'AC', 'Single Bed'),
    (102, 'AC', 'Double Bed'),
    (103, 'AC', 'Double Bed'),
    (104, 'AC', 'Single Bed'),
    (105, 'AC', 'Single Bed'),
    (106, 'Non-AC', 'Double Bed'),
    (107, 'Non-AC', 'Double Bed'),
    (108, 'Non-AC', 'Single Bed');

INSERT INTO Booking (booking_ID, resident_adhNo, roomNo, booking_date, checkin_date, checkout_date, status) VALUES 
    (1001, 667788990011, 101, '2024-08-01', '2024-08-05', '2024-08-10', 'Confirmed'),
    (1002, 778899001122, 102, '2024-08-02', '2024-08-06', '2024-08-11', 'Pending'),
    (1003, 889900112233, 103, '2024-08-03', '2024-08-07', '2024-08-12', 'Cancelled'),
    (1002, 778899001122, 104, '2024-08-04', '2024-08-08', '2024-08-13', 'Confirmed'),
    (1005, 778899001122, 105, '2024-08-05', '2024-08-09', '2024-08-14', 'Pending'),
    (1006, 778899001122, 102, '2024-09-04', '2024-09-08', '2024-09-13', 'Confirmed'),
    (1008, 778899001122, 101, '2024-09-04', '2024-10-08', '2024-10-13', 'Confirmed'),
    (1002, 778899001122, 108, '2024-09-04', '2024-11-08', '2024-12-13', 'Confirmed'),
    (1009, 667788990011, 101, '2024-08-01', '2024-08-05', '2024-08-10', 'Confirmed'),
    (1009, 667788990011, 103, '2024-08-03', '2024-08-07', '2024-08-12', 'Cancelled'),
    (1007, 667788990011, 105, '2024-08-10', '2024-08-15', '2024-08-20', 'Confirmed');


INSERT INTO Companions (Companion_Name, Companion_Gender, Companion_mobile, C_booking_ID) VALUES 
    ('Ethan Green', 'Male', 9098765432, 1001),
    ('Ava Lee', 'Female', 9087654321, 1002),
    ('James Hall', 'Male', 9076543210, 1002),
    ('Mia Young', 'Female', 9065432109, 1002),
    ('Lucas Harris', 'Male', 9054321098, 1002);

INSERT INTO Food (foodItem, type, price) VALUES 
    ('Chicken Biriyani', 'Non-Vegetarian', 250),
    ('Veg Biriyani', 'Vegetarian', 200),
    ('Fried Rice and ChilliChicken', 'Vegetarian', 150),
    ('Chappati and Chicken Curry', 'Non-Vegetarian', 180),
    ('Chappati and Paneer Curry', 'Vegetarian', 170);

INSERT INTO FoodOrders (foodItem, roomNo, resident_adhNo, date, orderedTime) VALUES 
    ('Chicken Biriyani', 101, 667788990011, '2024-08-06', '12:30:00'),
    ('Veg Biriyani', 102, 778899001122, '2024-08-07', '13:00:00'),
    ('Fried Rice and ChilliChicken', 103, 889900112233, '2024-08-08', '19:00:00'),
    ('Fried Rice and ChilliChicken', 104, 990011223344, '2024-08-09', '20:00:00'),
    ('Fried Rice and ChilliChicken', 105, 101112131415, '2024-08-10', '12:45:00');


SELECT * FROM Employee;
SELECT * FROM Residents;
SELECT * FROM Companions;
SELECT * FROM Rooms;    
SELECT * FROM Booking;
SELECT * FROM Food;
SELECT * FROM FoodOrders;


CREATE VIEW Booking_Details AS
SELECT b.*,r.*,c.Companion_Name,c.Companion_Gender,c.Companion_mobile
FROM Booking AS b JOIN Residents AS r
ON b.resident_adhNo=r.adhNo
LEFT JOIN Companions AS c 
ON b.booking_ID=c.C_booking_ID;

SELECT * FROM Booking_Details;

-- (a)
SELECT * 
FROM Residents
WHERE adhNo IN (
    SELECT resident_adhNo
    FROM Booking_Details
    GROUP BY booking_ID,resident_adhNo
    HAVING COUNT(resident_adhNo) > 3
);


-- (b)

SELECT bd.booking_ID,bd.Name,bd.address,bd.adhNo,bd.Gender,bd.age,bd.mobile,bd.email, COUNT(resident_adhNo) AS No_of_Companions
FROM Booking_Details AS bd
WHERE bd.checkin_date between '2024-08-05' and '2024-08-07'
GROUP BY booking_ID;


-- (c)
SELECT *
FROM Residents
WHERE adhNo IN (
    SELECT bd.resident_adhNo
    FROM Booking AS bd JOIN Rooms as rm
    ON bd.roomNo=rm.roomNo
    WHERE rm.roomType='AC'
    GROUP BY bd.resident_adhNo
    HAVING COUNT(DISTINCT bd.booking_ID)>=2 AND COUNT(bd.booking_ID)>2
); 


-- (d)(1)

SELECT f.*, COUNT(fo.foodItem) AS Frequency
FROM FoodOrders AS fo JOIN Food AS f 
ON fo.foodItem=f.foodItem 
GROUP BY foodItem
HAVING COUNT(fo.foodItem) = ( 
    SELECT MAX(foodCount)
    FROM(
        SELECT COUNT(foodItem) AS foodCount
        FROM FoodOrders
        GROUP BY foodItem
    ) AS sub1
);


-- (d)(2)

SELECT f.*, COUNT(fo.foodItem) AS Frequency
FROM FoodOrders AS fo JOIN Food AS f
ON fo.foodItem=f.foodItem 
GROUP BY foodItem
HAVING COUNT(fo.foodItem) =(
    SELECT MIN(foodCount)
    FROM(
        SELECT COUNT(foodItem) AS foodCount
        FROM FoodOrders
        GROUP BY foodItem 
    ) AS sub1
);


DROP DATABASE Resort;
