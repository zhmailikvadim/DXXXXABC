@AbapCatalog.sqlViewName: 'ZSDCACTSTOCKROW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Actual Stock Row Type'
@OData.publish: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZSD_C_ACTUAL_STOCK_RT as select from zsd_i_actual_sap_stock_row_typ
{
    key SapSnapshotDate,
    key Plant,
    key StorageLocation,
    key Article,
    StockType,
    SapStockQuantity,
    Meins,
    SapTimeStamp
} 
 