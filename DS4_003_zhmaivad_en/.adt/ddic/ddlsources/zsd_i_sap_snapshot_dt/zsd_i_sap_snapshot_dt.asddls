/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 25.08.2023 | 22859     : Feature - Stock reconciliation -  interfa
*              |            | DS4K957133                               *
************************************************************************/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sap snapshot - Basic(With date and time)'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_I_SAP_SNAPSHOT_DT
  as select from zsd_t_snapshot_a
{
  key snapshot_date                                                                                          as SapSnapshotDate,
  key plant                                                                                                  as Plant,
  key storage_location                                                                                       as StorageLocation,
  key sales_order_number                                                                                     as SalesOrderNumber,
  key sales_order_item                                                                                       as SalesOrderItem,
  key article                                                                                                as Article,
      sap_timestamp                                                                                          as SapTimestamp,
      tstmp_to_dats( sap_timestamp, abap_system_timezone( $session.client,'NULL' ),$session.client, 'NULL' ) as Sapdate,
      tstmp_to_tims( sap_timestamp, abap_system_timezone( $session.client,'NULL' ),$session.client, 'NULL' ) as Saptime,
      uu_qty                                                                                                 as UuQty,
      bl_qty                                                                                                 as BlQty,
      qi_qty                                                                                                 as QiQty,
      uu_diff                                                                                                as UuDiff,
      bl_diff                                                                                                as BlDiff,
      qi_diff                                                                                                as QiDiff,
      uu_real_diff                                                                                           as UuRealDiff,
      bl_real_diff                                                                                           as BlRealDiff,
      qi_real_diff                                                                                           as QiRealDiff,
      uu_diff_value                                                                                          as UuDiffValue,
      bl_diff_value                                                                                          as BlDiffValue,
      qi_diff_value                                                                                          as QiDiffValue,
      errors_uu_timing                                                                                       as ErrorsUuTiming,
      errors_bl_timing                                                                                       as ErrorsBlTiming,
      errors_qi_timing                                                                                       as ErrorsQiTiming,
      errors_gr_uu_qty                                                                                       as ErrorsGrUuQty,
      errors_gr_qi_qty                                                                                       as ErrorsGrQiQty,
      errors_gr_bl_qty                                                                                       as ErrorsGrBlQty,
      errors_gi_uu_qty                                                                                       as ErrorsGiUuQty,
      error_gr_ecom                                                                                          as ErrorGrEcom,
      error_gi_ecom                                                                                          as ErrorGiEcom,
      errors_invpost_uu_qty                                                                                  as ErrorsInvpostUuQty,
      errors_invpost_bl_qty                                                                                  as ErrorsInvpostBlQty,
      errors_invpost_qi_qty                                                                                  as ErrorsInvpostQiQty,
      total_net_diff                                                                                         as TotalNetDiff,
      total_net_diff_abs                                                                                     as TotalNetDiffAbs,
      total_diff_value                                                                                       as TotalDiffValue,
      total_diff_value_abs                                                                                   as TotalDiffValueAbs,
      price                                                                                                  as Price,
      has_difference                                                                                         as HasDifference,
      waers                                                                                                  as Currency,
      meins                                                                                                  as UnitOfMeasure,
      errors_changed_on                                                                                      as ErrorsChangedOn,
      errors_changed_by                                                                                      as ErrorsChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_on                                                                                             as CreatedOn,
      @Semantics.user.createdBy: true
      created_by                                                                                             as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      changed_on                                                                                             as ChangedOn,
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by                                                                                             as ChangedBy
}
