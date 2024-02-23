@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #BASIC
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADSDDATE',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'Basic View for Sales Document Date'
define view I_SupDmndAllDocSDDate
  as select from P_SupDmndAllDocSDDate
{
  RequirementDocumentNumber,
  RequirementDocumentItem,
  RequestedDate,
  ProductAvailabilityDate,
  Material,
  Plant,
  sum( ConfdOrderQtyByMatlAvailCheck ) as  ConfdOrderQtyByMatlAvailCheck
}
group by
  RequirementDocumentNumber,
  RequirementDocumentItem,
  RequestedDate,
  ProductAvailabilityDate,
  Material,
  Plant
