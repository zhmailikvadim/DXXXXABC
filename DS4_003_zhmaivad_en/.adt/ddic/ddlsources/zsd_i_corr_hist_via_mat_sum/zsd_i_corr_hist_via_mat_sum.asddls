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
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sum Move Type''s quantities'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_corr_hist_via_mat_sum
  as select from zsd_i_corr_hist_via_mat_doc as History
{
  key WmsSnapshotDate,
  key StockType,
  key Article,
  key Plant,
  key StorageLocation,
  key SalesOrderNumber,
  key SalesOrderItem,
      Meins,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      sum(AdjustmentQty) as AdjustmentQtySum
}
group by
  WmsSnapshotDate,
  StockType,
  Article,
  Meins,
  Plant,
  StorageLocation,
  SalesOrderNumber,
  SalesOrderItem
