# ProcurementDB: Supply Chain Purchasing, Freight Tracking & Lot Tracing Database

## Project Overview
**ProcurementDB** is a production-ready relational database schema designed to streamline international procurement, multi-currency freight tracking, and supplier-managed inventory compliance. Built with a deep focus on supply chain data integrity, this database serves as a robust auditing tool to reconcile financial variances (such as item-level discounts and multi-tiered tax calculations) and eliminate material waste across global vendor networks.

### Core Business Capabilities
* **Vendor-Managed Asset Auditing**: Reconciles bulk-prepaid packaging labels stored at supplier sites against historical order consumption to prevent shrinkage.
* **Granular Cost Reconciliations**: Supports multi-currency tracking (CAD/USD) with dynamic field handling for pre-discount, pre-tax, and fully inclusive totals.
* **End-to-End Lot Lineage**: Connects Purchase Orders, freight manifests, cargo arrival schedules, and outbound warehouse distributions to ensure total batch traceability.

---

## Database Relationship Diagram
Below is the optimized entity-relationship schema designed for high-performance querying and cross-functional visibility:

![ProcurementDB Schema](ProcurementDB_Schema_HighRes.png)

---

## Data Dictionary & Schema Architecture

### 1. Procurement & Order Ledger
* **`Orders`**: Main purchase ledger managing total order finances across multiple currencies and milestone dates.
  * `IPPO`: Inventory Planner order number.
  * `VendorPO` / `Invoice`: Official tracking references from supplier invoices.
  * `Amount_CAD`: Fully inclusive landed cost (including discounts, freight, and taxes).
  * `Proc_fee_CAD` / `Proc_fee_USD`: Administrative and customs processing fees.
  * `DP_Date` / `BP_Date`: Deposit Payment and Balance Payment milestone tracking.
* **`ORD_Det`**: Order line items configured for precise cost breakdown auditing.
  * `UP_b4DT`: Unit Price (CAD) before individual product discount and tax.
  * `UP_b4T`: Unit Price (CAD) including discount but before tax.
  * `UP`: Unit Price (CAD) inclusive of all individual items' discount and tax.
  * `SI`: Shipping Inclusion Note (Tracks whether a vendor is unable to break down shipping costs, isolating bulk logistics from product valuation).

### 2. Logistics & Inventory Auditing
* **`Vendors`**: Master directory of international suppliers with operational constraints.
  * `Production_LT`: Manufacturing lead time metrics.
  * `Std_Shipping` / `Fast_Sea_Shipping` / `Air_Shipping`: Multi-modal freight duration parameters used for demand planning.
* **`Freight`**: Shipment manifest tracking actual quantities dispatched against historical lines.
  * `frtQty`: Quantity physically shipped per consignment.
  * `Ship_Date` / `Arr_Date`: Actual shipping and port arrival timestamps.
* **`Lot`**: Operational registry pairing batch lots to physical freight arrivals (`LOT number or Batch number`).
* **`POTracking`**: Outbound logistics log detailing ex-warehouse distribution and exception handling (`Reason`, `Expiration`, `Warehouse`).

### 3. Vendor-Managed Prepaid Assets
* **`Labels`**: Monitors proprietary asset inventories (e.g., prepaid food nutrition labels) bulk-printed and stored at third-party contractor facilities. Tracks prepaid `Qty`, purchase `Price`, and unit cost (`UP`) to ensure financial accountability.

---

## Advanced SQL Capabilities (`queries/`)
The `queries/` folder contains structural SQL scripts engineered to automate operational analysis and financial auditing:

* **`Recent_Order_Price.sql`**: Employs a complex correlated subquery (`MAX(PO_Date)`) to extract the absolute latest historical purchase price per SKU and dynamically scales unit prices to case costs.
* **`Order_Lot_Tracker.sql`**: Establishes an end-to-end audit trail tracking the complete lineage of individual batches from the initial Purchase Order, through freight arrivals, down to final warehouse status and distribution exceptions.
* **`WIP_Lot_Tracking.sql`**: An advanced dynamic stock balance script that sits on top of the lot tracker. It utilizes structured subquery aggregations (`SUM` + `GROUP BY` via `LEFT JOIN`) to reconcile total inbound lot receipts against outbound ex-warehouse tracking tags to calculate live, remaining in-stock balances.
* **`Remaining_Labels.sql`**: A vendor asset audit query designed to reconcile prepaid label stocks. By cross-referencing upstream bulk orders against cumulative downstream PO consumption, it automatically flags discrepancies to prevent supplier material shrinkage.
* **`Last_Six_Months_Price.sql`**: Leverages time-series filtering functions (`DateAdd`) to provide rolling 6-month product margin variance analysis.
* **`Lot_Numbers_List.sql`**: Generates a clean traceability matrix mapping specific batches back to container arrival dates using optimized left outer joins.
