
## 🗃️ Database Schema
The project uses an e-commerce database with the following tables:

### Tables:
1. **customers** - Customer information
2. **products** - Product catalog  
3. **orders** - Order headers
4. **order_items** - Order line items

## 📊 SQL Concepts Demonstrated

### 1. Basic Operations
- SELECT statements with WHERE clauses
- ORDER BY for sorting
- GROUP BY for aggregation
- HAVING for filtered aggregation

### 2. JOIN Operations
- INNER JOIN, LEFT JOIN, RIGHT JOIN
- Multiple table joins

### 3. Advanced Queries
- Subqueries and nested SELECT statements
- Aggregate functions (SUM, AVG, COUNT)
- NULL value handling with COALESCE

### 4. Database Views
- **customer_order_summary** - Customer analytics
- **product_performance** - Product sales metrics  
- **monthly_sales** - Revenue trends
- **customer_lifetime_value** - Customer value analysis
- **category_performance** - Category-wise performance

## 🚀 Setup Instructions

### Prerequisites
- SQLite installed on your system

### Installation Steps
1. Clone this repository
2. Create and setup the database:
   ```bash
   sqlite3 ecommerce.db
