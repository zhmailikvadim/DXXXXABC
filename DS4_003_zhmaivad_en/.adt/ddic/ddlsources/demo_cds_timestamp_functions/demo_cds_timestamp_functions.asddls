@AbapCatalog.sqlViewName: 'DEMO_CDS_TSFNC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_timestamp_functions
 with parameters
    p_seconds   :abap.int4
  as select from
    demo_expressions
    {
      id,
      utcl_current() as utcl_timestamp,
      utcl_add_seconds(utcl2,:p_seconds)  as add_seconds,
      utcl_seconds_between(utcl1,utcl2)
                                          as seconds_between, 
      timestamp1                          as timestamp1,
      tstmp_is_valid(timestamp1)          as valid1,
      tstmp_seconds_between(
        tstmp_current_utctimestamp(),
        tstmp_add_seconds(
          timestamp1,
          cast( num1 as abap.dec(15,0) ),
          'FAIL'),
       'FAIL')                            as difference      
    }
