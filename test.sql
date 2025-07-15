-- ========================================
-- COMPLETE POSTGRESQL TUTORIAL - test.sql
-- ========================================

-- 🤔 WHAT IS A QUERY?
-- A query is a request for data from a database
-- It's written in SQL (Structured Query Language)
-- Examples: SELECT, INSERT, UPDATE, DELETE, CREATE TABLE

-- 🐘 WHAT IS POSTGRESQL AND WHY USE IT?
-- PostgreSQL is a powerful, open-source object-relational database system
-- Benefits:
-- - ACID compliance (Atomicity, Consistency, Isolation, Durability)
-- - Supports advanced data types (JSON, arrays, custom types)
-- - Excellent performance and scalability
-- - Strong community support
-- - Cross-platform compatibility
-- - Advanced features like window functions, CTEs, full-text search

-- 💻 COMMAND TO DEAL WITH SQL SHELL
-- To connect to PostgreSQL: psql -U username -d database_name
-- To run this file: psql -U postgres -d test1 -f test.sql
-- Common psql commands:
-- \l - list databases
-- \dt - list tables
-- \d table_name - describe table structure
-- \q - quit psql
-- \c database_name - connect to database

-- ========================================
-- TABLE CREATION WITH CONSTRAINTS
-- ========================================

-- 🧱 Create the 'person' table with proper constraints
CREATE TABLE person (
    id BIGSERIAL PRIMARY KEY,             -- Auto-incrementing unique identifier
    first_name VARCHAR(50) NOT NULL,      -- Required field
    last_name VARCHAR(50) NOT NULL,       -- Required field
    gender VARCHAR(7) NOT NULL,           -- Must specify gender
    date_of_birth DATE NOT NULL,          -- Birth date required
    email VARCHAR(150) UNIQUE NOT NULL,   -- Must be unique and not null
    country VARCHAR(50),                  -- Optional country field
    country_of_birth VARCHAR(50)          -- Optional birth country
);

-- 🧠 CONSTRAINT TYPES EXPLAINED:
-- PRIMARY KEY: Uniquely identifies each row, automatically creates index
-- NOT NULL: Column must have a value, prevents empty entries
-- UNIQUE: All values must be different, allows one NULL value
-- FOREIGN KEY: References another table's primary key
-- CHECK: Custom validation rule (e.g., CHECK (age >= 18))
-- DEFAULT: Sets default value if none provided

-- ✅ INSERT SAMPLE DATA
INSERT INTO person (first_name, last_name, gender, date_of_birth, email, country, country_of_birth) VALUES 
('Maryam', 'Osman', 'Female', '2000-01-01', 'maryam@example.com', 'Egypt', 'Egypt'),
('Ahmed', 'Hassan', 'Male', '1995-05-15', 'ahmed@example.com', 'Egypt', 'Sudan'),
('Sarah', 'Ali', 'Female', '1998-03-20', 'sarah@example.com', 'UAE', 'Egypt'),
('Omar', 'Mohamed', 'Male', '1992-07-10', 'omar@example.com', 'Egypt', 'Egypt'),
('Fatima', 'Ibrahim', 'Female', '1997-11-30', 'fatima@example.com', 'Egypt', 'Libya'),
('Khaled', 'Mahmoud', 'Male', '1993-09-25', 'khaled@example.com', 'Saudi', 'Egypt'),
('Nour', 'Adel', 'Female', '1999-12-05', 'nour@example.com', 'Egypt', 'Egypt'),
('Youssef', 'Farid', 'Male', '1994-02-14', 'youssef@example.com', 'Egypt', 'Egypt');

-- Generate more fake data using: https://mockaroo.com

-- ========================================
-- BASIC QUERIES AND SELECTING DATA
-- ========================================

-- 📊 BASIC SELECT - Get all records
SELECT * FROM person;

-- Select specific columns
SELECT first_name, last_name, email FROM person;

-- ========================================
-- ORDER BY - SORTING RESULTS
-- ========================================

-- 🔤 ORDER BY BASICS
-- Sorts results in ascending (ASC) or descending (DESC) order
-- Default is ASC if not specified

-- Simple sorting
SELECT * FROM person ORDER BY first_name;           -- A to Z
SELECT * FROM person ORDER BY first_name DESC;      -- Z to A
SELECT * FROM person ORDER BY date_of_birth;        -- Oldest first
SELECT * FROM person ORDER BY date_of_birth DESC;   -- Youngest first

