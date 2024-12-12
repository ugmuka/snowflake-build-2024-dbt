with
    final as (
        select
            price.survey_week as date,
            price.vegetable_name,
            weather.avg_temp_celsius,
            weather.avg_daily_high_temp_celsius,
            weather.avg_daily_low_temp_celsius,
            weather.total_rainfall_mm,
            weather.max_10min_rainfall_mm,
            weather.total_sunlight_hours,
            weather.max_snow_depth_cm,
            weather.total_snowfall_cm,
            price.price,
        from
            {{ ref('stg_vegetable_price_weekly') }} as price
            left outer join
                {{ ref('stg_weather_stats_weekly') }} as weather
                on
                    price.survey_week = weather.start_date
    )

select *
from final