--1 
-- Create a view named ‘ViewDeliveryTypeInformation’ to display DeliveryTypeId, DeliveryTypeName, DeliveryTypePrice for every delivery type which price is between 50000 and 65000. (CREATE VIEW, BETWEEN)
CREATE VIEW ViewDeliveryTypeInformation
AS
SELECT DeliveryTypeId, DeliveryTypeName, DeliveryTypePrice
FROM MsDeliveryType 
WHERE DeliveryTypePrice BETWEEN 50000 and 65000
GO

--2
-- Display StaffId, StaffName, StaffAddress, StaffSalary for every staff who had served any transaction on 8th month (August). (IN, MONTH)
SELECT StaffId, StaffName, StaffAddress, StaffSalary
FROM MsStaff
WHERE StaffId
IN (
	SELECT StaffId
	FROM TransactionHeader th
	WHERE MONTH(TransactionDate) = 8
)

-- 3
-- Display CustomerId, CustomerName, CustomerDOB, and Number of Transactions (obtained from the number of transactions occurred each customer) for every customer who has done any transaction at least 7 days before 17th August 2021. 
-- After that, combine that result with CustomerId, CustomerName, CustomerDOB, and Number of Transactions (obtained from the number of transactions occurred each customer) for every customer whose length name is more than 6 characters.  (COUNT, DATEDIFF, DAY, LEN, UNION, GROUP BY)
SELECT mc.CustomerId, CustomerName, CustomerDOB, 'Number of Transactions' = COUNT(TransactionId)
FROM MsCustomer mc
JOIN TransactionHeader th ON th.CustomerId = mc.CustomerId
WHERE DATEDIFF(DAY,'2021-08-17',TransactionDate) < 7
GROUP BY mc.CustomerId, CustomerName, CustomerDOB
UNION
SELECT mc.CustomerId, CustomerName, CustomerDOB, 'Number of Transactions' = COUNT(TransactionId)
FROM MsCustomer mc
JOIN TransactionHeader th ON th.CustomerId = mc.CustomerId
WHERE LEN(CustomerName) > 6
GROUP BY mc.CustomerId, CustomerName, CustomerDOB


-- 4
-- Display TransactionId, Total Amount (obtained from the total amount price of delivery type price), and TransactionDate for every transaction with delivery type name at least 2 words and occurred before 1st August 2021.  (SUM, JOIN, LIKE, DATEDIFF, DAY, GROUP BY)
SELECT td.TransactionId, 'Total Amount'= SUM(DeliveryTypePrice), TransactionDate
FROM TransactionHeader th
JOIN TransactionDetail td ON td.TransactionId = th.TransactionId
JOIN MsDeliveryType mdt ON mdt.DeliveryTypeId = td.DeliveryTypeId
WHERE DeliveryTypeName LIKE '% %' AND DATEDIFF(DAY,'2021-08-01',TransactionDate) < 1
GROUP BY td.TransactionId,TransactionDate


-- 5
-- Display TransactionId, Transaction Date (obtained from transaction date in ‘Mon dd, yyyy’ format), and  Package Origin (obtained from the uppercase of the first 3 letters in the CityName) 
-- for every transaction that delivery type price less than the average all of delivery type price and the city name contains ‘Java’.  (CONVERT, UPPER, SUBSTRING, AVG, alias subquery)
SELECT td.TransactionId, 'Transaction Date' = CONVERT(varchar,TransactionDate,107), 'Package Origin' = UPPER(SUBSTRING(CityName,1,3))
FROM MsDeliveryType mdt
JOIN TransactionDetail td ON td.DeliveryTypeId = mdt.DeliveryTypeId
JOIN TransactionHeader th ON th.TransactionId = td.TransactionId
JOIN MsCity mc ON mc.CityId = th.CityOriginId,
(
	SELECT 'AverageP' = AVG(DeliveryTypePrice)
	FROM MsDeliveryType
) AS X
 WHERE DeliveryTypePrice < x.AverageP AND CityName LIKE'%Java%'
