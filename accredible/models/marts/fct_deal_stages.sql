{{
    config(
        materialized='table',
        unique_key="deal_id||''''''''-''''''''||stage_created_at"
    )
}}

-- Fact table showing the business process of a deal moving between stages in the pipeline.
-- Each row represents a deal and details of when it moved into a certain stage in the pipeline.
-- This table can then be ingested into a BI tool e.g. looker or queried on its own to answer questions regarding deals and stages.

WITH deals AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['deal_id', 'stage_created_at']) }} AS deal_stage_key,
        {{ dbt_utils.generate_surrogate_key(['deal_id']) }} AS deal_key,
        deal_id,
        stage_created_at,
        pipeline_id,
        pipeline_name,
        deal_stage_id,
        stage_name AS pipeline_stage_name,
        stage_display_order

    FROM
    {{ ref("stg_deal_pipeline_stages") }}

)

SELECT
  *

FROM deals
