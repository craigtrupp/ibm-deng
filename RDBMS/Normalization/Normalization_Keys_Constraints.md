## Normalization Exercise
* Create Book Shop Table
```sql
-- Drop the tables in case they exist

DROP TABLE BookShop;
DROP TABLE BookShop_AuthorDetails;

-- Create the table

CREATE TABLE BookShop (
	BOOK_ID VARCHAR(4) NOT NULL, 
	TITLE VARCHAR(100) NOT NULL, 
	AUTHOR_NAME VARCHAR(30) NOT NULL, 
	AUTHOR_BIO VARCHAR(250),
	AUTHOR_ID INTEGER NOT NULL, 
	PUBLICATION_DATE DATE NOT NULL, 
	PRICE_USD DECIMAL(6,2) CHECK(Price_USD>0) NOT NULL
	);

-- Insert sample data into the table

INSERT INTO BookShop VALUES
('B101', 'Introduction to Algorithms', 'Thomas H. Cormen', 'Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein. He is a Full Professor of computer science at Dartmouth College and currently Chair of the Dartmouth College Writing Program.', 123 , '2001-09-01', 125),
('B201', 'Structure and Interpretation of Computer Programs', 'Harold Abelson', 'Harold Abelson, Ph.D., is Class of 1922 Professor of Computer Science and Engineering in the Department of Electrical Engineering and Computer Science at MIT and a fellow of the IEEE.', 456, '1996-07-25', 65.5),
('B301', 'Deep Learning', 'Ian Goodfellow', 'Ian J. Goodfellow is a researcher working in machine learning, currently employed at Apple Inc. as its director of machine learning in the Special Projects Group. He was previously employed as a research scientist at Google Brain.', 369, '2016-11-01', 82.7),
('B401', 'Algorithms Unlocked', 'Thomas H. Cormen', 'Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein. He is a Full Professor of computer science at Dartmouth College and currently Chair of the Dartmouth College Writing Program.', 123, '2013-05-15', 36.5),
('B501', 'Machine Learning: A Probabilistic Perspective', 'Kevin P. Murphy', '', 157, '2012-08-24', 46);

-- Retrieve all records from the table

SELECT * FROM BookShop;

```
|BOOK_ID|TITLE|AUTHOR_NAME|AUTHOR_BIO|AUTHOR_ID|PUBLICATION_DATE|PRICE_USD|
|----|----|-----|----|----|-----|-----|
|B101|Introduction to Algorithms|Thomas H. Cormen|Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles .....|123|2001-09-01|125.00|
|B201|Structure and Interpretation of Computer Programs|Harold Abelson|Harold Abelson, Ph.D., is Class of 1922 Professor of Computer Sci.....|456|1996-07-25|65.50|
|B301|Deep Learning|Ian Goodfellow|Ian J. Goodfellow is a researcher working in machine learning, currently employed at Apple Inc....|369|2016-11-01|82.70|
|B401|Algorithms Unlocked|Thomas H. Cormen|Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein...|123|2013-05-15|36.50|
|B501|Machine Learning: A Probabilistic Perspective||Kevin P. Murphy|157|2012-08-24|46.00|

<br>

#### `Enfore 2NF`
* In this scenario, to enforce 2NF you can take the author information such as AUTHOR_ID, AUTHOR_NAME and AUTHOR_BIO out of the BookShop table into another table, for example a table named BookShop_AuthorDetails. 
* You then link each book in the BookShop table to the relevant row in the BookShop_AuthorDetails table, using a unique common column such as AUTHOR_ID to link the tables

```sql
CREATE TABLE BookShop_AuthorDetails 
AS 
(SELECT DISTINCT AUTHOR_ID, AUTHOR_NAME, AUTHOR_BIO FROM BookShop) 
WITH DATA;
SELECT * FROM BookShop_AuthorDetails;
```
|AUTHOR_ID|AUTHOR_NAME|AUTHOR_BIO|
|----|----|----|
|123|Thomas H. Cormen|Thomas H. Cormen is the co-author of Introduction to Algorithms, along with Charles Leiserson, Ron Rivest, and Cliff Stein....|
|157|Kevin P. Murphy||
|369|Ian Goodfellow|Ian J. Goodfellow is a researcher working in machine learning, currently employed at Apple Inc. as its director of machine learning...|
|456|Harold Abelson|Harold Abelson, Ph.D., is Class of 1922 Professor of Computer Science and Engineering in the Department of Electrical Engineering and Computer Science at MIT|

<br>

`Drop Redundant Details`
* Now you can drop the redundant author information related columns from the BookShop table.
```sql
ALTER TABLE BookShop
DROP COLUMN AUTHOR_NAME
DROP COLUMN AUTHOR_BIO;
SELECT * FROM BookShop;
```
* Now BookShop looks like 

|BOOK_ID|TITLE|AUTHOR_ID|PUBLICATION_DATE|PRICE_USD|
|---|----|-----|-----|-----|
|B101|Introduction to Algorithms|123|2001-09-01|125.00|
|B201|Structure and Interpretation of Computer Programs|456|1996-07-25|65.50|
|B301|Deep Learning|369|2016-11-01|82.70|
|B401|Algorithms Unlocked|123|2013-05-15|36.50|
|B501|Machine Learning: A Probabilistic Perspective|157|2012-08-24|46.00|

