GO
CREATE DATABASE [JeNT]

GO
USE [JeNT]

GO
CREATE TABLE MsCustomer (
	CustomerId CHAR(5) NOT NULL, 
	CustomerName VARCHAR(25) NOT NULL,
	CustomerDOB DATE NOT NULL,
	CustomerPhone VARCHAR(12) NOT NULL,
	CustomerAddress VARCHAR(100) NOT NULL,

	PRIMARY KEY(CustomerId)
)

GO
CREATE TABLE MsStaff(
	StaffId CHAR(5) NOT NULL,
	StaffName VARCHAR(25) NOT NULL,
	StaffDOB DATE NOT NULL,
	StaffPhone VARCHAR(12) NOT NULL,
	StaffAddress VARCHAR(100) NOT NULL,
	StaffSalary INT NOT NULL,

	PRIMARY KEY(StaffId)
)

GO
CREATE TABLE MsDeliveryType(
	DeliveryTypeId CHAR(5) NOT NULL,
	DeliveryTypeName VARCHAR(20) NOT NULL,
	DeliveryTypePrice INT NOT NULL,

	PRIMARY KEY(DeliveryTypeId),
)

GO
CREATE TABLE MsCity(
	CityId CHAR(5) NOT NULL,
	CityName VARCHAR(25) NOT NULL,

	PRIMARY KEY(CityId)
)

GO
CREATE TABLE TransactionHeader(
	TransactionId CHAR(5) NOT NULL,
	CustomerId CHAR(5) NOT NULL,
	StaffId CHAR(5) NOT NULL,
	CityOriginId CHAR(5) NOT NULL,
	TransactionDate DATE NOT NULL,

	PRIMARY KEY(TransactionId),
	FOREIGN KEY(CustomerId) REFERENCES MsCustomer(CustomerId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(StaffId) REFERENCES MsStaff(StaffId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(CityOriginId) REFERENCES MsCity(CityId) ON DELETE CASCADE ON UPDATE CASCADE
)

GO
CREATE TABLE TransactionDetail(
	TransactionId CHAR(5) NOT NULL,
	DeliveryTypeId CHAR(5) NOT NULL,
	CityDestinationId CHAR(5) NOT NULL,

	PRIMARY KEY(TransactionId, DeliveryTypeId),
	FOREIGN KEY(TransactionId) REFERENCES TransactionHeader(TransactionId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(DeliveryTypeId) REFERENCES MsDeliveryType(DeliveryTypeId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(CityDestinationId) REFERENCES MsCity(CityId)
)

INSERT INTO MsCustomer VALUES
('CU001', 'William', '2001-05-15', '081278395720', 'Kemanggisan Street'),
('CU002', 'Elisa', '2002-07-23', '087584901538', 'Alam Sutera Boulevard'),
('CU003', 'Fernando', '2001-12-09', '085793860183', 'Syahdan Street'),
('CU004', 'Ken', '2000-11-25', '085948209581', 'Kijang Avenue'),
('CU005', 'Joko', '2001-08-17', '082957489230', 'Kembangan Boulevard')

INSERT INTO MsStaff VALUES 
('ST001', 'Leonardo', '2002-09-16', '083957839501', 'Anggrek Street', 4500000),
('ST002', 'Ronaldo', '1999-12-24', '082968479301', 'Melati Avenue', 6450000),
('ST003', 'Budi', '2000-03-14', '081493857985', 'Thamrin Boulevard', 5350000),
('ST004', 'Tono', '2000-06-17', '084357865980', 'Bandung Street', 7800000),
('ST005', 'Kevin', '1999-09-11', '084958109209', 'Bogor Boulevard', 6750000)

INSERT INTO MsCity VALUES 
('CT001', 'Jakarta'),
('CT002', 'Makassar, South Sulawesi'),
('CT003', 'Semarang, Central Java'),
('CT004', 'Surabaya, East Java'),
('CT005', 'Solo, Central Java')

INSERT INTO MsDeliveryType VALUES
('DT001', 'Reguler', 25000),
('DT002', 'SameDay', 55000),
('DT003', 'Express', 47500),
('DT004', 'Paket Kilat', 70000),
('DT005', 'Extra Cepat', 65000)

INSERT INTO TransactionHeader VALUES 
('TR001', 'CU002', 'ST001', 'CT001', '2021-08-17'),
('TR002', 'CU001', 'ST004', 'CT001', '2021-07-20'),
('TR003', 'CU003', 'ST003', 'CT002', '2021-06-20'),
('TR004', 'CU002', 'ST002', 'CT002', '2021-07-09'),
('TR005', 'CU005', 'ST005', 'CT003', '2021-08-11'),
('TR006', 'CU001', 'ST001', 'CT003', '2021-06-25'),
('TR007', 'CU004', 'ST002', 'CT004', '2021-08-07'),
('TR008', 'CU003', 'ST004', 'CT004', '2021-07-02'),
('TR009', 'CU005', 'ST005', 'CT005', '2021-07-11'),
('TR010', 'CU002', 'ST003', 'CT005', '2021-08-13')

INSERT INTO TransactionDetail VALUES
('TR001', 'DT002', 'CT004'),
('TR001', 'DT003', 'CT003'),
('TR002', 'DT001', 'CT005'),
('TR002', 'DT004', 'CT004'),
('TR003', 'DT005', 'CT001'),
('TR003', 'DT001', 'CT004'),
('TR004', 'DT002', 'CT005'),
('TR005', 'DT003', 'CT002'),
('TR006', 'DT004', 'CT001'),
('TR007', 'DT003', 'CT003'),
('TR008', 'DT001', 'CT002'),
('TR009', 'DT002', 'CT001'),
('TR009', 'DT004', 'CT002'),
('TR010', 'DT002', 'CT004'),
('TR010', 'DT005', 'CT003')

GO
EXEC sp_MSforeachtable 'SELECT * FROM ?'