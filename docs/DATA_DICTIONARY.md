# Data Dictionary

All monetary values are in AED millions unless explicitly stated. All records are fictional.

| Table           | Field                  | Meaning                                              | Grain / rule                          |
| --------------- | ---------------------- | ---------------------------------------------------- | ------------------------------------- |
| projects        | project_id             | Stable project identifier                            | One row per project; primary key      |
| projects        | project_name           | Fictional project name                               | One row per project                   |
| projects        | approved_budget_aed_m  | Original synthetic approved budget                   | AED M                                 |
| monthly_capex   | project_id             | Project foreign key                                  | Combined with month is primary key    |
| monthly_capex   | month                  | Reporting month                                      | Month-start date                      |
| monthly_capex   | planned_capex_aed_m    | Planned monthly CAPEX                                | AED M                                 |
| monthly_capex   | actual_capex_aed_m     | Actual monthly CAPEX                                 | AED M                                 |
| variance_log    | variance_id            | Variance/action identifier                           | Primary key                           |
| variance_log    | variance_amount_aed_m  | Logged variance amount                               | AED M; see source context             |
| purchase_orders | po_id                  | Fictional purchase order ID                          | Primary key                           |
| purchase_orders | revised_po_value_aed_m | Original + approved changes - approved cancellations | AED M                                 |
| purchase_orders | invoiced_to_date_aed_m | Invoiced amount recorded against PO                  | AED M                                 |
| purchase_orders | open_commitment_aed_m  | Revised PO - invoiced to date                        | AED M; simplified training convention |
| project_budget  | approved_budget_aed_m  | Synthetic Day 15 budget assumption                   | AED M                                 |
