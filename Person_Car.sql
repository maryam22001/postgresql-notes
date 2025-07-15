-- ================================
-- FOREIGN KEYS AND JOINS TUTORIAL
-- ================================

-- First, let's create our base tables with proper structure
CREATE TABLE person (
    id INT PRIMARY KEY,           -- PRIMARY KEY ensures uniqueness and creates index
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    gender VARCHAR(50),
    ip_address VARCHAR(20),
    country VARCHAR(50)
);

-- Insert sample data for person table
INSERT INTO person (id, first_name, last_name, email, gender, ip_address, country) VALUES 
(1, 'Benedikt', 'Alster', 'balster0@sakura.ne.jp', 'Male', '63.200.171.19', 'Colombia'),
(2, 'Cesare', 'Jocelyn', 'cjocelyn1@1688.com', 'Male', '146.18.140.57', 'Indonesia'),
(3, 'Robinia', 'Willgoose', 'rwillgoose2@simplemachines.org', 'Female', '113.14.84.86', 'China'),
(4, 'Blithe', 'Pirdy', 'bpirdy3@devhub.com', 'Female', '162.188.130.109', 'Albania'),
(5, 'Barbey', 'Winders', 'bwinders4@google.ca', 'Female', '234.8.148.109', 'China'),
(6, 'Gabbie', 'Falkinder', 'gfalkinder5@aboutads.info', 'Male', '150.56.34.115', 'China'),
(7, 'Valina', 'Akrigg', 'vakrigg6@weebly.com', 'Female', '195.78.215.237', 'China'),
(8, 'Lilah', 'Woodworth', 'lwoodworth7@wisc.edu', 'Female', '211.50.181.6', 'Philippines');

-- Create Car table with foreign key reference
CREATE TABLE Car (
    id INT PRIMARY KEY,                    -- PRIMARY KEY for car identification
    model TEXT,
    make VARCHAR(50),
    original_price VARCHAR(50),
    ten_percent_discount DECIMAL(5,2),
    price_after_ten_percent_discount VARCHAR(50),
    person_id INT,                         -- FOREIGN KEY column
    FOREIGN KEY (person_id) REFERENCES person(id)  -- Creates relationship to person table
);

-- Insert sample data for Car table
INSERT INTO Car (id, model, make, original_price, ten_percent_discount, price_after_ten_percent_discount, person_id) VALUES 
(1, 'Forester', 'Subaru', '25000', 9.47, '22500', 1),     -- Car belongs to person 1
(2, 'Charger', 'Dodge', '35000', 26.87, '31500', 2),      -- Car belongs to person 2
(3, 'Challenger', 'Dodge', '40000', 98.3, '36000', 3),    -- Car belongs to person 3
(4, 'Jetta', 'Volkswagen', '22000', 57.74, '19800', 1),   -- Second car for person 1
(5, 'Swift', 'Suzuki', '18000', 17.55, '16200', NULL);    -- Car without owner

-- ================================
-- WHAT ARE FOREIGN KEYS?
-- ================================

/*
FOREIGN KEY DEFINITION:
- A foreign key is a field (or collection of fields) in one table that refers to the PRIMARY KEY in another table
- It creates a link between two tables
- It ensures referential integrity (you can't have a car assigned to a person that doesn't exist)
- It prevents actions that would destroy links between tables

WHAT IS REFERENCES?
- REFERENCES keyword establishes the foreign key relationship
- Syntax: FOREIGN KEY (column_name) REFERENCES parent_table(parent_column)
- It tells the database which table and column this foreign key points to
*/

-- ================================
-- RELATIONSHIP EXAMPLES
-- ================================

-- 1. ONE CAR TO ONE PERSON (1:1 relationship)
-- Car with id=1 belongs to person with id=1
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
JOIN Car c ON p.id = c.person_id
WHERE c.id = 1;

-- 2. TWO CARS TO TWO PEOPLE (1:1 for each)
-- Show cars 2 and 3 with their respective owners
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
JOIN Car c ON p.id = c.person_id
WHERE c.id IN (2, 3);

-- 3. TWO CARS TO ONE PERSON (1:Many relationship)
-- Person with id=1 has multiple cars
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
JOIN Car c ON p.id = c.person_id
WHERE p.id = 1;

-- ================================
-- INNER JOIN
-- ================================

/*
INNER JOIN:
- Returns only records that have matching values in both tables
- If a person has no car, they won't appear in results
- If a car has no owner, it won't appear in results
*/

-- EASY EXAMPLE: Show all people who own cars
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
INNER JOIN Car c ON p.id = c.person_id;

-- COMPLEX EXAMPLE: Show people from China who own cars with discount > 20%
SELECT p.first_name, p.last_name, p.country, c.make, c.model, c.ten_percent_discount
FROM person p
INNER JOIN Car c ON p.id = c.person_id
WHERE p.country = 'China' AND c.ten_percent_discount > 20;

