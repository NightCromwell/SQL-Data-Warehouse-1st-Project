# DATA DICTIONARY / DICTIONARY FOR GOLD LAYER

#### This catalog is for the golden layer that uses the business rules, and is ready supported for analytical and report

#### Contains dimensional and fact tables using views

### 1.- **gold.dim_customers**

- **Purpose**: This VIEW contains enriched customers data.
- **Columns**:

| COLUMN NAME      | DATA TYPE     |  DESCRIPTION                                                                      |
|------------------|---------------|-----------------------------------------------------------------------------------|
| customer_key     | BIGINT        | Unique Surrogate Key that helps identify and for union with other tables (sales). |
| customer_id      | INT           | Unique Numerical Identifier assigned to each customer.                            |
| customer_number  | NVARCHAR (50) | Alphabetical identifier used for track customer.                                  |
| first_name       | NVARCHAR (50) | Customer system recorded first name.                                              |
| last_name        | NVARCHAR (50) | Customer system recorded last name or family name.                                |
| gender           | NVARCHAR (15) | Customer gender (e.g., 'Female', 'Male', 'n/a').                                  |
| birth_date       | DATE          | Customer Birhtdate with format YYYY-MM-DD (e.g., '2003-04-12').                   |
| marital_status   | NVARCHAR (15) | Customer marital status (e.g., 'Married', 'Single').                              |
| country          | NVARCHAR (50) | Customer Country of residence (e.g., 'Germany')                                   |
| create_date      | DATE          | The Date when the customer was r3ecorded in the system.                           |

==================================================================================

### 2.- **gold.dim_products**

- **Purpose**: This VIEW contains enriched products data.
- **Columns**:

| COLUMN NAME        | DATA TYPE     |  DESCRIPTION                                                                      |
|--------------------|---------------|-----------------------------------------------------------------------------------|
| product_key        | BIGINT        | Unique Surrogate Key that helps identify and for union with other tables (sales). |
| product_id         | INT           | Unique Numerical Identifier assigned to each product for referencing.             |
| product_number     | NVARCHAR (50) | Alphabetical identifier used for track product for categorization and inventory.  |
| product_name       | NVARCHAR (50) | Product descriptive name.                                                         |
| category_id        | NVARCHAR (50) | Unique Identifier for the category for analytics.                                 |
| category           | NVARCHAR (30) | Categorization of the product (e.g., 'bikes', 'Components').                      |
| subcategory        | NVARCHAR (30) | A detailed categorization of product.                                             |
| cost               | INT           | Cost of the product using monetary DOLAR unit.                                    |
| product_line       | NVARCHAR (20) | Series or product line (e.g. 'Mountain', 'Road').                                 |
| maintenance        | NVARCHAR (20) | indicates if the product requires maintenance.                                    |
| product_start_date | DATE          | Date from when the product is available                                           |

==================================================================================

### 3.- **gold.fact_sales**

- **Purpose**: This VIEW stores transactional data for analytics.
- **Columns**:

| COLUMN NAME      | DATA TYPE     |  DESCRIPTION                                                                      |
|------------------|---------------|-----------------------------------------------------------------------------------|
| order_number     | NVARCHAR (20) | Unique Alphabetical identifier for each sale.                                     |
| product_key      | BIGINT        | Surrogate Key linked to gold.dim_products.                                        |
| customer_key     | BIGINT        | Surrogate Key linked to gold.dim_customers.                                       |
| order_date       | DATE          | Date when customer ordered.                                                       |
| ship_date        | DATE          | Date when order was shipped.                                                      |
| due_date         | DATE          | Date when order payment was due.                                                  |
| sales_amount     | INT           | The complete monetary unit for the sale (e.g., 25).                               |
| quantity         | INT           | The number of products in the sale.                                               |
| price            | INT           | Price per unit in the sale.                                                       |
