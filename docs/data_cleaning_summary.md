# Data Cleaning Summary

## Overview
This document summarizes the results of the data cleaning process performed on the eCommerce dataset. The cleaning process covers 8 tables and includes checks for total rows, missing values, duplicates, and data inconsistencies.

---

## Total Rows per Table

| Table | Total Rows |
|-------|------------|
| customers | 99441 |
| geolocation | 1000163 |
| order_items | 112650 |
| order_payments | 103886 |
| order_review | 99224 |
| orders | 99441 |
| products | 32951 |
| sellers | 3095 |

---

## Missing Values

| Table | Column | Missing | Notes |
|-------|--------|---------|-------|
| customers | all columns | 0 | ✅ Clean |
| geolocation | all columns | 0 | ✅ Clean |
| order_items | all columns | 0 | ✅ Clean |
| order_payments | all columns | 0 | ✅ Clean |
| order_review | review_comment_title | 87,656 | ⚠️ Normal — not all customers fill in review title |
| order_review | review_comment_message | 58,247 | ⚠️ Normal — not all customers fill in review message |
| orders | order_approved_at | 160 | ⚠️ Normal — orders that were not approved (e.g. cancelled) |
| orders | order_delivered_carrier_date | 1,783 | ⚠️ Normal — orders that were not shipped |
| orders | order_delivered_customer_date | 2,965 | ⚠️ Normal — orders that were not delivered |
| products | product_category_name | 610 | ⚠️ Products without category — will be handled during analysis |
| products | product_weight_g | 2 | ⚠️ Minor missing — will be excluded during analysis |
| products | product_length_cm | 2 | ⚠️ Minor missing — will be excluded during analysis |
| products | product_height_cm | 2 | ⚠️ Minor missing — will be excluded during analysis |
| products | product_width_cm | 2 | ⚠️ Minor missing — will be excluded during analysis |
| sellers | all columns | 0 | ✅ Clean |

---

## Duplicate Check

| Table | Column | Duplicate | Notes |
|-------|--------|-----------|-------|
| customers | customer_id | 0 | ✅ Clean |
| geolocation | geolocation_zip_code_prefix | 17,972 | ✅ Normal — 1 zip code can have multiple coordinates |
| order_items | order_id | 9,803 | ✅ Normal — 1 order can have multiple items |
| order_payments | order_id | 2,961 | ✅ Normal — 1 order can have multiple payment methods |
| order_review | review_id | 789 | ⚠️ Duplicate reviews — will use latest review per review_id during analysis |
| orders | order_id | 0 | ✅ Clean |
| products | product_id | 0 | ✅ Clean |
| sellers | seller_id | 0 | ✅ Clean |

---

## Data Inconsistency

| Table | Issue | Notes |
|-------|-------|-------|
| geolocation | Inconsistent city name format (e.g. `acrelandia` vs `acrelândia`) | ⚠️ Special characters inconsistency — noted but not critical for this analysis |

---

## Handling Plan

| Issue | Handling |
|-------|---------|
| Missing `product_category_name` (610) | Group as `'unknown'` or exclude during product quality analysis |
| Missing delivery dates in `orders` | Expected for cancelled/undelivered orders — retain as is |
| Missing review comments | Expected behavior — retain as is |
| Duplicate `review_id` in `order_review` | Use latest review per `review_id` using `DISTINCT ON` |
| Inconsistent city names in `geolocation` | Noted — not critical for current analysis scope |

---

## Conclusion

The dataset is generally clean and ready for analysis. The missing values and duplicates found are mostly expected behaviors based on the nature of the eCommerce data. Specific handling will be applied during the analysis phase where needed.