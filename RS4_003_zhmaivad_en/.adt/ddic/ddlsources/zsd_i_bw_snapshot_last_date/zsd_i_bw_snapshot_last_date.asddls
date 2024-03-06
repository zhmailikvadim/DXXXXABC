/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 27.02.2024 | 29294     : [Feature] [Build] - Stock re *
*              |            | DS4K980553                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.03.2024 | 29314     : [Feature] [Build] - Stock re *
*              |            | DS4K982092                               *
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
  as select from zsd_i_snapshot
{
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      cast( max(WmsSnapshotDate) as abap.dats) as MaxBwSnapshotDate,
      max(WmsTimeStamp)                        as MaxWmsTimeStamp,
      max(SapTimeStamp)                        as MaxSapTimeStamp
}
where
  WmsSnapshotDate <= $session.system_date
group by
  Plant,
  StorageLocation,
  Article,
  SalesOrderNumber,
  SalesOrderItem
