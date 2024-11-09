-- Create Schema
CREATE SCHEMA IF NOT EXISTS bronze;

-- Create Airbnb Raw Table
CREATE TABLE bronze.airbnb_raw (
    listing_id INT,
    scrape_id BIGINT,
    scraped_date DATE,
    host_id INT,
    host_name VARCHAR(100),
    host_since DATE,
    host_is_superhost CHAR(1),
    host_neighbourhood VARCHAR(100),
    listing_neighbourhood VARCHAR(100),
    property_type VARCHAR(100),
    room_type VARCHAR(100),
    accommodates INT,
    price DECIMAL(10, 2),
    has_availability CHAR(1),
    availability_30 INT,
    number_of_reviews INT,
    review_scores_rating DECIMAL(4, 2),
    review_scores_accuracy DECIMAL(4, 2),
    review_scores_cleanliness DECIMAL(4, 2),
    review_scores_checkin DECIMAL(4, 2),
    review_scores_communication DECIMAL(4, 2),
    review_scores_value DECIMAL(4, 2)
);


COPY bronze.airbnb_raw FROM 'C:/Users/05_2020.csv' DELIMITER ',' CSV HEADER;

-- Create Census Raw Table
CREATE TABLE bronze.census_raw (
    lga_code INT,
    median_age_persons INT,
    median_mortgage_repay_monthly DECIMAL(10, 2),
    median_tot_prsnl_inc_weekly DECIMAL(10, 2),
    median_rent_weekly DECIMAL(10, 2),
    median_tot_fam_inc_weekly DECIMAL(10, 2),
    average_num_psns_per_bedroom DECIMAL(4, 2),
    median_tot_hhd_inc_weekly DECIMAL(10, 2),
    average_household_size DECIMAL(4, 2)
);


COPY bronze.census_raw FROM 'C:/Users/census_data.csv' DELIMITER ',' CSV HEADER;

-- Create LGA Mapping Table
CREATE TABLE bronze.lga_mapping (
    lga_code INT,
    lga_name VARCHAR(100),
    suburb_name VARCHAR(100)
);


COPY bronze.lga_mapping FROM 'C:/Users/lga_mapping.csv' DELIMITER ',' CSV HEADER;
