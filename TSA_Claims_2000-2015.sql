-- Show the full dataset:

SELECT *
FROM tsa_claims_clean;


-- How many records are there?

SELECT COUNT(*)
FROM tsa_claims_clean;


-- How many distinct values are there for each variable?

SELECT
	COUNT(DISTINCT claim_no),
	COUNT(DISTINCT date_rec),
	COUNT(DISTINCT incident_date),
	COUNT(DISTINCT ap_code),
	COUNT(DISTINCT ap_name),
	COUNT(DISTINCT airline),
	COUNT(DISTINCT claim_type),
	COUNT(DISTINCT claim_site),
	COUNT(DISTINCT item),
	COUNT(DISTINCT claim_amt),
	COUNT(DISTINCT status),
	COUNT(DISTINCT close_amt),
	COUNT(DISTINCT disp)
FROM tsa_claims_clean;



-- TIME-BASED QUERIES



-- What are the earliest and most recent incident dates recorded?

SELECT MIN(incident_date), MAX(incident_date)
FROM tsa_claims_clean
WHERE incident_date IS NOT NULL AND incident_date <> '';


-- How many claims are there for each date? Which dates have the most claims?

SELECT incident_date, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE incident_date IS NOT NULL AND incident_date <> ''
GROUP BY incident_date
ORDER BY claims DESC;


-- How many claims are there by day of the week?

SELECT
    CASE strftime('%w', incident_date)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
GROUP BY
    day_of_week
ORDER BY
    CASE day_of_week
        WHEN 'Sunday' THEN 0
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
    END;


-- How many claims are there for each claim type by day of the week? 

SELECT
    claim_type,
	CASE strftime('%w', incident_date)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
    AND claim_type IS NOT NULL AND claim_type != ''
GROUP BY
    claim_type, day_of_week
ORDER BY
	claim_type,
    CASE day_of_week
        WHEN 'Sunday' THEN 0
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
    END;


-- How many claims are there by month? What are the daily averages for each month?

SELECT
    CASE strftime('%m', incident_date)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
    END AS month_name,
    COUNT(*) AS total_claims,
    PRINTF('%.2f', COUNT(*) * 1.0 / (
        CASE strftime('%m', incident_date)
            WHEN '01' THEN 31.0
            WHEN '02' THEN 28.25
            WHEN '03' THEN 31.0
            WHEN '04' THEN 30.0
            WHEN '05' THEN 31.0
            WHEN '06' THEN 30.0
            WHEN '07' THEN 31.0
            WHEN '08' THEN 31.0
            WHEN '09' THEN 30.0
            WHEN '10' THEN 31.0
            WHEN '11' THEN 30.0
            WHEN '12' THEN 31.0
        END
    )) AS avg_daily_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
GROUP BY
    month_name
ORDER BY
    strftime('%m', incident_date);


-- How many claims are there each day of the year?

SELECT
    strftime('%m-%d', incident_date) AS month_day,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
GROUP BY
    month_day
ORDER BY
    total_claims DESC,
	month_day;


-- How many claims are there each day of the year for a specific Claim Type?

SELECT
    strftime('%m-%d', incident_date) AS month_day,
    claim_type,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
    AND claim_type = 'Passenger Property Loss'
GROUP BY
    month_day
ORDER BY
    total_claims DESC,
	month_day;


-- How many claims are there each day of the year for a specific Airport Code?

SELECT
    incident_date,
    ap_code,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
    AND ap_code = 'EWR'
GROUP BY
    incident_date
ORDER BY
    incident_date;


-- How many claims are there each day of the year for a specific Airline?

SELECT
    incident_date,
    airline,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
    AND airline = 'American Airlines'
GROUP BY
    incident_date
ORDER BY
    incident_date;


-- How many claims are there each year?

SELECT
    strftime('%Y', incident_date) AS claim_year,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
GROUP BY
    claim_year
ORDER BY
    claim_year;



-- CATEGORICAL QUERIES


-- How many claims are there by

-- Claim Type

