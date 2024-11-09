WITH silver_data AS (
    SELECT * FROM {{ ref('airbnb_silver') }}
)
SELECT 
    listing_id,
    listing_neighbourhood,
    AVG(price) AS avg_price,
    AVG(review_scores_rating) AS avg_rating,
    SUM(30 - availability_30) AS total_stays
FROM silver_data
GROUP BY listing_id, listing_neighbourhood;