-- ================================
-- LEFT JOIN (LEFT OUTER JOIN)
-- ================================

/*
LEFT JOIN:
- Returns ALL records from the left table (person)
- Returns matching records from the right table (Car)
- If no match, NULL values for right table columns
- Shows all people, even those without cars
*/

-- EASY EXAMPLE: Show all people and their cars (if they have any)
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
LEFT JOIN Car c ON p.id = c.person_id;

-- COMPLEX EXAMPLE: Find people without cars
SELECT p.first_name, p.last_name, p.country, c.make
FROM person p
LEFT JOIN Car c ON p.id = c.person_id
WHERE c.person_id IS NULL;

-- ================================
-- RIGHT JOIN (RIGHT OUTER JOIN)
-- ================================

/*
RIGHT JOIN:
- Returns ALL records from the right table (Car)
- Returns matching records from the left table (person)
- If no match, NULL values for left table columns
- Shows all cars, even those without owners
*/

-- EASY EXAMPLE: Show all cars and their owners (if they have any)
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
RIGHT JOIN Car c ON p.id = c.person_id;

-- COMPLEX EXAMPLE: Find cars without owners and their details
SELECT p.first_name, c.make, c.model, c.original_price
FROM person p
RIGHT JOIN Car c ON p.id = c.person_id
WHERE p.id IS NULL;

-- ================================
-- FULL OUTER JOIN
-- ================================

/*
FULL OUTER JOIN:
- Returns ALL records when there is a match in either table
- Shows all people (with or without cars) AND all cars (with or without owners)
- NULL values where no match exists
- Note: Not all databases support FULL OUTER JOIN (MySQL doesn't, PostgreSQL does)
*/

-- EASY EXAMPLE: Show all people and all cars, matched where possible
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
FULL OUTER JOIN Car c ON p.id = c.person_id;

-- For databases that don't support FULL OUTER JOIN, use UNION:
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
LEFT JOIN Car c ON p.id = c.person_id
UNION
SELECT p.first_name, p.last_name, c.make, c.model
FROM person p
RIGHT JOIN Car c ON p.id = c.person_id;

-- ================================
-- ADVANCED EXAMPLES
-- ================================

-- 1. Count cars per person
SELECT p.first_name, p.last_name, COUNT(c.id) as car_count
FROM person p
LEFT JOIN Car c ON p.id = c.person_id
GROUP BY p.id, p.first_name, p.last_name
ORDER BY car_count DESC;

-- 2. People with multiple cars
SELECT p.first_name, p.last_name, COUNT(c.id) as car_count
FROM person p
INNER JOIN Car c ON p.id = c.person_id
GROUP BY p.id, p.first_name, p.last_name
HAVING COUNT(c.id) > 1;

-- 3. Most expensive car per person
SELECT p.first_name, p.last_name, c.make, c.model, c.original_price
FROM person p
INNER JOIN Car c ON p.id = c.person_id
WHERE c.original_price = (
    SELECT MAX(c2.original_price)
    FROM Car c2
    WHERE c2.person_id = p.id
);

-- ================================
-- IMPORTANT NOTES
-- ================================

/*
KEY POINTS TO REMEMBER:

1. FOREIGN KEY CONSTRAINTS:
   - Prevent orphaned records (cars without valid owners)
   - Maintain data integrity
   - Can cascade deletes/updates if configured

2. JOIN PERFORMANCE:
   - Always index foreign key columns
   - Primary keys are automatically indexed
   - Use appropriate join types for your use case

3. NULL VALUES:
   - Foreign keys can be NULL (unless specified NOT NULL)
   - Be careful with NULL comparisons in WHERE clauses
   - Use IS NULL or IS NOT NULL for NULL checks

4. REFERENTIAL INTEGRITY:
   - Cannot insert a car with person_id that doesn't exist in person table
   - Cannot delete a person who has cars (unless CASCADE is set)
   - Database enforces these rules automatically

5. BEST PRACTICES:
   - Always use meaningful table and column names
   - Document relationships in your schema
   - Consider using ON DELETE CASCADE or ON UPDATE CASCADE when appropriate
   - Test your joins with sample data before production use
*/

-- ================================
-- TROUBLESHOOTING COMMON ISSUES
-- ================================

-- Issue 1: No results in INNER JOIN
-- Check if foreign key values actually exist in both tables
SELECT person_id, COUNT(*) FROM Car GROUP BY person_id;
SELECT id FROM person WHERE id NOT IN (SELECT DISTINCT person_id FROM Car WHERE person_id IS NOT NULL);

-- Issue 2: Duplicate results
-- Make sure you're not creating cartesian products
-- Use DISTINCT if needed, but investigate why duplicates exist

-- Issue 3: NULL vs empty results
-- Remember: NULL foreign keys won't match in INNER JOIN
-- Use LEFT JOIN to include records with NULL foreign keys
