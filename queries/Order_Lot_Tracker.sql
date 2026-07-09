-- ================================================================================================================================
-- Query Name:
-- Order_Lot_Tracker

-- Purpose:
-- Connects purchase orders, freight records, lot numbers, and warehouse tracking information into a single traceability report.

-- Business Value:
-- Provides complete lot traceability from purchasing through warehouse operations, supporting inventory audits and product recalls.

-- Used By:
-- Lot traceability report
-- ================================================================================================================================

SELECT 
    Products.P_Name, 
    Orders.PO_Date, 
    Lot.LOT, 
    POTracking.LOT, 
    POTracking.Description, 
    POTracking.Quantity, 
    POTracking.Reason, 
    POTracking.Expiration, 
    POTracking.Receiving, 
    POTracking.PickUP, 
    POTracking.Warehouse
FROM 
    (
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
    ) 
    LEFT JOIN POTracking ON Lot.LOT = POTracking.LOT
ORDER BY 
    Products.P_Name;
