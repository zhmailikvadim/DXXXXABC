@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: 'IMMPURORDAPI01'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType : #BASIC
@EndUserText.label: 'Purchase Order'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.representativeKey: 'PurchaseOrder'
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET ]
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@Metadata.ignorePropagatedAnnotations:true
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API

define view I_PurchaseOrderAPI01
  as select from I_PurchaseOrder

  association [0..*] to I_PurchaseOrderItemAPI01 as _PurchaseOrderItem       on  $projection.PurchaseOrder = _PurchaseOrderItem.PurchaseOrder

  --Extension Association
  association [1..1] to E_PurchasingDocument     as _PurchaseOrderExtension  on  $projection.PurchaseOrder = _PurchaseOrderExtension.PurchasingDocument


{
      //Key
  key PurchaseOrder,

      PurchaseOrderType,
      PurchaseOrderSubtype,
      PurchasingDocumentOrigin,

      //Admin
      CreatedByUser,
      CreationDate,
      PurchaseOrderDate,
      Language,
      CorrespncExternalReference,
      CorrespncInternalReference,

      //Status
      PurchasingDocumentDeletionCode,
      ReleaseIsNotCompleted,
      PurchasingCompletenessStatus,
      PurchasingProcessingStatus,
      PurgReleaseSequenceStatus,
      ReleaseCode,

      //Organization
      CompanyCode,
      PurchasingOrganization,
      PurchasingGroup,

      //Supplier
      Supplier,
      ManualSupplierAddressID,
      SupplierRespSalesPersonName,
      SupplierPhoneNumber,
      SupplyingSupplier,
      SupplyingPlant,
      InvoicingParty,
      Customer,

      //Quotation
      SupplierQuotationExternalID,

      //PaymentTerms
      PaymentTerms,
      CashDiscount1Days,
      CashDiscount2Days,
      NetPaymentDays,
      CashDiscount1Percent,
      CashDiscount2Percent,

      //DownPayment
      DownPaymentType,
      DownPaymentPercentageOfTotAmt,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      DownPaymentAmount,
      DownPaymentDueDate,

      //Incoterms
      IncotermsClassification,
      IncotermsTransferLocation,
      IncotermsVersion,
      IncotermsLocation1,
      IncotermsLocation2,

      //Intratat
      IsIntrastatReportingRelevant,
      IsIntrastatReportingExcluded,

      //Pricing
      PurchasingDocumentCondition            as PricingDocument,
      PricingProcedure,
      @Semantics.currencyCode:true
      DocumentCurrency,

      ValidityStartDate,
      ValidityEndDate,

      ExchangeRate,
      ExchangeRateIsFixed,

      LastChangeDateTime,

      TaxReturnCountry,
      VATRegistrationCountry,
      PurgReasonForDocCancellation,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PurgReleaseTimeTotalAmount,     

      // Associations

      _PurchaseOrderItem

}