-- 🔢 MULTIPLE COLUMN SORTING
-- First sorts by country, then by birth date within each country
SELECT * FROM person 
ORDER BY country, date_of_birth;

-- Complex sorting with different directions
SELECT * FROM person 
ORDER BY country ASC, date_of_birth DESC;

-- 🌍 REMOVE DUPLICATES WITH DISTINCT
SELECT DISTINCT country FROM person ORDER BY country;
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth;

-- Multiple columns with distinct
SELECT DISTINCT country, gender FROM person ORDER BY country, gender;

-- ========================================
-- WHERE CLAUSE - FILTERING DATA
-- ========================================

-- 🔍 BASIC WHERE EXAMPLES
SELECT * FROM person WHERE gender = 'Female';
SELECT * FROM person WHERE country = 'Egypt';
SELECT * FROM person WHERE date_of_birth > '1995-01-01';

-- 🔗 COMPLEX WHERE WITH MULTIPLE CONDITIONS
SELECT * FROM person 
WHERE country = 'Egypt' 
  AND gender = 'Female' 
  AND date_of_birth > '1995-01-01';

SELECT * FROM person 
WHERE country = 'Egypt' 
  OR country = 'UAE' 
  OR country = 'Saudi';

-- Mixed AND/OR (use parentheses for clarity)
SELECT * FROM person 
WHERE (country = 'Egypt' OR country = 'UAE') 
  AND gender = 'Female';

-- ========================================
-- COMPARISON OPERATORS
-- ========================================

-- 🔢 NUMERIC COMPARISONS
SELECT * FROM person WHERE id > 5;
SELECT * FROM person WHERE id >= 3;
SELECT * FROM person WHERE id < 7;
SELECT * FROM person WHERE id <= 4;
SELECT * FROM person WHERE id != 1;  -- or id <> 1

-- 📅 DATE COMPARISONS
SELECT * FROM person WHERE date_of_birth = '1995-05-15';
SELECT * FROM person WHERE date_of_birth > '1995-01-01';
SELECT * FROM person WHERE date_of_birth BETWEEN '1995-01-01' AND '1998-12-31';

-- 🔤 STRING COMPARISONS
SELECT * FROM person WHERE first_name = 'Ahmed';
SELECT * FROM person WHERE country != 'Egypt';

-- ========================================
-- LIMIT AND OFFSET
-- ========================================

-- 📝 LIMIT - Restrict number of results
SELECT * FROM person LIMIT 3;                    -- First 3 records
SELECT * FROM person ORDER BY first_name LIMIT 5; -- First 5 alphabetically

-- 📄 OFFSET - Skip records (useful for pagination)
SELECT * FROM person OFFSET 2;                   -- Skip first 2 records
SELECT * FROM person LIMIT 3 OFFSET 2;           -- Skip 2, then take 3
SELECT * FROM person ORDER BY id LIMIT 3 OFFSET 3; -- Page 2 of results

-- Pagination example: Page 2 with 3 records per page
SELECT * FROM person ORDER BY id LIMIT 3 OFFSET 3;

-- ========================================
-- IN AND NOT IN OPERATORS
-- ========================================

-- 📋 IN OPERATOR - Check if value exists in a list
SELECT * FROM person WHERE country IN ('Egypt', 'UAE', 'Saudi');
SELECT * FROM person WHERE gender IN ('Female');
SELECT * FROM person WHERE id IN (1, 3, 5, 7);

-- 🚫 NOT IN OPERATOR - Check if value doesn't exist in a list
SELECT * FROM person WHERE country NOT IN ('Egypt');
SELECT * FROM person WHERE id NOT IN (1, 2, 3);

-- Using subqueries with IN
SELECT * FROM person WHERE country IN (
    SELECT DISTINCT country_of_birth FROM person
);

-- ========================================
-- BETWEEN AND NOT BETWEEN
-- ========================================

-- 📊 BETWEEN - Check if value is within a range (inclusive)
SELECT * FROM person WHERE id BETWEEN 3 AND 6;
SELECT * FROM person WHERE date_of_birth BETWEEN '1995-01-01' AND '1998-12-31';

-- 🚫 NOT BETWEEN - Check if value is outside a range
SELECT * FROM person WHERE id NOT BETWEEN 3 AND 6;
SELECT * FROM person WHERE date_of_birth NOT BETWEEN '1995-01-01' AND '1998-12-31';

