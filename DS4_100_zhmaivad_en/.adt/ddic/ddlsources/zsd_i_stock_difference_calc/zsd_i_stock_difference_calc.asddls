/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 27.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock Difference report - basic CDS'
@Metadata:{ignorePropagatedAnnotations: true, allowExtensions: true}
define root view entity zsd_i_stock_difference_calc
  as select from zsd_i_bw_snapshot_calc_differ
{
               @ObjectModel.filter.enabled: true
  key          WmsSnapshotDate,
  key          Plant,
  key          StorageLocation,
  key          Article,
  key          SalesOrderNumber,
  key          SalesOrderItem,
               case when  SapTimeStamp = 0 then cast('10000101' as abap.dec( 21, 0 ) ) else SapTimeStamp end as SapTimeStamp,
               cast( substring(cast( SapTimeStamp as abap.char( 28 ) ),9,6) as abap.tims )                   as SapTime,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               UnrectrictedSapStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               InQualityInspSapStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               BlockedSapStockQuantity,
               case when  WmsTimeStamp = 0 then cast('10000101' as abap.dec( 21, 0 ) ) else WmsTimeStamp end as WmsTimeStamp,
               cast( substring(cast( WmsTimeStamp as abap.char( 23 ) ),9,6) as abap.tims )                   as WmsTime,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               UnrectrictedWmsStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               InQualityInspWmsStockQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               BlockedWmsStockQuantity,
               Meins,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               UnrectrictedTimingAdjustment,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               InQualityInspTimingAdjustment,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               BlockedTimingAdjustment,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               UnrectrictedDifferenceQty -  ErrorsGoodsReceiptUUQuantity + ErrorsGoodsIssueQuantity
                - ErrorsGrEcom  + ErrorsGiEcom - ErrorsInventoryPostingUnQty - UnrectrictedTimingAdjustment  as BwUnrectrictedDifferenceQty,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               UnrectrictedDifferenceQty,
               case when UnrectrictedDifferenceQty   <> 0
               then 2 when UnrectrictedDifferenceQty   = 0 then 3 else 0 end                                 as UnrectrictedDifferenceCritical,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               InQualityInspDifferenceQty - ErrorsGoodsReceiptQiQuantity
               - ErrorsInventoryPostingQiQty - InQualityInspTimingAdjustment                                 as BwInQualityInspDifferenceQty,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               InQualityInspDifferenceQty,
               case
               when InQualityInspDifferenceQty   <> 0
               then 2 when InQualityInspDifferenceQty   = 0 then 3 else 0 end                                as InQualityInspDifferenceCritica,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               BlockedDifferenceQty - $projection.errorsgoodsreceiptblquantity
               - ErrorsInventoryPostingBlQty - BlockedTimingAdjustment                                       as BwBlockedDifferenceQty,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               BlockedDifferenceQty,
               case
               when BlockedDifferenceQty  <> 0
               then 2 when BlockedDifferenceQty  = 0 then 3 else 0 end                                       as BlockedDifferenceCriticality,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               UnrectrictedDifferenceQty + InQualityInspDifferenceQty + BlockedDifferenceQty                 as DifferenceQty,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               abs($projection.DifferenceQty)                                                                as AbsoluteDifferenceQty,
               case when $projection.DifferenceQty <> 0 then 1 else 0 end                                    as DifferenceCriticality,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               cast( ( UnrectrictedDifferenceQty)
               * cast( Price as abap.dec(6, 2 ) ) as abap.curr( 13, 2 ) )                                    as UnrectrictedDifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               cast( ( InQualityInspDifferenceQty )
                * cast( Price as abap.dec( 6, 2 ) ) as abap.curr( 13, 2 ) )                                  as InQualityInspDifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               cast( ( BlockedDifferenceQty )
                * cast( Price as abap.dec( 6, 2 ) ) as abap.curr( 13, 2 ) )                                  as BlockedDifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               cast( ( $projection.DifferenceQty ) * cast( Price
               as abap.dec( 6, 2 ) ) as abap.curr( 13, 2 ) )                                                 as DifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               abs($projection.DifferenceValue)                                                              as AbsoluteDifferenceValue,
               @Semantics.amount.currencyCode: 'CurrencyCode'
               Price,
               case when  CurrencyCode = '' then cast ('EUR' as abap.cuky) else CurrencyCode end             as CurrencyCode,
               case when  $projection.unrectricteddifferenceqty <> 0
                       or $projection.inqualityinspdifferenceqty <> 0
                       or $projection.blockeddifferenceqty <> 0  then cast( 'X'  as boolean preserving type )
                    else cast( ''  as boolean preserving type ) end                                          as HasDifference,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsGoodsReceiptUUQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsGoodsReceiptQiQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsGoodsReceiptBlQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsGoodsIssueQuantity,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsGiEcom,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsGrEcom,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsInventoryPostingUnQty,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsInventoryPostingBlQty,
               @Semantics.quantity.unitOfMeasure : 'Meins'
               ErrorsInventoryPostingQiQty
}
where
  WmsSnapshotDate = $session.system_date
