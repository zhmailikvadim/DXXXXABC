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
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sap Snapshot Last Timestamp'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_sap_snapsh_last
  as select from zsd_i_sap_snapshot             as _Snapshot
    inner join   zsd_i_sap_stock_snaps_max_time as _sapstockmaxtimestmp on  _Snapshot.SapTimestamp     = _sapstockmaxtimestmp.MaxTimeStamp
                                                                        and _Snapshot.Plant            = _sapstockmaxtimestmp.Plant
                                                                        and _Snapshot.StorageLocation  = _sapstockmaxtimestmp.StorageLocation
                                                                        and _Snapshot.Article          = _sapstockmaxtimestmp.Article
                                                                        and _Snapshot.SalesOrderNumber = _sapstockmaxtimestmp.SalesOrderNumber
                                                                        and _Snapshot.SalesOrderItem   = _sapstockmaxtimestmp.SalesOrderItem
{
  key _Snapshot.Plant,
  key _Snapshot.StorageLocation,
  key _Snapshot.SalesOrderNumber,
  key _Snapshot.SalesOrderItem,
  key _Snapshot.Article,
      _Snapshot.SapSnapshotDate,
      _Snapshot.SapTimestamp,
//      @Semantics.quantity.unitOfMeasure : 'Meins'
//      _Snapshot.SapStockQuantity,
      _Snapshot.Meins,
      _Snapshot.CreatedBy,
      _Snapshot.CreatedAt,
      _Snapshot.ChangedBy,
      _Snapshot.ChangedAt,
      _Snapshot.LastChangedAt
}
