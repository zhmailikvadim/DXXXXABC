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
@EndUserText.label: 'Sum Move Type''s quantities'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_correct_history_qnt_sum
  as select from zsd_i_stock_correction_history
{
  key StockCorrectionUuid,
      Meins,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      sum(AdjustmentQty) as AdjustmentQtySum
}
where
  Status = 'Complete'
group by
  StockCorrectionUuid,
  Meins