SELECT claim_type, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE claim_type IS NOT NULL AND claim_type <> ''
GROUP BY claim_type
ORDER BY claims DESC;


-- Item

SELECT item, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE item IS NOT NULL AND item <> ''
GROUP BY item
ORDER BY claims DESC;


-- Claim Site

SELECT claim_site, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE claim_site IS NOT NULL AND claim_site <> ''
GROUP BY claim_site
ORDER BY claims DESC;


-- Status

SELECT status, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE status IS NOT NULL AND status <> ''
GROUP BY status
ORDER BY claims DESC;


-- Disposition

SELECT disp, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE disp IS NOT NULL AND disp <> ''
GROUP BY disp
ORDER BY claims DESC;


-- Airline

SELECT airline, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE airline IS NOT NULL AND airline <> ''
GROUP BY airline
ORDER BY claims DESC;


-- Aiport

SELECT ap_name, COUNT(claim_no) AS claims
FROM tsa_claims_clean
WHERE ap_name IS NOT NULL AND ap_name <> ''
GROUP BY ap_name
ORDER BY claims DESC;


-- Status & Disposition

SELECT status, disp, COUNT(*) AS claims
FROM tsa_claims_clean
WHERE status IS NOT NULL AND status != ''
AND disp IS NOT NULL AND disp != ''
GROUP BY status, disp;


-- Status & Claim Type

SELECT claim_type, status, COUNT(*) AS claims
FROM tsa_claims_clean
WHERE status IS NOT NULL AND status != ''
AND claim_type IS NOT NULL AND claim_type != ''
GROUP BY claim_type, status;


-- Status & Claim Type & Disposition

SELECT claim_type, status, disp, COUNT(*) AS claims
FROM tsa_claims_clean
WHERE status IS NOT NULL AND status != ''
AND claim_type IS NOT NULL AND claim_type != ''
AND disp IS NOT NULL AND disp != ''
GROUP BY claim_type, status, disp;


-- Claim Type & Item

SELECT claim_type, item, COUNT(*) AS claims
FROM tsa_claims_clean
WHERE item IS NOT NULL AND item != ''
AND claim_type IS NOT NULL AND claim_type != ''
GROUP BY claim_type, item
ORDER BY claims DESC;


-- Claim Site & Claim Type

SELECT claim_type, claim_site, COUNT(*) AS claims
FROM tsa_claims_clean
WHERE claim_site IS NOT NULL AND claim_site != ''
AND claim_type IS NOT NULL AND claim_type != ''
GROUP BY claim_type, claim_site
ORDER BY claims DESC;



-- FINANCIAL QUERIES



-- Total claim and close values, average claim and close values, and the differences between them

-- By year

WITH ConvertedAmounts AS (
    SELECT
        strftime('%Y', incident_date) AS claim_year,
        CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL) AS numeric_claim_amt,
        CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL) AS numeric_close_amt
    FROM
        tsa_claims_clean
    WHERE
        incident_date IS NOT NULL AND incident_date != '' AND claim_amt IS NOT NULL AND close_amt IS NOT NULL
)
SELECT
    claim_year,
    PRINTF('%.2f', SUM(numeric_claim_amt)) AS total_claim_value,
    PRINTF('%.2f', SUM(numeric_close_amt)) AS total_close_value,
    PRINTF('%.2f', SUM(numeric_claim_amt) - SUM(numeric_close_amt)) AS total_difference,
    PRINTF('%.2f', AVG(numeric_claim_amt)) AS average_claim_value,
    PRINTF('%.2f', AVG(numeric_close_amt)) AS average_close_value,
    PRINTF('%.2f', AVG(numeric_claim_amt) - AVG(numeric_close_amt)) AS average_difference
FROM
    ConvertedAmounts
GROUP BY
    claim_year
ORDER BY
    claim_year;


-- Airline

