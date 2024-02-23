/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Sales Document Item'
define view entity zsd_i_supdmndallsditm_rj
  as select from    zsd_i_supdmndallsditmbsc_rj as Item
    left outer join I_SupDmndAllDocSDDate       as Sched                on  Item.RequirementDocumentNumber = Sched.RequirementDocumentNumber
                                                                        and Item.RequirementDocumentItem   = Sched.RequirementDocumentItem
                                                                        and Item.RequestedDate             = Sched.RequestedDate
                                                                        and Item.Material                  = Sched.Material
                                                                        and Item.Plant                     = Sched.Plant
    left outer join zsd_i_supdmndovwsddate_rj   as Date                 on  Item.RequirementDocumentNumber = Date.SalesDocument
                                                                        and Item.RequirementDocumentItem   = Date.SalesDocumentItem
                                                                        and Item.Material                  = Date.Material
                                                                        and Item.Plant                     = Date.Plant

    left outer join zpd_t_mvke_seas             as RID                  on  Item.Material            = RID.matnr
                                                                        and Item.SalesOrganization   = RID.vkorg
                                                                        and Item.DistributionChannel = RID.vtweg
                                                                        and Item.ProductSeason       = RID.fsh_season
                                                                        and Item.ProductSeasonYear   = RID.fsh_season_year
    left outer join I_ProductSalesDelivery      as ProductSalesDelivery on  Item.Material            = ProductSalesDelivery.Product
                                                                        and Item.SalesOrganization   = ProductSalesDelivery.ProductSalesOrg
                                                                        and Item.DistributionChannel = ProductSalesDelivery.ProductDistributionChnl
    left outer join zpd_t_mvke_seas             as ZArtclSeason         on  Item.Material            = ZArtclSeason.matnr
                                                                        and Item.SalesOrganization   = ZArtclSeason.vkorg
                                                                        and Item.DistributionChannel = ZArtclSeason.vtweg
                                                                        and Item.ProductSeason       = ZArtclSeason.fsh_season
                                                                        and Item.ProductSeasonYear   = ZArtclSeason.fsh_season_year
    left outer join ZSD_I_SupDmndOvwSDDate      as DateCDD              on  Item.RequirementDocumentNumber = DateCDD.SalesDocument
                                                                        and Item.RequirementDocumentItem   = DateCDD.SalesDocumentItem
{
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  max(Sched.ProductAvailabilityDate)      as RequestedDate,
  Item.MaterialByCustomer,
  max(Item.ProductAvailabilityDate)       as ProductAvailabilityDate,
  Item.RequirementType,
  max(Date.EarliestRequestedDeliveryDate) as RequestedDeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.ScheduleLineOrderQuantity)     as RequestedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.ConfdOrderQtyByMatlAvailCheck) as ConfirmedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.DeliveredQuantityInBaseUnit)   as DeliveredQuantityInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  sum(Item.SalesContractReleasedQuantity) as SalesContractReleasedQuantity,
  Item.BaseUnit,
  Item.Material,
  Item.MaterialGroup,
  Item._MatPlant.MaterialType,
  Item.Plant,
  Item.SDDocumentCategory,
  Item._MatPlant.CrossPlantConfigurableProduct,
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
  Item._MatPlant.SegmentationStrategy,
  Item._MatPlant.SegmentationStrategyScope,
  Item.ProductSeasonYear,
  Item.ProductSeason,
  Item.ProductCollection,
  max(Item.ConfirmedShelvedDate)          as ConfirmedShelvedDate,
  max(Item.CreatedByUser)                 as CreatedByUser,
  Item.CustomerGroup,
  Item.AdditionalCustomerGroup1,
  Item.AdditionalCustomerGroup5,
  Item.DeliveryPriority,
  max(Item.ScheduleLine)                  as ScheduleLine,
  max(Item.GoodsIssueDate)                as GoodsIssueDate,
  max(Item.DeliveryDate)                  as DeliveryDate,
  Item.EAN,
  max(Item.FulfillmentDate)               as FulfillmentDate,
  max(Item.FulfillmentScenario)           as FulfillmentScenario,
  Item.ProductCharacteristic2,
  Item.UnderlyingPurchaseOrderItem,
  max(Item.SalesDocumentItemText)         as SalesDocumentItemText,
  Item.AdditionalMaterialGroup1,
  Item.MaterialGroup1Text,
  Item.NetAmount,
  Item.TransactionCurrency,
  Item.SDDocumentReason,
  Item.PayerParty,
  Item.PREIndicator,
  Item.PrepackHoldIndicator,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  sum(Item.OrderQuantity)                 as OrderQuantity,
  Item.OrderQuantityUnit,
  max(Item.RequestedShelfDate)            as RequestedShelfDate,
  Item.SalesDocumentItemCategory,
  Item.SalesDocumentRjcnReason,
  Item.ShippingType,
  Item.ShippingPoint,
  Item.ShipToParty,
  Item.ShipToPartyName,
  Item.ProductTheme,
  Item.PurchaseOrderByCustomer,
  Item.CustomerPurchaseOrderType,
  Item._MatPlant[left outer].PlannedDeliveryTime,
  Item.DeliveryBlockReason,
  Item.SoldToParty,
  Item.SoldToPartyName,
  max(Item._MatPlant._EANs.ean11)         as ean11,
  max(Item.LastChangeDate)                as LastChangeDate,
  Item.SalesOffice,
  max(Item.CreationDate)                  as CreationDate,
  Item.Payer,
  max(Item.ConfirmedShelfDate)            as ConfirmedShelfDate,
  Item.PRE_RE_Indicator,
  max(Item.OrderReason)                   as OrderReason,
  Item.SalesDocumentType,
  RID.zzretailintro                       as RetailIntroDate,
  Item.AgrmtValdtyEndDate,
  ProductSalesDelivery.ProductSalesStatus as DistribChainSpecifMatStat,
  ZArtclSeason.zzhard_launch              as HardLaunchDate,
  ZArtclSeason.zzpre_launch               as EarlyAccessDate,
  Item.RecommendedRetailPrice,
  Item.ConditionQuantityUnitRRP           as ConditionQuantityUnitRRP,
  Item.WholesalePrice,
  Item.ConditionQuantityUnitWP            as ConditionQuantityUnitWP,
  max(DateCDD.ConfirmedDeliveryDate)      as ConfirmedDeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'CallOffQuantityUnit'
  sum(Item.CallOffQuantity)               as CallOffQuantity,
  Item.CallOffQuantityUnit,
  max( Item.SoldToPartyPoType )           as SoldToPartyPoType
}

