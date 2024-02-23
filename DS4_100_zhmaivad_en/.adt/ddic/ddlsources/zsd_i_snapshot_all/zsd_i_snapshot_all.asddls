/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 19.12.2022 | FB_16311_SD_[Feature] [Build] - Stock reconciliation *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 19611     : [Feature] [Build] - Stock re *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sap Snapshot and Timing Adjustment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zsd_i_snapshot_all
  as select from zsd_i_actual_sap_stock_col_typ
  association [1..*] to zsd_i_mat_doc_timing_adj_sum  as _TimingAdjustmentSum on  $projection.Plant            = _TimingAdjustmentSum.Plant
                                                                              and $projection.StorageLocation  = _TimingAdjustmentSum.StorageLocation
                                                                              and $projection.Article          = _TimingAdjustmentSum.Article
                                                                              and $projection.SalesOrderNumber = _TimingAdjustmentSum.SalesOrderNumber
                                                                              and $projection.SalesOrderItem   = _TimingAdjustmentSum.SalesOrderItem
                                                                              and $projection.SapSnapshotDate  = _TimingAdjustmentSum.DocumentDate
  association        to zsd_i_bw_snapshot_calc_differ as _Difference          on  $projection.Plant            = _Difference.Plant
                                                                              and $projection.StorageLocation  = _Difference.StorageLocation
                                                                              and $projection.Article          = _Difference.Article
                                                                              and $projection.SalesOrderNumber = _Difference.SalesOrderNumber
                                                                              and $projection.SalesOrderItem   = _Difference.SalesOrderItem
                                                                              and $projection.SapSnapshotDate  = _Difference.WmsSnapshotDate
{
  key SapSnapshotDate,
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      UuQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      QiQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      BlQty,
      Meins                                                                                                  as UnitOfMeassure,
      SapTimeStamp,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      case when _TimingAdjustmentSum[1:StockType = 'UU'].TimingAdjustment is null
      then cast( 0 as abap.quan( 13, 3 )) else _TimingAdjustmentSum[1:StockType = 'UU'].TimingAdjustment end as UnrectrictedTimingAdjustment,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      case when _TimingAdjustmentSum[1:StockType = 'QI'].TimingAdjustment  is null
      then cast( 0 as abap.quan( 13, 3 )) else _TimingAdjustmentSum[1:StockType = 'QI'].TimingAdjustment end as InQualityInspTimingAdjustment,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      case when _TimingAdjustmentSum[1:StockType = 'BK'].TimingAdjustment  is null
      then cast( 0 as abap.quan( 13, 3 )) else _TimingAdjustmentSum[1:StockType = 'BK'].TimingAdjustment end as BlockedTimingAdjustment,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.UnrectrictedTimingAdjustment                                                               as ErrorsUuTiming,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.BlockedTimingAdjustment                                                                    as ErrorsBlTiming,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.InQualityInspTimingAdjustment                                                              as ErrorsQiTiming,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsGoodsReceiptUUQuantity                                                               as ErrorsGrUuQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsGoodsReceiptBlQuantity                                                               as ErrorsGrQiQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsGoodsReceiptBlQuantity                                                               as ErrorsGrBlQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsInventoryPostingUnQty                                                                as ErrorsInvpostUuQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsInventoryPostingBlQty                                                                as ErrorsInvpostBlQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsInventoryPostingQiQty                                                                as ErrorsInvpostQiQty,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsGiEcom                                                                               as ErrorGiEcom,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeassure'
      _Difference.ErrorsGrEcom                                                                               as ErrorGrEcom
}
