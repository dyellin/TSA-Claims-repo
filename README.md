# 🧳 TSA Claims 2000–2015 Analysis

**A Data Analytics Project Using SQL, Google Sheets, and Tableau**

### 🔗 Project Links
- 📘 **Dataset:** [TSA Claims Dataset (2000–2015)](https://www.kaggle.com/datasets/terminal-security-agency/tsa-claims-database)
- 🧾 **SQL Script:** [`TSA_Claims_2000-2015.sql`](https://github.com/dyellin/TSA-Claims-repo/blob/d7e3db08e3526604473c1400071ef5d579f788e6/TSA_Claims_2000-2015.sql)
- 📊 **Tableau Dashboard:** [TSA Claims 2000–2015 v2](https://public.tableau.com/views/TSAClaims2000-2015v2/Dashboard2?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
- 📖 **Tableau Story:** [TSA Claims: Outcomes, Costs, and Trends](https://public.tableau.com/views/TSAClaimsOutcomesCostsandTrends/Story1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
- 💻 **GitHub Repository:** [TSA-Claims-repo](https://github.com/dyellin/TSA-Claims-repo)

---

## ✈️ Project Overview
This project analyzes **TSA claims data from 2000–2015**, covering more than **200,000 records** related to property damage, lost items, personal injury, and other incidents reported to the **Transportation Security Administration** (TSA).

Since the TSA’s inception in **late 2001**, claims have grown into a significant **financial and operational liability**.  
This analysis uncovers **patterns, costs, and trends** in claims data to help TSA and DHS leadership improve efficiency, reduce costs, and prevent future incidents.

---

## 🗂️ Key Terms
- **Claim Amount:** The dollar amount requested by a claimant.
- **Close Amount:** The dollar amount awarded to the claimant.
- **Disposition:** The final status of a claim (e.g., *Approved*, *Settled*, *Denied*, *Canceled*).

---

## 📊 Executive Summary
The dataset includes over **204,000 claims** filed between 2000 and 2015.  
Visualized in Tableau, it reveals striking patterns in how claims were filed, processed, and resolved.

### Highlights:
- 🧾 **204,129 total claims**
- 💰 **$17.6 billion** claimed (excluding one anomalous $3T claim denied in 2007)
- 💸 **$14.3 million** awarded = **<1%** of total claimed

---

## 🔍 Key Insights

### Insight 1: Checkpoint Incidents
Roughly **20%** of all claims were related to **TSA checkpoints**.  
These go far beyond simple prohibited items — suggesting procedural or handling issues at screening stations.

### Insight 2: Missing Claim Amounts
Over **10%** of all claims listed a **$0 Claim Amount**, and every one of those cases was **denied or canceled**.  
This raises questions about data entry accuracy or reporting completeness.

### Cyclical Trends
- **Peak months:** July, August, and December → ~18,000+ claims each  
- **Busiest days:** Dec 26–Jan 5 → ~700 claims/day  
- **Peak years:** 2003–2005, with 2004 leading at nearly **29,000 claims**

---

## 🧠 Recommendations
To improve TSA’s operational efficiency and reduce claim frequency and payout:

1. **Staff strategically during peak travel seasons**  
   Increase checkpoint and baggage handling staff during holiday months to reduce errors caused by high traveler volume.

2. **Improve incident handling and reporting**  
   Better data collection and categorization at the time of claim filing will reduce the number of incomplete or $0-amount claims.

3. **Audit high-volume airports**  
   Identify airports with unusually high claim rates or claim-to-award discrepancies and investigate local process improvements.

---

## ⚙️ Data Sources
**Primary Dataset:** TSA Claims Data (2000–2015)  
**Storage:** Local + cloud copies  
**Structure:**

| Column | Description |
|--------|-------------|
| claim_no | Unique claim ID |
| date_rec | Date claim was received |
| incident_date | Date incident occurred |
| ap_code | 3-letter airport code |
| ap_name | Airport name |
| airline | Airline name |
| claim_type | Type of claim (e.g., Damaged, Lost, Injury) |
| claim_site | Where the incident occurred (Checkpoint, Baggage, etc.) |
| item | Claimed item |
| claim_amt | Amount claimed ($) |
| status | Claim status (Open, Closed, etc.) |
| close_amt | Amount awarded ($) |
| disp | Disposition (Approved, Denied, Settled, etc.) |

A secondary table added **city** and **state** location data, joined by `claim_no`.

---

## 🧹 Data Cleaning & Transformation

**Tool:** Google Sheets  

### Process:
- **Removed empty or invalid records** (e.g., claims with only a claim number)
- **Left nulls intact** when appropriate (blank fields often represent “no data,” not missing data)
- **Checked for duplicates** — only one found and removed
- **Standardized column names** in SQL for consistency:
  - `Claim Number` → `claim_no`
  - `Airport Name` → `ap_name`
  - `Claim Amount` → `claim_amt`
  - `Disposition` → `disp`
- **Normalized text fields** (`ap_name`, `item`) for uniform formatting
- **Validated date consistency** and ensured correct data types

---

## 🧮 Data Exploration & Analysis

**Tools:** DBeaver (SQL), Google Sheets  

### Time-Based Analysis
- Claims per **day, month, and year**
- Seasonal spikes during **summer and holiday travel**
- Earliest and latest **incident dates**
- Comparison of **incident_date** vs. **date_rec** to measure reporting delay

### Categorical Analysis
- Claims by **type**, **item**, **site**, **airline**, **airport**
- Cross-comparisons:
  - `status` × `claim_type`
  - `disp` × `ap_name`
  - `claim_site` × `claim_type`
  - `claim_type` × `item`

### Financial Analysis
- Total and average **claim vs. close amounts**
- Differences between **requested** and **awarded** values, grouped by:
  - Year, airline, airport, claim type, and disposition
- **Average time to close claims** by category

### Operational Efficiency
- Average **days between incident and received date**
- Claims progression by **status** and **disposition**
- **Delay metrics** to identify processing bottlenecks

---

## 📈 Tableau Dashboard & Story
The **interactive dashboard and story** visualize:
- Claims over time and by airport
- Total claimed vs. awarded amounts
- Monthly and yearly trends
- Most frequent claim types and sites
- Top airports and airlines for claims filed

> 🖥️ Explore the full Tableau Dashboard: [TSA Claims: Outcomes, Costs, and Trends](https://public.tableau.com/views/TSAClaims2000-2015v2/Dashboard2?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
> 
> 🖥️ Explore the full Tableau Story: [TSA Claims: Outcomes, Costs, and Trends](https://public.tableau.com/views/TSAClaimsOutcomesCostsandTrends/Story1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## ⚖️ Assumptions & Caveats
- TSA was established **November 19, 2001** — any earlier incidents (pre-2001) are questionable.
- Missing data:
  - Claim Amount: ~10%
  - Status / Disposition: ~5%
  - Close Amount: ~10%
- Some large outliers (e.g., $3 trillion claim) removed for visualization accuracy.
- Airport and airline names contain spelling inconsistencies that were cleaned but may not perfectly align.

---

## 🔭 Future Work
- Add time-of-day or flight destination data to study claim context
- Analyze claims by **TSA agent ID** or **airport shift** to identify high-risk patterns
- Incorporate **airline routes** to link claims with flight paths
- Build predictive model for **claim likelihood** based on season, airport, or flight characteristics

---

## ✅ Deliverables Summary
| Deliverable | Description |
|--------------|-------------|
| **Business Task** | Analyze TSA claims data to identify trends and reduce claim costs |
| **Data Sources** | TSA Claims Dataset (2000–2015) |
| **Cleaning** | Removed invalid rows, standardized names, validated formats |
| **Analysis** | SQL exploration, trend analysis, and Tableau visualization |
| **Recommendations** | Optimize staffing, improve data quality, audit high-claim airports |

---

## 👩‍💻 Author
**Dov Yellin**  
📧 dyellin13@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/dovyellin)
