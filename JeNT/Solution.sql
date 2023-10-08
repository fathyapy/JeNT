--1 
-- Create a table named ‘MsCourier’ with the following description: (CREATE TABLE, LIKE)
CREATE TABLE MsCourier (
	CourierId CHAR (5) Primary key CHECK (CourierId LIKE 'CR[0-9][0-9][0-9]'),
	CourierName	VARCHAR	(25) NOT NULL,
	CourierPhone VARCHAR (12) NOT NULL CHECK (CourierPhone LIKE '08%')
)

--2 
-- Add ‘StaffPosition’ as new column on MsStaff table with varchar data type and the length is 20. After that, add a constraint to MsStaff table to validate that ‘StaffSalary’ must be lower than 10000000. (ALTER TABLE, ADD, ADD CONSTRAINT)

ALTER TABLE MsStaff
ADD StaffPosition VARCHAR (20)

ALTER TABLE MsStaff 
ADD CONSTRAINT CheckSalary CHECK (StaffSalary <10000000)

-- 3
-- Insert these data into MsCustomer table: (INSERT)
INSERT INTO MsCustomer
VALUES ('CU006', 'Grace','2001-04-15','083847592091','Hayam Wuruk Boulevard')

select * from MsCustomer

-- 4
-- Display CustomerId, CustomerName, CustomerDOB, CustomerPhone, CustomerAddress for every customer whose address ends with ‘ Street’ (include space in front of Street word).(LIKE)
SELECT CustomerId, CustomerName, CustomerDOB, CustomerPhone, CustomerAddress
FROM MsCustomer
WHERE CustomerAddress LIKE '% Street'

-- 5
-- Update CustomerName from MsCustomer table for every customer who had perform any transaction on the 25th day of the month into ‘John Doe’. (UPDATE, DAY)
BEGIN TRAN
UPDATE MsCustomer
SET CustomerName = 'John Doe'
FROM TransactionHeader TH, MsCustomer C
WHERE TH.CustomerId = C.CustomerId AND DAY(TransactionDate) = 25
COMMIT

SELECT*FROM MsCustomer