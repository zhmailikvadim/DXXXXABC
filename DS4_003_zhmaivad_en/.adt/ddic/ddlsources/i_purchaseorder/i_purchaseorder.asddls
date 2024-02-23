@ClientHandling.algorithm: #SESSION_VARIABLE 
@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Purchase Order'
@AccessControl.authorizationCheck:#CHECK
@VDM.viewType : #BASIC
@AbapCatalog.sqlViewName: 'IMMPURCHASEORDER'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel: {
  modelCategory: #BUSINESS_OBJECT,
  compositionRoot:true,
  semanticKey: 'PurchaseOrder',
  representativeKey: 'PurchaseOrder'
}
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@AccessControl.privilegedAssociations: [ '_SupplierAddress' ]

define view I_PurchaseOrder
  as select from I_PurchasingDocument

  association [0..1] to I_PurchasingDocumentType  as _PurchaseOrderType       on  _PurchaseOrderType.PurchasingDocumentCategory = 'F'
                                                                              and _PurchaseOrderType.PurchasingDocumentType     = $projection.PurchaseOrderType

  association [0..*] to I_PurchaseOrderItem       as _PurchaseOrderItem       on  $projection.PurchaseOrder = _PurchaseOrderItem.PurchaseOrder

  association [1..1] to I_PurchaseOrderCalcFields as _PurchaseOrderCalcFields on  $projection.PurchaseOrder = _PurchaseOrderCalcFields.PurchaseOrder

{
      //Key
  key cast (PurchasingDocument as vdm_purchaseorder preserving type) as PurchaseOrder,

      //Category
      @ObjectModel.foreignKey.association: '_PurchaseOrderType'
      cast (PurchasingDocumentType as mm_purchaseordertype preserving type ) as PurchaseOrderType,
      PurchasingDocumentSubtype                      as PurchaseOrderSubtype,
      PurchasingDocumentOrigin,
      PurchasingDocumentIsAged,

      //Admin
      CreatedByUser,
 //     @Semantics.businessDate.createdAt
      CreationDate,
      cast (PurchasingDocumentOrderDate as bedat preserving type)    as PurchaseOrderDate,
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
      Language,

      //Status
      PurchasingDocumentDeletionCode,
      ReleaseIsNotCompleted,
      PurchasingCompletenessStatus,
      PurchasingProcessingStatus,
      PurgReleaseSequenceStatus,
      ReleaseCode,  
      PurchasingReleaseStrategy,    

      //Organization
      @ObjectModel.foreignKey.association: '_CompanyCode'
      CompanyCode,
      @ObjectModel.foreignKey.association: '_PurchasingOrganization'
      PurchasingOrganization,
      @ObjectModel.foreignKey.association: '_PurchasingGroup'
      PurchasingGroup,

      //Supplier
      @ObjectModel.foreignKey.association: '_Supplier'
      Supplier,
      ManualSupplierAddressID,
      SupplierAddressID,
      SupplierRespSalesPersonName,
      SupplierPhoneNumber,
      @ObjectModel.foreignKey.association: '_SupplyingSupplier'
      SupplyingSupplier,
      @ObjectModel.foreignKey.association: '_SupplyingPlant'
      SupplyingPlant,
      @ObjectModel.foreignKey.association: '_InvoicingParty'
      InvoicingParty,
      Customer,

      //References
      CorrespncExternalReference, //Your reference
      CorrespncInternalReference, //Our reference
      
      // Contract
      PurchaseContract,
      
      // Request For Quotation
      RequestForQuotation,      
      
      //Quotation
      SupplierQuotationExternalID,

      //PaymentTerms
      @ObjectModel.foreignKey.association: '_PaymentTerms'
      PaymentTerms,
      CashDiscount1Days,
      CashDiscount2Days,
      NetPaymentDays,
      CashDiscount1Percent,
      CashDiscount2Percent,

      //DownPayment
      DownPaymentType,
      DownPaymentPercentageOfTotAmt,
      DownPaymentAmount,
      DownPaymentDueDate,

      //Incoterms
      @ObjectModel.foreignKey.association: '_IncotermsClassification'
      IncotermsClassification,
      IncotermsTransferLocation,
      @ObjectModel.foreignKey.association: '_IncotermsVersion'
      IncotermsVersion,
      IncotermsLocation1,
      IncotermsLocation2,
      
      //Intratat
      IsIntrastatReportingRelevant,
      IsIntrastatReportingExcluded,

      //Pricing
      PurchasingDocumentCondition,
      PricingProcedure,
      
      @Semantics.currencyCode
      @ObjectModel.foreignKey.association: '_DocumentCurrency'
      DocumentCurrency,

      ValidityStartDate,
      ValidityEndDate,

      @Consumption.hidden: true 
      ExchangeRate,
      ExchangeRateIsFixed,
      
      LastChangeDateTime,
      IsEndOfPurposeBlocked,

      TaxReturnCountry,
      VATRegistrationCountry,
      PurgReasonForDocCancellation,
      PurgReleaseTimeTotalAmount,

      //_CompanyCode.FiscalYearVariant as FiscalYearVariant,

      // Associations

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _PurchaseOrderItem,
      _PurchaseOrderType,
      _CompanyCode,
      _CreatedByUser,
      _Supplier,
      _SupplyingSupplier,
      _InvoicingParty,
      _PurchasingOrganization,
      _PurchasingGroup,
      _DocumentCurrency,
      _IncotermsClassification,
      _IncotermsVersion,
      _SupplyingPlant,
      _PaymentTerms,
      _SupplierAddress,
      _Language,

      _PurchaseOrderCalcFields

      //Missing Associations

      //_AllContacts
      // Partner
      //Conditions
      //PricingProcedure
}
where
      I_PurchasingDocument.PurchasingDocumentCategory = 'F'
  and I_PurchasingDocument.PurchasingDocumentIsAged   = ''   
  and IsEndOfPurposeBlocked = ''
 