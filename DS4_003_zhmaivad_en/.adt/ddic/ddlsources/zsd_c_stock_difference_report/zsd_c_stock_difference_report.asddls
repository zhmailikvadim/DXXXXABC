/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 06.12.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | FB_16311_SD_[Feature] [Build] - Stock reconciliation *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.04.2023 | 19610     : FB_19610_SD_Feature - DEFECT - Stock Reconciliation *
*              |            | DS4K949060                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 29.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Stock Difference Report - Projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['WmsSnapshotDate','Plant','StorageLocation','Article']
define root view entity zsd_c_stock_difference_report
  provider contract transactional_query
  as projection on zsd_i_stock_difference_report
{
  key WmsSnapshotDate,
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      ArticleForSearch,
      Status,
      SapTimeStamp,
      SapTime,
      UnrectrictedSapStockQuantity,
      InQualityInspSapStockQuantity,
      BlockedSapStockQuantity,
      WmsTimeStamp,
      WmsTime,
      UnrectrictedWmsStockQuantity,
      InQualityInspWmsStockQuantity,
      BlockedWmsStockQuantity,
      UnrectrictedTimingAdjustment,
      InQualityInspTimingAdjustment,
      BlockedTimingAdjustment,
      RealUnrectrictedDifferenceQty,
      UnrectrictedDifferenceQty,
      RealInQualityInspDifferenceQty,
      InQualityInspDifferenceQty,
      RealBlockedDifferenceQty,
      BlockedDifferenceQty,
      DifferenceQty,
      AbsoluteDifferenceQty,
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
      HasDifference,
      ArticleExistInBothSystems,
      ErrorsGoodsReceiptUUQuantity,
      ErrorsGoodsReceiptQiQuantity,
      ErrorsGoodsReceiptBlQuantity,
      ErrorsGoodsIssueQuantity,
      ErrorsGrEcom,
      ErrorsGiEcom,
      ErrorsInventoryPostingUnQty,
      ErrorsInventoryPostingBlQty,
      ErrorsInventoryPostingQiQty,
      StatusCriticality,
      DifferenceCriticality,
      BlockedDifferenceCriticality,
      UnrectrictedDifferenceCritical,
      InQualityInspDifferenceCritica,
      InterfaceErrorsExist,
      DisplayOnlySOrdersOrViceVersa,
      SapUom,
      WmsUom,
      CurrencyCode,

      /* Associations */
      _ErrorsGoodsIssueIdoc,
      _ErrorsInventoryPosting,
      _ErrorsOmniShipmentConfirm,
      _ErrorsPartialGoodsReceipt,
      _HistorySapSnapShot,
      _TimingAdjustmentRows,
      _StockDifferenceCalc
}
