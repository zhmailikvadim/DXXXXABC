@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: 'IMMPURORDSLAPI01'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType : #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@EndUserText.label: 'Schedule Line in Purchase Order'
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.representativeKey: 'PurchaseOrderScheduleLine'
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET ]
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@Metadata.ignorePropagatedAnnotations:true

define view I_PurOrdScheduleLineAPI01
  as select from I_PurOrdScheduleLineBasic

  association [1..1] to I_PurchaseOrderAPI01        as _PurchaseOrder           on  $projection.PurchaseOrder = _PurchaseOrder.PurchaseOrder
  association [1..1] to I_PurchaseOrderItemAPI01    as _PurchaseOrderItem       on  $projection.PurchaseOrder     = _PurchaseOrderItem.PurchaseOrder
                                                                                and $projection.PurchaseOrderItem = _PurchaseOrderItem.PurchaseOrderItem
  association [0..*] to I_POSubcontractingCompAPI01 as _SubcontractingComponent on  $projection.PurchaseOrder             = _SubcontractingComponent.PurchaseOrder
                                                                                and $projection.PurchaseOrderItem         = _SubcontractingComponent.PurchaseOrderItem
                                                                                and $projection.PurchaseOrderScheduleLine = _SubcontractingComponent.PurchaseOrderScheduleLine



{
      @ObjectModel.foreignKey.association: '_PurchaseOrder'
  key PurchaseOrder,
      @ObjectModel.foreignKey.association: '_PurchaseOrderItem'
  key PurchaseOrderItem,
  key PurchaseOrderScheduleLine,
      PerformancePeriodStartDate,
      PerformancePeriodEndDate,


      DelivDateCategory,
      ScheduleLineDeliveryDate,
      ScheduleLineDeliveryTime,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      ScheduleLineOrderQuantity,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      RoughGoodsReceiptQty,

      @Semantics.unitOfMeasure: true
      PurchaseOrderQuantityUnit,

      PurchaseRequisition,

      PurchaseRequisitionItem,

      SourceOfCreation,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      PrevDelivQtyOfScheduleLine,
      NoOfRemindersOfScheduleLine,
      ScheduleLineIsFixed,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
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
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      StockTransferDeliveredQuantity,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      ScheduleLineIssuedQuantity,
      Batch,

      _PurchaseOrder,
      _PurchaseOrderItem,
      _SubcontractingComponent
}
