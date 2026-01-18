with payments as (
select * from {{ ref("stg_stripe__payments") }} where status='success'
),
pivoted as (
  select
    order_id,
    {%- for payment in ["coupon", "credit_card", "bank_transfer", "gift_card"] %}
      sum(case when payment_method='{{payment}}' then amount else 0 end) as {{payment}}_amount{{ ',' if not loop.last }}
    {%- endfor %}
  from payments
  group by order_id
)
select * from pivoted