group by
  Item.RequirementDocumentNumber,
  Item.RequirementDocumentItem,
  Item.RequirementType,
  Item.BaseUnit,
  Item.Material,
  Item.MaterialGroup,
  Item._MatPlant.MaterialType,
  Item.Plant,
  Item.MaterialByCustomer,
  Item.SDDocumentCategory,
  Item.SalesDocumentRjcnReason,
  Item._MatPlant.CrossPlantConfigurableProduct,
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
  Item._MatPlant.SegmentationStrategy,
  Item._MatPlant.SegmentationStrategyScope,
  Item.ProductSeasonYear,
  Item.ProductSeason,
  Item.ProductCollection,
  Item.CustomerGroup,
  Item.AdditionalCustomerGroup1,
  Item.AdditionalCustomerGroup5,
  Item.DeliveryPriority,
  Item.EAN,
  Item.ProductCharacteristic2,
  Item.UnderlyingPurchaseOrderItem,
  Item.AdditionalMaterialGroup1,
  Item.MaterialGroup1Text,
  Item.NetAmount,
  Item.TransactionCurrency,
  Item.SDDocumentReason,
  Item.PayerParty,
  Item.PREIndicator,
  Item.PrepackHoldIndicator,
  Item.OrderQuantityUnit,
  Item.SalesDocumentItemCategory,
  Item.ShippingType,
  Item.ShippingPoint,
  Item.ShipToParty,
  Item.ShipToPartyName,
  Item.ProductTheme,
  Item.PurchaseOrderByCustomer,
  Item.CustomerPurchaseOrderType,
  Item._MatPlant[left outer].PlannedDeliveryTime,
  Item.DeliveryBlockReason,
  Item.SoldToParty,
  Item.SoldToPartyName,
  Item._MatPlant._EANs.ean11,
  Item.SalesOffice,
  Item.Payer,
  Item.PRE_RE_Indicator,
  Item.SalesDocumentType,
  RID.zzretailintro,
  Item.AgrmtValdtyEndDate,
  ProductSalesDelivery.ProductSalesStatus,
  ZArtclSeason.zzhard_launch,
  ZArtclSeason.zzpre_launch,
  Item.RecommendedRetailPrice,
  Item.ConditionQuantityUnitRRP,
  Item.WholesalePrice,
  Item.ConditionQuantityUnitWP,
  DateCDD.ConfirmedDeliveryDate,
  Item.CallOffQuantityUnit
