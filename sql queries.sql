/*Which Tennessee counties had a disproportionately high number of opioid prescriptions?*/

SELECT f.county , SUM(total_claim_count) as total, population
FROM drug AS d
INNER JOIN prescription AS p2
USING (drug_name)
INNER JOIN prescriber AS p1
USING (npi)
INNER JOIN zip_fips AS z
ON p1.nppes_provider_zip5 = z.zip
INNER JOIN fips_county as f
USING (fipscounty)
INNER JOIN population as p3
USING (fipscounty)
WHERE f.state = 'TN' AND opioid_drug_flag = 'Y'
GROUP BY f.county, population
ORDER BY total DESC;


/*Who are the top opioid prescibers for the state of Tennessee?*/
SELECT p1.nppes_provider_first_name, p1.nppes_provider_last_org_name, SUM(total_claim_count) AS total
FROM drug AS d
INNER JOIN prescription AS p2
USING (drug_name)
INNER JOIN prescriber AS p1
USING (npi)
WHERE p1.nppes_provider_state = 'TN' AND opioid_drug_flag = 'Y'
GROUP BY p1.nppes_provider_first_name, p1.nppes_provider_last_org_name
ORDER BY total DESC;

/*What did the trend in overdose deaths due to opioids look like in Tennessee from 2015 to 2018?*/

SELECT *
FROM drug AS d
INNER JOIN prescription AS p2
USING (drug_name)
INNER JOIN prescriber AS p1
USING (npi)
INNER JOIN zip_fips AS z
ON p1.nppes_provider_zip5 = z.zip
INNER JOIN fips_county as f
USING (fipscounty)
INNER JOIN overdose_deaths as o
USING (fipscounty)
WHERE f.state = 'TN' AND opioid_drug_flag = 'Y' AND YEAR BETWEEN 2015 AND 2018
--GROUP BY year,overdose_deaths
ORDER BY overdose_deaths DESC
limit 20;


SELECT year, SUM(overdose_deaths)
FROM overdose_deaths
--JOIN zip_fips AS z
--USING(fipscounty)
--INNER JOIN prescriber AS p1
--ON p1.nppes_provider_zip5 = z.zip
GROUP BY year








