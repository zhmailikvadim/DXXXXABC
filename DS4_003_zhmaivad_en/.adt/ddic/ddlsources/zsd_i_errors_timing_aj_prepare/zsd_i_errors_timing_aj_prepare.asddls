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
define view entity zsd_i_errors_timing_aj_prepare
  as select from zsd_i_errors_timing_aj_base as AifErrorsBase
  association to zsd_i_errors_timing_aj_btw_art as _MovementBetweenArticles   on  $projection.MaterialDocument     = _MovementBetweenArticles.MaterialDocument
                                                                              and $projection.MaterialDocumentYear = _MovementBetweenArticles.MaterialDocumentYear
                                                                              and $projection.MaterialDocumentItem = _MovementBetweenArticles.MaterialDocumentItem
  association to zsd_i_errors_timing_aj_btw_str as _MovementBetweenStorageLoc on  $projection.MaterialDocument     = _MovementBetweenStorageLoc.MaterialDocument
                                                                              and $projection.MaterialDocumentYear = _MovementBetweenStorageLoc.MaterialDocumentYear
                                                                              and $projection.MaterialDocumentItem = _MovementBetweenStorageLoc.MaterialDocumentItem
  association to zsd_i_errors_timing_aj_btw_stp as _MovementBetweenStockTypes on  $projection.MaterialDocument     = _MovementBetweenStockTypes.MaterialDocument
                                                                              and $projection.MaterialDocumentYear = _MovementBetweenStockTypes.MaterialDocumentYear
                                                                              and $projection.MaterialDocumentItem = _MovementBetweenStockTypes.MaterialDocumentItem
  association to zsd_i_errors_timing_aj_btw_so  as _MovementBetweenSalesOrder on  $projection.MaterialDocument     = _MovementBetweenSalesOrder.MaterialDocument
                                                                              and $projection.MaterialDocumentYear = _MovementBetweenSalesOrder.MaterialDocumentYear
                                                                              and $projection.MaterialDocumentItem = _MovementBetweenSalesOrder.MaterialDocumentItem
{
  key      MaterialDocument,
  key      MaterialDocumentYear,
  key      MaterialDocumentItem,
           DocumentDate,
           Plant,
           StorageLocation,
           Article,
           SalesOrderNumber,
           SalesOrderItem,
           StockType,
           GoodsMovementType,
           @Semantics.quantity.unitOfMeasure: 'BaseUnit'
           Quantity,
           BaseUnit,
           _MovementBetweenStorageLoc.ReceivingStorageLocation,
           left(_MovementBetweenArticles.ReceivingArticle, 40) as ReceivingArticle,
           _MovementBetweenStockTypes.MoveTo,
           _MovementBetweenSalesOrder.ReceivingSalesOrder,
           _MovementBetweenSalesOrder.ReceivingSalesOrderItem,
           case when
               coalesce(_MovementBetweenArticles.Quantity,0)   > 0
           or  coalesce(_MovementBetweenStorageLoc.Quantity,0) > 0
           or coalesce(_MovementBetweenStockTypes.Quantity,0)  > 0
           or coalesce(_MovementBetweenSalesOrder.Quantity,0)  > 0
           then -1 else 1 end                                  as Sign
}
