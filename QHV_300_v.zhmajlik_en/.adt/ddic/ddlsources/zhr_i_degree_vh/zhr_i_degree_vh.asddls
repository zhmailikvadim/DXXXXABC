@AbapCatalog.sqlViewName: 'ZHRIDEGREEVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Ученая степень'



@UI.textArrangement: #TEXT_FIRST
define view ZHR_I_DEGREE_VH
  as select from t535n
{
         @UI.hidden: true
         @ObjectModel.text.element: ['Name']
  key    titel  as Id,
         @EndUserText.label: 'Ученая степень'
         ttout                                                                         as Name
} 
 where art = 'T' 
 