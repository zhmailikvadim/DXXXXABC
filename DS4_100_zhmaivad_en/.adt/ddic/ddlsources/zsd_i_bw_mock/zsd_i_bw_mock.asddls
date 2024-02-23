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
@EndUserText.label: 'Bw Snapshot'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_bw_mock
  as select from zsd_i_sap_snapshot 
{
  key     SapSnapshotDate                                                             as BwSnapshotDate,
  key     Plant,
  key     StorageLocation,
  key     Article,
  key     SalesOrderNumber,
  key     SalesOrderItem,
          SapTimestamp                                                                as WmsTimeStamp,
          SapTimestamp,
          ''                                                                          as cold_store_flag,
          Meins
//          @Semantics.quantity.unitOfMeasure : 'Meins'
//          case when StockType = 'UU'
//          then SapStockQuantity + cast(cast(substring( cast( tstmp_current_utctimestamp()
//           as abap.char(23) ), 14, 1 ) as abap.numc( 2 )) as abap.quan( 13, 3 ) )
//           else           SapStockQuantity - cast(cast(substring( cast( tstmp_current_utctimestamp()
//           as abap.char(23) ), 14, 1 ) as abap.numc( 2 )) as abap.quan( 13, 3 ) ) end as WmsStockNumber,
//          @Semantics.quantity.unitOfMeasure : 'Meins'
//          SapStockQuantity                                                            as SapStockNumber
}
