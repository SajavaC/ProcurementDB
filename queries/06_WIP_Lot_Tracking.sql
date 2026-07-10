-- ============================================================================================================================
-- Query Name:
-- Lot_Tracking

-- Purpose:
-- Calculates the remaining inventory quantity for each lot by comparing inbound receipts with outbound warehouse transactions.

-- Business Value:
-- Provides current lot balances for inventory monitoring and traceability.

-- Note:
-- This query is a work in progress and is intended to support future lot-level inventory tracking.
-- ============================================================================================================================

SELECT 
    InnerQuery.P_Name, 
    InnerQuery.LOT, 
    InnerQuery.SumOfQty AS TotalQty, 
    OuterQuery.SumOfQuantity AS OutboundQty, 
    (InnerQuery.SumOfQty - OuterQuery.SumOfQuantity) AS InStock
FROM 
    (
        SELECT 
            Products.P_Name, 
            Lot.LOT, 
            SUM(Lot.Qty) AS SumOfQty 
        FROM 
            Orders 
            INNER JOIN (
                Products 
                INNER JOIN (
                    ORD_Det 
                    INNER JOIN (
                        Freight 
                        INNER JOIN Lot ON Freight.ID = Lot.Freight_ID
                    ) ON ORD_Det.ID = Freight.OD_ID
                ) ON Products.ID = ORD_Det.Product_ID
            ) ON Orders.ID = ORD_Det.ORD_ID 
        GROUP BY 
            Products.P_Name, 
            Lot.LOT
    ) AS InnerQuery 
    LEFT JOIN (
        SELECT 
            POTracking.LOT, 
            SUM(POTracking.Quantity) AS SumOfQuantity 
        FROM 
            POTracking 
        GROUP BY 
            POTracking.LOT
    ) AS OuterQuery ON InnerQuery.LOT = OuterQuery.LOT;
