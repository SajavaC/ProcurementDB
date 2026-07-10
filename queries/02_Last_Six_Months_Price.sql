-- ===============================================================================================================
-- Query Name:
-- Last_Six_Months_Price

-- Purpose:
-- Displays the purchase price history for each product over the most recent six months.

-- Business Value:
-- Provides historical pricing trends that support supplier negotiations, price reviews, and purchasing decisions.
-- ===============================================================================================================

SELECT 
    Products.P_Name, 
    Orders.PO_Date, 
    ORD_Det.UP_b4T, 
    ORD_Det.UP, 
    ORD_Det.SI
FROM 
    Products 
    INNER JOIN (
        Orders 
        INNER JOIN ORD_Det ON Orders.ID = ORD_Det.ORD_ID
    ) ON Products.ID = ORD_Det.Product_ID
WHERE 
    Orders.PO_Date >= DateAdd("m", -6, Date())
ORDER BY 
    Products.P_Name, 
    Orders.PO_Date DESC;
