@AbapCatalog.sqlViewName: 'ZHRIHRP5122'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HRP5122'
define view ZHR_I_HRP5122 as select from hrp5122
{
    key objid as objid,
        hot_job as hot_job,
        external_code as external_code,
        start_date as start_date,
        end_date as end_date,
        posting_channel as posting_channel,
        status as status
        
    
}
  where posting_channel = '0002'   and status = '1' 

  