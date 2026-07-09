-- ==================================================================================================================================
-- Query Name:
-- Remaining_Labels

-- Purpose:
-- Calculates the remaining quantity of prepaid labels by comparing purchased quantities with actual product orders.

-- Business Value:
-- Helps monitor supplier-managed label inventory, reducing unnecessary purchases and identifying unexpected inventory discrepancies.
-- ==================================================================================================================================

SELECT 
    Labels.L_Name, 
    Products.P_Name, 
    (SUM(Labels.Qty) - SUM(ORD_Det.Qty)) AS [Remaining Qty]
FROM 
    (
        Products 
        INNER JOIN Labels ON Products.ID = Labels.ProductID
    ) 
    INNER JOIN ORD_Det ON Products.ID = ORD_Det.Product_ID
GROUP BY 
    Labels.L_Name, 
    Products.P_Name;
