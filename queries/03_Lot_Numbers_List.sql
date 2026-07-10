-- ========================================================================================================================================
-- Query Name:
-- Lot_Numbers_List

-- Purpose:
-- Lists all received lot numbers together with their corresponding products and arrival dates.

-- Business Value:
-- Provides a quick reference for product traceability and inventory verification, making it easier to locate specific batches when needed.
-- ========================================================================================================================================

SELECT 
    Products.P_Name, 
    Lot.LOT, 
    Lot.Qty, 
    Freight.Arr_Date
FROM 
    (
        (
            Lot 
            LEFT JOIN Freight ON Lot.Freight_ID = Freight.ID
        ) 
        LEFT JOIN ORD_Det ON Freight.OD_ID = ORD_Det.ID
    ) 
    LEFT JOIN Products ON ORD_Det.Product_ID = Products.ID
ORDER BY 
    Products.P_Name, 
    Freight.Arr_Date DESC;