-- String ranges (alphabetical)
SELECT * FROM person WHERE first_name BETWEEN 'A' AND 'M';

-- ========================================
-- LIKE OPERATOR - PATTERN MATCHING
-- ========================================

-- 🔍 LIKE OPERATOR - Pattern matching with wildcards
-- % = any sequence of characters
-- _ = exactly one character

-- Names starting with 'A'
SELECT * FROM person WHERE first_name LIKE 'A%';

-- Names ending with 'ed'
SELECT * FROM person WHERE first_name LIKE '%ed';

-- Names containing 'ar'
SELECT * FROM person WHERE first_name LIKE '%ar%';

-- Names with exactly 4 characters
SELECT * FROM person WHERE first_name LIKE '____';

-- Email domains
SELECT * FROM person WHERE email LIKE '%@gmail.com';

-- Case-insensitive matching
SELECT * FROM person WHERE first_name ILIKE 'ahmed';  -- PostgreSQL specific

-- NOT LIKE
SELECT * FROM person WHERE first_name NOT LIKE 'A%';

-- ========================================
-- AGGREGATE FUNCTIONS
-- ========================================

-- 📊 COUNT - Count rows
SELECT COUNT(*) FROM person;                      -- Total rows
SELECT COUNT(*) FROM person WHERE gender = 'Female'; -- Female count
SELECT COUNT(DISTINCT country) FROM person;       -- Unique countries

-- 🔢 MAX AND MIN
SELECT MAX(date_of_birth) FROM person;           -- Youngest person
SELECT MIN(date_of_birth) FROM person;           -- Oldest person
SELECT MAX(id) FROM person;                      -- Highest ID

-- ➗ AVERAGE (AVG)
SELECT AVG(EXTRACT(YEAR FROM date_of_birth)) FROM person; -- Average birth year

-- ➕ SUM
SELECT SUM(id) FROM person;                      -- Sum of all IDs

-- 🔄 ROUND
SELECT ROUND(AVG(EXTRACT(YEAR FROM date_of_birth)), 2) FROM person;

-- ========================================
-- GROUP BY AND HAVING
-- ========================================

-- 👥 GROUP BY - Groups rows with same values
SELECT gender, COUNT(*) FROM person GROUP BY gender;
SELECT country, COUNT(*) FROM person GROUP BY country;
SELECT country, gender, COUNT(*) FROM person GROUP BY country, gender;

-- 🔍 HAVING - Filter groups (like WHERE but for groups)
SELECT country, COUNT(*) FROM person 
GROUP BY country 
HAVING COUNT(*) > 1;

-- Complex grouping with multiple conditions
SELECT country, gender, COUNT(*) as person_count
FROM person 
GROUP BY country, gender
HAVING COUNT(*) >= 2
ORDER BY person_count DESC;

-- ========================================
-- ALIASES
-- ========================================

-- 🏷️ COLUMN ALIASES
SELECT first_name AS "First Name", 
       last_name AS "Last Name", 
       email AS "Email Address" 
FROM person;

-- TABLE ALIASES
SELECT p.first_name, p.last_name, p.country
FROM person AS p
WHERE p.gender = 'Female';

-- Aliases in calculations
SELECT first_name,
       EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth) AS age
FROM person;

-- ========================================
-- COALESCE - HANDLING NULL VALUES
-- ========================================

-- 🔄 COALESCE - Returns first non-null value
SELECT first_name, 
       COALESCE(country, 'Unknown') AS country_display
FROM person;

-- Multiple fallback values
SELECT first_name,
       COALESCE(country, country_of_birth, 'Not Specified') AS location
FROM person;

-- ========================================
-- TIMESTAMPS AND DATES
-- ========================================

-- 📅 CURRENT DATE AND TIME
SELECT CURRENT_DATE;                             -- Current date
SELECT CURRENT_TIME;                             -- Current time
SELECT CURRENT_TIMESTAMP;                       -- Current date and time
SELECT NOW();                                    -- Same as CURRENT_TIMESTAMP

-- 🔢 EXTRACTING FIELDS FROM DATES
SELECT first_name, 
       date_of_birth,
       EXTRACT(YEAR FROM date_of_birth) AS birth_year,
       EXTRACT(MONTH FROM date_of_birth) AS birth_month,
       EXTRACT(DAY FROM date_of_birth) AS birth_day
