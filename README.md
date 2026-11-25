# Oil & Gas CAPEX Performance Analysis | Portfolio Case Study

> **Synthetic portfolio project.** All project names, suppliers, purchase orders, budgets and financial values are fictional and created for learning. This project does not use or represent ADNOC internal data.

## Business question

How can a Project Controls / CAPEX Analyst monitor monthly capital expenditure, identify plan-versus-actual variances, investigate exceptions, track procurement commitments and communicate financial exposure to management?

## What this project demonstrates

- CAPEX planning and monthly actual-versus-plan analysis.
- Monthly and cumulative variance calculations.
- Variance investigation and corrective-action tracking.
- Purchase order change control and open commitment calculations.
- Project-level and portfolio-level committed exposure.
- PostgreSQL data modelling, SQL aggregations, window functions and data-quality checks.
- Power BI semantic modelling and DAX KPI design.
- Management reporting and recommendations.

## Portfolio snapshot

- Projects: 5
- Monthly CAPEX records: 60
- Variance log records: 8
- Purchase orders: 15
- Planned CAPEX: AED 355.000M
- Actual CAPEX: AED 360.711M
- Open commitments: AED 63.200M

## Repository structure

```text
CAPEX_Performance_Analysis/
├── README.md
├── LICENSE
├── .gitignore
├── data/
│   ├── raw/                 # Original source workbooks for provenance
│   └── processed/           # Clean CSV inputs and validation output
├── docs/
│   ├── DATA_DICTIONARY.md
│   ├── METHODOLOGY_AND_BUSINESS_RULES.md
│   └── EXECUTIVE_REPORT.md
├── excel/                   # Final Excel workbook (add reviewed copy)
├── sql/
│   └── 01_build_and_analyse_capex.sql
├── powerbi/
│   ├── measures.dax
│   └── POWER_BI_BUILD_GUIDE.md
└── images/                  # Dashboard screenshots for GitHub README
```

## Tools

Microsoft Excel · PostgreSQL · pgAdmin · SQL · Power BI · DAX · GitHub

## Key business definitions

- **Monthly variance:** actual CAPEX minus planned CAPEX. Positive = above plan.
- **Cumulative variance:** cumulative actual minus cumulative planned.
- **Open commitment:** revised PO value minus invoiced-to-date under the simplified training rule.
- **Current committed exposure:** actual CAPEX plus open commitments.
- **Budget headroom:** approved budget minus current committed exposure.
- **EAC:** actual CAPEX plus a separately validated ETC. Open POs alone are not ETC.

## Limitations

This is a portfolio demonstration using synthetic data, not an audited report, live operational system or representation of ADNOC. Real-world use would require Finance/Procurement source reconciliation, approved definitions, accrual treatment, change control, ETC/EAC governance and data access controls.
