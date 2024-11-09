-- (a) Demographic differences between top 3 and lowest 3 performing LGAs
WITH lga_revenue AS (
    SELECT
        lga_code,
        SUM(price * (30 - availability_30)) AS estimated_revenue
    FROM bronze.airbnb_raw
    JOIN bronze.lga_mapping ON airbnb_raw.listing_neighbourhood = lga_mapping.suburb_name
    GROUP BY lga_code
),
top_3_lgas AS (
    SELECT lga_code FROM lga_revenue ORDER BY estimated_revenue DESC LIMIT 3
),
bottom_3_lgas AS (
    SELECT lga_code FROM lga_revenue ORDER BY estimated_revenue ASC LIMIT 3
)
SELECT 
    c.lga_code,
    c.median_age_persons,
    c.median_mortgage_repay_monthly,
    c.median_tot_prsnl_inc_weekly,
    c.median_rent_weekly,
    c.average_household_size
FROM bronze.census_raw c
WHERE lga_code IN (SELECT lga_code FROM top_3_lgas UNION ALL SELECT lga_code FROM bottom_3_lgas);

-- (b) Correlation between median age and revenue generated per listing
SELECT 
    listing_neighbourhood,
    AVG(price * (30 - availability_30)) AS avg_revenue,
    c.median_age_persons
FROM bronze.airbnb_raw a
JOIN bronze.lga_mapping l ON a.listing_neighbourhood = l.suburb_name
JOIN bronze.census_raw c ON l.lga_code = c.lga_code
GROUP BY listing_neighbourhood, c.median_age_persons
ORDER BY avg_revenue DESC;

-- (c) Best property type for highest number of stays in top 5 neighbourhoods
WITH revenue_neighbourhoods AS (
    SELECT 
        listing_neighbourhood,
        SUM(price * (30 - availability_30)) AS estimated_revenue
    FROM bronze.airbnb_raw
    GROUP BY listing_neighbourhood
    ORDER BY estimated_revenue DESC
    LIMIT 5
)
SELECT 
    property_type,
    room_type,
    accommodates,
    AVG(30 - availability_30) AS avg_stays
FROM bronze.airbnb_raw
WHERE listing_neighbourhood IN (SELECT listing_neighbourhood FROM revenue_neighbourhoods)
GROUP BY property_type, room_type, accommodates
ORDER BY avg_stays DESC;
