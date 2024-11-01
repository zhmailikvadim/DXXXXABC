@AbapCatalog.sqlViewName: 'ZHRIDESPROFESVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XXL
@Search.searchable: true
@EndUserText.label: 'Справочник Профессия'


@OData.publish: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZHR_I_DESIRED_PROFES_VH
  as select from zhr_desirprof_vh
{            @Search.defaultSearchElement: true
             @Search.fuzzinessThreshold: 0.9
             @Search.ranking: #HIGH
             @EndUserText.label: 'Профессия'
  key        stext as stext,
             // @ObjectModel.text.element: ['stext']
             @UI.hidden: true
             id    as id










} 
 