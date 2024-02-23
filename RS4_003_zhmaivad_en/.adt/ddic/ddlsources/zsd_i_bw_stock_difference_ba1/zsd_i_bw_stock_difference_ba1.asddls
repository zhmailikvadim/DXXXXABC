/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BW or SAP Snapshot base'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity zsd_i_bw_stock_difference_ba1
  as select distinct from zsd_i_bw_snapshot_tf
{
  key         date0                                                              as WmsSnapshotDate,
  key         s4plant                                                            as Plant,
  key         stor_loc                                                           as StorageLocation,
  key         cast( s4product as matnr preserving type )                         as Article,
  key         cast( doc_number as zsd_sales_order_number preserving type )       as SalesOrderNumber,
  key         cast(s_ord_item as zsd_snapshot_sales_order_item preserving type ) as SalesOrderItem,
              wms_timestamp                                                      as WmsTimeStamp,
              sap_timestamp                                                      as SapTimeStamp,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMSUUST as abap.quan( 13, 3 ))                         as UnrectrictedSapStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMSQIST as abap.quan( 13, 3 ))                         as InQualityInspSapStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMSBLST as abap.quan( 13, 3 ))                         as BlockedSapStockQuantity,
              cast(unit as abap.unit( 3 ) )                                      as Meins,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMUUST as abap.quan( 13, 3 ))                          as UnrectrictedWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMQIST as abap.quan( 13, 3 ))                          as InQualityInspWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMBLST  as abap.quan( 13, 3 ))                         as BlockedWmsStockQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMUUDIF  as abap.quan( 13, 3 ))                        as UnrectrictedDifferenceQty,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMUURDF  as abap.quan( 13, 3 ))                        as BwUnrectrictedDifferenceQty,
              @Semantics.amount.currencyCode: 'CurrencyCode'
              cast(/BIC/RLMMUUDFV as abap.curr( 13, 2 ) )                        as UnrectrictedDifferenceValue,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMBLDIF  as abap.quan( 13, 3 ))                        as BlockedDifferenceQty,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMBLRDF  as abap.quan( 13, 3 ))                        as BwBlockedDifferenceQty,
              @Semantics.amount.currencyCode: 'CurrencyCode'
              cast(/BIC/RLMMBLDFV  as abap.curr( 13, 2 ) )                       as BlockedDifferenceValue,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMQIDIF  as abap.quan( 13, 3 ))                        as InQualityInspDifferenceQty,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMQIRDF  as abap.quan( 13, 3 ))                        as BwInQualityInspDifferenceQty,
              @Semantics.amount.currencyCode: 'CurrencyCode'
              cast(/BIC/RLMMQIDFV  as abap.curr( 13, 2 ) )                       as InQualityInspDifferenceValue,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMTLN   as abap.quan( 13, 3 ))                         as DifferenceQty,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMTLNA  as abap.quan( 13, 3 ))                         as AbsoluteDifferenceQty,
              @Semantics.amount.currencyCode: 'CurrencyCode'
              cast(/BIC/RLMMTLV   as abap.curr( 13, 2 ))                         as DifferenceValue,
              @Semantics.amount.currencyCode: 'CurrencyCode'
              cast(/BIC/RLMMTLVA   as abap.curr( 13, 2 ))                        as AbsoluteDifferenceValue,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMUUET  as abap.quan( 13, 3 ))                         as UnrectrictedTimingAdjustment,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMBLET  as abap.quan( 13, 3 ))                         as BlockedTimingAdjustment,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMQIET  as abap.quan( 13, 3 ))                         as InQualityInspTimingAdjustment,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMUUEGR  as abap.quan( 13, 3 ))                        as ErrorsGoodsReceiptUUQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMQIEGR  as abap.quan( 13, 3 ))                        as ErrorsGoodsReceiptQiQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMBLEGR  as abap.quan( 13, 3 ))                        as ErrorsGoodsReceiptBlQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMEGI  as abap.quan( 13, 3 ))                          as ErrorsGoodsIssueQuantity,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMEGREC  as abap.quan( 13, 3 ))                        as ErrorsGrEcom,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMEGIEC  as abap.quan( 13, 3 ))                        as ErrorsGiEcom,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMUUEIP  as abap.quan( 13, 3 ))                        as ErrorsInventoryPostingUnQty,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMBLEIP  as abap.quan( 13, 3 ))                        as ErrorsInventoryPostingBlQty,
              @Semantics.quantity.unitOfMeasure : 'Meins'
              cast(/BIC/RLMMQIEIP  as abap.quan( 13, 3 ))                        as ErrorsInventoryPostingQiQty,
              @Semantics.amount.currencyCode: 'CurrencyCode'
              /BIC/RLMMPRICE                                                     as Price,
              cast(/BIC/RLMMFLDIF as boolean preserving type )                   as HasDifference,
              CURRENCY                                                           as CurrencyCode,
              ERRORS_CHON                                                        as ErrorsChangedOn
}
