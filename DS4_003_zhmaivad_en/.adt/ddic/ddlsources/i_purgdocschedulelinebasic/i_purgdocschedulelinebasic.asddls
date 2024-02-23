@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Purchasing Document Schedule Line Basic'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IMMPRGDOCSLBASIC'
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

define view I_PurgDocScheduleLineBasic
  as select from eket as eket 

  association [1..1] to I_PurchasingDocument      as _PurchasingDocument        on  $projection.PurchasingDocument        = _PurchasingDocument.PurchasingDocument
  association [1..1] to I_PurchasingDocumentItem  as _PurchasingDocumentItem    on  $projection.PurchasingDocument        = _PurchasingDocumentItem.PurchasingDocument
                                                                                and $projection.PurchasingDocumentItem    = _PurchasingDocumentItem.PurchasingDocumentItem
  association [0..1] to I_UnitOfMeasure           as _OrderQuantityUnit         on  $projection.OrderQuantityUnit         = _OrderQuantityUnit.UnitOfMeasure
  association [0..1] to I_Purchaserequisition     as _PurchaseRequisition       on  $projection.PurchaseRequisition       = _PurchaseRequisition.PurchaseRequisition
  association [0..1] to I_Purchaserequisitionitem as _PurchaseRequisitionItem   on  $projection.PurchaseRequisition       = _PurchaseRequisitionItem.PurchaseRequisition
                                                                                and $projection.PurchaseRequisitionItem   = _PurchaseRequisitionItem.PurchaseRequisitionItem
  association [1..1] to I_Deliverydatecategory    as _DeliveryDateCategory      on  $projection.DelivDateCategory         = _DeliveryDateCategory.DelivDateCategory
 
 {
  key eket.ebeln as PurchasingDocument,
  key eket.ebelp as PurchasingDocumentItem,
  key etenr      as ScheduleLine,

      //@ObjectModel: { foreignKey.association: '_DeliveryDateCategory'} I_DeliveryDateCategory wrong implemented
      lpein      as DelivDateCategory,
      eindt      as ScheduleLineDeliveryDate,
      slfdt      as SchedLineStscDeliveryDate,
      startdate  as PerformancePeriodStartDate,
      enddate    as PerformancePeriodEndDate,
      uzeit      as ScheduleLineDeliveryTime,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'      
      eket.menge as ScheduleLineOrderQuantity,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      wemng      as RoughGoodsReceiptQty,

      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_OrderQuantityUnit'
      _PurchasingDocumentItem.OrderQuantityUnit       as OrderQuantityUnit,

      @ObjectModel.foreignKey.association: '_PurchaseRequisition'
      eket.banfn as PurchaseRequisition,

      @ObjectModel.foreignKey.association: '_PurchaseRequisitionItem'
      eket.bnfpo as PurchaseRequisitionItem,

      estkz      as SourceOfCreation,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'      
      ameng      as PrevDelivQtyOfScheduleLine,
      eket.mahnz as NoOfRemindersOfScheduleLine,
      fixkz      as ScheduleLineIsFixed,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'      
      mng02      as ScheduleLineCommittedQuantity,
      rsnum      as Reservation,
      mbdat      as ProductAvailabilityDate, 
      mbuhr      as MaterialStagingTime,
      tddat      as TransportationPlanningDate,
      tduhr      as TransportationPlanningTime, 
      lddat      as LoadingDate,
      lduhr      as LoadingTime,
      wadat      as GoodsIssueDate,
      wauhr      as GoodsIssueTime,
      eldat      as STOLatestPossibleGRDate,
      eluhr      as STOLatestPossibleGRTime,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'       
      glmng      as StockTransferDeliveredQuantity,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'      
      wamng      as ScheduleLineIssuedQuantity,
      charg      as Batch,
      licha      as BatchBySupplier,
      
      _PurchaseRequisition,
      _PurchaseRequisitionItem,
      _DeliveryDateCategory,
      _PurchasingDocument,
      _PurchasingDocumentItem,
      _OrderQuantityUnit

}

