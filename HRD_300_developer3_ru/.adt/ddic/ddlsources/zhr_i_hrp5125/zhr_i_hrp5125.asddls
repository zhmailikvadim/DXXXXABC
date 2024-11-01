@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'ZHRIHRP5125'

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'HRP5125'

define view ZHR_I_HRP5125
  as select from hrp5125

    inner join   ZHR_I_HRP1001  as hrp1001 on hrp1001.objid = hrp5125.objid
    inner join   hrp5126        as HRP5126 on HRP5126.objid = hrp1001.objid and hrp5125.otype = 'NB'
    inner join   zhr_c_org_recr as org     on org.orgid = HRP5126.orgid

{
  key hrp5125.objid as objid,
      hrp1001.plvar as plvar,
      hrp1001.otype as otype,
      start_date    as start_date,
      end_date      as end_date,
      external_code as external_code,
      header        as name_vacanc,
      city          as city,
      org.orgname   as orgname,
      hot_job       as hot_job,
      HRP5126.orgid as orgid
}

where hrp5125.otype = 'NB' 