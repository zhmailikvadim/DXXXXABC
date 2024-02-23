@EndUserText.label: 'Stock Difference Report - Projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true

define root view entity zsd_c_stock_diff_report_group
  as select from zsd_i_stock_difference_report
{
  key WmsSnapshotDate,
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      WmsSnapshotDateCriticality,
      CountOpenStatuses,
      CountCompleteStatuses,
      Status,
      StatusCriticality,
      SapTimeStamp,
      SapStampTime,
      @DefaultAggregation: #SUM
      UnrectrictedSapStockQuantity,
      @DefaultAggregation: #SUM
      InQualityInspSapStockQuantity,
      @DefaultAggregation: #SUM
      BlockedSapStockQuantity,
      @DefaultAggregation: #SUM
      ActualPickedStock,
      //      WmsTimeStamp,
      //      WmsStampTime,
      @DefaultAggregation: #SUM
      UnrectrictedWmsStockQuantity,
      @DefaultAggregation: #SUM
      InQualityInspWmsStockQuantity,
      @DefaultAggregation: #SUM
      BlockedWmsStockQuantity,
      Meins,
      @DefaultAggregation: #SUM
      UnrectrictedTimingAdjustment,
      @DefaultAggregation: #SUM
      InQualityInspTimingAdjustment,
      @DefaultAggregation: #SUM
      BlockedTimingAdjustment,
      @DefaultAggregation: #SUM
      BwUnrectrictedDifferenceQty,
      @DefaultAggregation: #SUM
      UnrectrictedDifferenceQty,
      @DefaultAggregation: #SUM
      UnrectrictedDifferenceCritical,
      @DefaultAggregation: #SUM
      BwInQualityInspDifferenceQty,
      @DefaultAggregation: #SUM
      InQualityInspDifferenceQty,
      InQualityInspDifferenceCritica,
      @DefaultAggregation: #SUM
      BwBlockedDifferenceQty,
      @DefaultAggregation: #SUM
      BlockedDifferenceQty,
      BlockedDifferenceCriticality,
      @DefaultAggregation: #SUM
      DifferenceQty,
      @DefaultAggregation: #SUM
      AbsoluteDifferenceQty,
      DifferenceCriticality,
      UnrectrictedDifferenceValue,
      InQualityInspDifferenceValue,
      BlockedDifferenceValue,
      DifferenceValue,
      AbsoluteDifferenceValue,
      ArticleDescription,
      MaterialType,
      ArticleGroup,
      GenericArticle,
      Price,
      CurrencyCode,
      DisplayOnlyDiffOrViceVersa,
      ArticleForSearch,
      DisplayOnlySOrdersOrViceVersa,
      OnlyFreshestWmsSnapshotDate,
      WmsMaxStampDate,
      SapMaxStampDate,
      MaxBwSnapshotDate,
      InterfaceIdocCountStock,
      InterfaceIdocCountErrors,
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
      UnrestrictedStockErrors,
      InQualityStockErrors,
      BlockedStockErrors,
      /* Associations */
      _AifInventPostErrorsMessages,
      _HistorySapSnapShot,
      _IdocErrors,
      _MaxBwSnapshotData,
      _ReturnOrdersAIFErrors,
      _TimingAdjustmentRows
}
