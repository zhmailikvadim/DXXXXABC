//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED

@EndUserText.label: 'Purchase Contract Header'

@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

@ObjectModel.semanticKey:  [ 'PurchaseContract' ]
@ObjectModel.representativeKey: 'PurchaseContract'

@ObjectModel.usageType:{
  serviceQuality: #B,
  sizeCategory: #L,
  dataClass: #TRANSACTIONAL
}

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.sapObjectNodeType.name: 'PurchaseContract'

define root view entity R_PurchaseContractTP
  as select from I_PurchaseContract

  composition [1..*] of R_PurchaseContractItemTP as _PurchaseContractItem
  composition [0..*] of R_PurContrPartnersTP     as _PurCtrPartners
  composition [0..*] of R_PurContrHeaderNotesTP  as _PurCtrNotes
    
  ----Extension Association
  association [1..1] to E_PurchasingDocument         as _PurchasingDocument         on $projection.PurchaseContract = _PurchasingDocument.PurchasingDocument

{
  key PurchaseContract,
      PurchaseContractType,
      PurchasingDocumentCategory,
      LastChangeDateTime,
      CreationDate,
      Supplier,
      CompanyCode,
      PurchasingOrganization,
      PurchasingGroup,
      DocumentCurrency,
      IncotermsClassification,
      IncotermsTransferLocation,
      PaymentTerms,
      CashDiscount1Days,
      CashDiscount2Days,
      NetPaymentDays,
      CashDiscount1Percent,
      CashDiscount2Percent,
      @Semantics.amount.currencyCode:'DocumentCurrency'
      PurchaseContractTargetAmount,
      ValidityStartDate,
      ValidityEndDate,
      @ObjectModel.foreignKey.association: '_ReleaseCode'
      ReleaseCode,
  
      CreatedByUser,
      PurchasingDocumentDeletionCode,
      SupplyingSupplier,
      InvoicingParty,
      
//      ExchangeRate,
      cast(abs(ExchangeRate) as fis_absolute_exchangerate preserving type)                                                      as AbsoluteExchangeRate,
      cast(case when ExchangeRate < 0 then 'X' else '' end as fis_indirect_quotation preserving type)                           as ExchRateIsIndirectQuotation,
      cast(case when ExchangeRate < 0 then division(1,abs(ExchangeRate),5) else ExchangeRate end as fis_effective_exchangerate) as EffectiveExchangeRate,
      

      ExchangeRateIsFixed,
      QuotationSubmissionDate,
      SupplierQuotation,
      CorrespncExternalReference,
      CorrespncInternalReference,
      SupplierRespSalesPersonName,
      SupplierPhoneNumber,
      IncotermsVersion,
      IncotermsLocation1,
      IncotermsLocation2,
      PurchasingDocumentName,
      PurchasingDocumentOrigin,
      ReleaseIsNotCompleted,
      PurchasingProcessingStatus,
      PurgAggrgdProdCmplncSuplrSts,
      
      SupplierAddressID,
      @Semantics.booleanIndicator: true
      IsEndOfPurposeBlocked,
      cast ('' as boolean) as PurgContractIsInPreparation,
      /* Associations */
      _PurchaseContractItem,
      _PurCtrNotes,
      _PurCtrPartners,

      /* Foreign key associations */
      _ReleaseCode
      
      
}
