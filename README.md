# 📊 Data Analysis Project: Data Insertion and Querying using PostgreSQL (pgAdmin4)

## 📁 Project Overview

This project demonstrates how to create and manipulate a basic e-commerce-style relational database using PostgreSQL (executed via pgAdmin4). It covers:

- Creating multiple related tables
- Inserting sample data
- Running complex SQL queries
- Using joins, subqueries, aggregate functions, views, and indexing

---

## 🧱 Database Schema

### 1. Customers Table
```sql
customers(customer_id, first_name, last_name, email, city)
orders(order_id, customer_id, order_date, total_amount)
order_items(order_item_id, order_id, product_id, quantity, price)
products(product_id, name, category, price)
suppliers(supplier_id, name, contact_info)
product_suppliers(product_id, supplier_id)
