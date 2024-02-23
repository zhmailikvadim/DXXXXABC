/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I_SupDmndAllDocSTOItm custom view'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
define view entity zsd_i_supdmndallstoitm_rj
  as select from    zsd_i_supdmndallstoitmbsc_rj as Item
    left outer join I_SupDmndAllDocSTODate       as Sched   on  Item.RequirementDocumentNumber = Sched.RequirementDocumentNumber
                                                            and Item.RequirementDocumentItem   = Sched.RequirementDocumentItem
                                                            and Item.RequestedDate             = Sched.RequestedDate
                                                            and Item.Material                  = Sched.Material
                                                            and Item.Plant                     = Sched.Plant
    left outer join P_SupDmndOvwSTODate          as Date    on  Item.RequirementDocumentNumber = Date.RequirementDocumentNumber
                                                            and Item.RequirementDocumentItem   = LPAD(
      Date.RequirementDocumentItem, 6, '0'
    )
                                                            and Item.Material                  = Date.Material
                                                            and Item.Plant                     = Date.Plant
    left outer join ZSD_I_SupDmndOvwSTODate      as DateCDD on  Item.RequirementDocumentNumber = DateCDD.RequirementDocumentNumber
                                                            and Item.RequirementDocumentItem   = LPAD(
      DateCDD.RequirementDocumentItem, 6, '0'
    )
    left outer join zpd_t_mvke_seas              as RID     on  Item.Material            = RID.matnr
                                                            and Item.SalesOrganization   = RID.vkorg
                                                            and Item.DistributionChannel = RID.vtweg
                                                            and Item.ProductSeason       = RID.fsh_season
                                                            and Item.ProductSeasonYear   = RID.fsh_season_year
{
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Sched.ProductAvailabilityDate            as RequestedDate,
  Item.ProductAvailabilityDate,
  Item.RequirementType,
  Date.EarliestRequestedDeliveryDate       as RequestedDeliveryDate,
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
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.OrderQuantity)                  as OrderQuantity,
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
  Item.SegmentationStrategyScope,
  Item.Vendor,
  Item.ProductCollection,
  Item.ConfirmedShelvedDate,
  Item.CreatedByUser,
  Item.CustomerGroup,
  Item.AdditionalCustomerGroup1,
  Item.AdditionalCustomerGroup5,
  Item.AdditionalCustomerGroup6,
  Item.DeliveryPriority,
  Item.DistribChainSpecifMatStat,
  Item.EAN,
  Item.ProductCharacteristic2,
  Item.SalesDocumentItemText,
  Item.SoldToPartyName,
  Item.NetAmount,
  Item.TransactionCurrency,
  Item.SDDocumentReason,
  Item.PlannedDeliveryTime,
  Item.PurchaseOrderType,
  Item.PurchaseOrderCategory,
  Item.OrderQuantityUnit,
  Item.RequestedShelfDate,
  max(Item.ScheduleLine)                   as ScheduleLine,
  Item.ProductSeason,
  Item.ProductSeasonYear,
  Item.ShippingInstruction,
  Item.ShipToParty,
  Item.ShipToPartyName,
  Item.CreationDate,
  Item.ProductTheme,
  Item.UPC,
  RID.zzhard_launch                        as HardLaunchDate,
  RID.zzpre_launch                         as EarlyAccessDate,
  DateCDD.ConfirmedDeliveryDate,
  RID.zzretailintro                        as RetailIntroDate,
  Item.ShippingPoint,
  Item.SalesDocumentRjcnReason,
  min(Item.SalesDocumentRjcnReasonName)    as SalesDocumentRjcnReasonName,
  max(Item.LastChangeDate)                 as LastChangeDate
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
  Item.SegmentationStrategyScope,
  Item.Vendor,
  Item.ProductCollection,
  Item.ConfirmedShelvedDate,
  Item.CreatedByUser,
  Item.CustomerGroup,
  Item.AdditionalCustomerGroup1,
  Item.AdditionalCustomerGroup5,
  Item.AdditionalCustomerGroup6,
  Item.DeliveryPriority,
  Item.DistribChainSpecifMatStat,
  Item.EAN,
  Item.ProductCharacteristic2,
  Item.SalesDocumentItemText,
  Item.SoldToPartyName,
  Item.NetAmount,
  Item.TransactionCurrency,
  Item.SDDocumentReason,
  Item.PlannedDeliveryTime,
  Item.PurchaseOrderType,
  Item.PurchaseOrderCategory,
  Item.OrderQuantity,
  Item.OrderQuantityUnit,
  Item.RequestedShelfDate,
  Item.ProductSeason,
  Item.ProductSeasonYear,
  Item.ShippingInstruction,
  Item.ShipToParty,
  Item.ShipToPartyName,
  Item.CreationDate,
  Item.ProductTheme,
  Item.UPC,
  RID.zzhard_launch,
  RID.zzpre_launch,
  DateCDD.ConfirmedDeliveryDate,
  RID.zzretailintro,
  Item.ShippingPoint,
  Item.SalesDocumentRjcnReason
