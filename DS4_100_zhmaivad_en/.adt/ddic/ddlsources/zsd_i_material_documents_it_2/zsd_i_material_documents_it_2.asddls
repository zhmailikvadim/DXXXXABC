@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Document Items 2'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_material_documents_it_2
  as select from zsd_i_material_documents_items
{
  key Material,
  key Plant,
  key StorageLocation,
  key SalesOrder,
  key SalesOrderItem,
  key MaterialDocumentYear,
  key MaterialDocument,
  key MaterialDocumentItem,
  key StockType,

      @Semantics.quantity.unitOfMeasure : 'EntryUnit'
      - case when WmsDocCreationTimeStamp > wms_timestamp
           then AdjustmentQty else cast(0 as abap.quan( 13, 0 )) end as WmsTimingAdjustment,

      @Semantics.quantity.unitOfMeasure : 'EntryUnit'
      - case when SapDocCreationTimeStamp > sap_timestamp
           then AdjustmentQty else cast(0 as abap.quan( 13, 0 )) end as SapTimingAdjustment,

      @Semantics.quantity.unitOfMeasure : 'EntryUnit'
      - case when WmsDocCreationTimeStamp > wms_timestamp
           then AdjustmentQty else cast(0 as abap.quan( 13, 0 )) end
      - case when SapDocCreationTimeStamp > sap_timestamp
           then AdjustmentQty else cast(0 as abap.quan( 13, 0 )) end as TotalTimingAdjustment,

      AdjustmentQty,
      wms_timestamp,
      sap_timestamp,
      WmsDocCreationTimeStamp,
      SapDocCreationTimeStamp,
      GoodsMovementType,
      DebitCreditCode,
      QuantityInBaseUnit,
      MaterialBaseUnit,
      QuantityInEntryUnit,
      EntryUnit,
      PostingDate,
      DocumentDate,
      SapDocCreationDate,
      SapDocCreationTime,
      CreatedByUser,
      WmsDocCreationDate,
      WmsDocCreationTime,
      CompanyCodeCurrency,
      PurchaseOrder,
      PurchaseOrderItem,
      OrderItem,
      MaintOrderRoutingNumber,
      MaintOrderOperationCounter,
      DeliveryDocument,
      DeliveryDocumentItem,
      CompanyCode,
      /* Associations */
      _MaterialDocumentHeader,
      _MaterialDocumentYear
}
