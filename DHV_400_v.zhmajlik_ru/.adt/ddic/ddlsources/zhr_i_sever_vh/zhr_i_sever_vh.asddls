@AbapCatalog.sqlViewName: 'ZHRISEVERVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник к полю Работа на Севере'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST


define view ZHR_I_SEVER_VH
  as select from zhr_sever_vh
{
       @UI.hidden: true
       @ObjectModel.text.element: ['Name']
  key  id   as Id,
       @EndUserText.label: 'Готовность к раб. в р-не Крайнего Севера'
       name as Name
} 
 