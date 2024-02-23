//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED

@EndUserText.label: 'Purchase Contract Item'

@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

@ObjectModel.semanticKey:  [ 'PurchaseContract','PurchaseContractItem' ]
@ObjectModel.representativeKey: 'PurchaseContractItem'

@ObjectModel.usageType:{
  serviceQuality: #C,
  sizeCategory: #L,
  dataClass: #TRANSACTIONAL
}

@Metadata.ignorePropagatedAnnotations: true

define view entity R_PurchaseContractItemTP
  as select from I_PurchaseContractItem

  composition [0..*] of R_PurContrAccountTP       as _PurCtrAccount
  composition [0..1] of R_PurContrAddressTP       as _PurCtrAddress
  composition [0..*] of R_PurContrItemNotesTP     as _PurCtrItNotes
  composition [1..*] of R_PurContrItemCndnValdtyTP as _PurContrItemCndnValdty

  association to parent R_PurchaseContractTP      as _PurchaseContract on $projection.PurchaseContract = _PurchaseContract.PurchaseContract

 ----Extension Association
  association [1..1] to E_PurchasingDocumentItem      as _PurchasingDocumentItem      on  $projection.PurchaseContract     = _PurchasingDocumentItem.PurchasingDocument
                                                                                      and $projection.PurchaseContractItem = _PurchasingDocumentItem.PurchasingDocumentItem

{

      @ObjectModel.foreignKey.association: '_PurchaseContract'
  key PurchaseContract,
  key PurchaseContractItem,
      PurchaseContractItemUniqueID,
      CompanyCode,
      Material,
      ManufacturerMaterial,
      PurchaseContractItemText,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ContractNetPriceAmount,
      OrderPriceUnit,
      VolumeUnit,
      OrderQuantityUnit,
      MaterialGroup,
      Customer,
      Subcontractor,
      ReferenceDeliveryAddressID,
      ManualDeliveryAddressID,
      DeliveryAddressID,
      Plant,
      StorageLocation,
      AccountAssignmentCategory,
      GoodsReceiptIsExpected,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      NetPriceQuantity,
      MultipleAcctAssgmtDistribution,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      TargetQuantity,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      TargetAmount,
      DocumentCurrency,
      OrdPriceUnitToOrderUnitDnmntr,
      OrderPriceUnitToOrderUnitNmrtr,
      PurchasingDocumentItemCategory,
      SupplierMaterialNumber,
      EvaldRcptSettlmtIsAllowed,
      UnderdelivTolrtdLmtRatioInPct,
      PriceIsToBePrinted,
      SupplierConfirmationControlKey,
      OverdelivTolrtdLmtRatioInPct,
      UnlimitedOverdeliveryIsAllowed,
      InvoiceIsExpected,
      InvoiceIsGoodsReceiptBased,
      PurgDocPriceDate,
      PurchasingInfoRecordUpdateCode,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      PurgDocReleaseOrderQuantity,
      PurgDocOrderAcknNumber,
      PurgDocEstimatedPrice as PurchasingPriceIsEstimated,
      IsInfoAtRegistration,
      NoDaysReminder1,
      NoDaysReminder2,
      NoDaysReminder3,
      StockType,
      TaxCode,
      TaxCountry,
      TaxDeterminationDate,
      RequirementTracking,
      IsOrderAcknRqd,
      ShippingInstruction,
      GoodsReceiptIsNonValuated,
      ServicePerformer,
      ProductTypeCode,
      MaterialType,
      PurchaseContractItemFormatted,
      PurchasingContractDeletionCode,
      PurchaseRequisition,
      PurchaseRequisitionItem,
      PartialInvoiceDistribution,
      ManufacturerPartNmbr,
      Manufacturer,
      PurchasingCategory,
      PurgCatName,
      PurchaseContractType,
      PurchasingOrganization,
      PurchasingGroup,
      PurgProdCmplncSupplierStatus,
      @Semantics.systemDateTime.lastChangedAt: true
      _PurchaseContract.LastChangeDateTime as LastChangeDateTime,
      /* Associations */
      _PurchaseContract,
      _PurCtrAccount,
      _PurCtrAddress,
      _PurCtrItNotes,
      _PurContrItemCndnValdty
}
