{{
    config(
        materialized='view',
        unique_key="deal_id||''''-''''||stage_created_at"
    )
}}

-- Get deal stage source data and cleanse data

WITH raw AS (
    SELECT
        CAST(DEAL_ID AS INTEGER) AS deal_id,
        CAST(STAGE_CREATED_AT AS TIMESTAMP) AS stage_created_at,
        UPPER(PIPELINE_ID) AS pipeline_id,
        UPPER(PIPELINE_NAME) AS pipeline_name,
        CAST(DEAL_STAGE_ID AS STRING) AS deal_stage_id,
        UPPER(STAGE_NAME) AS stage_name,
        CAST(STAGE_DISPLAY_ORDER AS INTEGER) AS stage_display_order

    FROM
        {{ source('src', 'deal_pipeline_stages') }}

),

-- Deduplicate by the deal_id and stage_created_at to remove any duplicates

deduped AS ( SELECT *, ROW_NUMBER() OVER (PARTITION BY deal_id, stage_created_at ORDER BY stage_created_at DESC) AS rank_rev FROM raw)

SELECT
    *
EXCEPT
    (rank_rev)
FROM
    deduped
WHERE
    rank_rev = 1
