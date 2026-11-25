-- Oil & Gas CAPEX Performance Analysis | PostgreSQL build script
-- SYNTHETIC TRAINING DATA ONLY. No ADNOC internal data is used.
-- Run in a dedicated PostgreSQL database. CSV paths in COPY must be adjusted to your local machine.

DROP VIEW IF EXISTS vw_project_exposure CASCADE;
DROP TABLE IF EXISTS purchase_orders CASCADE;
DROP TABLE IF EXISTS project_budget CASCADE;
DROP TABLE IF EXISTS variance_log CASCADE;
DROP TABLE IF EXISTS monthly_capex CASCADE;
DROP TABLE IF EXISTS projects CASCADE;

CREATE TABLE projects (
 project_id varchar(10) PRIMARY KEY, project_name text NOT NULL, division text,
 approved_budget_aed_m numeric(14,3) NOT NULL CHECK (approved_budget_aed_m >= 0),
 annual_planned_capex_aed_m numeric(14,3), project_stage text
);
CREATE TABLE monthly_capex (
 project_id varchar(10) NOT NULL REFERENCES projects(project_id),
 month date NOT NULL, planned_capex_aed_m numeric(14,3) NOT NULL CHECK(planned_capex_aed_m >= 0),
 actual_capex_aed_m numeric(14,3) NOT NULL CHECK(actual_capex_aed_m >= 0),
 PRIMARY KEY(project_id, month)
);
CREATE TABLE variance_log (
 variance_id varchar(20) PRIMARY KEY, project_id varchar(10) NOT NULL REFERENCES projects(project_id),
 month date NOT NULL, variance_amount_aed_m numeric(14,3), variance_reason text, corrective_action text,
 action_owner text, due_date date, action_status text
);
CREATE TABLE project_budget (
 project_id varchar(10) PRIMARY KEY REFERENCES projects(project_id), project_name text NOT NULL,
 approved_budget_aed_m numeric(14,3) NOT NULL CHECK(approved_budget_aed_m >= 0), budget_source text NOT NULL
);
CREATE TABLE purchase_orders (
 po_id varchar(20) PRIMARY KEY, project_id varchar(10) NOT NULL REFERENCES projects(project_id),
 project_name text NOT NULL, fictional_supplier text NOT NULL, scope_description text,
 original_po_value_aed_m numeric(14,3) NOT NULL, approved_change_orders_aed_m numeric(14,3) NOT NULL DEFAULT 0,
 approved_cancellations_aed_m numeric(14,3) NOT NULL DEFAULT 0, revised_po_value_aed_m numeric(14,3) NOT NULL,
 invoiced_to_date_aed_m numeric(14,3) NOT NULL, open_commitment_aed_m numeric(14,3) NOT NULL, po_status text
);

-- Load the five CSV files using pgAdmin Import/Export or psql \copy.
-- Example: \copy projects FROM 'data/processed/projects.csv' CSV HEADER;
-- Repeat for monthly_capex, variance_log, project_budget and purchase_orders.

CREATE OR REPLACE VIEW vw_project_exposure AS
WITH actuals AS (SELECT project_id, SUM(actual_capex_aed_m) actual_capex_aed_m FROM monthly_capex GROUP BY project_id),
commitments AS (SELECT project_id, SUM(open_commitment_aed_m) open_commitments_aed_m FROM purchase_orders GROUP BY project_id)
SELECT p.project_id, p.project_name, b.approved_budget_aed_m,
 COALESCE(a.actual_capex_aed_m,0) actual_capex_aed_m,
 COALESCE(c.open_commitments_aed_m,0) open_commitments_aed_m,
 COALESCE(a.actual_capex_aed_m,0)+COALESCE(c.open_commitments_aed_m,0) committed_exposure_aed_m,
 b.approved_budget_aed_m-COALESCE(a.actual_capex_aed_m,0)-COALESCE(c.open_commitments_aed_m,0) headroom_after_open_pos_aed_m,
 ROUND(100.0*COALESCE(a.actual_capex_aed_m,0)/NULLIF(b.approved_budget_aed_m,0),2) actual_budget_utilisation_pct,
 ROUND(100.0*(COALESCE(a.actual_capex_aed_m,0)+COALESCE(c.open_commitments_aed_m,0))/NULLIF(b.approved_budget_aed_m,0),2) committed_exposure_pct
FROM projects p JOIN project_budget b ON b.project_id=p.project_id
LEFT JOIN actuals a ON a.project_id=p.project_id LEFT JOIN commitments c ON c.project_id=p.project_id;

-- 1. Monthly and cumulative plan/actual/variance
SELECT project_id, month, planned_capex_aed_m, actual_capex_aed_m,
 actual_capex_aed_m-planned_capex_aed_m AS monthly_variance_aed_m,
 SUM(planned_capex_aed_m) OVER(PARTITION BY project_id ORDER BY month) cumulative_plan_aed_m,
 SUM(actual_capex_aed_m) OVER(PARTITION BY project_id ORDER BY month) cumulative_actual_aed_m,
 SUM(actual_capex_aed_m-planned_capex_aed_m) OVER(PARTITION BY project_id ORDER BY month) cumulative_variance_aed_m
FROM monthly_capex ORDER BY project_id, month;

-- 2. Procurement commitment analysis by project
SELECT project_id, SUM(revised_po_value_aed_m) revised_po_aed_m,
 SUM(invoiced_to_date_aed_m) invoiced_aed_m, SUM(open_commitment_aed_m) open_commitment_aed_m
FROM purchase_orders GROUP BY project_id ORDER BY open_commitment_aed_m DESC;

-- 3. Portfolio exposure
SELECT SUM(approved_budget_aed_m) approved_budget_aed_m, SUM(actual_capex_aed_m) actual_capex_aed_m,
 SUM(open_commitments_aed_m) open_commitments_aed_m, SUM(committed_exposure_aed_m) committed_exposure_aed_m,
 SUM(headroom_after_open_pos_aed_m) headroom_after_open_pos_aed_m
FROM vw_project_exposure;

-- 4. Data quality checks
SELECT COUNT(*) monthly_rows, COUNT(DISTINCT project_id) projects, COUNT(DISTINCT (project_id,month)) project_month_keys FROM monthly_capex;
SELECT po_id, COUNT(*) FROM purchase_orders GROUP BY po_id HAVING COUNT(*)>1;
SELECT * FROM purchase_orders WHERE open_commitment_aed_m < 0;
SELECT p.project_id FROM projects p LEFT JOIN project_budget b USING(project_id) WHERE b.project_id IS NULL;
