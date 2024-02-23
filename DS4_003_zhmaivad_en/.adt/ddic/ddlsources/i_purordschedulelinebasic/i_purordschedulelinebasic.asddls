@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Purchasing Document Schedule Line Basic'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IMMPURORDSLBASIC'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.representativeKey: 'PurchaseOrderScheduleLine'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

define view I_PurOrdScheduleLineBasic
  as select from I_PurgDocScheduleLineBasic
  inner join I_PurchaseOrder on I_PurgDocScheduleLineBasic.PurchasingDocument = I_PurchaseOrder.PurchaseOrder 

  association [1..1] to I_PurchaseOrder           as _PurchaseOrder             on  $projection.PurchaseOrder        = _PurchaseOrder.PurchaseOrder
  association [1..1] to I_PurchaseOrderItem       as _PurchaseOrderItem         on  $projection.PurchaseOrder        = _PurchaseOrderItem.PurchaseOrder
                                                                                and $projection.PurchaseOrderItem    = _PurchaseOrderItem.PurchaseOrderItem
 
 {
  key PurchasingDocument     as PurchaseOrder,
  key PurchasingDocumentItem as PurchaseOrderItem,
  key ScheduleLine as PurchaseOrderScheduleLine,
ScheduleLine,

      @ObjectModel: { foreignKey.association: '_DeliveryDateCategory'}
      DelivDateCategory,
      ScheduleLineDeliveryDate,
      SchedLineStscDeliveryDate,
      PerformancePeriodStartDate,
      PerformancePeriodEndDate,
      ScheduleLineDeliveryTime,
      ScheduleLineOrderQuantity,
      RoughGoodsReceiptQty,

      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_PurchaseOrderQuantityUnit'
      OrderQuantityUnit as PurchaseOrderQuantityUnit,

      @ObjectModel.foreignKey.association: '_PurchaseRequisition'
       PurchaseRequisition,

      @ObjectModel.foreignKey.association: '_PurchaseRequisitionItem'
      PurchaseRequisitionItem,

      SourceOfCreation,
      PrevDelivQtyOfScheduleLine,
      NoOfRemindersOfScheduleLine,
      ScheduleLineIsFixed,
      ScheduleLineCommittedQuantity,
      Reservation,
      ProductAvailabilityDate, 
      MaterialStagingTime,
      TransportationPlanningDate,
      TransportationPlanningTime, 
      LoadingDate,
      LoadingTime,
      GoodsIssueDate,
      GoodsIssueTime,
      STOLatestPossibleGRDate,
      STOLatestPossibleGRTime, 
      StockTransferDeliveredQuantity,
      ScheduleLineIssuedQuantity,
      Batch,
      BatchBySupplier,
      
      _PurchaseRequisition,
      _PurchaseRequisitionItem,
      _DeliveryDateCategory,
      _PurchaseOrder,
      _PurchaseOrderItem,
      _OrderQuantityUnit as _PurchaseOrderQuantityUnit

}

