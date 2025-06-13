select*from Books;
select*from employee_data ;
select*from Customers;
select*from Orders;


--1)retrieve all the books in the 'biography' genre:
select*from Books
where Genre='Biography';

--2)find the book published after 1950:
select * from Books 
where Published_Year > 1950;

--3)List all the customers from canada:
select*from Customers
where Country='Canada';

--4)show ordered placed in november 2023:
select*from Orders
where Order_Date between'2023-11-01' AND '2023-11-30';

--5)retrieve the total staock of books available:
SELECT SUM(CONVERT(INT, Stock)) AS Total_Stock
FROM Books;

--6)find the details of most expensive book:
SELECT TOP 1 * 
FROM Books 
ORDER BY Price DESC;

--7)show all the customers who ordered quantity more than 1 book:
select*from Orders
where Quantity>1;

--8)Retrieve all orders where total amount exceed $20:
select*from Orders 
where Total_Amount>$20;

--9)list all generes available in the book table:
select DISTINCT Genre from Books;

-- 10) Find the book with the lowest stock:
SELECT TOP 1 * FROM Books
ORDER BY Stock ASC;

-- 11) Calculate the total revenue generated from all Orders:
SELECT SUM(CONVERT(INT, Total_Amount)) AS Revenue
FROM Orders;

--ADVANCE QUESTION:
--1)retrieve the total no of books sold for each genre:
select b.Genre,SUM(CONVERT(INT,O.Quantity))as Total_Book_Sold
from Orders o
JOIN Books b on o.Book_ID=b.Book_ID
GROUP BY b.Genre;

--2)find the Average Price of Books in the 'Fantasy' Genre:
select AVG(Price) as Average_Price
from Books 
where Genre='Fantasy';

--3)list customers who have placed atleast 2 orders:
select Customer_id,COUNT(Order_id)as Order_COUNT from Orders
Group by Customer_ID
HAVING COUNT(Order_ID) >= 2;
--3)list customers  name who have placed atleast 2 orders:
select o.Customer_ID,c.Name,COUNT(o.Order_id)ORDER_COUNT
from Orders o
join Customers c on o.Customer_id=c.Customer_ID
GROUP BY o.Customer_ID,c.Name
HAVING COUNT(Order_ID) >= 2;

--4)find the most frequently ordered book:
SELECT TOP 1 Book_id, COUNT(Order_id) AS ORDER_COUNT
FROM Orders
GROUP BY Book_id
ORDER BY ORDER_COUNT DESC;
--4)find the most frequently ordered book name:
select TOP 1 o.Book_id,b.Title,COUNT(o.Order_id)as ORDER_COUNT
from Orders o
join Books b on o.Book_id=b.Book_id
GROUP BY o.Book_id,b.Title
ORDER BY ORDER_COUNT DESC;

--5)show the top 3 most expensive book of 'Fantasy' genre
SELECT TOP 3 *
FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC;

--6)retrieve the total quantity of books sold by each author:
select b.Author ,sum(CONVERT(INT,o.Quantity))as Total_Books_Sold
from Orders o
join Books b on o.Book_ID=b.Book_ID
group by b.Author;

--7) list the cities where customers who spent over $30 are located
select DISTINCT c.City,Total_Amount
from Orders o
join Customers c on o.Customer_ID=c.Customer_ID
where o.Total_Amount> $30;

--8)find the customers who spent most on Orders:
select TOP 1  c. Customer_id,c.Name,SUM(CONVERT(float,o.Total_Amount))as Total_Spent
from Orders o
join Customers c on o.Customer_ID=c.Customer_ID
group by c.Customer_ID,c.Name
order by Total_Spent DESC;

--9)calculate the stock remaining after fullfilling all orders :
SELECT b.Book_id, b.Title, b.Stock,
    COALESCE(SUM(CAST(o.Quantity AS INT)), 0) AS Order_Quantity,
    b.Stock - COALESCE(SUM(CAST(o.Quantity AS INT)), 0) AS Remaining_Stock
FROM 
    Books b
LEFT JOIN 
    Orders o ON b.Book_id = o.Book_id
GROUP BY 
    b.Book_id, b.Title, b.Stock;
