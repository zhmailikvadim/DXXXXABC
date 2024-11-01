@AbapCatalog.sqlViewName: 'ZHRIPREFCMMWYVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Preferred Comunication Way VH'
@Metadata.ignorePropagatedAnnotations: true

@OData.publish: true
define view ZHR_I_PREF_COM_WAY_VH
  as select from zhr_comm_way_vh
{
      @UI.hidden: true
      @ObjectModel.text.element: ['Name']
  key id   as Id,
      name as Name
} 
 