/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.11.2022 | 13444     : [Build] - Stock reconciliati *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.04.2023 | 19610     : FB_19610_SD_Feature - DEFECT - Stock Reconciliation *
*              |            | DS4K949060                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*
" ZHMAIVAD     | 21.07.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bw Snapshot'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_bw_snapshot
  as select from zsd_i_bw_or_sap_snapshot
  association [1..*] to zsd_i_mat_doc_timing_adj_sum as _TimingAdjustmentSum on  $projection.Plant            = _TimingAdjustmentSum.Plant
                                                                             and $projection.StorageLocation  = _TimingAdjustmentSum.StorageLocation
                                                                             and $projection.Article          = _TimingAdjustmentSum.Article
                                                                             and $projection.SalesOrderNumber = _TimingAdjustmentSum.SalesOrderNumber
                                                                             and $projection.SalesOrderItem   = _TimingAdjustmentSum.SalesOrderItem
                                                                             and $projection.WmsSnapshotDate  = _TimingAdjustmentSum.DocumentDate
{
  key            WmsSnapshotDate,
  key            Plant,
  key            StorageLocation,
  key            Article,
  key            SalesOrderNumber,
  key            SalesOrderItem,
                 WmsTimeStamp,
                 SapTimeStamp,
                 Meins,
                 UnrectrictedWmsStockQuantity,
                 @Semantics.quantity.unitOfMeasure : 'Meins'
                 InQualityInspWmsStockQuantity,
                 @Semantics.quantity.unitOfMeasure : 'Meins'
                 BlockedWmsStockQuantity,
                 UnrectrictedSapStockQuantity,
                 @Semantics.quantity.unitOfMeasure : 'Meins'
                 InQualityInspSapStockQuantity,
                 @Semantics.quantity.unitOfMeasure : 'Meins'
                 BlockedSapStockQuantity,
                 @Semantics.quantity.unitOfMeasure : 'Meins'
                 coalesce(_TimingAdjustmentSum[1:StockType = 'UU'].Quantity, cast( 0 as abap.quan( 13, 3 ))) as UnrectrictedTimingAdjustment,
                 @Semantics.quantity.unitOfMeasure : 'Meins'
                 coalesce(_TimingAdjustmentSum[1:StockType = 'QI'].Quantity, cast( 0 as abap.quan( 13, 3 ))) as InQualityInspTimingAdjustment,
                 @Semantics.quantity.unitOfMeasure : 'Meins'
                 coalesce(_TimingAdjustmentSum[1:StockType = 'BL'].Quantity, cast( 0 as abap.quan( 13, 3 ))) as BlockedTimingAdjustment

}
