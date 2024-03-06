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
*----------------------------------------------------------------------*
* ZHMAIVAD     | 27.02.2024 | 29294     : [Feature] [Build] - Stock re *
*              |            | DS4K980553                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.03.2024 | 29314     : [Feature] [Build] - Stock re *
*              |            | DS4K982092                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
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

  key         WmsSnapshotDate,
  key         Plant,
  key         StorageLocation,
  key         Article,
  key         SalesOrderNumber,
  key         SalesOrderItem,
              WmsTimeStamp,
              case when SapTimeStamp > 0 then
              SapTimeStamp
              else _SapSnapshot.SapTimestamp end as SapTimeStamp,
              Meins,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              UnrectrictedWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              InQualityInspWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              BlockedWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              case when SapTimeStamp > 0 then
              UnrectrictedSapStockQuantity
              else  _SapSnapshot.UuQty end       as UnrectrictedSapStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              case when SapTimeStamp > 0 then
              InQualityInspSapStockQuantity
              else  _SapSnapshot.QiQty end       as InQualityInspSapStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              case when SapTimeStamp > 0 then
              BlockedSapStockQuantity
              else _SapSnapshot.BlQty end        as BlockedSapStockQuantity
}
where
  WmsSnapshotDate = $session.system_date
