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
" ZHMAIVAD     | 13.09.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*
" ZHMAIVAD     | 21.09.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*/
@EndUserText.label: 'BW Snapshot Calc Discrepancies'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
define view entity zsd_i_bw_snapshot_calc_differ
  as select from zsd_i_bw_snapshot
  association to zsd_i_article_valuation        as _ArticleValuation          on  $projection.Article             = _ArticleValuation.Article
                                                                              and $projection.Plant               = _ArticleValuation.ValuationArea
                                                                              and _ArticleValuation.ValuationType = ''
  association to zsd_i_errors_goods_receipt_sum as _ErrorsGoodsReceiptSum     on  $projection.Article = _ErrorsGoodsReceiptSum.Product
                                                                              and $projection.Plant   = _ErrorsGoodsReceiptSum.Plant
  association to zsd_i_errors_goods_issue_sum   as _ErrorsGoodsIssueSum       on  $projection.Plant           = _ErrorsGoodsIssueSum.Plant
                                                                              and $projection.StorageLocation = _ErrorsGoodsIssueSum.StorageLocation
                                                                              and $projection.Article         = _ErrorsGoodsIssueSum.Article
  association to zsd_i_errors_inventory_pst_sum as _ErrorsInventoryPostingSum on  $projection.Plant           = _ErrorsInventoryPostingSum.Plant
                                                                              and $projection.StorageLocation = _ErrorsInventoryPostingSum.StorageLocation
                                                                              and $projection.Article         = _ErrorsInventoryPostingSum.Product
  association to zsd_i_errors_omni_shpm_cf_sum  as _ErrorsOmniShipmentSum     on  $projection.Plant           = _ErrorsOmniShipmentSum.Plant
                                                                              and $projection.StorageLocation = _ErrorsOmniShipmentSum.StorageLocation
                                                                              and $projection.Article         = _ErrorsOmniShipmentSum.Product
{
  key WmsSnapshotDate,
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      WmsTimeStamp,
      SapTimeStamp,
      Meins,
      UnrectrictedWmsStockQuantity,
      InQualityInspWmsStockQuantity,
      BlockedWmsStockQuantity,
      UnrectrictedSapStockQuantity,
      InQualityInspSapStockQuantity,
      BlockedSapStockQuantity,
      UnrectrictedTimingAdjustment,
      InQualityInspTimingAdjustment,
      BlockedTimingAdjustment,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity                                    as UnrectrictedDifferenceQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity                                  as InQualityInspDifferenceQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      BlockedWmsStockQuantity - BlockedSapStockQuantity                                              as BlockedDifferenceQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = ''].Quantity, 0) as abap.quan(13,3) )       as ErrorsGoodsReceiptUUQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = 'X'].Quantity, 0) as abap.quan(13,3) )      as ErrorsGoodsReceiptQiQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = 'S'].Quantity, 0) as abap.quan(13,3) )      as ErrorsGoodsReceiptBlQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsIssueSum.StockQuantity, 0) as abap.quan(13,3) )                      as ErrorsGoodsIssueQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsOmniShipmentSum.ErrorsGiEcom, 0) as abap.quan(13,3) )                     as ErrorsGiEcom,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsOmniShipmentSum.ErrorsGrEcom, 0) as abap.quan(13,3) )                     as ErrorsGrEcom,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'UU'].Quantity, 0) as abap.quan(13,3) ) as ErrorsInventoryPostingUnQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'QI'].Quantity, 0) as abap.quan(13,3) ) as ErrorsInventoryPostingQiQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'BL'].Quantity, 0) as abap.quan(13,3) ) as ErrorsInventoryPostingBlQty,
      _ArticleValuation.Price,
      coalesce( _ArticleValuation.CurrencyCode, cast ('EUR' as abap.cuky) )                          as CurrencyCode
}
where
      SapTimeStamp > 0
  and WmsTimeStamp > 0
