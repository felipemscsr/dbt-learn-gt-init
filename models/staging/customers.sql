with source as (

        select * from {{ source('jaffle', 'customers') }}

),

renamed as (

      select
          *
      from source
  )
  
  select * from renamed
    