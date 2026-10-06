/* ============================================================
   PROJECT  : Sales Data Analysis
   FILE     : Sales_Analysis.sql
   DATABASE : Oracle SQL
   AUTHOR   : Vaibhavi Kamble
   ============================================================ */

-- ============================================================
-- 1. CLEANUP
-- ============================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Sales CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Products CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Customers CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Employees CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Categories CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ============================================================
-- 2. CREATE TABLES
-- ============================================================

CREATE TABLE Categories (
    category_id NUMBER(5) PRIMARY KEY,
    category_name VARCHAR2(100) NOT NULL
);

CREATE TABLE Products (
    product_id NUMBER(5) PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL,
    category_id NUMBER(5),
    price NUMBER(10,2) CHECK (price > 0),
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
);

CREATE TABLE Customers (
    customer_id NUMBER(5) PRIMARY KEY,
    customer_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(50),
    state VARCHAR2(50)
);

CREATE TABLE Employees (
    employee_id NUMBER(5) PRIMARY KEY,
    employee_name VARCHAR2(100) NOT NULL,
    department VARCHAR2(50),
    salary NUMBER(10,2) CHECK (salary > 0)
);

CREATE TABLE Sales (
    sale_id NUMBER(5) PRIMARY KEY,
    customer_id NUMBER(5),
    product_id NUMBER(5),
    employee_id NUMBER(5),
    quantity NUMBER(5) CHECK (quantity > 0),
    sale_date DATE,
    discount NUMBER(5,2) DEFAULT 0 CHECK (discount BETWEEN 0 AND 100),

    CONSTRAINT fk_sale_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    CONSTRAINT fk_sale_product
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id),

    CONSTRAINT fk_sale_employee
        FOREIGN KEY (employee_id)
        REFERENCES Employees(employee_id)
);

-- ============================================================
-- 3. INSERT CATEGORIES
-- ============================================================

INSERT INTO Categories VALUES (1, 'Electronics');
INSERT INTO Categories VALUES (2, 'Furniture');
INSERT INTO Categories VALUES (3, 'Clothing');
INSERT INTO Categories VALUES (4, 'Books');
INSERT INTO Categories VALUES (5, 'Home Appliances');

-- ============================================================
-- 4. INSERT PRODUCTS
-- ============================================================

INSERT INTO Products VALUES (101, 'Laptop', 1, 65000);
INSERT INTO Products VALUES (102, 'Smartphone', 1, 30000);
INSERT INTO Products VALUES (103, 'Headphones', 1, 2500);
INSERT INTO Products VALUES (104, 'Office Chair', 2, 7500);
INSERT INTO Products VALUES (105, 'Office Table', 2, 12000);
INSERT INTO Products VALUES (106, 'T-Shirt', 3, 800);
INSERT INTO Products VALUES (107, 'Jeans', 3, 1800);
INSERT INTO Products VALUES (108, 'SQL Book', 4, 650);
INSERT INTO Products VALUES (109, 'Java Book', 4, 750);
INSERT INTO Products VALUES (110, 'Washing Machine', 5, 28000);
INSERT INTO Products VALUES (111, 'Microwave Oven', 5, 12000);

-- ============================================================
-- 5. INSERT CUSTOMERS
-- ============================================================

INSERT INTO Customers VALUES (201, 'Rahul Sharma', 'Mumbai', 'Maharashtra');
INSERT INTO Customers VALUES (202, 'Priya Patil', 'Pune', 'Maharashtra');
INSERT INTO Customers VALUES (203, 'Amit Shah', 'Ahmedabad', 'Gujarat');
INSERT INTO Customers VALUES (204, 'Sneha Joshi', 'Nashik', 'Maharashtra');
INSERT INTO Customers VALUES (205, 'Rohan Mehta', 'Surat', 'Gujarat');
INSERT INTO Customers VALUES (206, 'Neha Singh', 'Delhi', 'Delhi');
INSERT INTO Customers VALUES (207, 'Akash Verma', 'Bangalore', 'Karnataka');
INSERT INTO Customers VALUES (208, 'Pooja Desai', 'Mumbai', 'Maharashtra');
INSERT INTO Customers VALUES (209, 'Vikas Gupta', 'Pune', 'Maharashtra');
INSERT INTO Customers VALUES (210, 'Anjali Rao', 'Bangalore', 'Karnataka');

