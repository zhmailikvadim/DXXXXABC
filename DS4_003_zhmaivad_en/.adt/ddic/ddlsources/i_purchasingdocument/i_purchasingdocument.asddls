
@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: 'IMMPURCHASINGDOC'
@EndUserText.label: 'Purchasing Document'
@AccessControl.authorizationCheck:#CHECK
@VDM.viewType : #BASIC
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel: {
  representativeKey: 'PurchasingDocument',
  usageType.serviceQuality: #A, 
  usageType.sizeCategory: #L, 
  usageType.dataClass: #TRANSACTIONAL
}
@AccessControl.privilegedAssociations: [ '_SupplierAddress' ]

define view I_PurchasingDocument
  as select from ekko as ekko //PurgDoc

  association [1..1] to I_PurchasingDocumentCategory as _PurchasingDocumentCategory on  $projection.PurchasingDocumentCategory = _PurchasingDocumentCategory.PurchasingDocumentCategory

  association [0..1] to I_PurchasingDocumentType     as _PurchasingDocumentType     on  $projection.PurchasingDocumentCategory = _PurchasingDocumentType.PurchasingDocumentCategory
                                                                                    and $projection.PurchasingDocumentType     = _PurchasingDocumentType.PurchasingDocumentType

  association [0..1] to I_CompanyCode                as _CompanyCode                on  $projection.CompanyCode = _CompanyCode.CompanyCode

  association [0..1] to I_User                       as _CreatedByUser              on  $projection.CreatedByUser = _CreatedByUser.UserID

  association [0..1] to I_Supplier                   as _Supplier                   on  $projection.Supplier = _Supplier.Supplier

  association [0..1] to I_Supplier                   as _SupplyingSupplier          on  $projection.SupplyingSupplier = _SupplyingSupplier.Supplier

  association [0..1] to I_Supplier                   as _InvoicingParty             on  $projection.InvoicingParty = _InvoicingParty.Supplier

  association [0..1] to I_PaymentTerms               as _PaymentTerms               on  $projection.PaymentTerms = _PaymentTerms.PaymentTerms

  association [0..1] to I_Address                    as _SupplierAddress            on  $projection.ManualSupplierAddressID = _SupplierAddress.AddressID

  association [0..1] to I_PurchasingOrganization     as _PurchasingOrganization     on  $projection.PurchasingOrganization = _PurchasingOrganization.PurchasingOrganization

  association [0..1] to I_PurchasingGroup            as _PurchasingGroup            on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup

  association [0..1] to I_Currency                   as _DocumentCurrency           on  $projection.DocumentCurrency = _DocumentCurrency.Currency

  association [0..1] to I_IncotermsClassification    as _IncotermsClassification    on  $projection.IncotermsClassification = _IncotermsClassification.IncotermsClassification

  association [0..1] to I_IncotermsVersion           as _IncotermsVersion           on  $projection.IncotermsVersion = _IncotermsVersion.IncotermsVersion

  association [0..1] to I_Plant                      as _SupplyingPlant             on  $projection.SupplyingPlant = _SupplyingPlant.Plant

  association [0..*] to I_PurchasingDocumentItem     as _PurchasingDocumentItem     on  $projection.PurchasingDocument = _PurchasingDocumentItem.PurchasingDocument

  association [0..*] to I_PurchasingDocumentPartner  as _PurchasingDocumentPartner  on  $projection.PurchasingDocument = _PurchasingDocumentPartner.PurchasingDocument

  association [0..1] to I_PurchasingDocumentOrigin   as _PurchasingDocumentOrigin   on  $projection.PurchasingDocumentOrigin = _PurchasingDocumentOrigin.PurchasingDocumentOrigin

  association [0..1] to I_ReleaseCode                as _ReleaseCode                on  $projection.ReleaseCode = _ReleaseCode.ReleaseCode

  association [0..1] to I_PurchaseContract           as _PurchaseContract           on  $projection.PurchaseContract = _PurchaseContract.PurchaseContract

  association [0..1] to I_Language                   as _Language                   on  $projection.Language = _Language.Language

  association [0..1] to I_TaxCalculationProcedure    as _PricingProcedure           on  $projection.PricingProcedure = _PricingProcedure.TaxCalculationProcedure

  association [0..1] to E_PurchasingDocument         as _HeaderExtension            on  $projection.PurchasingDocument = _HeaderExtension.PurchasingDocument

