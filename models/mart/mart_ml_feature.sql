with
import_stg_vegetable_price_weekly as (
    select * from {{ ref("stg_vegetable_price_weekly") }}
),

import_stg_weather_stats_weekly as (
    select * from {{ ref("stg_weather_stats_weekly") }}
),

final as (
    select
        import_stg_vegetable_price_weekly.survey_week as date,
        import_stg_vegetable_price_weekly.vegetable_name,
        import_stg_weather_stats_weekly.avg_temp_celsius,
        import_stg_weather_stats_weekly.avg_daily_high_temp_celsius,
        import_stg_weather_stats_weekly.avg_daily_low_temp_celsius,
        import_stg_weather_stats_weekly.total_rainfall_mm,
        import_stg_weather_stats_weekly.max_10min_rainfall_mm,
        import_stg_weather_stats_weekly.total_sunlight_hours,
        import_stg_weather_stats_weekly.max_snow_depth_cm,
        import_stg_weather_stats_weekly.total_snowfall_cm,
        import_stg_vegetable_price_weekly.price
    from import_stg_vegetable_price_weekly
    left outer join
        import_stg_weather_stats_weekly
        on
            import_stg_vegetable_price_weekly.survey_week
            = import_stg_weather_stats_weekly.start_date
)

select *
from final