-- ============================================================
-- 6. INSERT EMPLOYEES
-- ============================================================

INSERT INTO Employees VALUES (301, 'Amit Kumar', 'Sales', 45000);
INSERT INTO Employees VALUES (302, 'Sneha Kulkarni', 'Sales', 52000);
INSERT INTO Employees VALUES (303, 'Raj Mehta', 'Sales', 48000);
INSERT INTO Employees VALUES (304, 'Priya Shah', 'Marketing', 55000);
INSERT INTO Employees VALUES (305, 'Karan Joshi', 'Sales', 60000);
INSERT INTO Employees VALUES (306, 'Neha Patil', 'Finance', 65000);

-- ============================================================
-- 7. INSERT SALES DATA
-- ============================================================

INSERT INTO Sales VALUES (1, 201, 101, 301, 1, DATE '2026-01-05', 5);
INSERT INTO Sales VALUES (2, 202, 102, 302, 2, DATE '2026-01-08', 10);
INSERT INTO Sales VALUES (3, 203, 103, 301, 3, DATE '2026-01-12', 5);
INSERT INTO Sales VALUES (4, 204, 104, 303, 2, DATE '2026-01-15', 8);
INSERT INTO Sales VALUES (5, 205, 105, 305, 1, DATE '2026-01-20', 5);
INSERT INTO Sales VALUES (6, 206, 106, 302, 5, DATE '2026-02-03', 10);
INSERT INTO Sales VALUES (7, 207, 107, 301, 3, DATE '2026-02-07', 5);
INSERT INTO Sales VALUES (8, 208, 108, 304, 4, DATE '2026-02-11', 0);
INSERT INTO Sales VALUES (9, 209, 109, 302, 2, DATE '2026-02-18', 5);
INSERT INTO Sales VALUES (10, 210, 110, 305, 1, DATE '2026-02-22', 10);
INSERT INTO Sales VALUES (11, 201, 111, 301, 2, DATE '2026-03-02', 5);
INSERT INTO Sales VALUES (12, 202, 101, 302, 1, DATE '2026-03-06', 7);
INSERT INTO Sales VALUES (13, 203, 102, 303, 1, DATE '2026-03-10', 5);
INSERT INTO Sales VALUES (14, 204, 103, 301, 4, DATE '2026-03-14', 10);
INSERT INTO Sales VALUES (15, 205, 104, 305, 1, DATE '2026-03-19', 5);
INSERT INTO Sales VALUES (16, 206, 105, 302, 2, DATE '2026-03-23', 8);
INSERT INTO Sales VALUES (17, 207, 106, 301, 6, DATE '2026-04-02', 5);
INSERT INTO Sales VALUES (18, 208, 107, 303, 2, DATE '2026-04-06', 0);
INSERT INTO Sales VALUES (19, 209, 108, 304, 3, DATE '2026-04-10', 5);
INSERT INTO Sales VALUES (20, 210, 109, 302, 4, DATE '2026-04-15', 10);
INSERT INTO Sales VALUES (21, 201, 110, 305, 1, DATE '2026-04-20', 8);
INSERT INTO Sales VALUES (22, 202, 111, 301, 2, DATE '2026-04-25', 5);
INSERT INTO Sales VALUES (23, 203, 101, 302, 1, DATE '2026-05-03', 10);
INSERT INTO Sales VALUES (24, 204, 102, 303, 2, DATE '2026-05-07', 5);
INSERT INTO Sales VALUES (25, 205, 103, 301, 5, DATE '2026-05-11', 5);
INSERT INTO Sales VALUES (26, 206, 104, 305, 2, DATE '2026-05-16', 8);
INSERT INTO Sales VALUES (27, 207, 105, 302, 1, DATE '2026-05-20', 5);
INSERT INTO Sales VALUES (28, 208, 106, 301, 4, DATE '2026-05-23', 10);
INSERT INTO Sales VALUES (29, 209, 110, 305, 1, DATE '2026-05-27', 5);
INSERT INTO Sales VALUES (30, 210, 111, 303, 2, DATE '2026-05-30', 0);

