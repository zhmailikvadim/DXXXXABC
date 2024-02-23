/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 04.04.2023 | 19667     : SD_Feature - [Defect]-Feature - SDO  Enhance *
*              |            | DS4K949084                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Demand of All Documents'
@Metadata.ignorePropagatedAnnotations: true
define view entity zsd_i_supdmndalldemand_rj
  as select from zsd_i_supdmndallsditm_rj as SD
{
  //SD - Without Assignments
  //VC - Sales Orders
  //VI - Free of Charge Order
  //VG - Fashion Sales Contracts
  //VS - Third Party Order
  //VE - Purchase To Order
  //VM - Make To Order
  RequirementDocumentNumber,
  RequirementDocumentItem,
  hextobin( '00000000000000000000000000000000' ) as SupProtTimeBucketUUID,
  RequestedDate,
  ProductAvailabilityDate,
  RequirementType,
  RequestedDeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  RequestedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  ConfirmedRqmtQtyInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  DeliveredQuantityInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  (   SD.RequestedRqmtQtyInBaseUnit
    - coalesce( SD.DeliveredQuantityInBaseUnit, 0 )
  )                                              as OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  cast( '' as sup_object_name )                  as SupplyProtectionName,
  SalesOrganization,
  DistributionChannel,
  Division,
  SalesDistrict,
  SoldToParty                                    as Customer,
  CompanyCode,
  StorageLocation,
  @Semantics.amount.currencyCode: 'DocumentCurrency'
  NetPriceAmount,
  DocumentCurrency,
  ProductCollection,
  CreatedByUser,
  SalesDocumentItemText,
  AdditionalMaterialGroup1,
  CustomerGroup,
  MaterialByCustomer,
  ean11,
  ProductCharacteristic2,
  FulfillmentDate,
  FulfillmentScenario,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  NetAmount,
  TransactionCurrency,
  FashionCancelDate,
  ShippingPoint,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  OrderQuantity,
  OrderQuantityUnit,
  SalesDocumentRjcnReason,
  LastChangeDate,
  SalesDocumentItemCategory,
  SalesOffice,
  ProductSeason,
  ProductSeasonYear,
  ShipToParty,
  CreationDate,
  SoldToParty,
  ProductTheme,
  Payer,
  PRE_RE_Indicator,
  RequestedShelfDate,
  PurchaseOrderByCustomer,
  OrderReason,
  SalesDocumentType,
  AgrmtValdtyEndDate,
  GoodsIssueDate,
  ScheduleLine,
  DeliveryDate,
  ConfirmedShelfDate,
  EAN,
  RetailIntroDate,
  EarlyAccessDate,
  HardLaunchDate,
  ShipToPartyName,
  SoldToPartyName,
  UnderlyingPurchaseOrderItem,
  SoldToPartyPoType
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from zsd_i_supdmndallstoitm_rj as STO
{
  //STO - Without Assignments
  //U1 - STO
  RequirementDocumentNumber,
  RequirementDocumentItem,
  hextobin( '00000000000000000000000000000000' ) as SupProtTimeBucketUUID,
  RequestedDate,
  ProductAvailabilityDate,
  RequirementType,
  RequestedDeliveryDate,
  RequestedRqmtQtyInBaseUnit,
  ConfirmedRqmtQtyInBaseUnit,
  DeliveredQuantityInBaseUnit,
  (   STO.RequestedRqmtQtyInBaseUnit
    - coalesce( STO.DeliveredQuantityInBaseUnit, 0 )
  )                                              as OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  cast( '' as sup_object_name )                  as SupplyProtectionName,
  SalesOrganization,
  DistributionChannel,
  Division,
  SalesDistrict,
  SoldToParty                                    as Customer,
  CompanyCode,
  StorageLocation,
  NetPriceAmount,
  DocumentCurrency,
  ProductCollection,
  CreatedByUser,
  SalesDocumentItemText,
  ''                                             as AdditionalMaterialGroup1,
  CustomerGroup,
  ''                                             as MaterialByCustomer,
  UPC                                            as ean11,
  ProductCharacteristic2,
  ''                                             as FulfillmentDate,
  ''                                             as FulfillmentScenario,
  NetAmount,
  TransactionCurrency,
  ''                                             as FashionCancelDate,
  ShippingPoint,
  OrderQuantity,
  BaseUnit                                       as OrderQuantityUnit,
  SalesDocumentRjcnReason,
  LastChangeDate,
  ''                                             as SalesDocumentItemCategory,
  ''                                             as SalesOffice,
  ProductSeason,
  ProductSeasonYear,
  ShipToParty,
  CreationDate,
  SoldToParty,
  ProductTheme,
  ''                                             as Payer,
  ''                                             as PRE_RE_Indicator,
  RequestedShelfDate,
  ''                                             as PurchaseOrderByCustomer,
  cast(SDDocumentReason as abap.char( 3 ))       as OrderReason,
  ''                                             as SalesDocumentType,
  ''                                             as AgrmtValdtyEndDate,
  ''                                             as GoodsIssueDate,
  ScheduleLine,
  ConfirmedDeliveryDate                          as DeliveryDate,
  ConfirmedShelvedDate                           as ConfirmedShelfDate,
  cast(EAN as abap.char( 13  ))                  as EAN,
  RetailIntroDate,
  EarlyAccessDate,
  HardLaunchDate,
  ''                                             as ShipToPartyName,
  ''                                             as SoldToPartyName,
  ''                                             as UnderlyingPurchaseOrderItem,
  ''                                             as SoldToPartyPoType
}
where
  RequestedRqmtQtyInBaseUnit > 0
