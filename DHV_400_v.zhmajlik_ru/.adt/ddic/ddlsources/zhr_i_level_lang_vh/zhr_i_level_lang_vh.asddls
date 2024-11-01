@AbapCatalog.sqlViewName: 'ZHRILEVELLANGVH'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Уровень владения языком'
@ObjectModel.usageType.sizeCategory: #XXL
//@Search.searchable: true
@OData.publish: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZHR_I_LEVEL_LANG_VH
  as select from zhr_lang_lev_vh
{
       @EndUserText.label: 'Уровень'
       //@Search.defaultSearchElement: true
       //@Search.ranking: #HIGH
  key  description as Description,
       @UI.hidden: true
       id          as ID,
       @EndUserText.label: 'Описание уровня'
       description_long


} 
 