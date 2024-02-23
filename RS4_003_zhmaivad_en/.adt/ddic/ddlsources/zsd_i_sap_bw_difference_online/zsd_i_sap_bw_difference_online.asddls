/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
----------------------------------------------------------------------*
" ZHMAIVAD     | 21.09.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*/
@EndUserText.label: 'BW Snapshot Calc Discrepancies'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
define view entity zsd_i_sap_bw_difference_online
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
  association to zsd_i_actual_sap_stock_col_typ as _SapSnapshot               on  $projection.WmsSnapshotDate  = _SapSnapshot.SapSnapshotDate
                                                                              and $projection.Plant            = _SapSnapshot.Plant
                                                                              and $projection.StorageLocation  = _SapSnapshot.StorageLocation
                                                                              and $projection.Article          = _SapSnapshot.Article
                                                                              and $projection.SalesOrderNumber = _SapSnapshot.SalesOrderNumber
                                                                              and $projection.SalesOrderItem   = _SapSnapshot.SalesOrderItem
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
      UnrectrictedWmsStockQuantity - cast(coalesce(_SapSnapshot.UuQty , 0) as abap.quan(13,3) )            as UnrectrictedDifferenceQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      InQualityInspWmsStockQuantity - cast(coalesce(_SapSnapshot.QiQty , 0) as abap.quan(13,3) )           as InQualityInspDifferenceQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      BlockedWmsStockQuantity - cast(coalesce(_SapSnapshot.BlQty , 0) as abap.quan(13,3) )                 as BlockedDifferenceQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = ''].Quantity, 0) as abap.quan(13,3) )             as ErrorsGoodsReceiptUUQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = 'X'].Quantity, 0) as abap.quan(13,3) )            as ErrorsGoodsReceiptQiQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = 'S'].Quantity, 0) as abap.quan(13,3) )            as ErrorsGoodsReceiptBlQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsGoodsIssueSum.StockQuantity, 0) as abap.quan(13,3) )                            as ErrorsGoodsIssueQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsOmniShipmentSum.ErrorsGiEcom, 0) as abap.quan(13,3) )                           as ErrorsGiEcom,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsOmniShipmentSum.ErrorsGrEcom, 0) as abap.quan(13,3) )                           as ErrorsGrEcom,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'UU'].Quantity, 0) as abap.quan(13,3) )       as ErrorsInventoryPostingUnQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'QI'].Quantity, 0) as abap.quan(13,3) )       as ErrorsInventoryPostingQiQty,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'BL'].Quantity, 0) as abap.quan(13,3) )       as ErrorsInventoryPostingBlQty,
      _ArticleValuation.Price,
      coalesce( _ArticleValuation.CurrencyCode, cast ('EUR' as abap.cuky) )                                as CurrencyCode,
      case
          when
             $projection.unrectrictedtimingadjustment > 0
          or $projection.inqualityinsptimingadjustment > 0
          or $projection.blockedtimingadjustment > 0
          or cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = ''].Quantity, 0) as abap.quan(13,3) ) > 0
          or cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = 'X'].Quantity, 0) as abap.quan(13,3) )  > 0
          or cast(coalesce(_ErrorsGoodsReceiptSum[1:StockType = 'S'].Quantity, 0) as abap.quan(13,3) )  > 0
          or cast(coalesce(_ErrorsGoodsIssueSum.StockQuantity, 0) as abap.quan(13,3) )   > 0
          or cast(coalesce(_ErrorsOmniShipmentSum.ErrorsGiEcom, 0) as abap.quan(13,3) )  > 0
          or cast(coalesce(_ErrorsOmniShipmentSum.ErrorsGrEcom, 0) as abap.quan(13,3) )  > 0
          or cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'UU'].Quantity, 0) as abap.quan(13,3) ) > 0
          or cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'QI'].Quantity, 0) as abap.quan(13,3) ) > 0
          or cast(coalesce(_ErrorsInventoryPostingSum[1:StockType = 'BL'].Quantity, 0) as abap.quan(13,3) ) > 0
          then cast( 'X'  as boolean preserving type ) else
          cast( ''  as boolean preserving type ) end                                                       as InterfaceErrorsExist,
      case when  UnrectrictedWmsStockQuantity - cast(coalesce(_SapSnapshot.UuQty , 0) as abap.quan(13,3) )  <> 0
              or InQualityInspWmsStockQuantity - cast(coalesce(_SapSnapshot.QiQty , 0) as abap.quan(13,3) ) <> 0
              or BlockedWmsStockQuantity - cast(coalesce(_SapSnapshot.BlQty , 0) as abap.quan(13,3) ) <> 0
              then cast( 'X'  as boolean preserving type ) else cast( ''  as boolean preserving type ) end as HasDifference
}
where
      SapTimeStamp    > 0
  and WmsTimeStamp    > 0
  and WmsSnapshotDate = $session.system_date
