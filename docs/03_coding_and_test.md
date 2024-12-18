# モデル開発とデータ品質のチェック用のテストの実装

## 諦めること：5分で全部は作れない、ごめんなさい

## 今日のデモでやること
- データソースの紹介とクレンジングの処理は大雑把に説明します
- 最終的に提供するデータ（mart_ml_feature）の実装を開発し、データの検証を行うテストを実装して検証してみる

## データソースの紹介
食品価格動向調査(野菜) 
- 元データ: https://www.maff.go.jp/j/zyukyu/anpo/kouri/k_yasai/h22index.html
- API版: https://www.cultivationdata.net/yasai-kakaku-web-api.html
```
select * from {{ source("salesforce", "vegetable_price_weekly") }}
```

気象データ
- https://www.data.jma.go.jp/gmd/risk/obsdl/ から東京都のみ取得
```
select * from {{ source("salesforce", "weather_stats_weekly") }}
```

## mart_ml_featureの実装

```
with
import_stg_vegetable_price_weekly as (
    select * from {{ ref("stg_vegetable_price_weekly") }}
),

import_stg_weather_stats_weekly as (
    select * from {{ ref("stg_weather_stats_weekly") }}
),

final as (
    select
        import_stg_vegetable_price_weekly.survey_week,
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
```

## _mart_ml_feature.ymlでデータ品質用のテストを実装する

- survey_weekとvegetable_nameの組み合わせでユニークになっているか検証する(unique)
- priceが必ず設定されているか検証する（not_null）