@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum Move Type''s quantities'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_corr_hist_mseg_transfer
  as select from zsd_i_stock_correction_history as History
    join         zsd_i_material_documents       as Mseg on History.MaterialDocument = Mseg.Mblnr

{
  key History.WmsSnapshotDate,
  key History.TransferTo,
  key History.Article,
  key History.Plant,
  key History.StorageLocation,
  key History.SalesOrderItem,
  key History.SalesOrderNumber,
      History.Meins,
      History.MaterialDocument,
      Mseg.Mblnr,

      @Semantics.quantity.unitOfMeasure : 'Meins'
      - sum(Mseg.Menge)              as AdjustmentQtySum,
      case Mseg.Insmk
      when  '' then 'UU'
      when 'F' then 'UU'
      when '2' then 'QI'
      when 'X' then 'QI'
      when '3' then 'BK' else '' end as StockType
}
where
  History.Status = 'COMPLETE'
group by
  History.WmsSnapshotDate,
  History.TransferTo,
  History.Article,
  History.Meins,
  History.Plant,
  History.StorageLocation,
  History.SalesOrderItem,
  History.SalesOrderNumber,
  Mseg.Insmk,
  History.MaterialDocument,
  Mseg.Mblnr
