select
    reporting_date,
    portfolio,
    currency,

    count(*) as loan_count,
    sum(exposure_amount) as total_exposure,
    round(sum(expected_loss), 2) as total_expected_loss

from {{ ref('int_loan_risk') }}

group by
    reporting_date,
    portfolio,
    currency