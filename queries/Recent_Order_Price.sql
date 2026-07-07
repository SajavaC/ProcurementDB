SELECT A.P_Name, A.PO_Date, A.UP_b4T, A.UP, A.SI
FROM (SELECT P_Name, PO_Date, UP_b4T, UP, SI
           FROM Products INNER JOIN (Orders INNER JOIN ORD_Det ON Orders.ID = ORD_Det.ORD_ID) ON Products.ID = ORD_Det.Product_ID)  AS A
WHERE (((A.PO_Date)=(SELECT MAX(B.PO_Date)
                                    FROM (SELECT P_Name, PO_Date, UP_b4T, UP, SI
                                                 FROM Products INNER JOIN (Orders INNER JOIN ORD_Det ON Orders.ID = ORD_Det.ORD_ID) ON Products.ID = ORD_Det.Product_ID) as B
                                    WHERE B.P_Name = A.P_Name)));
