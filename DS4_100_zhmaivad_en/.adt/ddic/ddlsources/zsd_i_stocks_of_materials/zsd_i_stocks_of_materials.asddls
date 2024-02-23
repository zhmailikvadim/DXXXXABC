@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock of Materials'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stocks_of_materials
  as select from zsd_i_nsdm_v_mard as a
    inner join   mara              as b on a.matnr = b.matnr
{
  key  $session.system_date                      as SapSnapshotDate,
  key  a.werks                                   as Plant,
  key  a.lgort                                   as StorageLocation,
  key  cast( a.matnr  as matnr preserving type ) as Article,
  key  ''                                        as SalesOrderNumber,
  key  cast( '000000' as posnr preserving type ) as SalesOrderItem,
  key  'UU'                                      as StockType,
       @Semantics.quantity.unitOfMeasure : 'Meins'
       a.labst                                   as SapStockQuantity,

       b.meins                                   as Meins,
       tstmp_current_utctimestamp()              as SapTimeStamp

}
union select from zsd_i_nsdm_v_mard as a
  inner join      mara as b on a.matnr = b.matnr
{
  key         $session.system_date                      as SapSnapshotDate,
  key         a.werks                                   as Plant,
  key         a.lgort                                   as StorageLocation,
  key         cast( a.matnr  as matnr preserving type ) as Article,
  key         ''                                        as SalesOrderNumber,
  key         cast( '000000' as posnr preserving type ) as SalesOrderItem,
  key         'QI'                                      as StockType,
              a.insme                                   as SapStockQuantity,
              b.meins                                   as Meins,
              tstmp_current_utctimestamp()              as SapTimeStamp
}
union select from zsd_i_nsdm_v_mard as a
  inner join      mara as b on a.matnr = b.matnr
{
  key       $session.system_date                      as SapSnapshotDate,
  key       a.werks                                   as Plant,
  key       a.lgort                                   as StorageLocation,
  key       cast( a.matnr  as matnr preserving type ) as Article,
  key       ''                                        as SalesOrderNumber,
  key       cast( '000000' as posnr preserving type ) as SalesOrderItem,
  key       'BL'                                      as StockType,
            a.speme                                   as SapStockQuantity,
            b.meins                                   as Meins,
            tstmp_current_utctimestamp()              as SapTimeStamp
}
union select from mska as a
  inner join      mara as b on b.matnr = b.matnr
{
  key        $session.system_date                      as SapSnapshotDate,
  key        a.werks                                   as Plant,
  key        a.lgort                                   as StorageLocation,
  key        cast( a.matnr  as matnr preserving type ) as Article,
  key        a.vbeln                                   as SalesOrderNumber,
  key        a.posnr                                   as SalesOrderItem,
  key        'UU'                                      as StockType,
             a.kalab                                   as SapStockQuantity,

             b.meins                                   as Meins,
             tstmp_current_utctimestamp()              as SapTimeStamp

}
union select from mska as a
  inner join      mara as b on b.matnr = b.matnr
{
  key       $session.system_date                      as SapSnapshotDate,
  key       a.werks                                   as Plant,
  key       a.lgort                                   as StorageLocation,
  key       cast( a.matnr  as matnr preserving type ) as Article,
  key       a.vbeln                                   as SalesOrderNumber,
  key       a.posnr                                   as SalesOrderItem,
  key       'QI'                                      as StockType,
            a.kains                                   as SapStockQuantity,

            b.meins                                   as Meins,
            tstmp_current_utctimestamp()              as SapTimeStamp
}
union select from mska as a
  inner join      mara as b on b.matnr = b.matnr
{
  key      $session.system_date                      as SapSnapshotDate,
  key      a.werks                                   as Plant,
  key      a.lgort                                   as StorageLocation,
  key      cast( a.matnr  as matnr preserving type ) as Article,
  key      a.vbeln                                   as SalesOrderNumber,
  key      a.posnr                                   as SalesOrderItem,
  key      'BL'                                      as StockType,
           a.kaspe                                   as SapStockQuantity,
           b.meins                                   as Meins,
           tstmp_current_utctimestamp()              as SapTimeStamp
}
