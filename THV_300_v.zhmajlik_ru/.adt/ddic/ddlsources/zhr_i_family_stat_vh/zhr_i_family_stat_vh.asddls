@AbapCatalog.sqlViewName: 'ZHRIFAMSTATVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Семейное положение'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST

define view ZHR_I_FAMILY_STAT_VH
  as select from zhr_fam_stat_vh
{
      @ObjectModel.text.element: ['description']
      @UI.hidden: true
  key id as id,
      @EndUserText.label: 'Семейное положение'
      description
} 
 