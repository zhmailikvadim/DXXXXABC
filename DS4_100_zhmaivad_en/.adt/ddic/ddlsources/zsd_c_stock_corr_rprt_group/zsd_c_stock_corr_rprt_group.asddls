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
@EndUserText.label: 'Stock corr report - Projection view'
@Metadata.allowExtensions: true
define root view entity zsd_c_stock_corr_rprt_group
  as select from zsd_i_stock_corr_rprt
{
  key Uuid,
      Status,
      Plant,
      StorageLocation,
      Article,
      ArticleDescription,
      GenericArticle,
      MaterialType,
      MaterialGroup,
      CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      StockType,
      StockTypeDescription,
      SalesOrderNumber,
      SalesOrderItem,
      ExecutionTimeStamp,
      ExecutionDate,
      ExecutionTime,
      TransferTo,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure : 'Meins'
      AdjustmentQty,
      MoveType,
      @DefaultAggregation: #SUM
      Adjustmented,
      AdjustmentCriticality,
      @DefaultAggregation: #SUM
      difference,
      @DefaultAggregation: #SUM
      DifferenceCalc,
      DifferenceCalcCriticality,
      @DefaultAggregation: #SUM
      MaterialDocumentsStockSum,
      Meins,
      StatusCriticality,
      WmsSnapshotDate,
      FreshestErrorMessage,
      FreshestErrorMessageId,
      FreshestErrorMessageNumber,
      CountErrors,
      InterfaceGrError,
      InterfaceTransferError,
      InterfaceGiError,
      TotalInterfaceError,
      TotalTimingAdjustment,
      EcomTotal,
      //ActualStockQty,
      CreatedAt,
      CreatedBy,
      ChangedAt,
      ChangedBy,
      LastChangedAt,

      /* Associations */
      _StockCorrectionHistory,
      _StockCorrectionErrors
}
