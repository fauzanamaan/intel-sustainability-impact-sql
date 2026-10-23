-- Queries copied as written from the completed document. Each was run on its own in the Global Career Accelerator SQL app, so they are not meant to run as one script.

-- Task 1A
SELECT
  d.*,
  i.*
FROM
  intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON d.device_id = i.device_id

-- Task 1B
SELECT
  d.*,
  i.*,
  (2024 - d.model_year ) AS device_age
FROM
  intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON d.device_id = i.device_id

-- Task 1D
SELECT
  d.*,
  i.*,
  (2024 - d.model_year) AS device_age,
  CASE
    WHEN (2024 - d.model_year) <= 3 THEN 'newer'
    WHEN (2024 - d.model_year) >= 4 AND (2024 -
d.model_year) <= 6 THEN 'mid-age'
    WHEN (2024 - d.model_year) > 6 THEN 'older'
    ELSE 'ERROR'
  END AS device_age_bucket
FROM
  intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON d.device_id = i.device_id
ORDER BY device_age DESC

-- Task 2B
WITH joined_data AS (SELECT
  d.*,
  i.*,
  (2024 - d.model_year) AS device_age,
  CASE
    WHEN (2024 - d.model_year) <= 3 THEN 'newer'
    WHEN (2024 - d.model_year) >= 4 AND (2024 -
d.model_year) <= 6 THEN 'mid-age'
    WHEN (2024 - d.model_year) > 6 THEN 'older'
    ELSE 'ERROR'
  END AS device_age_bucket
FROM
  intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON d.device_id = i.device_id)

SELECT
  COUNT(*) AS num_repurposed_devices,
  ROUND(AVG(device_age), 2) AS avg_device_age,
  ROUND(AVG(energy_savings_yr), 2) AS
avg_energy_saving_yr,
  ROUND(SUM(co2_saved_kg_yr)/1000, 2) AS
total_co2_saved_tons_yr
FROM joined_data

-- Task 3A
WITH joined_data AS (SELECT
  d.*,
  i.*,
  (2024 - d.model_year) AS device_age,
  CASE
    WHEN (2024 - d.model_year) <= 3 THEN 'newer'
    WHEN (2024 - d.model_year) >= 4 AND (2024 -
d.model_year) <= 6 THEN 'mid-age'
    WHEN (2024 - d.model_year) > 6 THEN 'older'
    ELSE 'ERROR'
  END AS device_age_bucket
FROM
  intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON d.device_id = i.device_id)
SELECT
  device_type,
  COUNT(*) AS num_repurposed_devices,
  ROUND(AVG(energy_savings_yr), 2) AS
avg_energy_saving_yr,
  ROUND(AVG(co2_saved_kg_yr)/1000, 2) AS
avg_co2_saved_tons_yr
FROM joined_data
GROUP BY device_type

-- Task 3C
WITH joined_data AS (SELECT
  d.*,
  i.*,
  (2024 - d.model_year) AS device_age,
  CASE
    WHEN (2024 - d.model_year) <= 3 THEN 'newer'
    WHEN (2024 - d.model_year) >= 4 AND (2024 -
d.model_year) <= 6 THEN 'mid-age'
    WHEN (2024 - d.model_year) > 6 THEN 'older'
    ELSE 'ERROR'
  END AS device_age_bucket
FROM
  intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON d.device_id = i.device_id)
SELECT
  device_age_bucket,
  COUNT(*) AS num_repurposed_devices,
  ROUND(AVG(energy_savings_yr), 2) AS
avg_energy_saving_yr,
  ROUND(AVG(co2_saved_kg_yr)/1000, 2) AS
avg_co2_saved_tons_yr
FROM joined_data
GROUP BY device_age_bucket

-- Task 3E
WITH joined_data AS (SELECT
  d.*,
  i.*,
  (2024 - d.model_year) AS device_age,
  CASE
    WHEN (2024 - d.model_year) <= 3 THEN 'newer'
    WHEN (2024 - d.model_year) >= 4 AND (2024 -
d.model_year) <= 6 THEN 'mid-age'
    WHEN (2024 - d.model_year) > 6 THEN 'older'
    ELSE 'ERROR'
  END AS device_age_bucket
FROM
  intel.device_data AS d
INNER JOIN intel.impact_data AS i
  ON d.device_id = i.device_id)
SELECT
  region,
  COUNT(*) AS num_repurposed_devices,
  ROUND(AVG(energy_savings_yr), 2) AS
avg_energy_saving_yr,
  ROUND(AVG(co2_saved_kg_yr)/1000, 2) AS
avg_co2_saved_tons_yr
FROM joined_data
GROUP BY region

-- LevelUp A
WITH
  joined_data AS (
    SELECT
      d.*,
      i.*,
      (2024 - d.model_year) AS device_age,
      CASE
        WHEN (2024 - d.model_year) <= 3 THEN 'newer'
        WHEN (2024 - d.model_year) >= 4 AND (2024 -
d.model_year) <= 6 THEN 'mid-age'
        WHEN (2024 - d.model_year) > 6 THEN 'older'
        ELSE 'ERROR'
      END AS device_age_bucket
    FROM
      intel.device_data AS d
    INNER JOIN intel.impact_data AS i
      ON d.device_id = i.device_id),

  region_device AS (
    SELECT
      region,
      device_type,
      COUNT(*) AS num_repurposed_devices,
      ROUND(AVG(energy_savings_yr), 2) AS
avg_energy_saving_yr,
      ROUND(AVG(co2_saved_kg_yr)/1000, 2) AS
avg_co2_saved_tons_yr,
      ROUND(SUM(energy_savings_yr), 2) AS
total_energy_saving_yr,
      ROUND(SUM(co2_saved_kg_yr)/1000, 2) AS
total_co2_saved_tons_yr
    FROM joined_data
    GROUP BY region, device_type),

  region_only AS (
    SELECT
      region,
      COUNT(*) AS num_repurposed_devices,
      ROUND(AVG(energy_savings_yr), 2) AS
avg_energy_saving_yr,
      ROUND(AVG(co2_saved_kg_yr)/1000, 2) AS
avg_co2_saved_tons_yr,
      ROUND(SUM(energy_savings_yr), 2) AS
total_energy_saving_yr,
      ROUND(SUM(co2_saved_kg_yr)/1000, 2) AS
total_co2_saved_tons_yr
    FROM joined_data
    GROUP BY region)

SELECT
  rd.region,
  rd.device_type,
  rd.num_repurposed_devices,
  rd.avg_energy_saving_yr,
  rd.avg_co2_saved_tons_yr,
  ROUND(rd.total_energy_saving_yr /
ro.total_energy_saving_yr * 100, 2) AS
pct_of_region_energy_saving,
  ROUND(rd.total_co2_saved_tons_yr /
ro.total_co2_saved_tons_yr * 100, 2) AS
pct_of_region_co2_saved
FROM region_device AS rd
INNER JOIN region_only AS ro
  ON rd.region = ro.region
ORDER BY
  rd.region,
  rd.device_type
