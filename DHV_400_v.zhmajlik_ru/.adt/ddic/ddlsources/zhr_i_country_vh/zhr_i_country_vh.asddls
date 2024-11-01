@AbapCatalog.sqlViewName: 'ZHRICOUNTRYVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Search.searchable: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Страна'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZHR_I_COUNTRY_VH
  as select from t005t
{
          @EndUserText.label: 'Страна'
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          @Search.ranking: #HIGH
  key     landx50 as Landx50,

          @UI.hidden: true
          land1   as land1

}
where
  spras = 'R'
 