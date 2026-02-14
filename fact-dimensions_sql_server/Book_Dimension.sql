-- create database gravity_books_DWH;
-- Book Dimension
-- Step 1: Select the desired columns
use gravity_books;
ALTER TABLE dbo.book      ALTER COLUMN title NVARCHAR(400) NULL;
ALTER TABLE dbo.publisher ALTER COLUMN publisher_name NVARCHAR(400) NULL;

select b.book_id, b.title, b.isbn13, b.num_pages, b.publication_date, 
	bl.language_id, bl.language_code, bl.language_name,
	p.publisher_id, p.publisher_name

from dbo.book as b
left join dbo.book_language as bl
on b.language_id=bl.language_id
join dbo.publisher as p
on b.publisher_id=p.publisher_id;

-- Step 2: Creating the dimension
use gravity_books_DWH;

create table dim_books
(
	book_key int primary key identity(1,1),  --surrogate key
	book_id_bk int not null, -- buisness key
	title VARCHAR(400),
	isbn13 varchar(13),
	num_pages INT,
	publication_date DATE,
	language_id INT,
    language_code VARCHAR(8),
    language_name VARCHAR(50),
	publisher_id INT,
    publisher_name VARCHAR(400),

	--Metadata
	source_system_code tinyint not null,
	-- SCD
	start_date datetime,
	end_date datetime,
	is_current tinyint not null,
);


--Step 3: select the dimension after the assignment
select * from dim_books;
select * from dim_books where book_id_bk = 5;

-- Step 4: Modifications
ALTER TABLE dbo.dim_books ALTER COLUMN publisher_name NVARCHAR(400) NULL;
ALTER TABLE dbo.dim_books ALTER COLUMN title NVARCHAR(400) NULL;
-- ############################################################

 -- Author Dimension
 -- Step 1: Select the desired columns
 use gravity_books;

select author_id,
    author_name
	from author;
-- Step 2: Creating the dimension
use gravity_books_DWH;

CREATE TABLE dim_author (
	author_key INT identity(1,1),  --surrogate key
    author_id_bk INT,
    author_name VARCHAR(400),
	CONSTRAINT pk_author PRIMARY KEY (author_key)
);
 
--Step 3: select the dimension after the assignment
select * from dim_author;
select * from dim_author where author_id_bk = 5;
 -- ############################################################

 -- Author_Book Dimension
 -- Step 1: Select the desired columns
use gravity_books;
select
    book_id ,
    author_id 
from dbo.book_author;

-- Step 2: Creating the dimension
use gravity_books_DWH;

create table dim_book_author
(

	book_key int not null, -- buisness key
	author_key int not null -- buisness key
	CONSTRAINT pk_bookauthor PRIMARY KEY (book_key, author_key),
    CONSTRAINT fk_ba_book FOREIGN KEY (book_key) REFERENCES dim_books (book_key),
    CONSTRAINT fk_ba_author FOREIGN KEY (author_key) REFERENCES dim_author (author_key)
);

--Step 3: select the dimension after the assignment
select * from dim_book_author;
select * from dim_book_author where author_key = 5;

