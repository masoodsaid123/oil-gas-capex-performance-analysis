# Power BI Dashboard Build Specification

## Required model
Use a star-style model with `projects` as the shared project dimension. Relate `projects[project_id]` 1:* to `monthly_capex[project_id]`, `purchase_orders[project_id]`, `project_budget[project_id]` and `variance_log[project_id]`. Use single-direction filtering from Projects. Create a Calendar table and relate it to Monthly_CAPEX[Month]. Do not create direct relationships between fact tables.

## Pages
1. **Portfolio Overview:** approved budget, planned CAPEX, actual CAPEX, variance, actual utilisation; monthly trend; project comparison.
2. **Project Performance:** project slicer; monthly planned vs actual; cumulative plan vs actual; variance log and actions.
3. **Procurement Exposure:** revised PO, invoiced, open commitment, actual CAPEX, committed exposure and headroom; supplier/PO detail table.
4. **Management Actions:** open actions by owner, status, due date and variance reason.

## Required measures
See `powerbi/measures.dax`. Store measures in a dedicated Measures table. Format monetary measures to 2 or 3 decimals and percentages to 1 decimal.

## Publishing checklist
- Validate project IDs and totals against the CSV source files.
- Show snapshot date and AED M units on every relevant page.
- Label all data as synthetic.
- Add a note that committed exposure is not EAC.
- Save the Power BI file as `CAPEX_Performance_Analysis.pbix` in this folder.
- Export dashboard pages as PNG images into `images/` for GitHub preview.
