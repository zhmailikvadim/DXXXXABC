@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #BASIC
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADSTODTE',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'Basic View for Stock Transport Order Date'
define view I_SupDmndAllDocSTODate
  as select from P_SupDmndAllDocSTODate
{
  RequirementDocumentNumber,
  RequirementDocumentItem,
  RequestedDate,
  ProductAvailabilityDate,
  Material,
  Plant,
  sum( ConfdOrderQtyByMatlAvailCheck ) as ConfdOrderQtyByMatlAvailCheck
}
group by
  RequirementDocumentNumber,
  RequirementDocumentItem,
  RequestedDate,
  ProductAvailabilityDate,
  Material,
  Plant
