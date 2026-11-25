# Executive CAPEX Performance Report (Synthetic Case Study)

**Reporting basis:** 12 monthly periods in 2025; procurement snapshot 31-Dec-2025.
**Units:** AED millions. **Data classification:** Fictional training data only.

## Executive overview
The portfolio contains 5 fictional capital projects and 60 project-month CAPEX records. Total planned CAPEX is AED 355.000M and actual CAPEX is AED 360.711M, giving an overall actual-versus-plan variance of AED 5.711M.

The procurement snapshot contains 15 fictional purchase orders. Revised PO value is AED 172.900M, invoiced-to-date is AED 109.700M and open commitments are AED 63.200M. Using the separate Day 15 synthetic budget assumptions totalling AED 450.000M, current committed exposure is AED 423.911M and budget headroom after open POs is AED 26.089M.

## Portfolio KPIs
| KPI | Result |
|---|---:|
| Projects | 5 |
| Monthly CAPEX rows | 60 |
| Planned CAPEX | 355.000M |
| Actual CAPEX | 360.711M |
| Actual vs plan variance | 5.711M |
| Revised PO value | 172.900M |
| Invoiced to date | 109.700M |
| Open commitments | 63.200M |
| Day 15 assumed budget | 450.000M |
| Current committed exposure | 423.911M |
| Headroom after open POs | 26.089M |

## Management interpretation
1. Review project-level monthly and cumulative variance to identify spend acceleration, delayed execution or scope changes.
2. Prioritise review of the largest open PO balances and confirm delivery milestones, remaining scope and invoice timing.
3. Reconcile actual CAPEX to finance records and PO consumption to procurement/AP records before formal reporting.
4. Refresh ETC and EAC using remaining work packages, uncommitted scope, risks and opportunities.
5. Assign corrective actions to named accountable roles with due dates and closure evidence.

## Critical interpretation caveat
Current committed exposure is actual CAPEX plus open purchase order commitments. It is **not** Estimate at Completion. It excludes future costs not yet committed. Do not claim that the project/portfolio will finish within budget based only on this calculation.

## Data quality and provenance
The original Day 2 workbook provides the project master and 60 monthly CAPEX rows. The Day 15 workbook provides the procurement snapshot and separate illustrative project budgets. A project-ID mismatch between the two sources was corrected by matching project names and translating procurement rows to the authoritative Day 2 IDs. See `data/processed/validation_summary.json`.