<br>

* Now you are only storing the author information once per author and only have to update it in one place; reducing redundancy and increasing consistency of data. Thus 2NF is ensured.

--- 

<br>

### Add Primary Keys
**1.** By definition, a `primary key` is a column or group of columns that uniquely identify every row in a table. A table cannot have more than one primary key. The rules for defining a primary key are:

- No two rows can have a duplicate primary key value.
- Every row must have a primary key value.
- No primary key field can be null.

```sql
ALTER TABLE BookShop
ADD PRIMARY KEY (BOOK_ID);
ALTER TABLE BookShop_AuthorDetails
ADD PRIMARY KEY (AUTHOR_ID);
```
* Now you can use the BOOK_ID column to uniquely identify every row in the BookShop table and the AUTHOR_ID column to uniquely identify every row in the BookShop_AuthorDetails table.

--- 

<br>

### Add Foreign Key
**1.** By definition, a `foreign key` is a column that establishes a relationship between two tables. 
* It acts as a `cross-reference` between two tables because it points to the primary key of another table. 
* A table can have multiple foreign keys referencing primary keys of other tables. Rules for defining a foreign key:
	- A foreign key in the referencing table must match the structure and data type of the existing primary key in the referenced table.
	- A foreign key can only have values present in the referenced primary key
	Foreign keys do not need to be unique. Most often they aren’t.
	- Foreign keys can be null.

<br>

* You will create a foreign key for the BookShop table by setting its AUTHOR_ID column as a foreign key, to establish a relationship between the BookShop and BookShop_AuthorDetails tables.

```sql
ALTER TABLE BookShop
ADD CONSTRAINT fk_BookShop FOREIGN KEY (AUTHOR_ID)
    REFERENCES BookShop_AuthorDetails(AUTHOR_ID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
```
* Note: `ON UPDATE NO ACTION` means if any existing row is updated in the foreign key column of the referencing table (the table containing the foreign key), the update will only be allowed if the new value of the foreign key column exists in the referenced primary key column of the referenced table (the table containing the primary key). 
* However, any update on a row of the referenced primary key column of the referenced table is always rejected if there is the existence of a corresponding row in the referencing foreign key column of the referencing table.

* `ON DELETE NO ACTION` means if any row in the referenced table (the table containing the primary key) is deleted, that row in the referenced table and the corresponding row in the referencing table (the table containing the foreign key) are not deleted.\

<br>

#### `Foreign Key Constraints`
* `NO ACTION`: When the ON UPDATE or ON DELETE clauses are set to NO ACTION, the performed update or delete operation in the parent table will fail with an error.
* `CASCADE`: Setting the ON UPDATE or ON DELETE clauses to CASCADE, the same action performed on the referenced values of the parent table will be reflected to the related values in the child table. For example, if the referenced value is deleted in the parent table, all related rows in the child table are also deleted.
* `SET NULL`: With this ON UPDATE and ON DELETE clauses option, if the referenced values in the parent table are deleted or modified, all related values in the child table are set to NULL value.
* `SET DEFAULT`: Using the SET DEFAULT option of the ON UPDATE and ON DELETE clauses specifies that, if the referenced values in the parent table are updated or deleted, the related values in the child table with FOREIGN KEY columns will be set to its default value.

---

<br>

### **Constraints**
**1.** `Entity Integrity Constraint`: Entity integrity ensures that no duplicate records exist within a table and that the column identifing each record within the table is not a duplicate and not null. The existence of a primary key in both the BookShop and BookShop_AuthorDetails tables satisfies this integrity constraint because a primary key mandates NOT NULL constraint as well as ensuring that every row in the table has a value that uniquely denotes the row.

**2.** `Referential Integrity Constraint`: Referential integrity ensures the existence of a referenced value if a value of one column of a table references a value of another column. The existence of the foreign Key (AUTHOR_ID) in the BookShop table satisfies this integrity constraint because a cross-reference relationship between the BookShop and BookShop_AuthorDetails tables exists. As a result of this relationship, each book in the BookShop table will be linked to the relevant row in the BookShop_AuthorDetails table through the AUTHOR_ID columns.

**3.** `Domain Integrity Constraint`: Domain integrity ensures that the purpose of a column is clear and the values of a column are consistent as well as valid. The existence of data types, length, date format, check, and null constraints in the CREATE statement of the BookShop table makes sure this integrity constraint is satisfied.

```sql
DROP TABLE Bookshop;

CREATE TABLE Bookshop (
	book_ID VARCHAR(4) NOT NULL,
	title VARCHAR(20)  NOT NULL,
	author_name VARCHAR(50) NOT NULL,
	author_bio VARCHAR(150) DEFAULT 'AN AUTHOR WRITES BOOKS',
	publication_date DATE NOT NULL,
	price_usd DECIMAL(6,2) CHECK(price_usd > 0) NOT NULL
);
```