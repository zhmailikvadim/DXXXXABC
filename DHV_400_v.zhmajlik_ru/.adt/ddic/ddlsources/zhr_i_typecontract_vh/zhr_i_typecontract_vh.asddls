@AbapCatalog.sqlViewName: 'ZHRITYPECONTVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Вид договора'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST

define view ZHR_I_TYPECONTRACT_VH
  as select from zt77rcf_contty_t
{

      @UI.hidden: true
      @ObjectModel.text.element: ['description']
  key work_contract as work_contract,
      @EndUserText.label: 'Вид'
      description   as description
}
where
  langu = $session.system_language 
 