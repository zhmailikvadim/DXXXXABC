@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #COMPOSITE
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADSDITM',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Sales Document Item'
define view I_SupDmndAllDocSDItm
  as select from I_SupDmndAllDocSDItmBsc as Item
    inner join   I_SupDmndAllDocSDDate   as Sched on  Item.RequirementDocumentNumber = Sched.RequirementDocumentNumber
                                                  and Item.RequirementDocumentItem   = Sched.RequirementDocumentItem
                                                  and Item.RequestedDate             = Sched.RequestedDate
                                                  and Item.Material                  = Sched.Material
                                                  and Item.Plant                     = Sched.Plant
    inner join   P_SupDmndOvwSDDate      as Date  on  Item.RequirementDocumentNumber = Date.SalesDocument
                                                  and Item.RequirementDocumentItem   = Date.SalesDocumentItem
                                                  and Item.Material                  = Date.Material
                                                  and Item.Plant                     = Date.Plant
{
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate           as RequestedDate,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  Date.EarliestRequestedDeliveryDate      as RequestedDeliveryDate,
  sum( case
         when Item.RequirementType = 'VS' and Item.ScheduleLineOrderQuantity < Item.ConfdOrderQtyByMatlAvailCheck
         then Item.ConfdOrderQtyByMatlAvailCheck
         when Item.ScheduleLineOrderQuantity > 0
         then Item.ScheduleLineOrderQuantity - Sched.ConfdOrderQtyByMatlAvailCheck + Item.ConfdOrderQtyByMatlAvailCheck
       else Item.ConfdOrderQtyByMatlAvailCheck
  end )                                   as RequestedRqmtQtyInBaseUnit,
  sum(Item.ConfdOrderQtyByMatlAvailCheck) as ConfirmedRqmtQtyInBaseUnit,
  sum(Item.DeliveredQuantityInBaseUnit)   as DeliveredQuantityInBaseUnit,
  sum(Item.SalesContractReleasedQuantity) as SalesContractReleasedQuantity,
  Item.BaseUnit,
  Item._MatPlant[inner].Material,
  Item.MaterialGroup,
  Item._MatPlant.MaterialType,
  Item._MatPlant[inner].Plant,
  Item.SDDocumentCategory,
  Item._MatPlant.CrossPlantConfigurableProduct,
  Item.OrderType,
  Item.RequirementSegment,
  Item.SalesOrganization,
  Item.DistributionChannel,
  Item.Division,
  Item.SalesDistrict,
  Item.SoldToParty,
  Item.CompanyCode,
  Item.StorageLocation,
  Item.FashionCancelDate,
  Item.DeliveryBlockStatus,
  Item.TotalBlockStatus,
  Item.NetPriceAmount,
  Item.DocumentCurrency,
  Item._MatPlant.SegmentationStrategy,
  Item._MatPlant.SegmentationStrategyScope
}
where
        Item.SDDocumentCategory               = 'C'
  or    Item.SDDocumentCategory               = 'I'
  or    Item.SDDocumentCategory               = 'S'
  or    Item.SDDocumentCategory               = 'E'
  or    Item.SDDocumentCategory               = 'W'
  or(
        Item.SDDocumentCategory               = 'G'
    and Item._SlsDocType.RFMIsFashionContract = 'X'
  )
group by
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  Date.EarliestRequestedDeliveryDate,
  Item.BaseUnit,
  Item._MatPlant[inner].Material,
  Item.MaterialGroup,
  Item._MatPlant.MaterialType,
  Item._MatPlant[inner].Plant,
  Item.SDDocumentCategory,
  Item._MatPlant.CrossPlantConfigurableProduct,
  Item.OrderType,
  Item.RequirementSegment,
  Item.SalesOrganization,
  Item.DistributionChannel,
  Item.Division,
  Item.SalesDistrict,
  Item.SoldToParty,
  Item.CompanyCode,
  Item.StorageLocation,
  Item.FashionCancelDate,
  Item.DeliveryBlockStatus,
  Item.TotalBlockStatus,
  Item.NetPriceAmount,
  Item.DocumentCurrency,
  Item._MatPlant.SegmentationStrategy,
  Item._MatPlant.SegmentationStrategyScope
