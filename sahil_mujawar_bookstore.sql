-- ============================================================
--  SETUP
-- ============================================================

-- Create bookstore database using command
create database bookstore;

-- Use bookstore using command
use bookstore;

-- Create authors table using command
create table authors(author_id int, author_name varchar(100), country varchar(50));

-- Create books table using command
create table books(book_id int, title varchar(100), author_id int, category varchar(50), price decimal(10,2), published_year int);

-- Insert data into both table using commands
INSERT INTO authors (author_id, author_name, country) VALUES
(1, 'Rabindranath Tagore', 'India'),
(2, 'Leo Tolstoy', 'Russia'),
(3, 'Chinua Achebe', 'Nigeria'),
(4, 'Gabriel Garcia Marquez', 'Colombia'),
(5, 'Haruki Murakami', 'Japan');

INSERT INTO books
(book_id, title, author_id, category, price, published_year)
VALUES
(1, 'Gitanjali', 1, 'Poetry', 300.00, 1910),
(2, 'The Home and the World', 1, 'Historical Fiction', 380.00, 1916),

(3, 'War and Peace', 2, 'Historical Fiction', 650.00, 1869),
(4, 'Anna Karenina', 2, 'Romance', 550.00, 1878),

(5, 'Things Fall Apart', 3, 'Historical Fiction', 400.00, 1958),
(6, 'No Longer at Ease', 3, 'Literary Fiction', 350.00, 1960),

(7, 'One Hundred Years of Solitude', 4, 'Magical Realism', 500.00, 1967),
(8, 'Love in the Time of Cholera', 4, 'Romance', 480.00, 1985),

(9, 'Norwegian Wood', 5, 'Romance', 420.00, 1987),
(10, 'Kafka on the Shore', 5, 'Fantasy', 475.00, 2002);


-- ============================================================
--  SECTION 1: BASIC QUERIES
-- ============================================================

-- Task 1: Display all books.
select *  from books;

-- Task 2: Display only the book title and price.
-- Task 3: Display the book title as Book Name and price as Book Price using column aliases.
select title as "Book Name", price as "Book Price" from books;

-- Task 4: Display all unique book categories.
select distinct category as "Book Category" from books;


-- ============================================================
--  SECTION 2: FILTERING DATA
-- ============================================================

-- Task 5: Display books priced above ₹700.
select title, price from books where price > 700;

-- Task 6: Display books priced between ₹500 and ₹800.
select title, price from books where price >= 500 and price <= 800;

select title, price from books where price between 500 and 800;

-- Task 7: Display books that belong to the Programming category.
select * from books where category = "Programming";

-- Task 8: Display books whose titles start with the letter S.
select * from books where title like "S%";

-- Task 9: Display books published after 2020.
select * from books where published_year > 2020;


-- ============================================================
--  SECTION 3: SORTING AND LIMITING RESULTS
-- ============================================================

-- Task 10: Display books sorted by price in descending order.
select * from books order by price desc;

-- Task 11: Display the top 3 most expensive books.
select * from books order by price desc limit 3;


-- ============================================================
--  SECTION 4: AGGREGATE FUNCTIONS
-- ============================================================

-- Task 12: Find:

-- Total number of books
select count(title) from books;

-- Total price of all books
select sum(price) from books;

-- Average book price
select avg(price) from books;

-- Highest book price
select max(price) from books;

-- Lowest book price
select min(price) from books;


-- ============================================================
--  SECTION 5: GROUP BY AND HAVING
-- ============================================================

-- Task 13: Display the average book price for each category.
select category, avg(price) from books group by category;

-- Task 14: Display only those categories whose average book price is greater than ₹650.
select category from books group by category having avg(price) > 650 ;


-- ============================================================
--  SECTION 6: JOINS
-- ============================================================

-- Task 15: Display each book along with its author's name using an INNER JOIN.
select * from books as b inner join authors as a on a.author_id = b.author_id;

-- Task 16: Display all authors along with the books they have written using a LEFT JOIN.
select a.author_name as "Author Name", b.title as "Book Name" from authors as a left join books as b on a.author_id = b.author_id;

-- Task 17: Display all books along with their author details using a RIGHT JOIN.
select a.author_name as "Author Name", b.title as "Book Name" from books as b right join authors as a on a.author_id = b.author_id;


-- ============================================================
--  SECTION 7: DATA MANIPULATION
-- ============================================================

-- Task 18: Insert a new book into the Books table.
insert into authors values (6,"George Matthew Adams","United States");

insert into books values (11,"You can",6,"Motivational",224.00,2023);

select * from authors where author_id = 6; select * from books where author_id = 6;

-- Task 19: Update the price of the book you inserted.
update books set price = 300 where book_id = 11; select * from books where book_id = 11;

-- Task 20: Delete the book record that you inserted.
delete from authors where author_id = 6; delete from books where author_id = 6;


-- ============================================================
--  SECTION 8: CREATING TABLES AND CONSTRAINTS
-- ============================================================

-- Task 21: Create a new table named Publishers with the following columns:
--          publisher_id, publisher_name, country, established_year
--          Apply the following constraints: PRIMARY KEY, NOT NULL, UNIQUE
create table Publishers(publisher_id int primary key, publisher_name varchar(100) not null unique, country varchar(50) not null, established_year int not null);

desc publishers;