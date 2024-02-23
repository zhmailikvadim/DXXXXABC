@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum Move Type''s quantities'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_corr_hist_transfer_sum
  as select from zsd_i_stock_correction_history as History
   {
  key History.WmsSnapshotDate,
  key History.TransferTo,
  key Article,
  key Plant,
  key StorageLocation,
  key SalesOrderItem,
  key SalesOrderNumber,
      History.Meins,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      - sum(History.AdjustmentQty) as TransferQtySum
}
where
  History.Status = 'COMPLETE'
group by
  History.WmsSnapshotDate,
  History.TransferTo,
  Article,
  History.Meins,
  Plant,
  StorageLocation,
  SalesOrderItem,
  SalesOrderNumber
