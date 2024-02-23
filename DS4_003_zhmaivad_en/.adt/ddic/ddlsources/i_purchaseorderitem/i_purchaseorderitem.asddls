@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Purchase Order Item'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IMMPURCHORDRITEM'
@AbapCatalog.preserveKey:true 
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.representativeKey: 'PurchaseOrderItem'
@ObjectModel.uniqueIdField: 'PurchaseOrderItemUniqueID'
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@AccessControl.privilegedAssociations:  [ '_ManualDeliveryAddress', '_ReferenceDeliveryAddress' ]

define view I_PurchaseOrderItem
  as select from I_PurchasingDocumentItem 

  association [1..1] to I_PurchaseOrder               as _PurchaseOrder               on  $projection.PurchaseOrder = _PurchaseOrder.PurchaseOrder
  association [1..*] to I_PurOrdPricingElement        as _PurchaseOrderPricingElement on  $projection.PurchaseOrder     = _PurchaseOrderPricingElement.PurchaseOrder
                                                                                      and $projection.PurchaseOrderItem = _PurchaseOrderPricingElement.PurchaseOrderItem
  association [1..1] to I_PurchaseOrderItemCalcFields as _PurchaseOrderItemCalcFields on  $projection.PurchaseOrder     = _PurchaseOrderItemCalcFields.PurchaseOrder
                                                                                      and $projection.PurchaseOrderItem = _PurchaseOrderItemCalcFields.PurchaseOrderItem
  association [0..1] to I_Material                   as _Material                 on  $projection.Material = _Material.Material
 
