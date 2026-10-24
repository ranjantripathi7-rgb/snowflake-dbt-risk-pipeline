use role SYSADMIN;
use warehouse TRAINING_WH;

-- Check which files are available.
list @RISK_DEMO.RAW.LOAN_STAGE;

-- Load the selected CSV into the raw table.
copy into RISK_DEMO.RAW.LOANS (
    loan_id,
    customer_id,
    portfolio,
    reporting_date,
    currency,
    exposure_amount,
    pd,
    lgd,
    updated_at
)
from @RISK_DEMO.RAW.LOAN_STAGE
files = ('loans_20261023.csv')
file_format = (
    format_name = 'RISK_DEMO.RAW.LOAN_CSV_FORMAT'
)
on_error = 'ABORT_STATEMENT';

-- Inspect the loaded records.
select *
from RISK_DEMO.RAW.LOANS
order by loan_id;

-- Check the number of records.
select count(*) as row_count
from RISK_DEMO.RAW.LOANS;
