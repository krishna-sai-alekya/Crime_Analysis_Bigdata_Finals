%sql
SELECT
  occ_year,
  COUNT(*) AS total_crimes
FROM crime_final_cluster.default.clean_crime
GROUP BY occ_year
ORDER BY occ_year

%sql
SELECT
  area_name,
  COUNT(*) AS total_crimes
FROM crime_final_cluster.default.clean_crime
GROUP BY area_name
ORDER BY total_crimes DESC