COMMIT;

-- ============================================================
-- 8. BASIC SELECT QUERIES
-- ============================================================

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Sales;

-- ============================================================
-- 9. FILTERING DATA
-- ============================================================

SELECT *
FROM Products
WHERE price > 10000;

SELECT *
FROM Customers
WHERE state = 'Maharashtra';

SELECT *
FROM Employees
WHERE department = 'Sales';

SELECT *
FROM Sales
WHERE discount >= 10;

-- ============================================================
-- 10. AGGREGATE FUNCTIONS
-- ============================================================

SELECT
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity,
    AVG(quantity) AS average_quantity,
    MAX(quantity) AS maximum_quantity,
    MIN(quantity) AS minimum_quantity
FROM Sales;

SELECT
    MAX(price) AS highest_price,
    MIN(price) AS lowest_price,
    AVG(price) AS average_price
FROM Products;

-- ============================================================
-- 11. GROSS AND NET SALES
-- ============================================================

SELECT
    s.sale_id,
    p.product_name,
    s.quantity,
    p.price,
    s.discount,
    (s.quantity * p.price) AS gross_sales,
    (s.quantity * p.price) -
        ((s.quantity * p.price) * s.discount / 100) AS net_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
ORDER BY s.sale_id;

-- ============================================================
-- 12. TOTAL SALES
-- ============================================================

SELECT
    SUM(s.quantity * p.price) AS total_gross_sales,
    SUM(
        (s.quantity * p.price) -
        ((s.quantity * p.price) * s.discount / 100)
    ) AS total_net_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id;

-- ============================================================
-- 13. SALES BY PRODUCT
-- ============================================================

SELECT
    p.product_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- ============================================================
-- 14. SALES BY CUSTOMER
-- ============================================================

SELECT
    c.customer_name,
    COUNT(s.sale_id) AS total_orders,
    SUM(s.quantity) AS total_quantity,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Customers c
    ON s.customer_id = c.customer_id
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_sales DESC;

-- ============================================================
-- 15. SALES BY EMPLOYEE
-- ============================================================

SELECT
    e.employee_name,
    e.department,
    COUNT(s.sale_id) AS total_orders,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Employees e
    ON s.employee_id = e.employee_id
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY e.employee_name, e.department
ORDER BY total_sales DESC;

-- ============================================================
-- 16. GROUP BY WITH HAVING
-- ============================================================

SELECT
    p.product_name,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity * p.price) > 20000
ORDER BY total_sales DESC;

-- ============================================================
-- 17. CATEGORY-WISE SALES
-- ============================================================

SELECT
    c.category_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
JOIN Categories c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_sales DESC;

-- ============================================================
-- 18. STATE-WISE SALES
-- ============================================================

SELECT
    cu.state,
    COUNT(s.sale_id) AS total_orders,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Customers cu
    ON s.customer_id = cu.customer_id
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY cu.state
ORDER BY total_sales DESC;

-- ============================================================
-- 19. CITY-WISE SALES
-- ============================================================

SELECT
    cu.city,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Customers cu
    ON s.customer_id = cu.customer_id
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY cu.city
ORDER BY total_sales DESC;

-- ============================================================
-- 20. MONTH-WISE SALES
-- ============================================================

SELECT
    EXTRACT(YEAR FROM s.sale_date) AS sale_year,
    EXTRACT(MONTH FROM s.sale_date) AS sale_month,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY
    EXTRACT(YEAR FROM s.sale_date),
    EXTRACT(MONTH FROM s.sale_date)
