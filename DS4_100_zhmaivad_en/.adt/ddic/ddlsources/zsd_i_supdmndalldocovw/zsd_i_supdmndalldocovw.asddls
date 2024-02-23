/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SHNIPALI     | 26.01.2023 | FB_16911_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K940435                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'P_SupDmndAllDocOvw - Custom View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #D,
     sizeCategory:   #XXL
   }
}
define view entity ZSD_I_SupDmndAllDocOvw
  as select from I_SupDmndAllDocTotDmnd //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ERROR Vadzim Zhmailik
{
  RequirementDocumentNumber,
  RequirementDocumentItem,
  SupProtTimeBucketUUID,
  ProductAvailabilityDate,
  RequestedDeliveryDate,
  RequirementType,
  cast('' as abap.char( 12 ))      as SupplyNumber,
  cast('00000' as abap.char(5))    as SupplyItem,
  cast('0000' as abap.char(4))     as SupplyScheduleLine,
  cast('' as abap.char(1))         as AssignedSupplyType,
  cast('' as abap.char(1))         as SupAssgmtSource,
  Material,
  Plant,
  cast('' as charg_d )             as Batch,
  StorageLocation,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  RequestedRqmtQtyInBaseUnit,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  ConfirmedRqmtQtyInBaseUnit,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  DeliveredQuantityInBaseUnit,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  OpenDemandQuantity,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  AssignedQuantityInBaseUnit,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  NormalAssignedQuantityInBsUnt,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  PreviewAssignedQuantityInBsUnt,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  ARunTmpAssignedQuantityInBsUnt,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  cast ( 0 as abap.quan( 25, 3 ) ) as OpenSupplyQuantity,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  cast ( 0 as abap.quan( 25, 3 ) ) as AssignedSupplyQtyInBaseUnit,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  cast ( 0 as abap.quan( 25, 3 ) ) as NormalSupplyQtyInBaseUnit,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  cast ( 0 as abap.quan( 25, 3 ) ) as PreviewSupplyQtyInBaseUnit,
  @DefaultAggregation: #SUM
  @Semantics.quantity.unitOfMeasure: 'AssgmtAggrgQtyUnit'
  cast ( 0 as abap.quan( 25, 3 ) ) as ARunTmpAssgdSupQtyInBaseUnit,
  BaseUnit,
  CalendarYear,
  CalendarMonth,
  CalendarMonthName,
  CalendarWeek,
  CalendarDay,
  MaterialGroup,
  MaterialType,
  RequirementSegment,
  cast( '' as sgt_scat )           as StockSegment,
  CrossPlantConfigurableProduct,
  SalesOrganization,
  DistributionChannel,
  Division,
  SalesDistrict,
  Customer,
  CompanyCode,
  @Semantics.amount.currencyCode: 'DocumentCurrency'
  NetPriceAmount,
  DocumentCurrency,
  cast('' as meins)                as AssgmtAggrgQtyUnit,
  '' as  RequestedShelfDate, //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ERROR Vadzim Zhmailik
  '' as  ConfirmedShelfDate  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ERROR Vadzim Zhmailik
}
union all select from ZSD_I_SupDmndAllDocTotSup as Supply
{
  cast( '' as abap.char(10) )                    as RequirementDocumentNumber,
  cast( '000000' as posnr )                      as RequirementDocumentItem,
  hextobin( '00000000000000000000000000000000' ) as SupProtTimeBucketUUID,
  ProductAvailabilityDate,
  RequestedDeliveryDate,
  cast( '' as abap.char(2) )                     as RequirementType,
  SupplyNumber,
  SupplyItem,
  SupplyScheduleLine,
  AssignedSupplyType,
  SupAssgmtSource,
  Material,
  Plant,
  Batch,
  StorageLocation,
  0                                              as RequestedRqmtQtyInBaseUnit,
  0                                              as ConfirmedRqmtQtyInBaseUnit,
  0                                              as DeliveredQuantityInBaseUnit,
  0                                              as OpenDemandQuantity,
  0                                              as AssignedQuantityInBaseUnit,
  0                                              as NormalAssignedQuantityInBsUnt,
  0                                              as PreviewAssignedQuantityInBsUnt,
  0                                              as ARunTmpAssignedQuantityInBsUnt,
  OpenSupplyQuantity,
  AssignedQuantityInBaseUnit                     as AssignedSupplyQtyInBaseUnit,
  NormalAssignedQuantityInBsUnt                  as NormalSupplyQtyInBaseUnit,
  PreviewAssignedQuantityInBsUnt                 as PreviewSupplyQtyInBaseUnit,
  ARunTmpAssignedQuantityInBsUnt                 as ARunTmpAssgdSupQtyInBaseUnit,
  BaseUnit,
  CalendarYear,
  CalendarMonth,
  CalendarMonthName,
  CalendarWeek,
  CalendarDay,
  MaterialGroup,
  MaterialType,
  cast( '' as sgt_rcat )                         as RequirementSegment,
  StockSegment,
  CrossPlantConfigurableProduct,
  SalesOrganization,
  DistributionChannel,
  Division,
  SalesDistrict,
  Customer,
  CompanyCode,
  NetPriceAmount,
  DocumentCurrency,
  cast('' as meins)                              as AssgmtAggrgQtyUnit,
  '' as RequestedShelfDate, //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ERROR Vadzim Zhmailik
  '' as ConfirmedShelfDate //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ERROR Vadzim Zhmailik
}
