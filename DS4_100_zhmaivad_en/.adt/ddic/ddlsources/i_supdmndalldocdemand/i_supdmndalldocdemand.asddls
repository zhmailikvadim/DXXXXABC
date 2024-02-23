@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #COMPOSITE
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADDMND',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Demand of All Documents'
define view I_SupDmndAllDocDemand
  as select from I_SupDmndAllDocSDItm as SD
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
  RequestedRqmtQtyInBaseUnit,
  ConfirmedRqmtQtyInBaseUnit,
  DeliveredQuantityInBaseUnit,
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
  NetPriceAmount,
  DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0
  
union all select from I_SupDmndAllDocPlndIndepRqmts as PIR
{
  //PIR - Without Assignments
  //PP - PIR
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
  OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  cast( '' as sup_object_name )                  as SupplyProtectionName,
  cast( '' as vkorg )                            as SalesOrganization,
  cast( '' as vtweg )                            as DistributionChannel,
  cast( '' as spart )                            as Division,
  cast( '' as bzirk )                            as SalesDistrict,
  cast( '' as kunnr )                            as Customer,
  cast( '' as bukrs )                            as CompanyCode,
  cast( '' as lgort_d )                          as StorageLocation,
  cast( 0  as netpr )                            as NetPriceAmount,
  cast( '' as waerk )                            as DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from I_SupDmndAllDocSTOItm as STO
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
  DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from I_SupDmndAllDocStkTransptReqn as STR
{
  //STR - Without Assignments
  //U2 - STR
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
  OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  cast( '' as sup_object_name )                  as SupplyProtectionName,
  cast( '' as vkorg )                            as SalesOrganization,
  cast( '' as vtweg )                            as DistributionChannel,
  cast( '' as spart )                            as Division,
  cast( '' as bzirk )                            as SalesDistrict,
  SoldToParty                                    as Customer,
  CompanyCode,
  StorageLocation,
  NetPriceAmount,
  DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from I_SupDmndAllDocPurOrdCompBsc as SubConPO
{
  //SubConPO - Without Assignments
  //BB - SubContrating Purchase Order Components
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
  (   SubConPO.OpenQuantity
    - coalesce( SubConPO.DeliveredQuantityInBaseUnit, 0 )
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
  cast( '' as vkorg )                            as SalesOrganization,
  cast( '' as vtweg )                            as DistributionChannel,
  cast( '' as spart )                            as Division,
  cast( '' as bzirk )                            as SalesDistrict,
  Customer,
  CompanyCode,
  StorageLocation,
  cast( 0  as netpr )                            as NetPriceAmount,
  cast( '' as waerk )                            as DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from I_SupDmndAllDocPurReqnComp as SubConPR
{
  //SubConPR - Without Assignments
  //RB - SubContrating Purchase Requisition Components
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
  OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  cast( '' as sup_object_name )                  as SupplyProtectionName,
  cast( '' as vkorg )                            as SalesOrganization,
  cast( '' as vtweg )                            as DistributionChannel,
  cast( '' as spart )                            as Division,
  cast( '' as bzirk )                            as SalesDistrict,
  Customer,
  CompanyCode,
  StorageLocation,
  cast( 0  as netpr )                            as NetPriceAmount,
  cast( '' as waerk )                            as DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from I_SupDmndAllDocProdnOrdCompBsc as ProdOrdComp
{
  //ProdOrdComp - Without Assignments
  //AR - Production Order Components
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
  (   ProdOrdComp.OpenQuantity
    - coalesce( ProdOrdComp.DeliveredQuantityInBaseUnit, 0 )
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
  cast( '' as vkorg )                            as SalesOrganization,
  cast( '' as vtweg )                            as DistributionChannel,
  cast( '' as spart )                            as Division,
  cast( '' as bzirk )                            as SalesDistrict,
  cast( '' as kunnr )                            as Customer,
  cast( '' as bukrs )                            as CompanyCode,
  StorageLocation,
  cast( 0  as netpr )                            as NetPriceAmount,
  cast( '' as waerk )                            as DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from I_SupDmndAllDocPlndOrdComp as PlndOrdComp
{
  //PlndOrdComp - Without Assignments
  //SB - Planned Order Components
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
  OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  cast( '' as sup_object_name )                  as SupplyProtectionName,
  cast( '' as vkorg )                            as SalesOrganization,
  cast( '' as vtweg )                            as DistributionChannel,
  cast( '' as spart )                            as Division,
  cast( '' as bzirk )                            as SalesDistrict,
  cast( '' as kunnr )                            as Customer,
  cast( '' as bukrs )                            as CompanyCode,
  StorageLocation,
  cast( 0  as netpr )                            as NetPriceAmount,
  cast( '' as waerk )                            as DocumentCurrency
}
where
  RequestedRqmtQtyInBaseUnit > 0

union all select from I_SupDmndAllDocRetsSup as RetsSup
{
  //Returns - Without Assignments
  //RP - Returns
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
  OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  cast( '' as sup_object_name )                  as SupplyProtectionName,
  cast( '' as vkorg )                            as SalesOrganization,
  cast( '' as vtweg )                            as DistributionChannel,
  cast( '' as spart )                            as Division,
  cast( '' as bzirk )                            as SalesDistrict,
  cast( '' as kunnr )                            as Customer,
  CompanyCode,
  StorageLocation,
  NetPriceAmount,
  DocumentCurrency
}

union all select from I_ARunSupplyProtection as SupProt
{
  //Supply Protection - Without Assignemnts
  //SUP - Supply Protection
  cast( '' as vbeln_va )      as RequirementDocumentNumber,
  cast( '000000' as posnr )   as RequirementDocumentItem,
  SupProtTimeBucketUUID,
  StartDate                   as RequestedDate,
  ProductAvailabilityDate,
  RequirementType,
  RequestedDeliveryDate,
  SupProtProtectedQuantity    as RequestedRqmtQtyInBaseUnit,
  SupProtProtectedQuantity    as ConfirmedRqmtQtyInBaseUnit,
  SupProtConsumedQuantity     as DeliveredQuantityInBaseUnit,
  ARunSupProtUnconsumedQty    as OpenDemandQuantity,
  BaseUnit,
  Material,
  MaterialGroup,
  Plant,
  cast( '' as auart )         as OrderType,
  CrossPlantConfigurableProduct,
  MaterialType,
  RequirementSegment,
  SupplyProtectionName,
  cast( '' as vkorg )         as SalesOrganization,
  cast( '' as vtweg )         as DistributionChannel,
  cast( '' as spart )         as Division,
  cast( '' as bzirk )         as SalesDistrict,
  cast( '' as kunnr )         as Customer,
  cast( '' as bukrs )         as CompanyCode,
  cast( '' as lgort_d )       as StorageLocation,
  cast( 0  as netpr )         as NetPriceAmount,
  cast( '' as waerk )         as DocumentCurrency
}
