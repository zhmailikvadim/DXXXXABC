@AbapCatalog.sqlViewName: 'ZSDIACTSAPSTOCKR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock of Materials Rows'
define view zsd_i_actual_sap_stock_row_typ   as select from zsd_i_nsdm_v_mard as a
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
 