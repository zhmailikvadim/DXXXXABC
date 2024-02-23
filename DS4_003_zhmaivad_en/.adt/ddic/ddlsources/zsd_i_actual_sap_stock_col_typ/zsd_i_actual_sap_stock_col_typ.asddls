/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 19611     : [Feature] [Build] - Stock re *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock of Materials'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #MIXED
}
define view entity zsd_i_actual_sap_stock_col_typ
  as select distinct from zsd_i_nsdm_v_mska
{
  key        $session.system_date                    as SapSnapshotDate,
  key        werks                                   as Plant,
  key        lgort                                   as StorageLocation,
  key        cast( matnr  as matnr preserving type ) as Article,
  key        vbeln                                   as SalesOrderNumber,
  key        posnr                                   as SalesOrderItem,
             @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
             kalab                                   as UuQty,
             @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
             kains                                   as QiQty,
             @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
             kaspe                                   as BlQty,
             BaseUnit                                as UnitOfMeasure,
             tstmp_current_utctimestamp()            as SapTimeStamp
}
union select distinct from zsd_i_nsdm_v_mard
{
  key  $session.system_date                      as SapSnapshotDate,
  key  werks                                     as Plant,
  key  lgort                                     as StorageLocation,
  key  cast( matnr  as matnr preserving type )   as Article,
  key  ''                                        as SalesOrderNumber,
  key  cast( '000000' as posnr preserving type ) as SalesOrderItem,
       labst                                     as UuQty,
       insme                                     as QiQty,
       speme                                     as BlQty,
       BaseUnit                                  as UnitOfMeasure,
       tstmp_current_utctimestamp()              as SapTimeStamp
}
