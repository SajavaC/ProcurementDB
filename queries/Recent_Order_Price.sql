-- ==============================================================================
-- Description: Advanced Correlated Subquery to dynamically capture the absolute 
--              latest historical purchase price and calculate custom case costs.
-- ==============================================================================

SELECT 
    A.P_Name, 
    A.PO_Date, 
    A.UP_b4T, 
    A.UP, 
    A.SI, 
    A.Unit, 
    ROUND(A.Unit * A.UP, 2) AS CasePrice
FROM 
    (
        SELECT 
            Products.P_Name, 
            Orders.PO_Date, 
            ORD_Det.UP_b4T, 
            ORD_Det.UP, 
            ORD_Det.SI, 
            Products.Unit 
        FROM 
            Products 
            INNER JOIN (
                Orders 
                INNER JOIN ORD_Det ON Orders.ID = ORD_Det.ORD_ID
            ) ON Products.ID = ORD_Det.Product_ID
    ) AS A
WHERE 
    A.PO_Date = (
        SELECT 
            MAX(B.PO_Date)     
        FROM 
            (
                SELECT 
                    Products.P_Name, 
                    Orders.PO_Date, 
                    ORD_Det.UP_b4T, 
                    ORD_Det.UP, 
                    ORD_Det.SI, 
                    Products.Unit         
                FROM 
                    Products          
                    INNER JOIN (
                        Orders          
                        INNER JOIN ORD_Det ON Orders.ID = ORD_Det.ORD_ID
                    ) ON Products.ID = ORD_Det.Product_ID     
            ) AS B     
        WHERE 
            B.P_Name = A.P_Name 
    )
ORDER BY 
    A.PO_Date DESC;
