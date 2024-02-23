/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bw Snapshot'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_bw_mock_col_typ
  as select from zsd_i_sap_snapshot
{
  key     SapSnapshotDate                                                as WmsSnapshotDate,
  key     Plant,
  key     StorageLocation,
  key     Article,
  key     SalesOrderNumber,
  key     SalesOrderItem,
          SapTimestamp                                                   as WmsTimeStamp,
          SapTimestamp,
          ''                                                             as cold_store_flag,
          Meins,

          @Semantics.quantity.unitOfMeasure : 'Meins'
          UnrectrictedSapStockQuantity,
          @Semantics.quantity.unitOfMeasure : 'Meins'
          InQualityInspSapStockQuantity,
          @Semantics.quantity.unitOfMeasure : 'Meins'
          BlockedSapStockQuantity,
          @Semantics.quantity.unitOfMeasure : 'Meins'
          UnrectrictedSapStockQuantity + cast( 4 as abap.quan( 13, 3 ) ) as UnrectrictedWmsStockQuantity,
          @Semantics.quantity.unitOfMeasure : 'Meins'
          case when InQualityInspSapStockQuantity > cast( 2 as abap.quan( 13, 3 ) )
          then
          InQualityInspSapStockQuantity - cast( 2 as abap.quan( 13, 3 ) )
          else InQualityInspSapStockQuantity end                         as InQualityInspWmsStockQuantity,
          @Semantics.quantity.unitOfMeasure : 'Meins'
          case when BlockedSapStockQuantity >  cast( 3 as abap.quan( 13, 3 ) )
          then
          BlockedSapStockQuantity - cast(3  as abap.quan( 13, 3 ) )
          else BlockedSapStockQuantity end                               as BlockedWmsStockQuantity
}
