@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #COMPOSITE
}
@VDM.private: true
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'PARUNASSGMTDMND',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XXL
   }
}
//@EndUserText.label: 'View for Supply Assignment Results from Demand Perspective'
define view P_ARunAssgmtDmnd
  as select from I_ARunAllDmndAssgmt as Assgmt
{
  Assgmt.RequirementDocumentNumber,
  Assgmt.RequirementDocumentItem,
  Assgmt.SupProtTimeBucketUUID,
  Assgmt.RequestedDate,
  Assgmt.ProductAvailabilityDate,
  Assgmt.RequirementType,
  Assgmt.Material,
  Assgmt.Plant,
  sum(Assgmt.AssignedQuantityInBaseUnit)     as AssignedQuantityInBaseUnit,
  sum(Assgmt.NormalAssignedQuantityInBsUnt)  as NormalAssignedQuantityInBsUnt,
  sum(Assgmt.PreviewAssignedQuantityInBsUnt) as PreviewAssignedQuantityInBsUnt,
  sum(Assgmt.ARunTmpAssignedQuantityInBsUnt) as ARunTmpAssignedQuantityInBsUnt,
  sum(FixedQuantityInBaseUnit)               as FixedQuantityInBaseUnit,
  sum(SupAssgmtReservedQtyInBaseUnit)        as SupAssgmtReservedQtyInBaseUnit,
  sum(ReadyForReleaseQtyInBaseUnit)          as ReadyForReleaseQtyInBaseUnit,
  sum(InboundAssignedQuantityInBsUnt)        as InboundAssignedQuantityInBsUnt,
  sum(ARunPhysSupAssgdQtyInBsUnt)            as ARunPhysSupAssgdQtyInBsUnt,
  Assgmt.BaseUnit
}
group by
  Assgmt.RequirementDocumentNumber,
  Assgmt.RequirementDocumentItem,
  Assgmt.SupProtTimeBucketUUID,
  Assgmt.RequestedDate,
  Assgmt.ProductAvailabilityDate,
  Assgmt.RequirementType,
  Assgmt.Material,
  Assgmt.Plant,
  Assgmt.BaseUnit
