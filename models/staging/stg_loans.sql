select
    trim(loan_id) as loan_id,
    trim(customer_id) as customer_id,
    upper(trim(portfolio)) as portfolio,

    try_to_date(
        reporting_date, 'YYYY-MM-DD'
    ) as reporting_date,

    upper(trim(currency)) as currency,

    try_to_decimal(exposure_amount, 18, 2) as exposure_amount,
    try_to_decimal(pd, 10, 6) as pd,
    try_to_decimal(lgd, 10, 6) as lgd,

    try_to_timestamp_ntz(updated_at) as updated_at,
    loaded_at

from {{ source('risk_raw', 'loans') }}