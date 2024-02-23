/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Timing Errors Base'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_errors_timing_aj_base
  as select from zsd_i_mat_doc_timing_adj_rows
{
  key MaterialDocument,
  key MaterialDocumentItem,
  key MaterialDocumentYear,
      DocumentDate,
      Article,
      Plant,
      StorageLocation,
      SalesOrderNumber,
      SalesOrderItem,
      StockType,
      TimingAdjustment             as Quantity,
      SapTimeStamp,
      WmsTimeStamp,
      WmsDocCreationTimeStamp,
      SapDocCreationTimeStamp,
      GoodsMovementType,
      DebitCreditCode,
      MaterialBaseUnit,
      QuantityInEntryUnit,
      EntryUnit,
      PostingDate,
      SapDocCreationDate,
      SapDocCreationTime,
      CreatedByUser,
      WmsDocCreationDate,
      WmsDocCreationTime,
      CompanyCodeCurrency,
      PurchaseOrder,
      PurchaseOrderItem,
      OrderItem,
      DeliveryDocument,
      DeliveryDocumentItem,
      CompanyCode,
      IssgOrRcvgMaterial           as ReceivingArticle,
      IssuingOrReceivingStorageLoc as ReceivingStorageLocation,
      MaterialBaseUnit             as BaseUnit,
      ReceivingSalesOrder,
      ReceivingSalesOrderItem,
      /* Associations */
      _MaterialDocumentHeader,
      _MaterialDocumentYear
}
