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
*----------------------------------------------------------------------*
* ZHMAIVAD     | 20.04.2023 | 19611     : [Feature] [Build] - Stock re *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*
* ZHMAIVAD     | 13.03.2024 | 29314     : [Feature] [Build] - Stock re *
*              |            | DS4K982092                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sap Snapshot - Basic'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsd_i_sap_snapshot
  as select from zsd_t_snapshot_a
{
  key snapshot_date         as SapSnapshotDate,
  key plant                 as Plant,
  key storage_location      as StorageLocation,
  key sales_order_number    as SalesOrderNumber,
  key sales_order_item      as SalesOrderItem,
  key article               as Article,
      sap_timestamp         as SapTimestamp,
      uu_qty                as UuQty,
      bl_qty                as BlQty,
      qi_qty                as QiQty,
      uu_diff               as UuDiff,
      bl_diff               as BlDiff,
      qi_diff               as QiDiff,
      uu_real_diff          as UuRealDiff,
      bl_real_diff          as BlRealDiff,
      qi_real_diff          as QiRealDiff,
      uu_diff_value         as UuDiffValue,
      bl_diff_value         as BlDiffValue,
      qi_diff_value         as QiDiffValue,
      errors_uu_timing      as ErrorsUuTiming,
      errors_bl_timing      as ErrorsBlTiming,
      errors_qi_timing      as ErrorsQiTiming,
      errors_gr_uu_qty      as ErrorsGrUuQty,
      errors_gr_qi_qty      as ErrorsGrQiQty,
      errors_gr_bl_qty      as ErrorsGrBlQty,
      errors_gi_uu_qty      as ErrorsGiUuQty,
      error_gr_ecom         as ErrorGrEcom,
      error_gi_ecom         as ErrorGiEcom,
      errors_invpost_uu_qty as ErrorsInvpostUuQty,
      errors_invpost_bl_qty as ErrorsInvpostBlQty,
      errors_invpost_qi_qty as ErrorsInvpostQiQty,
      total_net_diff        as TotalNetDiff,
      total_net_diff_abs    as TotalNetDiffAbs,
      total_diff_value      as TotalDiffValue,
      total_diff_value_abs  as TotalDiffValueAbs,
      price                 as Price,
      has_difference        as HasDifference,
      waers                 as Currency,
      meins                 as UnitOfMeasure,
      errors_changed_on     as ErrorsChangedOn,
      errors_changed_by     as ErrorsChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_on            as CreatedOn,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      changed_on            as ChangedOn,
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by            as ChangedBy
}
