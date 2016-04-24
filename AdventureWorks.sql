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
SELECT s.SalesOrderID, s.UnitPrice
FROM ProductAW p JOIN SalesOrderDetail s ON p.ProductID = s.ProductID
GROUP BY s.SalesOrderID
HAVING count(p.ProductID) = 1;

-- #8. Where did the racing socks go? 
-- List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.

SELECT p1.Name, c1.CompanyName
FROM CustomerAW c1
JOIN SalesOrderHeader s2 ON c1.CustomerID = s2.CustomerID
JOIN SalesOrderDetail s1 ON s1.SalesOrderID = s2.SalesOrderID
JOIN ProductAW p1 ON s1.ProductID = p1.ProductID
JOIN ProductModel p2 ON p1.ProductModelID = p2.ProductModelID
WHERE p2.Name = 'Racing Socks'

-- #9. Show the product description for culture 'fr' for product with ProductID 736.
SELECT p1.Description
FROM ProductDescription p1 
JOIN ProductModelProductDescription p2 ON p1.ProductDescriptionID = p2.ProductDescriptionID
JOIN ProductModel p3 ON p2.ProductModelID = p3.ProductModelID
JOIN ProductAW p4 ON p4.ProductModelID = p3.ProductModelID
WHERE p4.ProductID = 736 and p2.Culture = 'fr'

-- #10. Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest. 
-- For each order show the CompanyName and the SubTotal and the total weight of the order.
SELECT c1.CompanyName, s2.SubTotal, p1.Weight
FROM ProductAW p1 
JOIN SalesOrderDetail s1 ON s1.ProductID = p1.ProductID
JOIN SalesOrderHeader s2 ON s1.SalesOrderID = s2.SalesOrderID
JOIN CustomerAW c1 ON s2.CustomerID = c1.CustomerID
ORDER BY s2.SubTotal DESC;

-- #11. How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?

-- wo shi meme ran
