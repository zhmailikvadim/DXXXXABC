@AbapCatalog.sqlViewName: 'ZHRIREGIONVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Search.searchable: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Область'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZHR_I_REGION_VH
  as select from t005u
{

          @EndUserText.label: 'Область'
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          @Search.ranking: #HIGH
  key     bezei      as bezei,
          @UI.hidden: true
          max(bland) as bland,
          land1      as land1
}
where
  spras = $session.system_language
group by
  bezei,
  land1 
 