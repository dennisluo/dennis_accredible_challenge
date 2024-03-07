{{
    config(
        materialized='view',
        unique_key="deal_id"
    )
}}

-- Get deal source data and cleanse data

WITH raw AS (
    SELECT
        CAST(DEAL_ID AS INTEGER) AS deal_id,
        UPPER(PIPELINE_ID) AS pipeline_id,
        UPPER(PIPELINE_NAME) AS pipeline_name,
        UPPER(STAGE_NAME) AS stage_name,
        COALESCE(CAST(AMOUNT_IN_HOME_CURRENCY AS FLOAT64),0) AS amount_in_home_currency,
        CAST(CREATED_AT AS TIMESTAMP) AS created_at,
        CAST(CLOSE_DATE AS TIMESTAMP) AS closed_at,
        UPPER(DEAL_SOURCE_TYPE) AS deal_source_type

    FROM
        {{ source('src', 'deals') }}

),

-- Deduplicate by the deal_id to remove any duplicates

deduped AS ( SELECT *, ROW_NUMBER() OVER (PARTITION BY deal_id ORDER BY created_at DESC) AS rank_rev FROM raw)

SELECT
    *
EXCEPT
    (rank_rev)
FROM
    deduped
WHERE
    rank_rev = 1
