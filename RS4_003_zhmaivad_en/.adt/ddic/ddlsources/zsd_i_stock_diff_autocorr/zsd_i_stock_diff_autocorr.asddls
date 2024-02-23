/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 12.07.2023 | 22859 Stock reconciliation -  interface  *
*              |            | DS4K958577                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 12.07.2023 | 22859 Stock reconciliation -  interface  *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock differ data for Auto corr report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stock_diff_autocorr
  as select from zsd_i_stock_difference_report
{
  key max(WmsSnapshotDate) as WmsSnapshotDate,
      Plant,
      StorageLocation,
      Article,
      SalesOrderNumber,
      SalesOrderItem
}
where
  WmsTimeStamp > 0
group by
  Plant,
  StorageLocation,
  Article,
  SalesOrderNumber,
  SalesOrderItem
