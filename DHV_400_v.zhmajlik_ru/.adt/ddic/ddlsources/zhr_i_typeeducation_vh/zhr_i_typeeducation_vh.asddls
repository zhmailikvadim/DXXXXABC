@AbapCatalog.sqlViewName: 'ZHRITYPEEDUCVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Вид Обучения'

//@OData.publish: true
@UI.textArrangement: #TEXT_FIRST

define view ZHR_I_TYPEEDUCATION_VH
  as select from zhr_degree_vh
{

  key name as name,
      id   as id
} 
 