-- CustomerAW(CustomerID, FirstName, MiddleName, LastName, CompanyName, EmailAddress)

-- CustomerAddress(CustomerID, AddressID, AddressType)

-- Address(AddressID, AddressLine1, AddressLine2, City, StateProvince, CountyRegion, PostalCode)

-- SalesOrderHeader(SalesOrderID, RevisionNumber, OrderDate, CustomerID, BillToAddressID, ShipToAddressID, ShipMethod, SubTotal, TaxAmt, Freight)

-- SalesOrderDetail(SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount)

-- ProductAW(ProductID, Name, Color, ListPrice, Size, Weight, ProductModelID, ProductCategoryID)

-- ProductModel(ProductModelID, Name)

-- ProductCategory(ProductCategoryID, ParentProductCategoryID Name)

-- ProductModelProductDescription(ProductModelID, ProductDescriptionID, Culture)

-- ProductDescription(ProductDescriptionID, Description)

-- #1. Show the CompanyName for James D. Kramer
SELECT CompanyName
FROM CustomerAW
WHERE FirstName='James'
AND MiddleName='D.'
AND LastName='Kramer';

-- #2. Show the first name and the email address of customer with CompanyName 'Bike World'
SELECT FirstName, EmailAddress FROM CustomerAW 
WHERE CompanyName = 'Bike World';

-- #3. Show the CompanyName for all customers with an address in City 'Dallas'.
SELECT DISTINCT CompanyName FROM CustomerAW 
JOIN CustomerAddress ON CustomerAW.CustomerID = CustomerAddress.CustomerID
JOIN Address ON CustomerAddress.AddressID = Address.AddressID
WHERE Address.City = 'Dallas';

-- #4. How many items with ListPrice more than $1000 have been sold?
SELECT count(*)
FROM ProductAW p JOIN SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000;

-- #5. Give the CompanyName of those customers with orders over $100000. 
-- Include the subtotal plus tax plus freight.
SELECT c.CompanyName FROM CustomerAW c
JOIN SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.SubTotal > 100000;

-- #6. Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'
SELECT count(*)
FROM ProductAW paw 
JOIN SalesOrderDetail sod ON paw.ProductID = sod.ProductID
JOIN SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
JOIN CustomerAW c ON c.CustomerID = soh.CustomerID
WHERE paw.Name = 'Racing Socks, L'
ORDER BY c.CompanyName = 'Riding Cycles';

-- #7. A "Single Item Order" is a customer order where only one item is ordered. 
-- Show the SalesOrderID and the UnitPrice for every Single Item Order.

