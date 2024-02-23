/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
************************************************************************
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*/

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock corr report - Projection view'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['WmsSnapshotDate','Plant','StorageLocation','Article']
define root view entity zsd_c_stock_corr_rprt
  provider contract transactional_query
  as projection on zsd_i_stock_corr_rprt
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
      @EndUserText.label: null
      @EndUserText.quickInfo: null
      SalesOrderNumber,
      SalesOrderItem,
      ExecutionTimeStamp,
      ExecutionDate,
      ExecutionTime,
      TransferTo,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      AdjustmentQty,
      MoveType,
      Adjustmented,
      AdjustmentCriticality,
      Difference,
      DifferenceCalc,
      DifferenceCalcCriticality,
      MaterialDocumentsStockSum,
      Meins,
      StatusCriticality,
      StatusCriticalityHighLight,
      WmsSnapshotDate,
      FreshestErrorMessage,
      CountErrors,
      CreatedAt,
      CreatedBy,
      ChangedAt,
      ChangedBy,
      LastChangedAt,

      /* Associations */
      _StockCorrectionHistory : redirected to composition child zsd_c_stock_correction_history,
      _StockCorrectionErrors  : redirected to composition child zsd_c_stock_correction_errors
}
