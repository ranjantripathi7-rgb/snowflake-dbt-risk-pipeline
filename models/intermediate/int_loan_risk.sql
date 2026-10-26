select
    loan_id,
    customer_id,
    portfolio,
    reporting_date,
    currency,
    exposure_amount,
    pd,
    lgd,

    exposure_amount * pd * lgd as expected_loss

from {{ ref('stg_loans') }}