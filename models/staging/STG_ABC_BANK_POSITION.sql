WITH

src_data as (
    SELECT
        ACCOUNTID            as ACCOUNT_CODE     -- TEXT
         , SYMBOL            as SECURITY_CODE    -- TEXT
         , DESCRIPTION       as SECURITY_NAME    -- TEXT
         , EXCHANGE          as EXCHANGE_CODE    -- TEXT
         , REPORT_DATE       as REPORT_DATE      -- DATE
         , QUANTITY          as QUANTITY         -- NUMBER
         , COST_BASE         as COST_BASE        -- NUMBER
         , POSITION_VALUE    as POSITION_VALUE   -- NUMBER
         , CURRENCY          as CURRENCY_CODE    -- TEXT

         , 'SOURCE_DATA.ABC_BANK_POSITION' as RECORD_SOURCE

    FROM `dbt-analytics-engineer-422418`.`SOURCE_DATA`.`ABC_BANK_POSITION`
),

hashed as (
    SELECT
          ACCOUNT_CODE || '|' || SECURITY_CODE as POSITION_HKEY
        , ACCOUNT_CODE  || '|' || SECURITY_CODE || '|' || SECURITY_NAME || '|' || EXCHANGE_CODE ||'|' || REPORT_DATE ||'|' || QUANTITY ||'|' || COST_BASE || '|' || POSITION_VALUE || '|' || CURRENCY_CODE as POSITION_HDIFF
        , *
        , '2024-06-10 10:04:01.510949+00:00'as LOAD_TS_UTC
    FROM src_data
)

SELECT * FROM hashed