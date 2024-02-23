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
@EndUserText.label: 'Freshest Correction History Message'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stock_corr_hist_freshest
  as select from zsd_i_stock_correction_history as CorrectionHistory
    join         zsd_i_correct_hist_last_number as LastHistoryNumber on  CorrectionHistory.StockCorrectionUuid = LastHistoryNumber.StockCorrectionUuid
                                                                     and CorrectionHistory.SemanticCountNumber = LastHistoryNumber.LastSemanticCountNumber
{
  key CorrectionHistory.HistoryUuid,
  key CorrectionHistory.StockCorrectionUuid,
      CorrectionHistory.SemanticCountNumber,
      CorrectionHistory.Plant,
      CorrectionHistory.StorageLocation,
      CorrectionHistory.Article,
      CorrectionHistory.SalesOrderNumber,
      CorrectionHistory.SalesOrderItem,
      CorrectionHistory.Status,
      CorrectionHistory.Meins,
      CorrectionHistory.MaterialDocument,
      CorrectionHistory.MaterialDocumentYear,
      CorrectionHistory.MoveType,
      CorrectionHistory.SapSnapshotDate,
      CorrectionHistory.WmsSnapshotDate,
      CorrectionHistory.TransferTo,
      CorrectionHistory.TransferToDescription,
      CorrectionHistory.AdjustmentQty,
      LastHistoryNumber.CountHistoryNumbers,
      CorrectionHistory.StatusCriticality,
      CorrectionHistory.CreateTimestamp,
      CorrectionHistory.CreatedAt,
      CorrectionHistory.CreatedBy,
      CorrectionHistory.ChangedAt,
      CorrectionHistory.ChangedBy,
      CorrectionHistory.LastChangedAt
}