ORDER BY sale_year, sale_month;

-- ============================================================
-- 21. YEAR-WISE SALES
-- ============================================================

SELECT
    EXTRACT(YEAR FROM s.sale_date) AS sale_year,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY EXTRACT(YEAR FROM s.sale_date)
ORDER BY sale_year;

-- ============================================================
-- 22. TOP 5 PRODUCTS
-- ============================================================

SELECT
    p.product_name,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;

-- ============================================================
-- 23. TOP 5 CUSTOMERS
-- ============================================================

SELECT
    cu.customer_name,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Customers cu
    ON s.customer_id = cu.customer_id
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY cu.customer_name
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;

-- ============================================================
-- 24. TOP SALES EMPLOYEE
-- ============================================================

SELECT
    e.employee_name,
    SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Employees e
    ON s.employee_id = e.employee_id
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY e.employee_name
ORDER BY total_sales DESC
FETCH FIRST 1 ROW ONLY;

-- ============================================================
-- 25. PRODUCTS ABOVE AVERAGE PRICE
-- ============================================================

SELECT
    product_id,
    product_name,
    price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
)
ORDER BY price DESC;

-- ============================================================
-- 26. EMPLOYEES ABOVE AVERAGE SALARY
-- ============================================================

SELECT
    employee_id,
    employee_name,
    salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
)
ORDER BY salary DESC;

-- ============================================================
-- 27. HIGHEST PRICED PRODUCT
-- ============================================================

SELECT
    product_name,
    price
FROM Products
WHERE price = (
    SELECT MAX(price)
    FROM Products
);

-- ============================================================
-- 28. LOWEST PRICED PRODUCT
-- ============================================================

SELECT
    product_name,
    price
FROM Products
WHERE price = (
    SELECT MIN(price)
    FROM Products
);

-- ============================================================
-- 29. CUSTOMERS SPENDING ABOVE AVERAGE
-- ============================================================

SELECT
    cu.customer_name,
    SUM(s.quantity * p.price) AS total_spending
FROM Sales s
JOIN Customers cu
    ON s.customer_id = cu.customer_id
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY cu.customer_name
HAVING SUM(s.quantity * p.price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            SUM(s2.quantity * p2.price) AS customer_total
        FROM Sales s2
        JOIN Products p2
            ON s2.product_id = p2.product_id
        GROUP BY s2.customer_id
    )
)
ORDER BY total_spending DESC;

-- ============================================================
-- 30. COMPLETE SALES REPORT
-- ============================================================

SELECT
    s.sale_id,
    s.sale_date,
    cu.customer_name,
    cu.city,
    cu.state,
    p.product_name,
    cat.category_name,
    s.quantity,
    p.price,
    s.discount,
    e.employee_name,
    e.department,
    (s.quantity * p.price) AS gross_sales,
    (s.quantity * p.price) -
        ((s.quantity * p.price) * s.discount / 100) AS net_sales
FROM Sales s
JOIN Customers cu
    ON s.customer_id = cu.customer_id
JOIN Products p
    ON s.product_id = p.product_id
JOIN Categories cat
    ON p.category_id = cat.category_id
JOIN Employees e
    ON s.employee_id = e.employee_id
ORDER BY s.sale_date;

-- ============================================================
-- 31. DISCOUNT ANALYSIS
-- ============================================================

SELECT
    discount,
    COUNT(*) AS number_of_orders,
    SUM(quantity * p.price) AS gross_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY discount
ORDER BY discount;

-- ============================================================
-- 32. DAILY SALES
-- ============================================================

SELECT
    s.sale_date,
    SUM(s.quantity * p.price) AS daily_sales
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY s.sale_date
ORDER BY s.sale_date;

-- ============================================================
-- 33. BEST SELLING PRODUCT BY QUANTITY
-- ============================================================

