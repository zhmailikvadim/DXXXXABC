/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 06.12.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 21.07.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Total Timing Adjustment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_mat_doc_timing_adj_sum
  as select from zsd_i_errors_timing_adjustment
{
  key DocumentDate,
  key Article,
  key Plant,
  key StorageLocation,
  key SalesOrderNumber,
  key SalesOrderItem,
  key StockType,
      BaseUnit,
      @Semantics.quantity.unitOfMeasure : 'BaseUnit'
      sum(Quantity) as Quantity
}
where
  Quantity <> 0
group by
  DocumentDate,
  Article,
  Plant,
  StorageLocation,
  SalesOrderNumber,
  SalesOrderItem,
  StockType,
  BaseUnit