{
  key ekko.ebeln                                   as PurchasingDocument,

      @ObjectModel.foreignKey.association: '_PurchasingDocumentCategory'
      ekko.bstyp                                   as PurchasingDocumentCategory,

      @ObjectModel.foreignKey.association: '_PurchasingDocumentType'
      ekko.bsart                                   as PurchasingDocumentType,

      ekko.bsakz                                   as PurchasingDocumentSubtype,

      @ObjectModel.foreignKey.association: '_CompanyCode'
      ekko.bukrs                                   as CompanyCode,

      ekko.loekz                                   as PurchasingDocumentDeletionCode,

      ekko.isaged                                  as PurchasingDocumentIsAged,
      
      ekko.pincr                                   as ItemNumberInterval,
      
      ekko.upinc                                   as ItemNumberIntervalForSubItems,
     
      @ObjectModel.foreignKey.association: '_PurchasingDocumentOrigin'
      ekko.statu                                   as PurchasingDocumentOrigin,

      ekko.frgrl                                   as ReleaseIsNotCompleted,

      @ObjectModel.foreignKey.association: '_ReleaseCode'
      ekko.frgke                                   as ReleaseCode,
      
      ekko.frgsx                                   as PurchasingReleaseStrategy,

      ekko.frgzu                                   as PurgReleaseSequenceStatus,

      ekko.lands                                   as TaxReturnCountry,

      @Semantics.businessDate.createdAt: true
      ekko.aedat                                   as CreationDate,

      ekko.lastchangedatetime                      as LastChangeDateTime,

      @Semantics.user.createdBy: true
      ekko.ernam                                   as CreatedByUser,

      @ObjectModel.foreignKey.association: '_Supplier'
      cast ( ekko.lifnr as md_supplier preserving type)           as Supplier,

      ekko.verkf                                   as SupplierRespSalesPersonName,

      ekko.telf1                                   as SupplierPhoneNumber,

      ekko.adrnr                                   as SupplierAddressID, //obsolete

      @ObjectModel.foreignKey.association: '_SupplierAddress'
      ekko.adrnr                                   as ManualSupplierAddressID,

      ekko.ihrez                                   as CorrespncExternalReference,

      ekko.unsez                                   as CorrespncInternalReference,
      
      @ObjectModel.foreignKey.association: '_PurchasingOrganization'
      ekko.ekorg                                   as PurchasingOrganization,

      @ObjectModel.foreignKey.association: '_PurchasingGroup'
      ekko.ekgrp                                   as PurchasingGroup,

      //_CompanyCode.FiscalYearVariant as FiscalYearVariant,

      @Semantics.currencyCode:true
      @ObjectModel.foreignKey.association: '_DocumentCurrency'
      ekko.waers                                   as DocumentCurrency,

      cast ( ekko.wkurs as fis_exchange_rate preserving type )     as ExchangeRate,

      @Semantics.businessDate.at
      ekko.bedat                                   as PurchasingDocumentOrderDate,

      @ObjectModel.foreignKey.association: '_SupplyingSupplier'
      ekko.llief                                   as SupplyingSupplier,

      @ObjectModel.foreignKey.association: '_SupplyingPlant'
      ekko.reswk                                   as SupplyingPlant,

      @ObjectModel.foreignKey.association: '_InvoicingParty'
      ekko.lifre                                   as InvoicingParty,
      
      ekko.kunnr                                   as Customer,

      @ObjectModel.foreignKey.association: '_PurchaseContract'
      ekko.konnr                                   as PurchaseContract,

      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
      ekko.spras                                   as Language,

      ekko.absgr                                   as PurgReasonForDocCancellation,

      ekko.memory                                  as PurchasingCompletenessStatus,

      @ObjectModel.foreignKey.association: '_IncotermsClassification'
      ekko.inco1                                   as IncotermsClassification,

      ekko.inco2                                   as IncotermsTransferLocation,

      @ObjectModel.foreignKey.association: '_PaymentTerms'
      cast( zterm as farp_dzterm preserving type)                 as PaymentTerms,

      cast (ekko.zbd1t as dzbd1t preserving type)                  as CashDiscount1Days,

      cast (ekko.zbd2t as dzbd2t preserving type)                  as CashDiscount2Days,

      cast (ekko.zbd3t as dzbd3t preserving type)                  as NetPaymentDays,

      ekko.zbd1p                                   as CashDiscount1Percent,

      ekko.zbd2p                                   as CashDiscount2Percent,

      @ObjectModel.foreignKey.association: '_PricingProcedure'
      ekko.kalsm                                   as PricingProcedure,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation:#NONE
      ekko.ktwrt                                   as TargetAmount,
      
      ekko.distributiontype                        as PurgDocumentDistributionType,

      ekko.knumv                                   as PurchasingDocumentCondition,

      ekko.kdatb                                   as ValidityStartDate,

      ekko.kdate                                   as ValidityEndDate,

      ekko.lphis                                   as ScheduleAgreementHasReleaseDoc,

      ekko.angdt                                   as QuotationLatestSubmissionDate,

      ekko.bnddt                                   as BindingPeriodValidityEndDate,

      ekko.ihran                                   as QuotationSubmissionDate,

      ekko.angnr                                   as SupplierQuotationExternalID,

      ekko.ausnr                                   as RequestForQuotation,

      ekko.kufix                                   as ExchangeRateIsFixed,

      @ObjectModel.foreignKey.association: '_IncotermsVersion'
      ekko.incov                                   as IncotermsVersion,

      ekko.inco2_l                                 as IncotermsLocation1,

      ekko.inco3_l                                 as IncotermsLocation2,

      ekko.procstat                                as PurchasingProcessingStatus,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ekko.rlwrt                                   as PurgReleaseTimeTotalAmount,
      
      ekko.dptyp                                   as DownPaymentType,
      
      ekko.dppct                                   as DownPaymentPercentageOfTotAmt,
      
      @Semantics.amount.currencyCode: 'DocumentCurrency' 
      ekko.dpamt                                   as DownPaymentAmount,
      
      ekko.dpdat                                   as DownPaymentDueDate,

      cast ( ekko.description as vdm_purgdoc_name preserving type ) as PurchasingDocumentName,

      ekko.qtn_erlst_submsn_date                   as QuotationEarliestSubmsnDate,

      ekko.bwbdt                                   as LatestRegistrationDate,

      ekko.followon_doc_cat                        as FollowOnDocumentCategory,
      
      ekko.followon_doc_type                       as FollowOnDocumentType,
      
      ekko.stceg                                   as VATRegistration,
            
      ekko.stceg_l                                 as VATRegistrationCountry,
      
      ekko.intra_rel                               as IsIntrastatReportingRelevant,
      
      ekko.intra_excl                              as IsIntrastatReportingExcluded,
      @Semantics.booleanIndicator: true
      ekko.iseopblocked                            as IsEndOfPurposeBlocked, //IsEopBlocked 
      
      //ekko.absgr                                   as 

      ekko.parent_id                               as PurchasingParentDocument,
      ekko.grouping_id                             as ProcmtHubCompanyCodeGroupingID,
      
      _CompanyCode,
      _PurchasingDocumentType,
      _PurchasingDocumentCategory,
      _Supplier,
      _SupplyingSupplier,
      _InvoicingParty,
      _PaymentTerms,
      _PurchasingOrganization,
      _PurchasingGroup,
      _SupplierAddress,
      _DocumentCurrency,
      _CreatedByUser,
      _IncotermsClassification,
      _IncotermsVersion,
      _SupplyingPlant,
      _PurchasingDocumentOrigin,
      _ReleaseCode,
      _PurchaseContract,
      _Language,
      _PricingProcedure,
      _PurchasingDocumentItem,
      _PurchasingDocumentPartner
} 

