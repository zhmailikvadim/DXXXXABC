/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.11.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST, #GROUP_BY]
@AccessControl: {
  authorizationCheck: #CHECK
}
@EndUserText.label: 'I_SupDmndAllDocSDItm Custom View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}

@Metadata.allowExtensions: true
define view entity ZSD_I_SupDmndAllDocSDItm
  as select from ZSD_I_SupDmndAllDocSDItmBsc as Item
    inner join   I_SupDmndAllDocSDDate       as Sched on  Item.RequirementDocumentNumber = Sched.RequirementDocumentNumber
                                                      and Item.RequirementDocumentItem   = Sched.RequirementDocumentItem
                                                      and Item.RequestedDate             = Sched.RequestedDate
                                                      and Item.Material                  = Sched.Material
                                                      and Item.Plant                     = Sched.Plant
    inner join   P_SupDmndOvwSDDate          as Date  on  Item.RequirementDocumentNumber = Date.SalesDocument
                                                      and Item.RequirementDocumentItem   = Date.SalesDocumentItem
                                                      and Item.Material                  = Date.Material
                                                      and Item.Plant                     = Date.Plant

  association [0..1] to zpd_t_mvke_seas        as RID                  on  Item.Material            = RID.matnr
                                                                       and Item.SalesOrganization   = RID.vkorg
                                                                       and Item.DistributionChannel = RID.vtweg
                                                                       and Item.ProductSeason       = RID.fsh_season
                                                                       and Item.ProductSeasonYear   = RID.fsh_season_year
  association [0..1] to I_ProductSalesDelivery as ProductSalesDelivery on  Item.Material            = ProductSalesDelivery.Product
                                                                       and Item.SalesOrganization   = ProductSalesDelivery.ProductSalesOrg
                                                                       and Item.DistributionChannel = ProductSalesDelivery.ProductDistributionChnl
  association [0..1] to ZSD_I_SupDmndOvwSDDate as DateCDD              on  Item.RequirementDocumentNumber = DateCDD.SalesDocument
                                                                       and Item.RequirementDocumentItem   = DateCDD.SalesDocumentItem
                                                                       and Item.Material                  = DateCDD.Material
                                                                       and Item.Plant                     = DateCDD.Plant
{
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate           as RequestedDate,
  Item.MaterialByCustomer,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.CumulativeConfirmedQuantity) as CumulativeConfirmedQuantity,
  Date.EarliestRequestedDeliveryDate      as RequestedDeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  Item.OrderQuantity                      as RequestedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.ConfdOrderQtyByMatlAvailCheck) as ConfirmedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.DeliveredQuantityInBaseUnit)   as DeliveredQuantityInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.SalesContractReleasedQuantity) as SalesContractReleasedQuantity,
  Item.BaseUnit,
  Item._MatPlant[inner].Material,
  Item.MaterialGroup,
  Item._MatPlant.MaterialType,
  Item._MatPlant[inner].Plant,
  Item.SDDocumentCategory,
  Item._MatPlant[inner].CrossPlantConfigurableProduct,
  Item.OrderType,
  Item.RequirementSegment,
  Item.SalesOrganization,
  Item.DistributionChannel,
  Item.Division,
  Item.SalesDistrict,
  Item.CompanyCode,
  Item.StorageLocation,
  Item.FashionCancelDate,
  Item.DeliveryBlockStatus,
  Item.TotalBlockStatus,
  Item.NetPriceAmount,
  Item.DocumentCurrency,
  Item._MatPlant[inner].SegmentationStrategy,
  Item._MatPlant[inner].SegmentationStrategyScope,
  Item.ProductSeasonYear,
  Item.ProductSeason,
  Item.ProductCollection,
  Item.ConfirmedShelvedDate,
  Item.CreatedByUser,
  Item.CreationDate,
  Item.CustomerGroup,
  Item.AdditionalCustomerGroup1,
  Item.AdditionalCustomerGroup5,
  Item.AdditionalCustomerGroup6,
  Item.DeliveryPriority,
  Item.ScheduleLine,
  Item.GoodsIssueDate,
  Item.DeliveryDate,
  Item.EAN,
  Item.FulfillmentDate,
  Item.FulfillmentScenario,
  Item.ProductCharacteristic2,
  Item.UnderlyingPurchaseOrderItem,
  Item.SalesDocumentItemText,
  Item.AdditionalMaterialGroup1,
  Item.MaterialGroup1Text,
  Item.NetAmount,
  Item.TransactionCurrency,
  Item.SDDocumentReason,
  Item.PayerParty,
  Item.PREIndicator,
  Item.PrepackHoldIndicator,
  Item.OrderQuantity,
  Item.OrderQuantityUnit,
  Item.RequestedShelfDate,
  Item.SalesDocumentItemCategory,
  Item.ShippingType,
  Item.ShipToParty,
  Item.ShipToPartyName,
  Item.ProductTheme,
  Item.PurchaseOrderByCustomer,
  Item.CustomerPurchaseOrderType,
  Item._MatPlant[inner].PlannedDeliveryTime,
  Item.DeliveryBlockReason,
  Item.SoldToParty,
  Item.SoldToPartyName,
  Item._MatPlant[inner]._EANs.ean11,
  Item.AgrmtValdtyEndDate,
  Item.RecommendedRetailPrice,
  Item.ConditionQuantityUnitRRP,
  Item.WholesalePrice,
  Item.ConditionQuantityUnitWP,
  @Semantics.quantity.unitOfMeasure: 'CallOffQuantityUnit'
  Item.CallOffQuantity,
  Item.CallOffQuantityUnit,
  RID.zzretailintro                       as RetailIntroDate,
  RID.zzhard_launch                       as HardLaunchDate,
  RID.zzpre_launch                        as EarlyAccessDate,
  DateCDD.ConfirmedDeliveryDate,
  ProductSalesDelivery.ProductSalesStatus as DistribChainSpecifMatStat

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
  Item.CumulativeConfirmedQuantity,
  Date.EarliestRequestedDeliveryDate,
  Item.BaseUnit,
  Item._MatPlant[inner].Material,
  Item.MaterialGroup,
  Item._MatPlant.MaterialType,
  Item._MatPlant[inner].Plant,
  Item.MaterialByCustomer,
  Item.SDDocumentCategory,
  Item._MatPlant[inner].CrossPlantConfigurableProduct,
  Item.OrderType,
  Item.RequirementSegment,
  Item.SalesOrganization,
  Item.DistributionChannel,
  Item.Division,
  Item.SalesDistrict,
  Item.CompanyCode,
  Item.StorageLocation,
  Item.FashionCancelDate,
  Item.DeliveryBlockStatus,
  Item.TotalBlockStatus,
  Item.NetPriceAmount,
  Item.DocumentCurrency,
  Item._MatPlant[inner].SegmentationStrategy,
  Item._MatPlant[inner].SegmentationStrategyScope,
  Item.ProductSeasonYear,
  Item.ProductSeason,
  Item.ProductCollection,
  Item.ConfirmedShelvedDate,
  Item.CreatedByUser,
  Item.CreationDate,
  Item.CustomerGroup,
  Item.AdditionalCustomerGroup1,
  Item.AdditionalCustomerGroup5,
  Item.AdditionalCustomerGroup6,
  Item.DeliveryPriority,
  Item.ScheduleLine,
  Item.GoodsIssueDate,
  Item.DeliveryDate,
  Item.EAN,
  Item.FulfillmentDate,
  Item.FulfillmentScenario,
  Item.ProductCharacteristic2,
  Item.UnderlyingPurchaseOrderItem,
  Item.SalesDocumentItemText,
  Item.AdditionalMaterialGroup1,
  Item.MaterialGroup1Text,
  Item.NetAmount,
  Item.TransactionCurrency,
  Item.SDDocumentReason,
  Item.PayerParty,
  Item.PREIndicator,
  Item.PrepackHoldIndicator,
  Item.OrderQuantity,
  Item.OrderQuantityUnit,
  Item.RequestedShelfDate,
  Item.SalesDocumentItemCategory,
  Item.ShippingType,
  Item.ShipToParty,
  Item.ShipToPartyName,
  Item.ProductTheme,
  Item.PurchaseOrderByCustomer,
  Item.CustomerPurchaseOrderType,
  Item._MatPlant[inner].PlannedDeliveryTime,
  Item.DeliveryBlockReason,
  Item.SoldToParty,
  Item.SoldToPartyName,
  Item._MatPlant[inner]._EANs.ean11,
  Item.AgrmtValdtyEndDate,
  Item.RecommendedRetailPrice,
  Item.ConditionQuantityUnitRRP,
  Item.WholesalePrice,
  Item.ConditionQuantityUnitWP,
  Item.CallOffQuantity,
  Item.CallOffQuantityUnit,
  ProductSalesDelivery.ProductSalesStatus,
  DateCDD.ConfirmedDeliveryDate,
  RID.zzretailintro,
  RID.zzhard_launch,
  RID.zzpre_launch
