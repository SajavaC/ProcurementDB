# ProcurementDB: Supply Chain Purchasing, Freight Tracking & Lot Tracing Database

---

Note: All sensitive business data, proprietary store identities, and financial metrics have been completely randomized, scrubbed, or substituted with sample metrics to strictly comply with non-disclosure agreements (NDA) and protect data privacy.

---

## Project Overview

This database was built to centralize purchasing information and improve visibility across the procurement process.

Instead of managing purchase orders, supplier information, freight records, lot numbers, and cost calculations in separate spreadsheets, this relational database consolidates them into a single system. It supports purchasing activities from supplier selection through freight arrival while maintaining product-level cost history and lot traceability.

In addition to serving as a purchasing record, the database also provides operational reports that simplify price reviews, lot tracking, and inventory auditing.

This database was not created as a technical exercise. It was built to organize procurement data in a way that makes day-to-day supply chain work more efficient and easier to manage.

---

## Core Business Capabilities

### **Purchasing & Cost Tracking**

Maintains complete purchasing records, including supplier quotations, purchase orders, landed costs, taxes, freight charges, and historical pricing. This provides a centralized view of procurement costs for future purchasing decisions.

### **Lot Traceability**

Tracks products from purchase orders through freight arrivals to individual lot numbers, making it possible to trace inventory batches and monitor remaining quantities after warehouse distribution.

### **Supplier Performance Reference**

Stores supplier lead times and available shipping methods, providing a historical reference for procurement planning and supplier evaluation.

### **Vendor Asset Management**

Tracks prepaid packaging labels stored at suppliers and compares purchased quantities with actual usage, helping monitor remaining inventory and reduce unnecessary reorders.

---

## Database Relationship Diagram
Below is the optimized entity-relationship schema designed for high-performance querying and cross-functional visibility:

![ProcurementDB Schema](relationship_diagram.png)

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

## SQL Reports (`queries/`)

The SQL queries in this project automate recurring procurement analyses and provide operational reports used during purchasing and inventory reviews.

### `Recent_Order_Price.sql`

Retrieves the most recent purchase price for each product, allowing buyers to quickly review current pricing before placing new orders.

### `Last_Six_Months_Price.sql`

Displays historical purchase prices over the previous six months, making it easier to identify price changes and support supplier negotiations.

### `Lot_Numbers_List.sql`

Lists all received lot numbers together with their arrival dates, providing a quick reference for product traceability.

### `Lot_Tracking.sql`

Calculates the remaining quantity for each lot by comparing inbound receipts with outbound warehouse records.

### `Order_Lot_Tracker.sql`

Connects purchase orders, freight records, lot numbers, and warehouse transactions into a single report, providing complete traceability for each inventory batch.

### `Remaining_Labels.sql`

Compares purchased label quantities with actual usage to estimate remaining inventory held by suppliers.