WITH ConvertedAmounts AS (
    SELECT
        airline,
        CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL) AS numeric_claim_amt,
        CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL) AS numeric_close_amt
    FROM
        tsa_claims_clean
    WHERE
        incident_date IS NOT NULL AND incident_date != '' 
        AND claim_amt IS NOT NULL AND close_amt IS NOT NULL
        AND airline IS NOT NULL AND airline != ''
)
SELECT
    airline,
    PRINTF('%.2f', SUM(numeric_claim_amt)) AS total_claim_value,
    PRINTF('%.2f', SUM(numeric_close_amt)) AS total_close_value,
    PRINTF('%.2f', AVG(numeric_claim_amt)) AS average_claim_value,
    PRINTF('%.2f', AVG(numeric_close_amt)) AS average_close_value
FROM
    ConvertedAmounts
GROUP BY
    airline
ORDER BY
    SUM(numeric_claim_amt) DESC;


-- Airport & Airport Code

WITH ConvertedAmounts AS (
    SELECT
        ap_name, ap_code,
        CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL) AS numeric_claim_amt,
        CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL) AS numeric_close_amt
    FROM
        tsa_claims_clean
    WHERE
        incident_date IS NOT NULL AND incident_date != '' 
        AND claim_amt IS NOT NULL AND close_amt IS NOT NULL
        AND ap_name IS NOT NULL AND ap_name != ''
        AND ap_code IS NOT NULL AND ap_code != ''
)
SELECT
    ap_name, ap_code,
    PRINTF('%.2f', SUM(numeric_claim_amt)) AS total_claim_value,
    PRINTF('%.2f', SUM(numeric_close_amt)) AS total_close_value,
    PRINTF('%.2f', AVG(numeric_claim_amt)) AS average_claim_value,
    PRINTF('%.2f', AVG(numeric_close_amt)) AS average_close_value
FROM
    ConvertedAmounts
GROUP BY
    ap_name, ap_code
ORDER BY
    SUM(numeric_claim_amt) DESC;


-- Item

WITH ConvertedAmounts AS (
    SELECT
        item,
        CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL) AS numeric_claim_amt,
        CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL) AS numeric_close_amt
    FROM
        tsa_claims_clean
    WHERE
        incident_date IS NOT NULL AND incident_date != '' 
        AND claim_amt IS NOT NULL AND close_amt IS NOT NULL
        AND item IS NOT NULL AND item != ''
)
SELECT
    item,
    PRINTF('%.2f', SUM(numeric_claim_amt)) AS total_claim_value,
    PRINTF('%.2f', SUM(numeric_close_amt)) AS total_close_value,
    PRINTF('%.2f', AVG(numeric_claim_amt)) AS average_claim_value,
    PRINTF('%.2f', AVG(numeric_close_amt)) AS average_close_value
FROM
    ConvertedAmounts
GROUP BY
    item
ORDER BY
    SUM(numeric_claim_amt) DESC;


-- Claim Type

WITH ConvertedAmounts AS (
    SELECT
        claim_type,
        CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL) AS numeric_claim_amt,
        CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL) AS numeric_close_amt
    FROM
        tsa_claims_clean
    WHERE
        incident_date IS NOT NULL AND incident_date != '' 
        AND claim_amt IS NOT NULL AND close_amt IS NOT NULL
        AND claim_type IS NOT NULL AND claim_type != ''
)
SELECT
    claim_type,
    PRINTF('%.2f', SUM(numeric_claim_amt)) AS total_claim_value,
    PRINTF('%.2f', SUM(numeric_close_amt)) AS total_close_value,
    PRINTF('%.2f', AVG(numeric_claim_amt)) AS average_claim_value,
    PRINTF('%.2f', AVG(numeric_close_amt)) AS average_close_value
FROM
    ConvertedAmounts
GROUP BY
    claim_type
ORDER BY
    SUM(numeric_claim_amt) DESC;


-- Average Claim/Claim Amount Difference by Airline

WITH ConvertedAmounts AS (
    SELECT
        airline,
        CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL) AS numeric_claim_amt,
        CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL) AS numeric_close_amt
    FROM
        tsa_claims_clean
    WHERE
        claim_amt IS NOT NULL AND close_amt IS NOT NULL AND
        airline IS NOT NULL AND airline != ''
)
SELECT
    airline,
    PRINTF('%.2f', AVG(numeric_claim_amt) - AVG(numeric_close_amt)) AS average_financial_difference,
    PRINTF('%.2f', SUM(numeric_close_amt)) AS total_close_value
