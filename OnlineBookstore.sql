-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the databae
USE Onlinebookstore;

-- Create Tables
CREATE TABLE Books (
	Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
    
CREATE TABLE Customers (
	Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);



SELECT * FROM customers;
SELECT * FROM books;
SELECT * FROM orders;

DESCRIBE customers;
DESCRIBE Orders;
DESCRIBE Books;


LOAD DATA LOCAL INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Books.csv'
INTO TABLE Books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Order_ID, Customer_ID, Book_ID, @order_date, Quantity, Total_Amount)
SET Order_Date = STR_TO_DATE(@order_date, '%m/%d/%Y');


-- Basic Queries
#1) Retrieve all books in the "Fiction" genre
SELECT *
FROM books
WHERE genre = 'Fiction';

#2) Find books published after the year 1950
SELECT *
FROM books
WHERE published_year > 1950;

#3) List all customers from the Canada
SELECT *
FROM customers
WHERE Country = 'Canada';

#4) Show orders placed in November 2023
SELECT *
FROM Orders
WHERE Order_Date >= '2023-11-01' 
	AND Order_Date < '2023-12-01';
    
SELECT * FROM Orders 
WHERE order_date 
BETWEEN '2023-11-01' AND '2023-11-30';

#5) Retrieve the total stock of books available
SELECT SUM(stock) AS total_stock
FROM Books;

#6) Find the details of the most expensive book
SELECT *
FROM books
WHERE Price = (SELECT MAX(Price) FROM books); 

SELECT * 
FROM Books 
ORDER BY Price DESC 
LIMIT 1;


#7) Show all customers who ordered more than 1 quantity of a book
SELECT 
c.name, o.quantity
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id
WHERE o.quantity > 1;


#8) Retrieve all orders where the total amount exceeds $20
SELECT *
FROM Orders
Where Total_Amount > 20;

#9) List all genres available in the Books table
SELECT DISTINCT genre
FROM books;

#10) Find the book with the lowest stock
SELECT *
FROM books
WHERE stock = (
SELECT min(stock) FROM books
WHERE stock > 0
);

SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;

#11) Calculate the total revenue generated from all orders
SELECT 
SUM(Total_Amount) AS total_revenue
FROM orders;

-- Advance Queries

#1) Retrieve the total number of books sold for each genre
SELECT 
	b.genre, 
    SUM(O.quantity) AS total_books_sold
FROM books b
JOIN orders o 
	ON b.book_id = o.book_id
GROUP BY b.genre;


#2) Find the average price of books in the "Fantasy" genre
SELECT AVG(Price) AS Average_Price
FROM books
WHERE genre = 'Fantasy';

#3) List customers who have placed at least 2 orders
SELECT 
	c.name, 
    COUNT(o.order_id) AS total_orders
FROM customers c 
JOIN orders o 
	ON c.customer_id = o.customer_id
GROUP BY c.name, c.customer_id
HAVING Count(o.order_id) >=2;

 #4) Find the most frequently ordered book
SELECT 
	b.book_id,
	b.title,
    COUNT(o.order_id) AS order_count
FROM books b
JOIN orders o 
	 ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;

#5) Show the top 3 most expensive books of 'Fantasy' Genre 
SELECT title, Price
FROM books
WHERE genre = 'Fantasy'
ORDER BY PRICE DESC
LIMIT 3;


#6) Retrieve the total quantity of books sold by each author
SELECT 
	b.Author, 
    SUM(o.quantity) AS Total_books_sold
FROM books b
JOIN orders o 
ON b.book_id = o.book_id
GROUP BY b.Author;

#7) List the cities where customers who spent over $30 are located
SELECT c.city, 
SUM(o.total_amount) AS Amount_spent
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.city
HAVING SUM(o.total_amount) > 30;


#8) Find the customer who spent the most on orders
SELECT 
	c.name, 
	SUM(o.total_Amount) AS total_spent 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY SUM(o.total_Amount) DESC
LIMIT 1;


#9) Calculate the stock remaining after fulfilling all orders

SELECT 
	b.book_id,
    b.title,
    b.stock
		- COALESCE(SUM(o.quantity), 0) AS remaining_stock
	FROM books b
LEFT JOIN orders o 
  ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;
