with

    source as (select * from {{ source("salesforce", "vegetable_planting_yearly") }}),

    renamed as (
        select
            planting_year__c as planting_year,
            vegetable_name__c as vegetable_name,
            planted_area_ha__c as planted_area_ha,
            harvest_amount_ton__c as harvest_amount_ton,
            shipping_amount_ton__c as shipping_amount_ton
        from source
    ),

    /*
    vegiatable_name: 空白を削除
    計測量系: 数値型に変換
    */
    column_format as (
        select 
            planting_year,
            translate(vegetable_name, ' 　', '') as vegetable_name,
            to_number(replace(planted_area_ha, ',')) as planted_area_ha,
            to_number(replace(harvest_amount_ton, ',')) as harvest_amount_ton,
            to_number(replace(shipping_amount_ton, ',')) as shipping_amount_ton
        from renamed
    )

select *
from column_format
