-- ==============================================================================
-- Description: Monitors short-term vendor pricing trends over a rolling 
--              6-month historical period using dynamic date calculations.
-- ==============================================================================

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
