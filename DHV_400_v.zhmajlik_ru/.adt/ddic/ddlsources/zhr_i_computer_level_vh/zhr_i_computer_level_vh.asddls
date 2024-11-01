@AbapCatalog.sqlViewName: 'ZHRICOMPTRLVLVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Computer Level Value Help'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST
define view ZHR_I_COMPUTER_LEVEL_VH
  as select from zhr_comp_lvl_vh
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Description']
  key id          as Id,
      @EndUserText.label: 'Уровень владения ПК'
      description as Description
} 
 