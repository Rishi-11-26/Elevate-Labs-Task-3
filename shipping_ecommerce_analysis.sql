-- Task 3: Data Analysis on shipping_ecommerce

-- 1. Basic selection, filtering, and sorting
SELECT * FROM shipping_ecommerce
WHERE Discount_offered > 10
ORDER BY Discount_offered DESC;

-- 2. Aggregation by product importance
SELECT Product_importance, COUNT(*) AS total_shipments, AVG(Discount_offered) AS avg_discount
FROM shipping_ecommerce
GROUP BY Product_importance;

-- 3. Aggregation by shipment mode and warehouse block
SELECT Warehouse_block, Mode_of_Shipment, COUNT(*) AS total_shipments, AVG(Customer_rating) AS avg_rating
FROM shipping_ecommerce
GROUP BY Warehouse_block, Mode_of_Shipment;

-- 4. Gender distribution
SELECT Gender, COUNT(*) AS total
FROM shipping_ecommerce
GROUP BY Gender;

-- 5. Most common mode of shipment per product importance
SELECT Product_importance, Mode_of_Shipment, COUNT(*) AS mode_count
FROM shipping_ecommerce
GROUP BY Product_importance, Mode_of_Shipment
ORDER BY Product_importance, mode_count DESC;

-- 6. High customer care calls
SELECT *
FROM shipping_ecommerce
WHERE Customer_care_calls = (SELECT MAX(Customer_care_calls) FROM shipping_ecommerce);

-- 7. Top 5 discounts by weight (subquery example)
SELECT *
FROM shipping_ecommerce
WHERE Weight_in_gms IN (
  SELECT Weight_in_gms FROM shipping_ecommerce 
  ORDER BY Discount_offered DESC LIMIT 5
);

-- 8. Example of self join: Customers with same rating/product importance (show two different discounts)
SELECT a.Customer_rating, a.Product_importance, a.Discount_offered, b.Discount_offered AS Other_Discount
FROM shipping_ecommerce a
INNER JOIN shipping_ecommerce b
  ON a.Product_importance = b.Product_importance AND a.Customer_rating = b.Customer_rating
WHERE a.ROWID != b.ROWID;

-- 9. View for summary analysis
CREATE OR REPLACE VIEW shipment_summary AS
SELECT Warehouse_block, Mode_of_Shipment, COUNT(*) AS total_shipments, AVG(Customer_rating) AS avg_rating
FROM shipping_ecommerce
GROUP BY Warehouse_block, Mode_of_Shipment;

-- 10. Index for optimization (edit 'idx_discount' name if it exists)
CREATE INDEX idx_discount ON shipping_ecommerce(Discount_offered);
