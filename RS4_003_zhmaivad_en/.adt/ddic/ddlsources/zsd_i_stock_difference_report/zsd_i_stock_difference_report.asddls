/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
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
* NAGARSOW     | 30.08.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock Difference report'
@Metadata:{ignorePropagatedAnnotations: true, allowExtensions: false}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
define root view entity zsd_i_stock_difference_report
  as select from zsd_i_bw_stock_difference_base
  association        to I_ProductDescription           as _ProductDescription        on  $projection.Article          = _ProductDescription.Product
                                                                                     and _ProductDescription.Language = $session.system_language
  association        to I_Product                      as _Product                   on  $projection.Article = _Product.Product
  association [1..*] to zsd_i_stock_difference_calc    as _StockDifferenceCalc       on  $projection.Plant            = _StockDifferenceCalc.Plant
                                                                                     and $projection.StorageLocation  = _StockDifferenceCalc.StorageLocation
                                                                                     and $projection.Article          = _StockDifferenceCalc.Article
                                                                                     and $projection.SalesOrderNumber = _StockDifferenceCalc.SalesOrderNumber
                                                                                     and $projection.SalesOrderItem   = _StockDifferenceCalc.SalesOrderItem
                                                                                     and $projection.WmsSnapshotDate  = _StockDifferenceCalc.WmsSnapshotDate
  association        to zsd_i_stock_corr_calc_for_diff as _StockCorrectionCalc       on  $projection.Plant            = _StockCorrectionCalc.Plant
                                                                                     and $projection.StorageLocation  = _StockCorrectionCalc.StorageLocation
                                                                                     and $projection.Article          = _StockCorrectionCalc.Article
                                                                                     and $projection.SalesOrderNumber = _StockCorrectionCalc.SalesOrderNumber
                                                                                     and $projection.SalesOrderItem   = _StockCorrectionCalc.SalesOrderItem
                                                                                     and $projection.WmsSnapshotDate  = _StockCorrectionCalc.WmsSnapshotDate
  association [1..*] to zsd_i_bw_stock_difference_base as _HistorySapSnapShot        on  $projection.Article          = _HistorySapSnapShot.Article
                                                                                     and $projection.Plant            = _HistorySapSnapShot.Plant
                                                                                     and $projection.StorageLocation  = _HistorySapSnapShot.StorageLocation
                                                                                     and $projection.SalesOrderNumber = _HistorySapSnapShot.SalesOrderNumber
                                                                                     and $projection.SalesOrderItem   = _HistorySapSnapShot.SalesOrderItem
  association [1..*] to zsd_i_actual_picked_stock      as _ActualPickedStock         on  $projection.SalesOrderNumber = _ActualPickedStock.OrderNumber
                                                                                     and $projection.SalesOrderItem   = _ActualPickedStock.OrderItemNumber
  association [1..*] to zsd_i_mat_doc_timing_adj_rows  as _TimingAdjustmentRows      on  $projection.Plant            = _TimingAdjustmentRows.Plant
                                                                                     and $projection.StorageLocation  = _TimingAdjustmentRows.StorageLocation
                                                                                     and $projection.Article          = _TimingAdjustmentRows.Article
                                                                                     and $projection.SalesOrderNumber = _TimingAdjustmentRows.SalesOrderNumber
                                                                                     and $projection.SalesOrderItem   = _TimingAdjustmentRows.SalesOrderItem
                                                                                     and $projection.WmsSnapshotDate  = _TimingAdjustmentRows.DocumentDate
  association [1..*] to zsd_i_errors_goods_issue_idoc  as _ErrorsGoodsIssueIdoc      on  $projection.Article         = _ErrorsGoodsIssueIdoc.Article
                                                                                     and $projection.Plant           = _ErrorsGoodsIssueIdoc.Plant
                                                                                     and $projection.StorageLocation = _ErrorsGoodsIssueIdoc.StorageLocation
  association [1..*] to zsd_i_errors_goods_receipt_aif as _ErrorsPartialGoodsReceipt on  $projection.Article = _ErrorsPartialGoodsReceipt.Product
                                                                                     and $projection.Plant   = _ErrorsPartialGoodsReceipt.Plant
  association [1..*] to zsd_i_errors_inventory_pst_bas as _ErrorsInventoryPosting    on  $projection.Article = _ErrorsInventoryPosting.Product
                                                                                     and $projection.Plant   = _ErrorsInventoryPosting.Plant
  association [1..*] to zsd_i_errors_omni_shpm_cf_idoc as _ErrorsOmniShipmentConfirm on  $projection.Plant           = _ErrorsOmniShipmentConfirm.Plant
                                                                                     and $projection.StorageLocation = _ErrorsOmniShipmentConfirm.StorageLocation
                                                                                     and $projection.Article         = _ErrorsOmniShipmentConfirm.Product
{
               @ObjectModel.filter.enabled: true
  key          WmsSnapshotDate,
  key          Plant,
  key          StorageLocation,
  key          Article,
  key          SalesOrderNumber,
  key          SalesOrderItem,
               _StockCorrectionCalc.CountStatus                                                                           as CountOpenStatuses,
               _StockCorrectionCalc[1:Status = 'Complete'].CountStatus                                                    as CountCompleteStatuses,
               cast(case  when _StockCorrectionCalc[1:Status = 'Open'].CountStatus is null
               and _StockCorrectionCalc[1:Status = 'Complete'].CountStatus > 0 then 'Complete'
               when (_StockCorrectionCalc[1:Status = 'Open'].CountStatus > 0
               or _StockCorrectionCalc[1:Status = 'Error'].CountStatus > 0 ) then 'Open' else '' end as abap.char( 10 ) ) as Status,
               case  when _StockCorrectionCalc[1:Status = 'Open'].CountStatus is null
               and _StockCorrectionCalc[1:Status = 'Complete'].CountStatus > 0 then 3
               when (_StockCorrectionCalc[1:Status = 'Open'].CountStatus > 0
               or _StockCorrectionCalc[1:Status = 'Error'].CountStatus > 0 ) then 2 else 0 end                            as StatusCriticality,
               SapTimeStamp,
               cast( substring(cast( SapTimeStamp as abap.char( 28 ) ),9,6) as abap.tims )                                as SapTime,
               cast( UnrectrictedSapStockQuantity as zsd_stock_recon_qnt_int )                                            as UnrectrictedSapStockQuantity,
               cast(InQualityInspSapStockQuantity as zsd_stock_recon_qnt_int)                                             as InQualityInspSapStockQuantity,
               cast(BlockedSapStockQuantity as zsd_stock_recon_qnt_int)                                                   as BlockedSapStockQuantity,
               WmsTimeStamp,
               cast( substring(cast( WmsTimeStamp as abap.char( 23 ) ),9,6) as abap.tims )                                as WmsTime,
               cast(UnrectrictedWmsStockQuantity as zsd_stock_recon_qnt_int)                                              as UnrectrictedWmsStockQuantity,
               cast(InQualityInspWmsStockQuantity as zsd_stock_recon_qnt_int)                                             as InQualityInspWmsStockQuantity,
               cast(BlockedWmsStockQuantity as zsd_stock_recon_qnt_int)                                                   as BlockedWmsStockQuantity,
               Meins                                                                                                      as SapUom,
               Meins                                                                                                      as WmsUom,
               cast(UnrectrictedTimingAdjustment as zsd_stock_recon_qnt_int)                                              as UnrectrictedTimingAdjustment,
               cast(InQualityInspTimingAdjustment as zsd_stock_recon_qnt_int)                                             as InQualityInspTimingAdjustment,
               cast(BlockedTimingAdjustment as zsd_stock_recon_qnt_int)                                                   as BlockedTimingAdjustment,
               cast(RealUnrectrictedDifferenceQty as zsd_stock_recon_qnt_int)                                             as RealUnrectrictedDifferenceQty,
               cast(UnrectrictedDifferenceQty as zsd_stock_recon_qnt_int)                                                 as UnrectrictedDifferenceQty,
               case when UnrectrictedDifferenceQty   <> 0
               then 2 when UnrectrictedDifferenceQty   = 0 then 3 else 0 end                                              as UnrectrictedDifferenceCritical,
               cast(RealInQualityInspDifferenceQty as zsd_stock_recon_qnt_int)                                            as RealInQualityInspDifferenceQty,
               cast(InQualityInspDifferenceQty as zsd_stock_recon_qnt_int)                                                as InQualityInspDifferenceQty,
               case
               when InQualityInspDifferenceQty   <> 0
               then 2 when InQualityInspDifferenceQty   = 0 then 3 else 0 end                                             as InQualityInspDifferenceCritica,
               cast(RealBlockedDifferenceQty as zsd_stock_recon_qnt_int)                                                  as RealBlockedDifferenceQty,
               cast(BlockedDifferenceQty  as zsd_stock_recon_qnt_int)                                                     as BlockedDifferenceQty,
               case
               when BlockedDifferenceQty  <> 0
               then 2 when BlockedDifferenceQty  = 0 then 3 else 0 end                                                    as BlockedDifferenceCriticality,
               cast(DifferenceQty as zsd_stock_recon_qnt_int)                                                             as DifferenceQty,
               cast(AbsoluteDifferenceQty as zsd_stock_recon_qnt_int)                                                     as AbsoluteDifferenceQty,
               case when $projection.DifferenceQty <> 0 then 1 else 0 end                                                 as DifferenceCriticality,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               UnrectrictedDifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               InQualityInspDifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               BlockedDifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               DifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               abs($projection.differencevalue)                                                                           as AbsoluteDifferenceValue,
               _ProductDescription.ProductDescription                                                                     as ArticleDescription,
               _Product.ProductType                                                                                       as MaterialType,
               _Product.ProductGroup                                                                                      as ArticleGroup,
               _Product.CrossPlantConfigurableProduct                                                                     as GenericArticle,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               Price,
               CurrencyCode,
               HasDifference,
               cast(_Product.Product as matnr preserving type )                                                           as ArticleForSearch,
               case when SalesOrderNumber = ''
                    then cast( ''  as boolean preserving type ) else
                    cast( 'X'  as boolean preserving type ) end                                                           as DisplayOnlySOrdersOrViceVersa,
               case when WmsTimeStamp > 0 and SapTimeStamp > 0
                    then cast( 'X'  as boolean preserving type ) else
                    cast( ''  as boolean preserving type ) end                                                            as ArticleExistInBothSystems,
               cast(ErrorsGoodsReceiptUUQuantity as zsd_stock_recon_qnt_int)                                              as ErrorsGoodsReceiptUUQuantity,
               cast(ErrorsGoodsReceiptQiQuantity as zsd_stock_recon_qnt_int)                                              as ErrorsGoodsReceiptQiQuantity,
               cast(ErrorsGoodsReceiptBlQuantity as zsd_stock_recon_qnt_int)                                              as ErrorsGoodsReceiptBlQuantity,
               cast(ErrorsGoodsIssueQuantity as zsd_stock_recon_qnt_int)                                                  as ErrorsGoodsIssueQuantity,
               cast(ErrorsGiEcom as zsd_stock_recon_qnt_int)                                                              as ErrorsGiEcom,
               cast(ErrorsGrEcom as zsd_stock_recon_qnt_int)                                                              as ErrorsGrEcom,
               cast(ErrorsInventoryPostingUnQty as zsd_stock_recon_qnt_int)                                               as ErrorsInventoryPostingUnQty,
               cast(ErrorsInventoryPostingBlQty as zsd_stock_recon_qnt_int)                                               as ErrorsInventoryPostingBlQty,
               cast(ErrorsInventoryPostingQiQty as zsd_stock_recon_qnt_int)                                               as ErrorsInventoryPostingQiQty,
               case
                   when
                      $projection.UnrectrictedTimingAdjustment > 0
                   or $projection.InQualityInspTimingAdjustment > 0
                   or $projection.BlockedTimingAdjustment > 0
                   or $projection.ErrorsGoodsReceiptUUQuantity > 0
                   or $projection.ErrorsGoodsReceiptQiQuantity > 0
                   or $projection.ErrorsGoodsReceiptBlQuantity > 0
                   or $projection.ErrorsGoodsIssueQuantity > 0
                   or $projection.ErrorsGiEcom > 0
                   or $projection.ErrorsGrEcom > 0
                   or $projection.ErrorsInventoryPostingUnQty > 0
                   or $projection.ErrorsInventoryPostingBlQty > 0
                   or $projection.ErrorsInventoryPostingQiQty > 0
                   then cast( 'X'  as boolean preserving type ) else
                   cast( ''  as boolean preserving type ) end                                                             as InterfaceErrorsExist,
               _ActualPickedStock,
               _HistorySapSnapShot,
               _TimingAdjustmentRows,
               _ErrorsGoodsIssueIdoc,
               _ErrorsPartialGoodsReceipt,
               _ErrorsOmniShipmentConfirm,
               _ErrorsInventoryPosting,
               _StockDifferenceCalc
}
where
  WmsSnapshotDate > '00000000'
