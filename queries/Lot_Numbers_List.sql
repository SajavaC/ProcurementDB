-- ==============================================================================
-- Description: Extracts full lot identification logs along with cargo arrival 
--              dates using multi-layered left outer joins.
-- ==============================================================================

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
