CREATE DATABASE Mall;
USE Mall;

CREATE TABLE Product(
    productID int,
    productName varchar(50),
    category varchar(20),
    company varchar(50),
    price int,
    PRIMARY KEY (productID)
);

CREATE TABLE Customer(
    Name varchar(50),
    address varchar(120),
    mobile bigint,
    emailID varchar(50),
    PRIMARY KEY (mobile)
);


CREATE TABLE OrderDetails(
    ordered_pID int,
        quantity varchar(20),
        ordered_date DATE,
        cus_mobile bigint,
        PRIMARY KEY(ordered_pID,cus_mobile),
        FOREIGN KEY(cus_mobile) REFERENCES Customer(mobile),
        FOREIGN KEY(ordered_pID) REFERENCES Product(productID)
);

INSERT INTO Product VALUES
    (1234,'teddy bear','doll','allens',1500),
    (2423,'pizza','foodItem','dominos',300),
    (5241,'s23 Ultra','mobile','samsung',100000),
    (7821,'4k Led TV','tv','Sony',25000),
    (2234,'HP Victus','laptop','hp',70000);

INSERT INTO Customer VALUES
    ('Ajith','Gandhinargar 2nd street',9625457823,'ajith@gmail.com'),
    ('Sanjay','Flat No 24, girinagar',9523147802,'sanjay@gmail.com'),
    ('Akash','kk road ktym',9243617505,'akash@gmail.com'),
    ('Madhav','arjun street, CK road',9412357862,'madhav@gmail.com'),
    ('Adarsh','RK junction, Changanassery',6223456810,'adarsh@gmail.com');

INSERT INTO OrderDetails VALUES
    (1234,'1','2024-02-10',9625457823),
    (5241,'1','2024-02-10',9625457823),
    (7821,'1','2024-02-10',9625457823),
    (5241,'1','2024-05-11',9243617505),
    (7821,'1','2024-07-01',9243617505),
    (5241,'1','2024-02-10',6223456810);

SELECT * FROM Product;
SELECT * FROM Customer;
SELECT * FROM OrderDetails;


SELECT c.*
FROM OrderDetails AS o JOIN Customer AS c
ON o.cus_mobile=c.mobile
GROUP BY o.cus_mobile,o.ordered_date
HAVING COUNT(cus_mobile) > 2;


SELECT c.*,COUNT(o.ordered_pID) AS No_of_items
FROM Customer AS c JOIN OrderDetails AS o
ON c.mobile=o.cus_mobile
WHERE o.ordered_date < '2024-07-12'
GROUP BY o.cus_mobile;



SELECT p.*,COUNT(o.ordered_pID)*p.price AS revenue
FROM OrderDetails AS o JOIN Product AS p
ON o.ordered_pID = p.productID
GROUP BY o.ordered_pID,p.price
HAVING (COUNT(o.ordered_pID)*p.price) = (
        SELECT MAX(revenue)
        FROM(
                SELECT o.ordered_pID,COUNT(o.ordered_pID),COUNT(o.ordered_pID)*p.price AS revenue
                FROM OrderDetails AS o JOIN Product AS p
                ON o.ordered_pID = p.productID
                GROUP BY o.ordered_pID
        ) AS subq);

DROP DATABASE Mall;