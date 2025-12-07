#  README.md — CRIME DATA ANALYSIS (BIG DATA PROJECT) 

# Crime Data Analysis – Big Data Project (Databricks + PySpark)

## 1.  Project Overview

This project performs an end-to-end Big Data analysis on a **Crime Dataset** using **Databricks (Free Edition)**, **PySpark**, **Spark SQL**, and **Lakeview Dashboards**.

The main goals are to analyze:

- Crime distribution across different areas  
- Top crime types  
- How victim age influences crime frequency  
- Provide visual dashboards with actionable KPIs  

The workflow includes:

- Data ingestion  
- Cleaning & feature engineering  
- Analytical exploration in PySpark & SQL  
- Dashboard creation with 3 KPI-centric tiles  
- Proper documentation in GitHub  


## 2. Dataset Description

Source file: `Crime_Data_from_2020_to_Present.csv`

### Columns:
- `DR_NO`
- `Date Rptd`
- `DATE OCC`
- `TIME OCC`
- `AREA`
- `AREA NAME`
- `Rpt Dist No`
- `Part 1-2`
- `Crm Cd`
- `Crm Cd Desc`
- `Mocodes`
- `Vict Age`
- `Vict Sex`
- `Vict Descent`
- `Premis Cd`
- `Premis Desc`
- `Weapon Used Cd`
- `Weapon Desc`
- `Status`
- `Status Desc`
- `Crm Cd 1`
- `Crm Cd 2`
- `Crm Cd 3`
- `Crm Cd 4`
- `LOCATION`
- `Cross Street`
- `LAT`
- `LON`


## 3. Tools & Technologies

- Databricks (Free Edition)
- PySpark
- Spark SQL
- Databricks Lakeview Dashboards
- GitHub (Version Control)


## 4. Data Pipeline

### 4.1 Ingestion

Notebook: `01_ingest_and_clean_crime.ipynb`

Steps:

1. Uploaded the file into Databricks.
2. Created raw table:



main.default.raw_crime



### 4.2 Cleaning & Feature Engineering

Performed in `01_ingest_and_clean_crime.ipynb`.

Key transformations:

### Date and Time Cleanup
- Converted `DATE OCC` into a valid timestamp  
- Extracted:
  - `occ_year`
  - `occ_month`
  - `occ_day`
  - `occ_hour` (derived from TIME OCC)

###  Victim Age Category
Created age groups:

- `Child (0–17)`
- `Adult (18–44)`
- `Middle Age (45–64)`
- `Senior (65+)`
- `Unknown` for missing ages

### Standardized Area Name
Renamed and cleaned `AREA NAME` → `area_name`

### Removed unusable records
- Dropped null coordinates  
- Dropped rows with missing essential fields  

Cleaned table saved as:



main.default.clean_crime

`

## 5. Exploratory Analysis

Notebook: `02_analysis_notebook.ipynb`

### 5.1 PySpark Examples

#### Crime count by area
python
df.groupBy("area_name").count().orderBy("count", ascending=False).show()
`

#### Top crime categories

python
df.groupBy("Crm Cd Desc").count().orderBy("count", ascending=False).show()


#### Crime by victim age group

python
df.groupBy("age_group").count().show()


---

### 5.2 SQL Examples (also stored in `sql_queries.sql`)

#### Total crimes by year

sql
SELECT occ_year, COUNT(*) AS total_crimes
FROM main.default.clean_crime
GROUP BY occ_year
ORDER BY occ_year;


#### Top 10 crime descriptions

sql
SELECT Crm_Cd_Desc, COUNT(*) AS crime_count
FROM main.default.clean_crime
GROUP BY Crm_Cd_Desc
ORDER BY crime_count DESC
LIMIT 10;



## 6.  Dashboard (Lakeview)

Notebook: `03_dashboard_notebook.ipynb` creates needed aggregated tables:

* `dash_crimes_by_area`
* `dash_top_crime_categories`
* `dash_crimes_by_age_group`

###  Dashboard Tiles

#### 1️ Crimes by Area

* Data Source: `dash_crimes_by_area`
* Chart: Bar
* X-axis: `area_name`
* Y-axis: `crime_count`
* KPI: Which areas have the highest crime occurrences?


#### 2️ Top 10 Crime Categories

* Data Source: `dash_top_crime_categories`
* Chart: Bar
* X-axis: `crm_cd_desc`
* Y-axis: `crime_count`
* KPI: Most common crime types in the dataset


#### 3️ Crimes by Victim Age Group

* Data Source: `dash_crimes_by_age_group`
* Chart: Bar
* X-axis: `age_group`
* Y-axis: `crime_count`
* KPI: Which age groups are victimized the most?


## 7. Dashboard Filters (Correct per Tile Datasource)

Because Lakeview dashboards require filters to come from the **same datasource as the tile**, the valid filters are:


### Filter 1 — Area Name

* Datasource: `dash_crimes_by_area`
* Field: `area_name`
* Applies to: **Tile 1** only


### Filter 2 — Crime Category

* Datasource: `dash_top_crime_categories`
* Field: `crm_cd_desc`
* Applies to: **Tile 2** only


### Filter 3 — Age Group

* Datasource: `dash_crimes_by_age_group`
* Field: `age_group`
* Applies to: **Tile 3** only

These filters are fully compatible and generate meaningful dashboard exploration without datasource conflicts.


## 8.  How to Run the Project

1. Import all notebooks into Databricks.
2. Attach a running cluster.
3. Run:

   * `01_ingest_and_clean_crime.ipynb`
   * `02_analysis_notebook.ipynb`
   * `03_dashboard_notebook.ipynb`
4. Create a Lakeview Dashboard:

   * Add all 3 tiles
   * Add and connect filters
5. Save dashboard


## 9.  Repository Structure


crime-data-bigdata-final/
│
├── 01_ingest_and_clean_crime.ipynb
├── 02_analysis_notebook.ipynb
├── 03_dashboard_notebook.ipynb
├── sql_queries.sql
└── README.md



## 10.  Conclusion

This project demonstrates a complete Big Data pipeline for analyzing crime patterns:

* Ingesting and cleaning real-world crime records
* Engineering analytical fields
* Using PySpark & SQL for insights
* Designing a professional dashboard with relevant KPIs
* Clearly identifying crime trends by **area**, **crime type**, and **victim age group**

The final dashboard provides quick, actionable insights for law enforcement, researchers, or policymakers.
