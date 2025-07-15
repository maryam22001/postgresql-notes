# PostgreSQL Learning Notes

A beginner-friendly collection of PostgreSQL tutorial notes and SQL practice files.

## 📚 What's This?

These are my notes from a comprehensive PostgreSQL tutorial, organized for easy learning and reference. Perfect for beginners who want to learn database fundamentals.

**Original Tutorial**: [PostgreSQL Tutorial](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbm5vR0pBMmduNldEYzQ0c1N2elNKczN0VndIUXxBQ3Jtc0tuYy05aERTWWgxRUN4andXbTdsQUxOTXVkTUZuX2JjZ0VwdU1Kc3pVdDU1R2ZLTWEyOHJXb3NGNzNLX1JtYnMwQ21rbzhGVVZ0TmllUnVNS3ZkZU9aVTdJd2Fhd0E2SUlJSHYzdHlRenRSeEE5NU16VQ&q=http%3A%2F%2Fbit.ly%2F2ClGPdY&v=qw--VYLpxG4)

## 📁 Files

- `paste.txt` - Complete tutorial notes with timestamps
- `person.sql` - Basic table operations and queries
- `Car.sql` - Working with different data types
- `Person_Car.sql` - Connecting tables (relationships)
- `test.sql` - Practice queries and experiments

## 🎯 What You'll Learn

### Basics
- Creating databases and tables
- Adding, updating, and deleting data
- Simple queries with filtering and sorting

### Intermediate
- Grouping data and calculations
- Working with dates and numbers
- Data constraints and validation

### Advanced
- Connecting tables with foreign keys
- Handling duplicate data
- Exporting data to files

## 🚀 How to Use

1. **Install PostgreSQL** on your computer
2. **Clone this repo** to your local machine
3. **Open terminal** and connect to PostgreSQL with `psql`
4. **Start with `person.sql`** for basic concepts
5. **Follow with `Car.sql`** and `Person_Car.sql`
6. **Use `test.sql`** to practice on your own

## 📖 Key Commands

```sql
-- Create a table
CREATE TABLE people (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INT
);

-- Add data
INSERT INTO people (name, age) VALUES ('John', 25);

-- Query data
SELECT * FROM people WHERE age > 20;

-- Connect tables
ALTER TABLE cars ADD FOREIGN KEY (owner_id) REFERENCES people(id);
```

