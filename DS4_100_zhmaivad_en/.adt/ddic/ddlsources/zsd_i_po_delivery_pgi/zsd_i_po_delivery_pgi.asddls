@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase order, Delivery, PGI'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_po_delivery_pgi
  as select from I_DeliveryDocumentItem    as deliverydocumentitem
    inner join   I_PurchaseOrderItemAPI01  as purchaseorderitem on  purchaseorderitem.PurchaseOrder     = deliverydocumentitem.ReferenceSDDocument
                                                                and purchaseorderitem.PurchaseOrderItem = right(
      deliverydocumentitem.ReferenceSDDocumentItem, 5
    )
    inner join   I_PurOrdScheduleLineAPI01 as scheduleline      on  scheduleline.PurchaseOrder     = purchaseorderitem.PurchaseOrder
                                                                and scheduleline.PurchaseOrderItem = purchaseorderitem.PurchaseOrderItem
{
  key deliverydocumentitem.DeliveryDocument,
  key deliverydocumentitem.DeliveryDocumentItem,
      purchaseorderitem.PurchaseOrder,
      purchaseorderitem.PurchaseOrderItem,
      scheduleline.PurchaseOrderScheduleLine,
      scheduleline.PurchaseOrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      scheduleline.ScheduleLineOrderQuantity      as ScheduledQty,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      scheduleline.StockTransferDeliveredQuantity as DeliveredQty,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      scheduleline.ScheduleLineIssuedQuantity     as IssuedQty,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      scheduleline.RoughGoodsReceiptQty           as GoodsReceiptQty,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      deliverydocumentitem.ActualDeliveryQuantity

}
where
      purchaseorderitem.PurchaseOrder        = '4900002207'
  and scheduleline.ScheduleLineOrderQuantity > 0
