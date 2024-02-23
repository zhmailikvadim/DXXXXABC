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
@EndUserText.label: 'Last Date In BW Snapshot'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_bw_snapshot_last_date
  as select from zsd_i_bw_snapshot
{
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      max(WmsSnapshotDate) as MaxBwSnapshotDate,
      max(WmsTimeStamp)    as MaxWmsTimeStamp,
      max(SapTimeStamp)    as MaxSapTimeStamp
}
group by
  Plant,
  StorageLocation,
  Article,
  SalesOrderNumber,
  SalesOrderItem
