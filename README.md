📚 Online Bookstore SQL Project



📌 Project Overview



This project demonstrates end-to-end \*\*SQL skills\*\* by designing and querying an \*\*Online Bookstore database\*\*. The project includes database creation, table design, CSV data import, and execution of real-world business queries.



It is designed to showcase \*\*practical SQL knowledge\*\* suitable for \*\*Data Analyst / SQL Developer\*\* roles.



---


🛠️ Tools \& Technologies



Database: MySQL 8.0

Language: SQL

Tool: MySQL Workbench

Data Source: CSV files



---



🗂️ Database Structure



The database contains three main tables:



1️⃣ Books



Stores book-related information.



\* Book\_ID (Primary Key)

\* Title

\* Author

\* Genre

\* Published\_Year

\* Price

\* Stock



2️⃣ Customers



Stores customer details.



\* Customer\_ID (Primary Key)

\* Name

\* Email

\* Phone

\* City

\* Country



3️⃣ Orders



Stores order transactions.



\* Order\_ID (Primary Key)

\* Customer\_ID (Foreign Key)

\* Book\_ID (Foreign Key)

\* Order\_Date

\* Quantity

\* Total\_Amount



---



📥 Data Import Process



\* Data was stored in \*\*CSV format\*\*

\* Imported using `LOAD DATA LOCAL INFILE`

\* Header rows ignored

\* Date values handled using `STR\_TO\_DATE()`



---



🔍 SQL Queries Implemented



🔹 Basic Queries



\* Retrieve books by genre

\* Filter books by published year

\* Find customers by country

\* Calculate total stock

\* Identify most expensive book



🔹 Intermediate Queries



\* Customers ordering multiple quantities

\* Orders above a certain amount

\* Distinct genres available

\* Total revenue calculation



🔹 Advanced Queries



\* Total books sold per genre

\* Most frequently ordered book

\* Customers with highest spending

\* Remaining stock after orders

\* Cities with high-spending customers



---



📊 Key Insights



\* Identified top-selling genres and authors

\* Analyzed customer purchase behavior

\* Calculated revenue and stock impact

\* Demonstrated joins, subqueries, grouping, and aggregation



---



🎯 Skills Demonstrated



\* Database design \& normalization

\* CSV data handling

\* Complex joins \& aggregations

\* Subqueries \& filtering

\* Real-world business problem solving using SQL



---



🚀 How to Run the Project



1\. Create the database using the provided SQL script

2\. Create tables in correct order

3\. Enable `local\_infile`

4\. Import CSV files into respective tables

5\. Run analytical queries



---


📁 Project Files



\* `OnlineBookstore.sql` – Complete SQL script

\* `Books.csv`

\* `Customers.csv`

\* `Orders.csv`

\* `README.md`



---


👩‍💻 Author



AMrita SIngh

Aspiring Data Analyst | SQL | Python | Power BI | Excel | Data Analytics



---



⭐ This project is created for learning, portfolio, and interview preparation purposes.





