@AbapCatalog.sqlViewName: 'ZHRITYPERELATVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник степень родства'

@OData.publish: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZHR_I_TYPE_RELAT_VH
  as select from zt591s
{
  key             stext as Description,
                  subty as id

}
where
      sprsl = 'R'
  and infty = '0021' 
 