FROM person;

-- Age calculation
SELECT first_name,
       date_of_birth,
       EXTRACT(YEAR FROM AGE(date_of_birth)) AS age
FROM person;

-- ➕ ADDING AND SUBTRACTING FROM DATES
SELECT first_name,
       date_of_birth,
       date_of_birth + INTERVAL '1 year' AS next_birthday,
       date_of_birth - INTERVAL '1 month' AS one_month_before
FROM person;

-- 📊 INTERVAL EXAMPLES
SELECT first_name,
       date_of_birth + INTERVAL '5 years 3 months 2 days' AS future_date
FROM person;

-- People born in specific year
SELECT * FROM person WHERE EXTRACT(YEAR FROM date_of_birth) = 1995;

-- ========================================
-- PRIMARY KEYS
-- ========================================

-- 🔑 PRIMARY KEY CONCEPTS
-- - Uniquely identifies each row
-- - Cannot be NULL
-- - Cannot be duplicated
-- - Automatically creates an index
-- - Only one primary key per table

-- View table structure
-- \d person  (in psql command line)

-- ========================================
-- ALTER TABLE - MODIFYING TABLE STRUCTURE
-- ========================================

-- 🔧 ADDING COLUMNS
ALTER TABLE person ADD COLUMN phone VARCHAR(20);
ALTER TABLE person ADD COLUMN salary DECIMAL(10,2);

