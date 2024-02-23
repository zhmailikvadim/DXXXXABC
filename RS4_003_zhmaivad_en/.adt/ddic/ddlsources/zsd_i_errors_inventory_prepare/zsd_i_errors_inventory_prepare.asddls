/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Errors Inventory Postings Batch WMS->S4'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity zsd_i_errors_inventory_prepare
  as select from zsd_i_errors_inventory_pst_bas as AifErrorsBase
  association to zsd_i_errors_inventory_btw_art as _MovementBetweenArticles   on $projection.Msgguid = _MovementBetweenArticles.Msgguid
  association to zsd_i_errors_inventory_btw_str as _MovementBetweenStorageLoc on $projection.Msgguid = _MovementBetweenStorageLoc.Msgguid
  association to zsd_i_errors_inventory_btw_stp as _MovementBetweenStockTypes on $projection.Msgguid = _MovementBetweenStockTypes.Msgguid
  association to zsd_i_errors_inventory_btw_so  as _MovementBetweenSalesOrder on $projection.Msgguid = _MovementBetweenSalesOrder.Msgguid
{
  key Msgguid,
      WmsDate,
      AifErrorsBase.Plant,
      StorageLocation,
      Product,
      SalesOrder,
      SalesOrderItem,
      StockType,
      MovementType,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      Quantity,
      BaseUnit,
      _MovementBetweenStorageLoc.ReceivingStorageLocation,
      left(_MovementBetweenArticles.ReceivingArticle, 40) as ReceivingArticle,
      _MovementBetweenStockTypes.MoveTo,
      _MovementBetweenSalesOrder.ReceivingSalesOrder,
      _MovementBetweenSalesOrder.ReceivingSalesOrderItem,
      case when
          coalesce(_MovementBetweenArticles.Quantity,   0) > 0 or
          coalesce(_MovementBetweenStorageLoc.Quantity, 0) > 0 or
          coalesce(_MovementBetweenStockTypes.Quantity, 0) > 0 or
          coalesce(_MovementBetweenSalesOrder.Quantity, 0) > 0
      then -1 else 1 end                                  as Sign
}
