# Superstore Sales Analysis (SQL + Python + Power BI)

## 1. Project Overview
This project performs an end-to-end retail sales analysis to identify profit drivers, evaluate discount impact, and analyze regional performance. The goal is to uncover underperforming areas and support data-driven business decisions.

---

## 2. Problem Statement
Retail businesses often focus on revenue growth but overlook profitability.  
This project answers:

- What drives profit and loss?
- How do discounts impact profitability?
- Which regions and categories underperform?
- Where are the key business risks?

---

## 3. Tools & Technologies
- SQL (data extraction & validation)
- Python (Pandas)
- Power BI (dashboard & visualization)

---

## 4. Dataset
- Source: Superstore dataset (Kaggle)
- Contains:
  - Orders, Sales, Profit, Discount
  - Customer, Region, Category, Sub-category
  - Order and shipping dates

---

## 5. Project Structure
/sql -> SQL queries for analysis
- ([SQL Queries for Superstore Data.sql](https://github.com/user-attachments/files/27191789/SQL.Queries.for.Superstore.Data.sql))

/python -> Data cleaning & analysis scripts
- SQL Queries Countercheck ([sql_queries_countercheck.ipynb](https://github.com/user-attachments/files/27191795/sql_queries_countercheck.ipynb))
- Deep Analysis ([deep_analysis.ipynb](https://github.com/user-attachments/files/27191794/deep_analysis.ipynb))

/dashboard -> Power BI dashboard file (.pbix)

/data -> Dataset (raw / cleaned)
- [sample_superstore.csv](https://github.com/user-attachments/files/27191903/sample_superstore.csv)
- [superstore_cleaned.csv](https://github.com/user-attachments/files/27191910/superstore_cleaned.csv)

---

## 6. Key Analysis Performed

### Sales & Profit Trends
- Monthly sales and profit analysis
- Profit margin tracking
- Month-over-Month (MoM) and Year-over-Year (YoY) growth

### Profit Drivers Analysis
- Correlation analysis between sales, discount, and profit
- Identification of key variables impacting profitability

### Discount Impact (Critical)
- Analysis of profit vs discount levels
- Identification of discount thresholds causing losses

### Regional Performance
- Sales, profit, and profit margin by region
- Regional profitability comparison

### Category & Product Analysis
- Identification of loss-making categories and products
- Category vs overall average performance

### Customer Analysis
- Top customers by revenue and profit
- Customer lifetime value (CLV)
- Repeat purchase rate
- Customer acquisition trends

### Root Cause Analysis
- Region × Category intersection analysis
- Identification of worst-performing segments

### Advanced Analysis
- Seasonal trends (monthly sales patterns)
- Forecasting next month sales
- High-risk (churn) customer identification

---

## 7. Key Insights

### 1. Aggressive Discounting Is Eroding Profitability
The analysis revealed a strong negative relationship between discount levels and profit margins. Transactions with higher discount rates consistently generated lower profitability, with several discount brackets resulting in net losses. This indicates that revenue growth is being partially driven by unsustainable pricing strategies.

### 2. Revenue Growth Does Not Equate to Profit Growth
Several regions and product segments generated high sales volume but underperformed in profitability. The findings suggest that focusing solely on revenue KPIs may mask underlying margin deterioration and operational inefficiencies.

### 3. Losses Are Concentrated in Specific Region–Category Combinations
Root cause analysis identified a small number of region and category intersections responsible for a disproportionate share of total losses. This highlights the importance of targeted corrective actions rather than broad company-wide adjustments.

### 4. Profitability Is More Sensitive to Margin Control Than Sales Volume
Correlation analysis showed that profit performance is influenced more heavily by discount management and product mix than by transaction volume alone. High sales activity without margin discipline does not translate into sustainable business performance.

### 5. Certain Product Categories Consistently Underperform
Category-level analysis identified recurring loss-making sub-categories despite stable sales activity. This suggests structural pricing, discounting, or cost allocation issues within specific product groups.

### 6. Customer Value Distribution Is Highly Uneven
Customer analysis showed that a relatively small segment of customers contributes a significant share of total profit. This creates opportunities for targeted retention strategies and customer segmentation initiatives.

### 7. Seasonal Demand Patterns Present Forecasting Opportunities
Monthly trend analysis revealed recurring seasonal fluctuations in sales performance. These patterns can be leveraged to improve inventory planning, sales forecasting, and promotional timing.

### 8. High-Risk Customers Indicate Potential Retention Gaps
Customer churn-risk analysis identified inactive one-time buyers with long purchase gaps, suggesting opportunities to improve customer retention and repeat purchase behavior through targeted engagement strategies.

---

## 8. Dashboard Overview (Power BI)

The dashboard consists of 3 main pages:

### Page 1: Overview
- Sales, Profit, and KPI summary
- High-level performance trends
<img width="1317" height="737" alt="Dashboard Page 1" src="https://github.com/user-attachments/assets/1a743836-88a4-4e43-b71c-23816261947b" />

### Page 2: Regional & Category Analysis
- Regional performance comparison
- Category and sub-category breakdown
<img width="1297" height="741" alt="Dashboard Page 2" src="https://github.com/user-attachments/assets/50ef398b-8ef3-41fc-b7d5-d4f8603d9e7c" />


### Page 3: Profit Drivers
- Profit vs Discount analysis
- Scatter plot identifying loss patterns
<img width="1311" height="738" alt="Dashboard Page 3" src="https://github.com/user-attachments/assets/89a43efe-d276-4af9-a780-b2180d5bc65e" />

---

## 9. Business Value

This analysis helps:
- Optimize discount strategies
- Improve profit margins
- Identify loss-making segments
- Support strategic decision-making with data

---

## 10. Conclusion

The project highlights that revenue growth alone is not sufficient.  
Controlling discounts and focusing on high-margin segments is critical for sustainable profitability.