-- 🔧 ADDING PRIMARY KEY TO EXISTING TABLE
-- (Only if table doesn't already have one and values are unique)
-- ALTER TABLE person ADD PRIMARY KEY (id);

-- 🔧 ADDING UNIQUE CONSTRAINTS
ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE (email);

-- Multiple column unique constraint
ALTER TABLE person ADD CONSTRAINT unique_name_birth 
UNIQUE (first_name, last_name, date_of_birth);

-- ========================================
-- UNIQUE CONSTRAINTS VS PRIMARY KEY
-- ========================================

-- 📋 DIFFERENCES:
-- PRIMARY KEY:
-- - Only one per table
-- - Cannot be NULL
-- - Automatically creates clustered index
-- - Used for foreign key references

-- UNIQUE:
-- - Multiple unique constraints per table
-- - Can have one NULL value
-- - Creates non-clustered index
-- - Can be referenced by foreign keys

-- ========================================
-- CHECK CONSTRAINTS
-- ========================================

-- ✅ CHECK CONSTRAINT - Boolean condition validation
ALTER TABLE person ADD CONSTRAINT check_gender 
CHECK (gender IN ('Male', 'Female'));

ALTER TABLE person ADD CONSTRAINT check_birth_date 
CHECK (date_of_birth <= CURRENT_DATE);

-- Age constraint
ALTER TABLE person ADD CONSTRAINT check_age 
CHECK (EXTRACT(YEAR FROM AGE(date_of_birth)) >= 0);

-- ========================================
-- DELETE OPERATIONS
-- ========================================

-- 🗑️ DELETE RECORDS
-- Delete specific record
DELETE FROM person WHERE id = 8;

-- Delete with conditions
DELETE FROM person WHERE country = 'UAE' AND gender = 'Male';

-- Delete all records (BE CAREFUL!)
-- DELETE FROM person;  -- This deletes all data!

-- ========================================
-- UPDATE OPERATIONS
-- ========================================

-- ✏️ UPDATE RECORDS
-- Update single field
UPDATE person SET country = 'Egypt' WHERE id = 1;

-- Update multiple fields
UPDATE person SET 
    country = 'Egypt',
    phone = '+20-123-456-789'
WHERE id = 1;

-- Update with conditions
UPDATE person SET salary = 5000.00 
WHERE gender = 'Male' AND country = 'Egypt';

-- ========================================
-- ON CONFLICT (UPSERT)
-- ========================================

-- 🔄 ON CONFLICT DO UPDATE (PostgreSQL specific)
INSERT INTO person (id, first_name, last_name, gender, date_of_birth, email)
VALUES (1, 'Maryam', 'Updated', 'Female', '2000-01-01', 'maryam@example.com')
ON CONFLICT (id) DO UPDATE SET 
    first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name;

-- ON CONFLICT DO NOTHING
INSERT INTO person (first_name, last_name, gender, date_of_birth, email)
VALUES ('New', 'Person', 'Male', '1990-01-01', 'maryam@example.com')
ON CONFLICT (email) DO NOTHING;

-- ========================================
-- SEQUENCES
-- ========================================

-- 🔢 WORKING WITH SEQUENCES
-- View current sequence value
SELECT currval('person_id_seq');

-- Get next sequence value
SELECT nextval('person_id_seq');

-- Reset sequence
ALTER SEQUENCE person_id_seq RESTART WITH 100;

-- Set sequence to max existing value
SELECT setval('person_id_seq', (SELECT MAX(id) FROM person));

-- ========================================
-- UUID - UNIVERSALLY UNIQUE IDENTIFIER
-- ========================================

-- 🆔 UUID CONCEPTS
-- - 128-bit identifier
-- - Globally unique
-- - No central authority needed
-- - Useful for distributed systems

-- Enable UUID extension (run once)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create table with UUID
CREATE TABLE person_uuid (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

-- Insert with UUID
INSERT INTO person_uuid (first_name, last_name, email)
VALUES ('John', 'Doe', 'john@example.com');

-- Generate UUID manually
SELECT uuid_generate_v4();

-- ========================================
-- FOREIGN KEYS AND RELATIONSHIPS
-- ========================================

-- 🔗 CREATE RELATED TABLES
CREATE TABLE car (
    id BIGSERIAL PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    price DECIMAL(10,2),
    person_id BIGINT REFERENCES person(id)  -- Foreign key
);

-- Insert sample cars
INSERT INTO car (make, model, price, person_id) VALUES
('Toyota', 'Camry', 25000.00, 1),
('Honda', 'Civic', 22000.00, 1),    -- Person 1 has 2 cars
('BMW', 'X5', 55000.00, 2),
('Mercedes', 'C-Class', 45000.00, 3);

-- ========================================
-- JOINS - COMBINING TABLES
-- ========================================

-- 🔄 INNER JOIN - Only matching records
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
INNER JOIN car c ON p.id = c.person_id;

-- 🔄 LEFT JOIN - All persons, matched cars
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
LEFT JOIN car c ON p.id = c.person_id;

-- 🔄 RIGHT JOIN - All cars, matched persons
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
RIGHT JOIN car c ON p.id = c.person_id;

-- 🔄 FULL OUTER JOIN - All records from both tables
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
FULL OUTER JOIN car c ON p.id = c.person_id;

-- ========================================
-- QUERY PERFORMANCE ANALYSIS
-- ========================================

-- 📊 EXPLAIN - Show execution plan
EXPLAIN SELECT * FROM person WHERE country = 'Egypt';

-- 📊 EXPLAIN ANALYZE - Execute and show actual performance
EXPLAIN ANALYZE SELECT * FROM person WHERE country = 'Egypt';

-- 📊 EXPLAIN with various options
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM person WHERE country = 'Egypt';
EXPLAIN (ANALYZE, COSTS) SELECT * FROM person WHERE country = 'Egypt';
EXPLAIN (ANALYZE, TIMING) SELECT * FROM person WHERE country = 'Egypt';
EXPLAIN (ANALYZE, VERBOSE) SELECT * FROM person WHERE country = 'Egypt';
EXPLAIN (ANALYZE, FORMAT JSON) SELECT * FROM person WHERE country = 'Egypt';

-- ========================================
-- USEFUL TIPS AND BEST PRACTICES
-- ========================================

-- 💡 PERFORMANCE TIPS:
-- 1. Use indexes on frequently queried columns
-- 2. Avoid SELECT * in production
-- 3. Use appropriate data types
-- 4. Normalize your database structure
-- 5. Use LIMIT for large datasets
-- 6. Analyze query performance with EXPLAIN

-- 🔍 COMMON PATTERNS:
-- 1. Always use WHERE with UPDATE/DELETE
-- 2. Use transactions for multiple related operations
-- 3. Validate data with CHECK constraints
-- 4. Use meaningful column and table names
-- 5. Document complex queries with comments

-- 🛡️ SECURITY CONSIDERATIONS:
-- 1. Never use string concatenation for queries (SQL injection risk)
-- 2. Use parameterized queries
-- 3. Limit database user permissions
-- 4. Regularly backup your database
-- 5. Keep PostgreSQL updated

-- ========================================
-- END OF TUTORIAL
-- ========================================

-- 🎉 Voilà !
