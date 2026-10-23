# Intel Sustainability Impact Analysis

SQL analysis of a device repurposing program: which device types, ages and regions give the largest energy and CO2 savings, and where the program should focus.

**Queries:** [sql/queries.sql](sql/queries.sql) · **Full completed document:** [project-pdf/intel-sustainability-impact.pdf](project-pdf/intel-sustainability-impact.pdf)

This is a training project from the Global Career Accelerator program, completed for the **Querying Data (Intel Project) Certification**. The scenario and data come from the program. The data is described in the project as hypothetical: it was built to reflect the structure of Intel's data, not taken from it. This repo is not affiliated with Intel, and the work was not done for Intel.

## Context

Intel runs programs that repurpose and recycle used devices to cut e-waste, energy use and CO2 emissions. The project asks which devices in the 2024 program should be prioritized for the most environmental benefit, and ends with a recommendation.

## Data

Two tables joined on `device_id`, one row per device repurposed in 2024:

- `intel.device_data`: device type (laptop or desktop) and model year.
- `intel.impact_data`: usage purpose, power use, estimated energy saved per year (kWh), estimated CO2 saved per year (kg), recycling rate, and region (North America, Europe or Asia).

## Tools and skills

- SQL: `INNER JOIN`, calculated columns, `CASE WHEN` buckets
- Common table expressions (`WITH`), including several in one query
- `GROUP BY` with `COUNT`, `AVG`, `SUM` and `ROUND`
- Share of a total, by joining two aggregated tables
- Turning query results into a recommendation

## Approach

1. Joined the two tables and added each device's age (2024 minus model year).
2. Grouped ages into newer (3 years or less), mid-age (4 to 6) and older (over 6) with `CASE WHEN`.
3. Summarized the whole program: device count, average age, average energy saved and total CO2 saved.
4. Compared device types, age groups and regions.
5. LevelUp: calculated each device type's share of energy and CO2 savings within each region.

## Key findings

- **601,740 devices** were repurposed in 2024.
- **Laptops are the most repurposed type** (408,064 devices) and save slightly more energy per device than desktops (25.80 kWh a year). CO2 savings per device are about the same for both.
- **Older devices are repurposed least** (20,239 devices) but save the most energy per device on average (48.02 kWh a year).
- **Asia has the highest average CO2 saved per device** (0.02 tons a year), while energy saved per device is about the same in every region. The analysis puts this down to a likely higher carbon intensity of electricity in Asia.
- **Within every region, laptops account for most of the energy savings** and about 68% of the CO2 saved.

**Recommendation:** grow the program in Asia and prioritize older devices, which give the highest energy and CO2 savings per device, while continuing to prioritize laptops. To also control cost, add per-device repurposing cost to the data, compare it by region and device type, and send devices that cost too much to repurpose for parts instead.

## Running the queries

The queries cannot be re-run outside the program. The data exists only in the Global Career Accelerator SQL app, and this repo does not include it.

`sql/queries.sql` holds the queries exactly as written in the completed document, in order, each labeled with its task. Tasks without a query (1C, 2A, 2C, 3B, 3D, 3F, Task 4 and LevelUp B and C) were written answers.

## Repo structure

```
intel-sustainability-impact-sql/
├── sql/
│   └── queries.sql                        the queries, labeled by task
└── project-pdf/
    └── intel-sustainability-impact.pdf    full completed document with written answers
```
