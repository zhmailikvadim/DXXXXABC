/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock Corr Keys Group for Differ RPRT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stock_corr_calc_for_diff
  as select from zsd_i_stock_corr_rprt
{
  key    WmsSnapshotDate,
  key    Plant,
  key    StorageLocation,
  key    Article,
  key    SalesOrderNumber,
  key    SalesOrderItem,
         Status,
         count( distinct Status  ) as CountStatus

}
group by
  WmsSnapshotDate,
  Plant,
  StorageLocation,
  Article,
  SalesOrderNumber,
  SalesOrderItem,
  Status
