E-commerce-Database-Design

Objective This project demonstrates an advanced database design for an e-commerce platform, creating a comprehensive Entity-Relationship Diagram (ERD) that maps the complex relationships between products, categories, inventory, and other key e-commerce components.

Tools Used
- MySQL - Database management system
- Lucidchart - ERD design and visualization tool

Core Entities and Their Relationships

Product Management

1. Product Category Structure
   - The `product_category` table serves as a hierarchical organization system
   - It has a self-referencing relationship through `parent_category_id` allowing for nested categories
   - Categories have descriptive fields (name, description, image) and connect to `size_category`

2. Product Entity
   - The `product` table is the central entity containing general product information (name, description, etc.)
   - Products are classified into categories via `product_category_id`
   - Products are associated with brands through `brand_id`
   - Additional product details include specifications like `model_height`, `model_wearing`, and care instructions

3. Product Items
   - The `product_item` table represents specific sellable variants of products
   - Each item links to its parent product via `product_id`
   - Items have distinct colors (`color_id`) and pricing information (`original_price`, `sale_price`)
   - Product items are identified by a unique `product_code`

Variant Management

1. Product Variations
   - The `product_variation` table manages inventory for specific combinations
   - Each variation connects to a product item (`product_item_id`) and size (`size_id`)
   - Inventory tracking is handled through `qty_in_stock`

2. Size System
   - `size_category` defines groups of sizes (e.g., clothing, footwear)
   - `size_option` contains specific sizes within categories
   - Size options have a `sort_order` to maintain consistent display sequence

3. Attributes System
   - `attribute_type` defines categories of attributes (e.g., material, fit)
   - `attribute_option` contains specific values for each attribute type
   - `product_attribute` connects attributes to products, allowing for detailed specifications

Media and Brand Management

1. Product Images
   - The `product_image` table stores image references
   - Images are associated with specific product items
   - Multiple images can be stored with distinct filenames

2. Brand Information
   - The `brand` table stores brand details
   - Brands have names and descriptions
   - Products are associated with a single brand

Key Database Design Features

1. Primary and Foreign Keys
   - Each table has defined primary keys (PK)
   - Relationships between tables are established through foreign keys (FK)
   - The diagram clearly shows these relationships with connecting lines

2. Hierarchical Structures
   - Product categories form a tree structure through self-reference
   - Size categories organize specific size options

3. Product Variants
   - The system efficiently handles multiple product variations through:
     - Color variants at the product item level
     - Size variants at the product variation level
     - Additional attributes through the attribute system

4. Inventory Management
   - Stock is tracked at the specific variation level (product + color + size)
   - Each unique variation has its own inventory count

Common Query Examples

```sql
-- Find all products in a specific category
SELECT p.* FROM product p
JOIN product_category pc ON p.product_category_id = pc.product_category_id
WHERE pc.category_name = 'Shoes';

-- Get all variants of a product with inventory counts
SELECT pi.product_code, c.color_name, so.size_name, pv.qty_in_stock
FROM product p
JOIN product_item pi ON p.product_id = pi.product_id
JOIN color c ON pi.color_id = c.color_id
JOIN product_variation pv ON pi.product_item_id = pv.product_item_id
JOIN size_option so ON pv.size_id = so.size_id
WHERE p.product_name = 'Classic T-Shirt';

-- Find all products of a specific brand with their categories
SELECT p.product_name, pc.category_name, b.brand_name
FROM product p
JOIN product_category pc ON p.product_category_id = pc.product_category_id
JOIN brand b ON p.brand_id = b.brand_id
WHERE b.brand_name = 'Nike';

-- List all products that are low in stock (fewer than 5 items)
SELECT p.product_name, pi.product_code, c.color_name, so.size_name, pv.qty_in_stock
FROM product p
JOIN product_item pi ON p.product_id = pi.product_id
JOIN color c ON pi.color_id = c.color_id
JOIN product_variation pv ON pi.product_item_id = pv.product_item_id
JOIN size_option so ON pv.size_id = so.size_id
WHERE pv.qty_in_stock < 5;
```

Setup Instructions

1. Create a new MySQL database:
   ```sql
   CREATE DATABASE ecommerce_db;
   USE ecommerce_db;
   ```

2. Execute the provided SQL script to create all tables with proper relationships:
   ```
   mysql -u username -p ecommerce_db < schema.sql
   ```

3. Verify the database structure:
   ```sql
   SHOW TABLES;
   ```

4. If needed, populate with sample data:
   ```sql
   SOURCE sample_data.sql;
   ```

![E-Commerce](https://github.com/user-attachments/assets/91ffdcfc-bc7f-4190-aa1b-f47433583707)
