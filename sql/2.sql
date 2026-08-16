USE india_financial_stress;
SELECT ticker, company_name, sector, current_price 
FROM companies 
ORDER BY sector;

USE india_financial_stress;
SELECT ticker, COUNT(*) as years, 
       MIN(report_year) as from_year, 
       MAX(report_year) as to_year
FROM financial_data
GROUP BY ticker
ORDER BY ticker
LIMIT 10;

USE india_financial_stress;

SELECT 'companies'        AS tbl, COUNT(*) AS records FROM companies
UNION ALL
SELECT 'macro_indicators' AS tbl, COUNT(*) AS records FROM macro_indicators
UNION ALL
SELECT 'financial_data'   AS tbl, COUNT(*) AS records FROM financial_data
UNION ALL
SELECT 'stock_prices'     AS tbl, COUNT(*) AS records FROM stock_prices;