SELECT
    p.product_name,
    SUM(s.quantity) AS total_quantity
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
FETCH FIRST 1 ROW ONLY;

-- ============================================================
-- 34. HIGHEST REVENUE PRODUCT
-- ============================================================

SELECT
    p.product_name,
    SUM(s.quantity * p.price) AS total_revenue
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
FETCH FIRST 1 ROW ONLY;

-- ============================================================
-- 35. CUSTOMERS WITH MORE THAN 2 ORDERS
-- ============================================================

SELECT
    cu.customer_name,
    COUNT(s.sale_id) AS order_count
FROM Sales s
JOIN Customers cu
    ON s.customer_id = cu.customer_id
GROUP BY cu.customer_name
HAVING COUNT(s.sale_id) > 2
ORDER BY order_count DESC;

-- ============================================================
-- 36. EMPLOYEE SALES REPORT
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    COUNT(s.sale_id) AS total_orders,
    NVL(SUM(s.quantity * p.price), 0) AS total_sales
FROM Employees e
LEFT JOIN Sales s
    ON e.employee_id = s.employee_id
LEFT JOIN Products p
    ON s.product_id = p.product_id
GROUP BY
    e.employee_id,
    e.employee_name,
    e.department
ORDER BY total_sales DESC;

-- ============================================================
-- 37. PRODUCT PERFORMANCE REPORT
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    p.price,
    NVL(SUM(s.quantity), 0) AS units_sold,
    NVL(SUM(s.quantity * p.price), 0) AS revenue
FROM Products p
JOIN Categories cat
    ON p.category_id = cat.category_id
LEFT JOIN Sales s
    ON p.product_id = s.product_id
GROUP BY
    p.product_id,
    p.product_name,
    cat.category_name,
    p.price
ORDER BY revenue DESC;

-- ============================================================
-- 38. CUSTOMER PURCHASE REPORT
-- ============================================================

SELECT
    cu.customer_id,
    cu.customer_name,
    cu.city,
    cu.state,
    COUNT(s.sale_id) AS total_orders,
    NVL(SUM(s.quantity), 0) AS total_items,
    NVL(SUM(s.quantity * p.price), 0) AS total_spending
FROM Customers cu
LEFT JOIN Sales s
    ON cu.customer_id = s.customer_id
LEFT JOIN Products p
    ON s.product_id = p.product_id
GROUP BY
    cu.customer_id,
    cu.customer_name,
    cu.city,
    cu.state
ORDER BY total_spending DESC;

-- ============================================================
-- 39. OVERALL SALES PERFORMANCE
-- ============================================================

SELECT
    COUNT(DISTINCT s.sale_id) AS total_orders,
    COUNT(DISTINCT s.customer_id) AS total_customers,
    COUNT(DISTINCT s.product_id) AS products_sold,
    SUM(s.quantity) AS total_units_sold,
    SUM(s.quantity * p.price) AS gross_revenue,
    SUM(
        (s.quantity * p.price) -
        ((s.quantity * p.price) * s.discount / 100)
    ) AS net_revenue,
    AVG(s.quantity * p.price) AS average_order_value
FROM Sales s
JOIN Products p
    ON s.product_id = p.product_id;

-- ============================================================
-- 40. FINAL CATEGORY DASHBOARD
-- ============================================================

SELECT
    cat.category_name,
    COUNT(DISTINCT p.product_id) AS number_of_products,
    SUM(s.quantity) AS units_sold,
    SUM(s.quantity * p.price) AS gross_sales,
    SUM(
        (s.quantity * p.price) -
        ((s.quantity * p.price) * s.discount / 100)
    ) AS net_sales
FROM Categories cat
JOIN Products p
    ON cat.category_id = p.category_id
LEFT JOIN Sales s
    ON p.product_id = s.product_id
GROUP BY cat.category_name
ORDER BY net_sales DESC;

COMMIT;

/* ============================================================
   END OF SALES DATA ANALYSIS PROJECT
   ============================================================ */
