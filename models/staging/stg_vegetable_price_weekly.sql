{% set unpivot_mapping = [
    ['cabbage', 'キャベツ'],
    ['green_onion', 'ねぎ'],
    ['lettuce', 'レタス'],
    ['potato', 'ばれいしょ'],
    ['onion', 'たまねぎ'],
    ['cucumber', 'きゅうり'],
    ['tomato', 'トマト'],
    ['carrot', 'にんじん'],
    ['chinese_cabbage', 'はくさい'],
    ['radish', 'だいこん']
]%}

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

    unpivot_vegitable as (
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
    )

select *
from unpivot_vegitable
