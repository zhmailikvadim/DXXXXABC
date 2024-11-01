@AbapCatalog.sqlViewName: 'ZHRIENTERPRIVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Предприятие'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST

define view ZHR_I_ENTERPRICE_VH
  as select from zhr_c_org_recr
{
       @EndUserText.label: 'Организация'
  key  orgname as orgname,
       orgid   as orgid,

       orgloc  as orgloc

} 
 