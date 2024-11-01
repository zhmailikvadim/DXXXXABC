@AbapCatalog.sqlViewName: 'ZHRIHRP1001'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HRP1001'
define view ZHR_I_HRP1001 as select from hrp1001 as hrp1001
      inner join ZHR_I_HRP5122 as HRP5122 on hrp1001.sobid = HRP5122.objid
                                         
{
    key sobid,
        hrp1001.objid as objid,
        hrp1001.plvar as plvar,
        hrp1001.otype as otype,
        hot_job as hot_job,
        external_code as external_code,
        HRP5122.start_date as start_date,
        HRP5122.end_date as end_date
        
    
} where otype = 'NB'
    and sclas = 'NC'
    