{
      //Key
      @ObjectModel.foreignKey.association: '_PurchaseOrder'
  key PurchasingDocument                                     as PurchaseOrder,
  key cast (PurchasingDocumentItem as vdm_purchaseorderitem preserving type) as PurchaseOrderItem,  
      PurchasingDocumentItemUniqueID as PurchaseOrderItemUniqueID,
      
      @ObjectModel.foreignKey.association: '_PurgDocumentCategory'
      PurchasingDocumentCategory                             as PurchaseOrderCategory,

      @Semantics.currencyCode: true
      DocumentCurrency,

      PurchasingDocumentDeletionCode,

      //Product
      @ObjectModel.foreignKey.association: '_MaterialGroup'
      MaterialGroup,

      @ObjectModel.foreignKey.association: '_Material'
  
      Material,
      MaterialType,
      SupplierMaterialNumber,
      SupplierSubrange,
      ManufacturerPartNmbr,
      Manufacturer,

      @ObjectModel.foreignKey.association: '_ManufacturerMaterial'
      ManufacturerMaterial,

      PurchasingDocumentItemText                             as PurchaseOrderItemText,

      @ObjectModel.foreignKey.association: '_ProductType'
      ProductType,

      @ObjectModel.foreignKey.association: '_CompanyCode'
      CompanyCode,

      @ObjectModel.foreignKey.association: '_Plant'
      Plant,

      @ObjectModel.foreignKey.association: '_ManualDeliveryAddress'
      ManualDeliveryAddressID,

      @ObjectModel.foreignKey.association: '_ReferenceDeliveryAddress'
      ReferenceDeliveryAddressID,

      @ObjectModel.foreignKey.association: '_Customer'
      Customer,
      
      @ObjectModel.foreignKey.association: '_Subcontractor'
      Subcontractor,
 
      SupplierIsSubcontractor,
            
      @ObjectModel.foreignKey.association: '_ConfigurableProduct'
      CrossPlantConfigurableProduct,
      
      //@ObjectModel.foreignKey.association: '_ProductCategory'
      ArticleCategory,
      
      PlndOrderReplnmtElmntType,
      
      @Semantics.unitOfMeasure: true
      ProductPurchasePointsQtyUnit,
      
      @Semantics.quantity.unitOfMeasure: 'ProductPurchasePointsQtyUnit'
      @DefaultAggregation: #NONE
      ProductPurchasePointsQty,            

      @ObjectModel.foreignKey.association: '_StorageLocation'
      StorageLocation,

      @Semantics.unitOfMeasure:true
      @ObjectModel.foreignKey.association: '_OrderQuantityUnit'
      OrderQuantityUnit                                      as PurchaseOrderQuantityUnit,

      OrderItemQtyToBaseQtyNmrtr,

      OrderItemQtyToBaseQtyDnmntr,

      @Semantics.quantity.unitOfMeasure: 'OrderPriceUnit'
      NetPriceQuantity,

      IsCompletelyDelivered,

      IsFinallyInvoiced,

      GoodsReceiptIsExpected,
      
      OutwardDeliveryIsComplete, 
      
      InvoiceIsExpected,

      InvoiceIsGoodsReceiptBased,

      @ObjectModel.foreignKey.association: '_PurchaseContractItem'
      PurchaseContractItem,

      @ObjectModel.foreignKey.association: '_PurchaseContract'
      PurchaseContract,

      @ObjectModel.foreignKey.association: '_PurchaseRequisition'
      PurchaseRequisition,
      
      RequirementTracking,
      
      IsOrderAcknRqd,

      @ObjectModel.foreignKey.association: '_PurchaseRequisitionItem'
      PurchaseRequisitionItem,
      
      RequestForQuotation,
      
      RequestForQuotationItem,
      
      SupplierQuotation,
      
      SupplierQuotationItem,

      EvaldRcptSettlmtIsAllowed,

      UnlimitedOverdeliveryIsAllowed,

      OverdelivTolrtdLmtRatioInPct,

      UnderdelivTolrtdLmtRatioInPct,

      RequisitionerName,
      
      MRPArea,
       
      PlannedDeliveryDurationInDays,
      
      GoodsReceiptDurationInDays,
      
      PartialDeliveryIsAllowed,
      
      ConsumptionPosting,

      @ObjectModel.foreignKey.association: '_ServicePerformer'
      ServicePerformer,

      ServicePackage,

      @Semantics.unitOfMeasure: true
      BaseUnit,

      @ObjectModel.foreignKey.association: '_PurgDocumentItemCategory'
      PurchasingDocumentItemCategory                         as PurchaseOrderItemCategory,

      ProfitCenter,

      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_OrderPriceUnit'
      OrderPriceUnit,

      @Semantics.unitOfMeasure: true
      VolumeUnit                                             as ItemVolumeUnit,

      @Semantics.unitOfMeasure: true
      WeightUnit                                             as ItemWeightUnit,

      MultipleAcctAssgmtDistribution,

      PartialInvoiceDistribution,

      PricingDateControl,

      IsStatisticalItem,
      
      PurchasingParentItem,
      
      GoodsReceiptLatestCreationDate,

      IsReturnsItem,
      
      PurchasingOrderReason,

      @ObjectModel.foreignKey.association: '_IncotermsClassification'
      IncotermsClassification,

      IncotermsTransferLocation,

      IncotermsLocation1,

      IncotermsLocation2,

      @ObjectModel.foreignKey.association: '_PriorSupplier'
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

      @ObjectModel.foreignKey.association: '_PurchasingInfoRecord'
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

      //    ekpo.ktmng as TargetQuantity,

      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      OrderQuantity,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetPriceAmount,

      //    ekpo.zwert as OutlineAgreementTargetAmount,

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
      
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NonDeductibleInputTaxAmount,
      
      StockType,

      ValuationType,

      ValuationCategory,
      
      ItemIsRejectedBySupplier,
      
      PurgDocPriceDate,
      
      IsInfoRecordUpdated,
      
      PurgDocReleaseOrderQuantity,
      
      PurgDocOrderAcknNumber,
      
      CostCenter,
      
      GLAccount,
      
      WBSElementInternalID,
      
      Fund,
      
      BudgetPeriod,
      
      FundsCenter,
      
      CommitmentItem,
      
      FunctionalArea,
      
      GrantID,

         EarmarkedFunds,
      EarmarkedFundsDocument,
      
      EarmarkedFundsItem,
      EarmarkedFundsDocumentItem,
      
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
      ExpectedOverallLimitAmount,
      OverallLimitAmount,
      PurContractForOverallLimit,
      
      RequirementSegment,
      
      // Brazil Extension
      @ObjectModel.foreignKey.association: '_BR_MaterialOrigin'
      BR_MaterialOrigin,
      
      @ObjectModel.foreignKey.association: '_BR_MaterialUsage'
      BR_MaterialUsage,
      
      @ObjectModel.foreignKey.association: '_BR_CFOPCategory'
      BR_CFOPCategory,
      
      @ObjectModel.foreignKey.association: '_BR_NCM'
      BR_NCM,
      
      ConsumptionTaxCtrlCode,
      
      BR_IsProducedInHouse,
      
      ThirdPtyOrdProcgExtReference,
      
      ThirdPtyOrdProcgExtRefItem,
      

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _PurchaseOrderPricingElement,
      _PurchaseOrder,
      _DocumentCurrency,
      _PurchaseOrderItemCalcFields,
      _CompanyCode,
      _Plant,
      _StorageLocation,
      _Material,
      _ManufacturerMaterial,
      _MaterialGroup,
      _OrderPriceUnit,
      _ManualDeliveryAddress,
      _ReferenceDeliveryAddress,
      _PurgDocumentCategory,
      _PurgDocumentItemCategory,
      _IncotermsClassification,
      _PriorSupplier,
      _ConsumptionPosting,
      //I_PurchasingDocumentItem._ScheduleLine,
      _PurchaseRequisitionItem,
      _PurchasingInfoRecord,
      //I_PurchasingDocumentItem._Manufacturer,
      _Customer,
      _Subcontractor,
      _ConfigurableProduct,
      _PurchaseRequisition,
      _PurchaseContract,
      _PurchaseContractItem,
      _ServicePerformer,
      _OrderQuantityUnit,
      _ProductType,
      _AllocationTable,
      _AllocationTableItem,
      _RetailPromotion,
      
      //Associations for Brazilian specific fields
      _BR_MaterialOrigin,
      _BR_MaterialUsage,
      _BR_CFOPCategory,
      _BR_NCM

}
where 
  PurchasingDocumentCategory = 'F' 
  and IsEndOfPurposeBlocked = '' 
  
  
  
  
  
  
  
