@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BW or SAP Snapshot base'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_BW_OR_SAP_SNAPSHOT_MOCK
  as select distinct from zsd_i_sap_snapshot

{
  key          SapSnapshotDate as WmsSnapshotDate,
  key          Plant,
  key          StorageLocation,
  key          Article,
  key          SalesOrderNumber,
  key          SalesOrderItem,
               SapTimestamp    as WmsTimeStamp,
               SapTimestamp,
               ''              as cold_store_flag,
               UnitOfMeasure,
               @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
               UuQty           as UnrectrictedWmsStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
               QiQty           as InQualityInspWmsStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
               BlQty           as BlockedWmsStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
               QiQty           as UnrectrictedSapStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
               UuQty           as InQualityInspSapStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
               BlQty           as BlockedSapStockQuantity
}
