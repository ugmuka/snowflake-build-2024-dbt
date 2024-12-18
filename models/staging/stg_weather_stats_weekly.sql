with

    source as (select * from {{ source("salesforce", "weather_stats_weekly") }}),

    renamed as (
        select
            max_snow_depth_cm,
            total_snowfall_cm,
            start_date__c as start_date,
            end_date__c as end_date,
            avg_temp_celsius__c as avg_temp_celsius,
            avg_daily_high_temp_celsius__c as avg_daily_high_temp_celsius,
            avg_daily_low_temp_celsius__c as avg_daily_low_temp_celsius,
            total_rainfall_mm__c as total_rainfall_mm,
            max_10min_rainfall_mm__c as max_10min_rainfall_mm,
            total_sunlight_hours__c as total_sunlight_hours
        from source
    ),

    final as (
        select
            start_date,
            end_date,
            avg_temp_celsius,
            avg_daily_high_temp_celsius,
            avg_daily_low_temp_celsius,
            total_rainfall_mm,
            max_10min_rainfall_mm,
            total_sunlight_hours,
            max_snow_depth_cm,
            total_snowfall_cm
        from renamed
    )


select *
from final
