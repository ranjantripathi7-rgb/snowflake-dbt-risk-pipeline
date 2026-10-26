select *

from {{ ref('stg_loans') }}

where exposure_amount < 0
   or pd < 0
   or pd > 1
   or lgd < 0
   or lgd > 1