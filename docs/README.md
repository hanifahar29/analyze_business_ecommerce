# Analyzing eCommerce Business Performance with SQL

![SQL](https://img.shields.io/badge/SQL-Analysis-orange?logo=postgresql)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database--Design-blue?logo=postgresql)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

## 📌 Overview
This project analyzes the business performance of one of the largest eCommerce marketplaces in South America that connects micro-business owners with their customers. The analysis focuses on three key aspects — **customer growth**, **product quality**, and **payment type** — to provide data-driven insights that support business decision making.

---

## 🛠️ Tools & Technologies
| Tool | Purpose |
|------|---------|
| PostgreSQL | Database management & SQL querying |
| pgAdmin | ERD design & database administration |
| GitHub | Version control & project documentation |

---

## 🗃️ Dataset
The dataset consists of 8 tables. You can find the raw data in the [dataset folder](https://github.com/hanifahar29/analyze_business_ecommerce/tree/main/dataset).

| Table | Total Rows |
|-------|-----------|
| customers | 99,441 |
| geolocation | 1,000,163 |
| order_items | 112,650 |
| order_payments | 103,886 |
| order_review | 99,224 |
| orders | 99,441 |
| products | 32,951 |
| sellers | 3,095 |

---

## 📁 Project Structure
```
analyze_business_ecommerce/
├── docs/
│   ├── project_scope.md
│   └── data_cleaning_summary.md
├── sql/
│   ├── 01_schema_definition.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_analysis_customer_growth.sql
│   ├── 04_analysis_product_quality.sql
│   └── 05_analysis_payment_type.sql
├── erd/
│   └── erd_schemas.pgerd
├── dataset/
└── README.md
```

| File/Folder | Description |
|-------------|-------------|
| [docs/](https://github.com/hanifahar29/analyze_business_ecommerce/tree/main/docs) | Project scope & data cleaning summary |
| [sql/](https://github.com/hanifahar29/analyze_business_ecommerce/tree/main/sql) | All SQL query files |
| [erd/](https://github.com/hanifahar29/analyze_business_ecommerce/tree/main/erd) | Entity Relationship Diagram |
| [dataset/](https://github.com/hanifahar29/analyze_business_ecommerce/tree/main/dataset) | Raw dataset files |

---

## 📊 Analysis & Insights

### 1. Customer Growth

| Year | Avg Monthly Active User | New Customer | Repeat Customer | Avg Order/Customer |
|------|------------------------|--------------|-----------------|-------------------|
| 2016 | 110 | 326 | 3 | 1 |
| 2017 | 3,758 | 43,708 | 1,256 | 1 |
| 2018 | 5,401 | 52,062 | 1,167 | 1 |

**Insights:**
- Monthly active users grew significantly from 110 (2016) to 5,401 (2018), indicating rapid business growth
- New customer acquisition increased drastically each year, showing strong market penetration
- Repeat customers are very low compared to total customers — most customers only order once
- Average order per customer is consistently 1, confirming low customer retention

> **Recommendation:** The business needs a customer retention strategy such as loyalty programs, personalized promotions, or email marketing to encourage repeat purchases.

---

### 2. Product Quality

| Year | Top Revenue Category | Total Revenue | Top Cancel Category | Total Cancel |
|------|---------------------|---------------|--------------------|----|
| 2016 | furniture_decor | 46,653.74 | toys | 26 |
| 2017 | bed_bath_table | 6,921,535.24 | sports_leisure | 265 |
| 2018 | health_beauty | 8,451,584.77 | health_beauty | 334 |

**Insights:**
- Revenue grew massively from 2016 to 2018, consistent with customer growth trends
- Top revenue categories shift each year — from furniture/home to health & beauty
- In 2018, `health_beauty` is both the top revenue AND top cancel category, indicating high demand but also high dissatisfaction
- Cancel orders also increased each year, which needs attention

> **Recommendation:** Investigate the causes of cancellation in `health_beauty` category — whether it's product quality, delivery issues, or customer expectations mismatch.

---

### 3. Payment Type

**All-time payment usage:**
| Payment Type | Total Usage |
|-------------|-------------|
| credit_card | 76,795 |
| boleto | 19,784 |
| voucher | 5,775 |
| debit_card | 1,529 |
| not_defined | 3 |

**Payment usage per year:**
| Year | Credit Card | Boleto | Voucher | Debit Card |
|------|-------------|--------|---------|------------|
| 2016 | 258 | 63 | 23 | 2 |
| 2017 | 34,568 | 9,508 | 3,027 | 422 |
| 2018 | 41,969 | 10,213 | 2,725 | 1,105 |

**Insights:**
- Credit card is the most dominant payment method across all years (73% of total transactions)
- Boleto is the second most used payment method, reflecting local Brazilian payment preferences
- Debit card usage grew significantly from 2 (2016) to 1,105 (2018)
- Voucher usage slightly decreased from 2017 to 2018

> **Recommendation:** Prioritize credit card payment experience optimization. Consider offering installment promotions via credit card to increase average order value.

---

## 🧠 SQL Techniques Used

| Analysis | Techniques |
|----------|------------|
| Customer Growth | `CTE`, `SUBQUERY`, `JOIN`, `EXTRACT`, `COUNT DISTINCT`, `AVG`, `ROUND` |
| Product Quality | `CTE`, `WINDOW FUNCTION (RANK)`, `PARTITION BY`, `JOIN`, `SUM`, `CAST` |
| Payment Type | `CASE WHEN`, `JOIN`, `COUNT`, `GROUP BY`, `ORDER BY` |

---

## 📝 Conclusion
The eCommerce business showed strong growth in customer acquisition and revenue from 2016 to 2018. However, customer retention remains a challenge with most customers only ordering once. The `health_beauty` category presents both the highest opportunity and risk. Credit card dominates as the preferred payment method, reflecting the importance of a seamless digital payment experience.

---

## 🤝 Contact
If you have any questions or would like to collaborate, feel free to reach out!

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/hanifaharrasyidah)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/hanifaharrasyidah)
