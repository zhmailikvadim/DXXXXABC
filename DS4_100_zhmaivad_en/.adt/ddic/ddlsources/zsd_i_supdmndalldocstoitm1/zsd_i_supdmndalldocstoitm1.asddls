@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Stock Transport Order Item'
define view entity zsd_i_supdmndalldocstoitm1
  as select from    zsd_i_supdmndalldocstoitmbsc1 as Item
    left outer join I_SupDmndAllDocSTODate        as Sched on  Item.RequirementDocumentNumber = Sched.RequirementDocumentNumber
                                                           and Item.RequirementDocumentItem   = Sched.RequirementDocumentItem
                                                           and Item.RequestedDate             = Sched.RequestedDate
                                                           and Item.Material                  = Sched.Material
                                                           and Item.Plant                     = Sched.Plant
    left outer join P_SupDmndOvwSTODate           as Date  on  Item.RequirementDocumentNumber = Date.RequirementDocumentNumber
                                                           and Item.RequirementDocumentItem   = LPAD(
      Date.RequirementDocumentItem, 6, '0'
    )
                                                           and Item.Material                  = Date.Material
                                                           and Item.Plant                     = Date.Plant

{
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate            as RequestedDate,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  Date.EarliestRequestedDeliveryDate       as RequestedDeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.ScheduleLineOrderQuantity)      as ScheduleLineOrderQuantity,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum( case
    when Item.ScheduleLineOrderQuantity > 0
    then Item.ScheduleLineOrderQuantity - Sched.ConfdOrderQtyByMatlAvailCheck + Item.ConfdOrderQtyByMatlAvailCheck
    else Item.ConfdOrderQtyByMatlAvailCheck
  end )                                    as RequestedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum( Item.ConfdOrderQtyByMatlAvailCheck) as ConfirmedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum ( case
    when Item.DeliveredQuantityInBaseUnit > Item.ConfdOrderQtyByMatlAvailCheck
    then Item.ConfdOrderQtyByMatlAvailCheck
    else Item.DeliveredQuantityInBaseUnit
  end )                                    as DeliveredQuantityInBaseUnit,
  Item.BaseUnit,
  Item.Material,
  Item.MaterialGroup,
  Item.MaterialType,
  Item.RequirementSegment,
  Item.Plant,
  Item.OrderType,
  Item.CrossPlantConfigurableProduct,
  Item.PurchasingOrganization,
  Item.PurchasingGroup,
  Item.SalesOrganization,
  Item.DistributionChannel,
  Item.Division,
  Item.SalesDistrict,
  Item.SoldToParty,
  Item.CompanyCode,
  Item.StorageLocation,
  Item.PurgReleaseSequenceStatus,
  @Semantics.amount.currencyCode: 'DocumentCurrency'
  Item.NetPriceAmount,
  Item.DocumentCurrency,
  Item.SegmentationStrategy,
  Item.SegmentationStrategyScope
}
group by
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  Date.EarliestRequestedDeliveryDate,
  Item.BaseUnit,
  Item.Material,
  Item.MaterialGroup,
  Item.MaterialType,
  Item.RequirementSegment,
  Item.Plant,
  Item.OrderType,
  Item.CrossPlantConfigurableProduct,
  Item.PurchasingOrganization,
  Item.SalesOrganization,
  Item.PurchasingGroup,
  Item.DistributionChannel,
  Item.Division,
  Item.SalesDistrict,
  Item.SoldToParty,
  Item.CompanyCode,
  Item.StorageLocation,
  Item.PurgReleaseSequenceStatus,
  Item.NetPriceAmount,
  Item.DocumentCurrency,
  Item.SegmentationStrategy,
  Item.SegmentationStrategyScope
