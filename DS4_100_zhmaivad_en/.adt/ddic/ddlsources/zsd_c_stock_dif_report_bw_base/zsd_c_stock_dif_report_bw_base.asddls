@EndUserText.label: 'Difference Report - Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZSD_C_STOCK_DIF_REPORT_BW_BASE
  provider contract transactional_query
  as projection on zsd_i_stock_dif_report_bw_base
{
  key BwSnapshotDate,
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      SapTimestamp,
      SapStampTime,
      UnrectrictedSapStockQuantity,
      InQualityInspSapStockQuantity,
      BlockedSapStockQuantity,
      WmsTimeStamp,
      WmsStampTime,
      UnrectrictedWmsStockQuantity,
      InQualityInspWmsStockQuantity,
      BlockedWmsStockQuantity,
      Meins,
      UnrectrictedDifferenceQty,
      InQualityInspDifferenceQty,
      BlockedDifferenceQty,
      DifferenceQty,
      UnrectrictedDifferenceValue,
      InQualityInspDifferenceValue,
      BlockedDifferenceValue,
      DifferenceValue,
      ArticleDescription,
      MaterialType,
      ArticleGroup,
      GenericArticle,
      Price,
      CurrencyCode,
      Status,
      StatusCriticality,
      ArticleForSearch,
      InterfaceGRError,
      InterfaceTransferError,
      InterfaceGIError,
      TotalInterfaceError,
      TotalTimingAdjustment,
      ECOMtotal,
      TimingAdjustment1,
      TimingAdjustment2,
      ECOMTimingAdjustment,
      ECOMInterfaceGItoCustomerInEr,
      ECOMIntCustomerReturnsInEr,
      ECOMonWay,
      CreatedAt,
      CreatedBy,
      ChangedAt,
      ChangedBy,
      LastChangedAt,
      /* Associations */
      _AifInventPostErrorsMessages,
      _HistorySapSnapShot,
      _IdocErrors,
      _ReturnOrdersAIFErrors
}