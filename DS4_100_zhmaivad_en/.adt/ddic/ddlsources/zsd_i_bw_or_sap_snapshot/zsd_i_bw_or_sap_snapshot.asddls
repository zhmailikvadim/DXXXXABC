/*-----------------------------------------------------------------------
"  R E V I S I O N   H I S T O R Y                                     -
" -----------------------------------------------------------------------
" AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              -
"              |            | TRANSPORT REQUESTS                       -
" -----------------------------------------------------------------------
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
" ----------------------------------------------------------------------*
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'BW or SAP Snapshot base'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_bw_or_sap_snapshot
  as select distinct from zsd_i_bw_stock_difference_base
  association to zsd_i_sap_snapshot as _SapSnapshot on  $projection.WmsSnapshotDate  = _SapSnapshot.SapSnapshotDate
                                                    and $projection.Plant            = _SapSnapshot.Plant
                                                    and $projection.StorageLocation  = _SapSnapshot.StorageLocation
                                                    and $projection.Article          = _SapSnapshot.Article
                                                    and $projection.SalesOrderNumber = _SapSnapshot.SalesOrderNumber
                                                    and $projection.SalesOrderItem   = _SapSnapshot.SalesOrderItem
{
              // non't forget change it back before release
              //
  key         WmsSnapshotDate,
  key         Plant,
  key         StorageLocation,
  key         Article,
  key         SalesOrderNumber,
  key         SalesOrderItem,
              SapTimeStamp                                                    as WmsTimeStamp,
              case when SapTimeStamp > 0 then
              SapTimeStamp
              else _SapSnapshot.SapTimestamp end                              as SapTimeStamp,
              Meins,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              UnrectrictedSapStockQuantity - cast( 20 as abap.quan( 13, 3 ) ) as UnrectrictedWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              InQualityInspSapStockQuantity + cast( 8 as abap.quan( 13, 3 ) ) as InQualityInspWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              BlockedSapStockQuantity + cast( 12 as abap.quan( 13, 3 ) )      as BlockedWmsStockQuantity,
              //non't forget change it back before release
              //
              //
              //

              @Semantics.quantity.unitOfMeasure : 'Meins'
              case when SapTimeStamp > 0 then
              UnrectrictedSapStockQuantity
              else  _SapSnapshot.UuQty end                                    as UnrectrictedSapStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              case when SapTimeStamp > 0 then
              InQualityInspSapStockQuantity
              else  _SapSnapshot.QiQty end                                    as InQualityInspSapStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              case when SapTimeStamp > 0 then
              BlockedSapStockQuantity
              else _SapSnapshot.BlQty end                                     as BlockedSapStockQuantity
}
