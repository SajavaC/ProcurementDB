-- ==============================================================================
-- Description: Reconciles Vendor-Managed Label Inventory (VMI) by calculating 
--              theoretical remaining balances against actual order consumption.
-- Audit Purpose: Performs variance analysis between prepaid label purchases and 
--                production outputs to audit vendor usage and eliminate unexplained 
--                shrinkage or unauthorized waste.
-- ==============================================================================

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
