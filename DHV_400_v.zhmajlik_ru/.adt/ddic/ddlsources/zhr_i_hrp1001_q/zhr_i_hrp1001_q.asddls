@AbapCatalog.sqlViewName: 'ZHRIHRP1001Q'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Соединение для выбора наименования языка'
define view ZHR_I_HRP1001_Q
  as select from zhrp1001
{
  sobid as sobid
}
where
      otype = 'QK'
  and sclas = 'Q' 
  and objid = '70000314'
 