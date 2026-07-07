SELECT P_Name, PO_Date, UP_b4T, UP, SI
FROM Products INNER JOIN (Orders INNER JOIN ORD_Det ON Orders.ID = ORD_Det.ORD_ID) ON Products.ID = ORD_Det.Product_ID
WHERE PO_Date >= DateAdd("m", -6, Date())
ORDER BY P_Name, PO_Date DESC;
