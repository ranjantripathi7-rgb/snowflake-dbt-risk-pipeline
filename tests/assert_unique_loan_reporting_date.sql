select
    loan_id,
    reporting_date,
    count(*) as record_count

from {{ ref('stg_loans') }}

group by
    loan_id,
    reporting_date

having count(*) > 1