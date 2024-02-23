@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Demand of All Documents'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSD_I_SupDmndAllDocDemand1
  as select from zsd_i_supdmndalldocsditm1 as SD
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
  UnderlyingPurchaseOrderItem,
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
  SalesDocumentRjcnReasonName,
  LastChangeDate,
  SalesDocumentItemCategory,
  SalesOffice
}

union all select from zsd_i_supdmndalldocstoitm1 as STO
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
  ''                                             as ProductCollection,
  ''                                             as CreatedByUser,
  ''                                             as UnderlyingPurchaseOrderItem,
  ''                                             as SalesDocumentItemText,
  ''                                             as AdditionalMaterialGroup1,
  ''                                             as CustomerGroup,
  ''                                             as MaterialByCustomer,
  ''                                             as ean11,
  ''                                             as ProductCharacteristic2,
  ''                                             as FulfillmentDate,
  ''                                             as FulfillmentScenario,
  cast(0 as netwr )                              as NetAmount,
  cast('' as waerk )                             as TransactionCurrency,
  ''                                             as FashionCancelDate,
  ''                                             as ShippingPoint,
  0                                              as OrderQuantity,
  cast('' as abap.unit( 3 ) )                    as OrderQuantityUnit,
  ''                                             as SalesDocumentRjcnReason,
  ''                                             as SalesDocumentRjcnReasonName,
  ''                                             as LastChangeDate,
  ''                                             as SalesDocumentItemCategory,
  ''                                             as SalesOffice
}
