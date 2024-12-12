with

    source as (select * from {{ source("salesforce", "vegetable_price_weekly") }}),

    renamed as (
        select
            survey_week__c as survey_week,
            price_cabbage__c as "キャベツ",
            price_green_onion__c as "ねぎ",
            price_lettuce__c as "レタス",
            price_potato__c as "ばれいしょ",
            price_onion__c as "たまねぎ",
            price_cucumber__c as "きゅうり",
            price_tomato__c as "トマト",
            price_carrot__c as "にんじん",
            price_chinese_cabbage__c as "はくさい",
            price_radish__c as "だいこん"
        from source
    ),

    -- 横持ちになっているものを縦持ちに変換
    unpivot_vegetable as (
        select * from renamed
        unpivot (price for vegetable_name in (
            "キャベツ",
            "ねぎ",
            "レタス",
            "ばれいしょ",
            "たまねぎ",
            "きゅうり",
            "トマト",
            "にんじん",
            "はくさい",
            "だいこん"
        ))
    ),

    final as (
        select
            survey_week,
            vegetable_name,
            price
        from
            unpivot_vegetable
    )

select *
from final
