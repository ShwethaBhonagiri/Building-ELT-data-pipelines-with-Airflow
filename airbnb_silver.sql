WITH raw_data AS (
    SELECT 
        listing_id,
        host_id,
        listing_neighbourhood,
        price,
        review_scores_rating,
        availability_30
    FROM {{ ref('airbnb_raw') }}
)
SELECT 
    listing_id,
    host_id,
    listing_neighbourhood,
    price,
    CASE 
        WHEN has_availability = 't' THEN 'Available'
        ELSE 'Unavailable'
    END AS availability_status,
    review_scores_rating,
    availability_30
FROM raw_data;
