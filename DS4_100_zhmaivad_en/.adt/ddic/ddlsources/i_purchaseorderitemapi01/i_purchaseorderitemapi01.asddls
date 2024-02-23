@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: 'IMMPOITEMAPI01'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType : #BASIC
@EndUserText.label: 'Purchase Order Item'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.representativeKey: 'PurchaseOrderItem'
@ObjectModel.semanticKey: ['PurchaseOrder','PurchaseOrderItem']
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET ]
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@Metadata.ignorePropagatedAnnotations:true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API


define view I_PurchaseOrderItemAPI01 
as select from R_PurchaseOrderItem

  association [1..1] to I_PurchaseOrderAPI01           as _PurchaseOrder                on  $projection.PurchaseOrder     = _PurchaseOrder.PurchaseOrder
  
  association [1..*] to I_PurOrdAccountAssignmentAPI01 as _PurOrdAcctAssignment         on  _PurOrdAcctAssignment.PurchaseOrder     = $projection.PurchaseOrder
                                                                                        and _PurOrdAcctAssignment.PurchaseOrderItem = $projection.PurchaseOrderItem
  association [1..*] to I_PurOrdScheduleLineAPI01      as _PurOrdScheduleLine           on  _PurOrdScheduleLine.PurchaseOrder     = $projection.PurchaseOrder
                                                                                        and _PurOrdScheduleLine.PurchaseOrderItem = $projection.PurchaseOrderItem
  ----Extension Association
  association [1..1] to E_PurchasingDocumentItem       as _PurchaseOrderItemExtension   on  $projection.PurchaseOrder     = _PurchaseOrderItemExtension.PurchasingDocument
                                                                                        and $projection.PurchaseOrderItem = _PurchaseOrderItemExtension.PurchasingDocumentItem
                                                                                        
 {
      //Key
  @ObjectModel.foreignKey.association: '_PurchaseOrder'    
  key PurchaseOrder,
  key PurchaseOrderItem,  
      PurchaseOrderItemUniqueID,

      PurchaseOrderCategory,

      @Semantics.currencyCode: true
      DocumentCurrency,

      PurchasingDocumentDeletionCode,
      
      PurchasingDocumentItemOrigin,

      //Product
      MaterialGroup,

      Material,
      MaterialType,
      SupplierMaterialNumber,
      SupplierSubrange,
      ManufacturerPartNmbr,
      Manufacturer,

      ManufacturerMaterial,

      PurchaseOrderItemText,

      ProductType,

      CompanyCode,

      Plant,

      ManualDeliveryAddressID,

      ReferenceDeliveryAddressID,

      Customer,
      
      Subcontractor,
 
      SupplierIsSubcontractor,
            
      CrossPlantConfigurableProduct,
      
      ArticleCategory,
      
      PlndOrderReplnmtElmntType,
      
      @Semantics.unitOfMeasure: true
      ProductPurchasePointsQtyUnit,
      
      @Semantics.quantity.unitOfMeasure: 'ProductPurchasePointsQtyUnit'
      ProductPurchasePointsQty,    
              
      StorageLocation,

      // main Quantity Unit for PO Item
      @Semantics.unitOfMeasure: true
      PurchaseOrderQuantityUnit,

      OrderItemQtyToBaseQtyNmrtr,

      OrderItemQtyToBaseQtyDnmntr,

      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      NetPriceQuantity,

      IsCompletelyDelivered,

      IsFinallyInvoiced,

      GoodsReceiptIsExpected,

      InvoiceIsExpected,

      InvoiceIsGoodsReceiptBased,

      PurchaseContractItem,

      PurchaseContract,

      PurchaseRequisition,
      
      RequirementTracking,

      PurchaseRequisitionItem,

      EvaldRcptSettlmtIsAllowed,

      UnlimitedOverdeliveryIsAllowed,

      OverdelivTolrtdLmtRatioInPct,

      UnderdelivTolrtdLmtRatioInPct,

      RequisitionerName,
       
      PlannedDeliveryDurationInDays,
      
      GoodsReceiptDurationInDays,
      
      PartialDeliveryIsAllowed,
      
      ConsumptionPosting,

      ServicePerformer,

      BaseUnit,

      PurchaseOrderItemCategory,

      ProfitCenter,

      OrderPriceUnit,

      @Semantics.unitOfMeasure: true
      ItemVolumeUnit,

      @Semantics.unitOfMeasure: true
      ItemWeightUnit,

      MultipleAcctAssgmtDistribution,

      PartialInvoiceDistribution,

      PricingDateControl,

      IsStatisticalItem,
      
      PurchasingParentItem,
      
      GoodsReceiptLatestCreationDate,

      IsReturnsItem,
      
      PurchasingOrderReason,

      IncotermsClassification,

      IncotermsTransferLocation,

      IncotermsLocation1,

      IncotermsLocation2,

      PriorSupplier,

      InternationalArticleNumber,
      
      IntrastatServiceCode,
      
      CommodityCode,
      
      MaterialFreightGroup,
      
      DiscountInKindEligibility,
      
      PurgItemIsBlockedForDelivery,

      //ConfirmationControl,

      SupplierConfirmationControlKey,

      PriceIsToBePrinted,

      AccountAssignmentCategory,

      PurchasingInfoRecord,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetAmount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      GrossAmount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      EffectiveAmount,
      
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Subtotal1Amount,
     
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Subtotal2Amount,
      
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Subtotal3Amount,
      
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Subtotal4Amount,
      
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Subtotal5Amount,
      
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Subtotal6Amount,

      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'      
      OrderQuantity,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetPriceAmount,

      @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
      ItemVolume,

      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ItemGrossWeight,

      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ItemNetWeight,

      OrderPriceUnitToOrderUnitNmrtr,

      OrdPriceUnitToOrderUnitDnmntr,

      GoodsReceiptIsNonValuated,

      TaxCode,

      TaxJurisdiction,

      ShippingInstruction,
      
      ShippingType,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NonDeductibleInputTaxAmount,
      
      StockType,

      ValuationType,

      ValuationCategory,
      
      ItemIsRejectedBySupplier,
      
      PurgDocPriceDate,
      
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      PurgDocReleaseOrderQuantity,

      @API.element.releaseState: #DEPRECATED
      @API.element.successor: 'EarmarkedFundsDocument'
      EarmarkedFunds,
      
      EarmarkedFundsDocument,

      @API.element.releaseState: #DEPRECATED
      @API.element.successor: 'EarmarkedFundsDocumentItem'
      EarmarkedFundsItem,
      
      EarmarkedFundsDocumentItem,
      
      PartnerReportedBusinessArea,
      
      InventorySpecialStockType,
      
      DeliveryDocumentType,
      
      IssuingStorageLocation,
      
      AllocationTable,
      
      AllocationTableItem,
      
      RetailPromotion,

      // Down Payment
      DownPaymentType,
      
      DownPaymentPercentageOfTotAmt,
      
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      DownPaymentAmount,
      
      DownPaymentDueDate,
      
      // S/4 Limit
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ExpectedOverallLimitAmount,
      @Semantics.amount.currencyCode: 'DocumentCurrency'      
      OverallLimitAmount,
      
      RequirementSegment,
      
      SubcontrgCompIsRealTmeCnsmd,
      
      // Brazil Extension
      BR_MaterialOrigin,
      
      BR_MaterialUsage,
      
      BR_CFOPCategory,
      
      BR_NCM,
      
      BR_IsProducedInHouse,

      _PurchaseOrder,
      
      _PurOrdScheduleLine,
      
      _PurOrdAcctAssignment
}
