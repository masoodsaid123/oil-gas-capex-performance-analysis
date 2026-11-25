# Methodology and Business Rules

## Objective
Demonstrate an end-to-end, fictional Oil & Gas capital project performance analysis workflow using Excel, PostgreSQL and Power BI.

## Core measures
- Monthly variance = Actual CAPEX - Planned CAPEX. Positive means actual spend is above plan; negative means below plan.
- Cumulative variance = cumulative actual - cumulative planned.
- Actual budget utilisation = cumulative actual CAPEX / approved budget.
- Revised PO = original PO + approved change orders - approved cancellations.
- Open commitment = revised PO - invoiced to date (simplified training convention).
- Current committed exposure = actual CAPEX + open commitments.
- Budget headroom after open POs = approved budget - current committed exposure.
- EAC = actual CAPEX + ETC. Do not infer ETC from open POs alone.

## Analysis workflow
1. Confirm project master and reporting period.
2. Validate row counts, keys, date coverage, nulls and non-negative values.
3. Reconcile actual CAPEX to the finance ledger in a real environment.
4. Reconcile PO values, changes, invoicing and open balances to procurement/AP evidence.
5. Calculate monthly and cumulative performance.
6. Investigate material variances using reason, owner, due date and action status.
7. Present exceptions, exposure and management actions.

## Limitations
This portfolio uses synthetic data and illustrative budget assumptions. It does not represent ADNOC systems, actual projects, suppliers, contracts or internal processes. The analysis is a demonstration, not an audited financial report.
