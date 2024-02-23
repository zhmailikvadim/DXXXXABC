@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #COMPOSITE
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADSTOITM',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Stock Transport Order Item'
define view I_SupDmndAllDocSTOItm
  as select from I_SupDmndAllDocSTOItmBsc as Item
    inner join   I_SupDmndAllDocSTODate   as Sched on  Item.RequirementDocumentNumber = Sched.RequirementDocumentNumber
                                                   and Item.RequirementDocumentItem   = Sched.RequirementDocumentItem
                                                   and Item.RequestedDate             = Sched.RequestedDate
                                                   and Item.Material                  = Sched.Material
                                                   and Item.Plant                     = Sched.Plant
    inner join   P_SupDmndOvwSTODate      as Date  on  Item.RequirementDocumentNumber = Date.RequirementDocumentNumber
                                                   and Item.RequirementDocumentItem   = LPAD(Date.RequirementDocumentItem,6,'0')
                                                   and Item.Material                  = Date.Material
                                                   and Item.Plant                     = Date.Plant

{
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate            as RequestedDate,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  Date.EarliestRequestedDeliveryDate       as RequestedDeliveryDate,
  sum( case
    when Item.ScheduleLineOrderQuantity > 0
    then Item.ScheduleLineOrderQuantity - Sched.ConfdOrderQtyByMatlAvailCheck + Item.ConfdOrderQtyByMatlAvailCheck
    else Item.ConfdOrderQtyByMatlAvailCheck
  end )                                    as RequestedRqmtQtyInBaseUnit,
  sum( Item.ConfdOrderQtyByMatlAvailCheck) as ConfirmedRqmtQtyInBaseUnit,
  sum ( case
    when Item.DeliveredQuantityInBaseUnit > Item.ConfdOrderQtyByMatlAvailCheck
    then Item.ConfdOrderQtyByMatlAvailCheck
    else Item.DeliveredQuantityInBaseUnit
  end )                                    as DeliveredQuantityInBaseUnit,
  BaseUnit,
  Item.Material,
  Item.MaterialGroup,
  Item.MaterialType,
  Item.RequirementSegment,
  Item.Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  Item.PurchasingOrganization,
  Item.PurchasingGroup,
  Item.SalesOrganization,
  Item.DistributionChannel,
  Item.Division,
  SalesDistrict,
  SoldToParty,
  CompanyCode,
  StorageLocation,
  PurgReleaseSequenceStatus,
  NetPriceAmount,
  DocumentCurrency,
  SegmentationStrategy,
  SegmentationStrategyScope
}
group by
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  Date.EarliestRequestedDeliveryDate,
  BaseUnit,
  Item.Material,
  Item.MaterialGroup,
  Item.MaterialType,
  Item.RequirementSegment,
  Item.Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  Item.PurchasingOrganization,
  Item.SalesOrganization,
  Item.PurchasingGroup,
  Item.DistributionChannel,
  Item.Division,
  SalesDistrict,
  SoldToParty,
  CompanyCode,
  StorageLocation,
  PurgReleaseSequenceStatus,
  NetPriceAmount,
  DocumentCurrency,
  SegmentationStrategy,
  SegmentationStrategyScope
