@AbapCatalog.sqlViewName: 'ZHRIBUSINTRIPVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Готовность к командировке'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST
define view ZHR_I_BUSIN_TRIP_VH
  as select from zt77rcf_workti_t
{
       @UI.hidden: true
       @ObjectModel.text.element: ['Description']
  key  employment_fract as WorkContract,
       @EndUserText.label: 'Готовность к командировкам'
       description      as Description
}
where
  langu = $session.system_language 
 