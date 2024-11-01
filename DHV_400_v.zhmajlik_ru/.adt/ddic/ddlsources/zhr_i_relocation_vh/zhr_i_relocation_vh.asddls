@AbapCatalog.sqlViewName: 'ZHRIRELOCATIONVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Готовность к переезду'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST
define view ZHR_I_RELOCATION_VH
  as select from zhr_reloc_vh
{
       @UI.hidden: true
       @ObjectModel.text.element: ['Name']
  key  id   as Id,
       @EndUserText.label: 'Переезд'
       name as Name
} 
 