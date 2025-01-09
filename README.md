**COMPANY**:CODTECH IT SOLUTION
**NAME**:HAFSA Y
**INTERN ID**:CT0806D0 
**DOMAIN:SQL**
**BATCH DURATION**:20/12/24-20/01/25 
**MENTOR NAME**:Neela Santhosh Kumar
# DATA-ANALYSIS-WITH-COMPLEX-QUERIES


---

### **Project Overview**

This project demonstrates advanced SQL techniques using **Common Table Expressions (CTEs)** and **Window Functions** to analyze sales data. The objective is to generate a comprehensive report that showcases monthly sales trends, cumulative sales, customer rankings, and detailed order information.

---

### **Features**

1. **Monthly Sales Analysis**  
   - Calculates total sales for each month.  
   - Ranks months based on total sales using the `RANK()` window function.  
   - Truncates the order date to the start of each month using `DATE_FORMAT()`.

2. **Cumulative Sales**  
   - Computes cumulative sales over time using the `SUM()` window function.  
   - Calculates a moving average of total sales using `AVG()` with a range window.

3. **Customer Sales Analysis**  
   - Aggregates total sales and total orders per customer.  
   - Ranks customers by total sales using the `RANK()` function.  
   - Computes the percentage contribution of each customer to overall sales.

4. **Detailed Order Information**  
   - Provides a detailed breakdown of orders for each customer.  
   - Includes running totals, moving averages, previous and next orders using various window functions like `SUM()`, `AVG()`, `LAG()`, and `LEAD()`.  
   - Identifies the first order amount using `FIRST_VALUE()`.  
   - Retrieves the maximum and minimum order amounts for each customer.

---

### **SQL Techniques Used**

1. **Common Table Expressions (CTEs)**  
   - Four CTEs are used to structure the query logically:
     - `monthly_sales`: Monthly sales totals and rankings.
     - `cumulative_sales`: Cumulative and moving average sales.
     - `customer_sales`: Aggregated sales and rankings by customer.
     - `detailed_sales`: Detailed order breakdown with advanced window functions.

2. **Window Functions**  
   - `RANK()`, `SUM()`, `AVG()`, `LAG()`, `LEAD()`, `FIRST_VALUE()`, `MAX()`, and `MIN()` are used extensively to perform advanced calculations over specific partitions of data.

3. **Date Formatting**  
   - `DATE_FORMAT(order_date, '%Y-%m-01')` is used to truncate dates to the start of the month since `DATE_TRUNC()` is not available in MySQL.

---

### **Dependencies**

- **MySQL 8.0 or higher**: Ensure that your MySQL version supports CTEs and window functions.

---

### **Usage**

1. **Run the SQL Script**  
   - Copy the provided SQL query and run it in your MySQL environment.
   - The query will generate a report combining monthly sales trends, cumulative sales, customer rankings, and detailed order information.

2. **Expected Output**  
   The result will be a comprehensive table with columns such as:
   - `customer_id`: Unique identifier for each customer.
   - `customer_total_sales`: Total sales made by the customer.
   - `total_orders`: Number of orders placed by the customer.
   - `customer_rank`: Rank of the customer based on total sales.
   - `order_id`, `order_date`, `order_amount`: Detailed order information.
   - `running_total`: Running total of sales for each customer.
   - `moving_avg_3`: Moving average of sales over a window of three orders.
   - `previous_order`, `next_order`: Amounts of the previous and next orders.
   - `monthly_total_sales`: Total sales for each month.
   - `month_rank`: Rank of the month based on total sales.
   - `cumulative_total`: Cumulative sales up to the current month.
   - `moving_avg`: Moving average of monthly sales.

---

### **Example Query Output**

| customer_id | customer_total_sales | total_orders | customer_rank | order_id | order_date | order_amount | order_number | running_total | moving_avg_3 | previous_order | next_order | first_order_amount | max_order_amount | min_order_amount | month     | monthly_total_sales | month_rank | cumulative_total | moving_avg |
|-------------|----------------------|--------------|---------------|----------|------------|--------------|--------------|---------------|--------------|----------------|------------|--------------------|------------------|------------------|-----------|---------------------|------------|------------------|------------|
| 101         | 1500                 | 5            | 1             | 1        | 2024-01-01 | 300          | 1            | 300           | 350          | NULL           | 400        | 300                | 500              | 300              | 2024-01-01 | 500                 | 2          | 500              | 500        |
| 102         | 1200                 | 4            | 2             | 2        | 2024-02-01 | 400          | 1            | 400           | 450          | NULL           | 500        | 400                | 600              | 400              | 2024-02-01 | 700                 | 1          | 1200             | 600        |

---

### **Further Improvements**

- **Additional Metrics**: The query can be extended to include additional metrics such as median sales, sales growth rates, or customer retention rates.
- **Visualization**: Use a reporting tool like **Tableau**, **Power BI**, or **Excel** to visualize the generated data.
- **Optimization**: For large datasets, consider indexing columns used in `GROUP BY` and `JOIN` operations.



