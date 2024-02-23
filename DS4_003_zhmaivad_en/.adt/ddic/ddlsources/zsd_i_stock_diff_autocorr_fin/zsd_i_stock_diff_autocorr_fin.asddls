/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 12.07.2023 | 22859 Stock reconciliation -  interface  *
*              |            | DS4K958577                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 28.12.2023 | 22859 Stock reconciliation -  interface  *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock diff data for Auto corrtn report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stock_diff_autocorr_fin
  as select from zsd_i_stock_diff_autocorr      as _Std
    inner join   zsd_i_stock_diff_autocorr_vald as _StdComplete on  _StdComplete.WmsSnapshotDate  = _Std.WmsSnapshotDate
                                                                and _StdComplete.Plant            = _Std.Plant
                                                                and _StdComplete.StorageLocation  = _Std.StorageLocation
                                                                and _StdComplete.Article          = _Std.Article
                                                                and _StdComplete.SalesOrderNumber = _Std.SalesOrderNumber
                                                                and _StdComplete.SalesOrderItem   = _Std.SalesOrderItem
{
  key _Std.WmsSnapshotDate  as WmsSnapshotDate,
  key _Std.Plant            as Plant,
  key _Std.StorageLocation  as StorageLocation,
  key _Std.Article          as Article,
  key _Std.SalesOrderNumber as SalesOrderNumber,
  key _Std.SalesOrderItem   as SalesOrderItem
}
