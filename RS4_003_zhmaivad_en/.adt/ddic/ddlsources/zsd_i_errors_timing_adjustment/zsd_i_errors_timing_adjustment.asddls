/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Errors Inventory Postings Batch WMS->S4'
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zsd_i_errors_timing_adjustment
  as select from zsd_i_errors_timing_aj_prepare as AifErrorsBase
{
  key               DocumentDate,
  key               AifErrorsBase.Plant,
  key               StorageLocation,
  key               Article,
  key               SalesOrderNumber,
  key               SalesOrderItem,
  key               StockType,
                    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
                    Sign * Quantity as Quantity,
                    BaseUnit
}
union select from zsd_i_errors_timing_aj_prepare as AifErrorsBase
{
  key               DocumentDate,
  key               AifErrorsBase.Plant,
  key               ReceivingStorageLocation as StorageLocation,
  key               Article,
  key               SalesOrderNumber,
  key               SalesOrderItem,
  key               StockType,
                    Quantity,
                    BaseUnit
}
where
  ReceivingStorageLocation <> ''
union select from zsd_i_errors_timing_aj_prepare as AifErrorsBase
{
  key               DocumentDate,
  key               AifErrorsBase.Plant,
  key               StorageLocation,
  key               ReceivingArticle as Article,
  key               SalesOrderNumber,
  key               SalesOrderItem,
  key               StockType,
                    Quantity,
                    BaseUnit
}
where
  ReceivingArticle <> ''
union select from zsd_i_errors_timing_aj_prepare as AifErrorsBase
{
  key               DocumentDate,
  key               AifErrorsBase.Plant,
  key               StorageLocation,
  key               Article,
  key               SalesOrderNumber,
  key               SalesOrderItem,
  key               MoveTo as StockType,
                    Quantity,
                    BaseUnit
}
where
  MoveTo <> ''
union select from zsd_i_errors_timing_aj_prepare as AifErrorsBase
{
  key               DocumentDate,
  key               AifErrorsBase.Plant,
  key               StorageLocation,
  key               Article,
  key               ReceivingSalesOrder     as SalesOrderNumber,
  key               ReceivingSalesOrderItem as SalesOrderItem,
  key               StockType,
                    Quantity,
                    BaseUnit
}
where
  ReceivingSalesOrder <> ''
