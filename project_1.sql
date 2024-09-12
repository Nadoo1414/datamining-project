create schema retailshop;

use retailshop;

select * from online_retail;

--                          Beginner Queries.
-- Define meta data in mysql workbench or any other SQL tool 
show columns from online_retail;

-- What is the distribution of order values across all customers in the dataset? 
select CustomerID, SUM(Quantity * UnitPrice) as TotalOrderValue
from online_retail
group by CustomerID;

-- How many unique products has each customer purchased?
select CustomerID, count(distinct StockCode) as UniqueProductsPurchased
from online_retail
group by CustomerID;

-- Which customers have only made a single purchase from the company?
select CustomerID
from online_retail
group by CustomerID
having COUNT(distinct InvoiceNo) = 1;

--                       Advance Queries 
-- Customer Segmentation by Purchase Frequency
select CustomerID,
       case
           when COUNT(InvoiceNo) > 10 then 'High Frequency'
           when COUNT(InvoiceNo) between 5 and 10 then 'Medium Frequency'
           else 'Low Frequency'
       end as PurchaseFrequency
from online_retail
group by CustomerID;

-- Which products are most commonly purchased together by customers in the dataset?
select a.StockCode as ProductA, b.StockCode as ProductB, count(*) as PurchaseCount
from online_retail a
join online_retail b
on a.InvoiceNo = b.InvoiceNo and a.StockCode < b.StockCode
group by a.StockCode, b.StockCode
order by PurchaseCount desc;

-- 2. Average Order Value by Country
select Country, avg(Quantity * UnitPrice) as AverageOrderValue
from online_retail
group by Country;

-- 3. Customer Churn Analysis
select CustomerID
from online_retail
where InvoiceDate < now() - interval 6 month
group by CustomerID
having MAX(InvoiceDate) < NOW() - interval 6 month;

-- 4. Product Affinity Analysis
 select a.StockCode as ProductA, b.StockCode as ProductB, count(*) as AffinityScore
from online_retail a
join online_retail b
on a.InvoiceNo = b.InvoiceNo and a.StockCode < b.StockCode
group by a.StockCode, b.StockCode
order by AffinityScore desc;

-- 5. Time-based Analysis
select date_format(InvoiceDate, '%Y-%m') as month, 
       sum(Quantity * UnitPrice) as MonthlySales 
from online_retail 
group by month 
order by month;

 

 