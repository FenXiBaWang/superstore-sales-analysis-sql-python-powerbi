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
- Python (Pandas, NumPy, Matplotlib, Seaborn)
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

/python -> Data cleaning & analysis scripts

/dashboard -> Power BI dashboard file (.pbix)

/data -> Dataset (raw / cleaned)


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

- High discounts significantly reduce profitability and create loss-making transactions
- Some regions generate high revenue but have low profit margins due to discounting
- Specific categories and sub-categories consistently operate at a loss
- Profitability is driven more by margin control than sales volume
- Certain region-category combinations are the main source of losses

---

## 8. Dashboard Overview (Power BI)

The dashboard consists of 3 main pages:

### Page 1: Overview
- Sales, Profit, and KPI summary
- High-level performance trends

### Page 2: Regional & Category Analysis
- Regional performance comparison
- Category and sub-category breakdown

### Page 3: Profit Drivers
- Profit vs Discount analysis
- Scatter plot identifying loss patterns

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

---

## 11. Future Improvements

- Build predictive models for profit optimization
- Enhance forecasting using time-series models
- Deploy dashboard for real-time business monitoring
