/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 06.12.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | FB_16311_SD_[Feature] [Build] - Stock reconciliation *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 20960     : [Feature] [Build] - Stock re *
*              |            | DS4K951475                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock Correction Basic'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stock_corr
  as select from zsd_t_stock_corr
{
  key uuid                as Uuid,
      stock_snapshot_uuid as StockSnapshotUuid,
      plant               as Plant,
      storage_location    as StorageLocation,
      article             as Article,
      sales_order_number  as SalesOrderNumber,
      sales_order_item    as SalesOrderItem,
      execution_timestamp as ExecutionTimestamp,
      transfer_to         as TransferTo,
      adjustment_qty      as AdjustmentQty,
      move_type_group     as MoveTypeGroup,
      difference          as Difference,
      wms_snapshot_date   as WmsSnapshotDate,
      stock_type          as StockType,
      meins               as Meins,
      created_by          as CreatedBy,
      created_at          as CreatedAt,
      changed_by          as ChangedBy,
      changed_at          as ChangedAt,
      last_changed_at     as LastChangedAt
}
