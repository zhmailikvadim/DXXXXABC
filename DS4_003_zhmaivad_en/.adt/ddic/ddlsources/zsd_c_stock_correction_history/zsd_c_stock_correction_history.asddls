/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 20960     : [Feature] [Build] - Stock re *
*              |            | DS4K951475                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Stock Correction History - Projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define view entity zsd_c_stock_correction_history
  as projection on zsd_i_stock_correction_history
{

  key HistoryUuid,
  key StockCorrectionUuid,
      SemanticCountNumber,
      Status,
      TransferTo,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      AdjustmentQty,
      Meins,
      MaterialDocument,
      MaterialDocumentYear,
      MoveType,
      SapSnapshotDate,
      WmsSnapshotDate,
      StatusCriticality,
      CreatedAt,
      CreatedBy,
      ChangedAt,
      ChangedBy,
      LastChangedAt,
      /* Associations */
      _StockCorrectionReport : redirected to parent zsd_c_stock_corr_rprt
}
