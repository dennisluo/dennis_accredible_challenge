{{
    config(
        materialized='table',
        unique_key="deal_id"
    )
}}

-- Dimension table containing details of each deal.
-- Each row represents deal and affiliated details.
-- This table can then be ingested into a BI tool e.g. looker or queried on its own to answer questions regarding deals.

WITH deals AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['deal_id']) }} AS deal_key,
        deal_id,
        pipeline_id,
        pipeline_name,
        stage_name AS current_stage_name,
        amount_in_home_currency AS amount_usd,
        created_at AS deal_created_at,
        closed_at AS deal_closed_at,
        deal_source_type

    FROM
    {{ ref("stg_deals") }}

)

SELECT
  *

FROM deals
