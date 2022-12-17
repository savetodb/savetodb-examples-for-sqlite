-- =============================================
-- Application: Sample 08 - Northwind
-- Version 10.6, December 13, 2022
--
-- Copyright 2017-2022 Gartle LLC
--
-- License: MIT
-- =============================================

DELETE FROM objects             WHERE TABLE_NAME IN ('CustomerIndex', 'CustomersByIndex', 'OrderDetailsByOrderID', 'OrdersByCustomerID');
DELETE FROM translation         WHERE TABLE_NAME IN ('CustomerIndex', 'CustomersByIndex', 'OrderDetailsByOrderID', 'OrdersByCustomerID');
DELETE FROM formats             WHERE TABLE_NAME IN ('CustomerIndex', 'CustomersByIndex', 'OrderDetailsByOrderID', 'OrdersByCustomerID');
DELETE FROM handlers            WHERE TABLE_NAME IN ('CustomerIndex', 'CustomersByIndex', 'OrderDetailsByOrderID', 'OrdersByCustomerID');

DROP VIEW  Sales;
DROP TABLE OrderDetails;
DROP TABLE InternationalOrders;
DROP TABLE Orders;
DROP TABLE EmployeesTerritories;
DROP TABLE PreviousEmployees;
DROP TABLE Employees;
DROP TABLE Products;
DROP TABLE Customers;
DROP TABLE Categories;
DROP TABLE Suppliers;
DROP TABLE Territories;
DROP TABLE Regions;

-- print Application removed