FROM
    ConvertedAmounts
GROUP BY
    airline
ORDER BY
    AVG(numeric_claim_amt) - AVG(numeric_close_amt) DESC;


-- What are the total and average claim and close amounts by day of the week?

SELECT
    CASE strftime('%w', incident_date)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    PRINTF('%.2f', SUM(CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL))) AS total_claim_value,
    PRINTF('%.2f', SUM(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL))) AS total_close_value,
    PRINTF('%.2f', AVG(CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL))) AS average_claim_value,
    PRINTF('%.2f', AVG(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL))) AS average_close_value,
    COUNT(*) AS total_claims
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != '' AND
    claim_amt IS NOT NULL AND claim_amt != '' AND
    close_amt IS NOT NULL AND close_amt != ''
GROUP BY
    day_of_week
ORDER BY
    CASE day_of_week
        WHEN 'Sunday' THEN 0
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
    END;


-- Status & Claim Type & Disposition + Total Claim and Close Values + Average Claim and Close Values + % Differences where the Close Amount total and average are > 0

SELECT
    claim_type, status, disp,
    ROUND(AVG(JULIANDAY(date_rec) - JULIANDAY(incident_date)), 2) AS avg_days_to_resolve,
    PRINTF('%.2f', SUM(CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL))) AS total_claim_value,
    PRINTF('%.2f', SUM(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL))) AS total_close_value,
    PRINTF('%.2f', (SUM(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL)) * 100.0 / SUM(CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL)))) AS total_paid_pct,
    PRINTF('%.2f', AVG(CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL))) AS average_claim_value,
    PRINTF('%.2f', AVG(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL))) AS average_close_value,
    PRINTF('%.2f', (AVG(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL)) * 100.0 / AVG(CAST(REPLACE(REPLACE(claim_amt, '$', ''), ',', '') AS REAL)))) AS average_paid_pct
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
    AND date_rec IS NOT NULL AND date_rec != ''
    AND claim_type IS NOT NULL AND claim_type != ''
    AND status IS NOT NULL AND status != ''
    AND disp IS NOT NULL AND disp != ''
    AND claim_amt IS NOT NULL AND claim_amt != ''
    AND close_amt IS NOT NULL AND close_amt != ''
GROUP BY
    claim_type, status, disp
HAVING
    SUM(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL)) > 0 AND
    AVG(CAST(REPLACE(REPLACE(close_amt, '$', ''), ',', '') AS REAL)) > 0
ORDER BY
    avg_days_to_resolve DESC;



-- EFFICIENCY QUERIES



-- Average days between incident date and received date (how long it took to file a claim)

SELECT
    AVG(JULIANDAY(date_rec) - JULIANDAY(incident_date)) AS avg_days_to_file
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != '' AND
    date_rec IS NOT NULL AND date_rec != '';


-- By Claim Type

SELECT
    claim_type,
    AVG(JULIANDAY(date_rec) - JULIANDAY(incident_date)) AS avg_days_to_file
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != '' AND
    date_rec IS NOT NULL AND date_rec != '' AND
    claim_type IS NOT NULL AND claim_type != ''
GROUP BY
    claim_type
ORDER BY
    avg_days_to_file DESC;


-- By Status & Claim Type & Disposition

SELECT
    claim_type, status, disp,
    ROUND(AVG(JULIANDAY(date_rec) - JULIANDAY(incident_date)), 2) AS avg_days_to_resolve
FROM
    tsa_claims_clean
WHERE
    incident_date IS NOT NULL AND incident_date != ''
    AND date_rec IS NOT NULL AND date_rec != ''
    AND claim_type IS NOT NULL AND claim_type != ''
    AND status IS NOT NULL AND status != ''
    AND disp IS NOT NULL AND disp != ''
GROUP BY
    claim_type, status, disp
ORDER BY
    avg_days_to_resolve DESC;

