@AccessControl.authorizationCheck: #MANDATORY
@AccessControl.personalData.blocking: #REQUIRED

@ObjectModel.query.implementedBy: 'ABAP:CL_FAP_SUPPLIER_LIST_V2'

@Metadata.allowExtensions: true

@VDM.viewType: #CONSUMPTION

@EndUserText.label: 'Display Supplier List'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #C,
  sizeCategory: #XL,
  dataClass: #MIXED
}

@UI.headerInfo: {
  typeName: 'Supplier',
  typeNamePlural: 'Suppliers',
  title: {  label: 'Supplier',
            value: 'Supplier'}
}
define view entity C_SupplierList
  as select from I_Supplier
{

      @UI.hidden: true
  key cast(Supplier as pph_flgzl) as SequenceInternalID,

      @UI                            : {
        lineItem                     : [ { position: 10 } ],
        identification               : [ { position: 10, importance: #HIGH, type: #STANDARD } ],
        selectionField               : [ { position: 10 } ]
      }
      @UI.textArrangement            : #TEXT_SEPARATE
      @ObjectModel.text.element      : ['SupplierName']
      @Consumption.semanticObject    : 'Supplier'
      @EndUserText.quickInfo         : 'Supplier'
      @EndUserText.label             : 'Supplier'
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_Supplier_VH', element:'Supplier' } }]
      @Search.defaultSearchElement   : true
      @Search.fuzzinessThreshold     : 0.8
      @Search.ranking                : #HIGH
      Supplier,

      @UI                            : {
        lineItem                     : [ { position: 30 } ],
        identification               : [ { position: 30, importance: #HIGH } ],
        selectionField               : [ { position: 20 } ]
      }
      @UI.textArrangement            : #TEXT_LAST
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CompanyCodeVH', element: 'CompanyCode' } }]
      @ObjectModel.text.element      : ['CompanyCodeName']
      @Consumption.labelElement      : 'CompanyCodeName'
      @Consumption.semanticObject    : 'CompanyCode'
      cast( '' as bukrs) as CompanyCode,

      //LFBK

      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_BusinessPartnerVH', element: 'BusinessPartner' } }]
      cast( '' as bu_partner) as BusinessPartner,

      @Consumption.valueHelpDefinition: [{ entity:{ name: 'C_PurchasingOrganizationVHTemp', element: 'PurchasingOrganization' } }]
      cast( '' as ekorg) as PurchasingOrganization,

      @ObjectModel.text.element      : [ 'CountryName' ]
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'C_BankCountryVH', element: 'BankCountry' } }]
      cast( '' as banks) as BankCountry,

      @UI.hidden                     : true
      cast( '' as bankl) as Bank,

      @UI                            : {
        lineItem                     : [ { position: 80 } ] }
      @Consumption.semanticObject    : 'BankAcccount'
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'C_BPBankAccountVH', element: 'BankAccount' } }]
      cast( '' as bu_bankn) as BankAccount,

      //
      @UI                            : {
        selectionField               : [ { position: 40 } ] }
      @ObjectModel.text.element      : ['SupplierCountryName']
      @Semantics.address.country     : true
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_Country', element: 'Country' } }]
      cast( '' as land1) as Country,

      cast( '' as bptaxtype) as BPTaxType,

      cast( '' as butxt) as CompanyCodeName,

      @UI                            : {
        lineItem                     : [ { position: 20 } ],
        identification               : [ { position: 20, importance: #HIGH, type: #STANDARD } ]
      }
      @Consumption.semanticObject    : 'Supplier'
      @Semantics.organization.name   : true
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'C_SupplierValueHelp', element: 'SupplierName' } }]
      @EndUserText.quickInfo         : 'Name of Supplier'
      cast( '' as md_supplier_name) as SupplierName,
      cast( '' as fap_supplier_full_name) as SupplierFullName,
      //

      //            @Search.defaultSearchElement   : true
      //            @Search.fuzzinessThreshold     : 0.8
      @UI.hidden                     : true
      cast( '' as name1_gp) as OrganizationBPName1,

      //            @Search.defaultSearchElement   : true
      //            @Search.fuzzinessThreshold     : 0.8
      @UI.hidden                     : true
      cast( '' as bu_nameor2) as OrganizationBPName2,

      @UI                            : {
        lineItem                     : [ { position: 50 } ]
      }
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CountryVH', element: 'Description' } }]
      cast( '' as landx50) as SupplierCountryName,

      @ObjectModel.text.element      : ['RegionName']
      @Consumption.labelElement      : 'RegionName'
      @UI.textArrangement            : #TEXT_LAST
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_Region', element: 'Region' } }]
      cast( '' as regio) as Region,

      @UI.hidden                     : true
      cast( '' as bezei20) as RegionName,

      @Semantics.address.zipCode     : true
      cast( '' as pstlz) as PostalCode,

      @UI                            : {
        lineItem                     : [ { position: 70 } ],
        selectionField               : [ { position: 30 } ] }
      //      @Search.defaultSearchElement   : true
      //      @Search.fuzzinessThreshold     : 0.8
      cast( '' as farp_supplist_ort01_gp) as CityName,

      @Semantics.address.street      : true
      cast( '' as stras_gp) as StreetName,

      cast( '' as ad_strspp1) as StreetPrefixName,
      cast( '' as ad_strspp2) as AdditionalStreetPrefixName,
      cast( '' as ad_strspp3) as StreetSuffixName,
      cast( '' as ad_lctn) as AdditionalStreetSuffixName,

      @Semantics                     : {
        telephone.type               : [#PREF]
      }
      cast( '' as telf1) as PhoneNumber1,
      @Semantics                     : {
        telephone.type               : [#FAX]
      }
      cast( '' as telfx) as FaxNumber,
      @Semantics.systemDate.createdAt: true
      cast( '' as erdat_rf) as CreationDate,

      @Consumption.semanticObject    : 'User'
      @UI                            : {
        lineItem                     : [ { position: 130 } ]
      }
      cast( '' as fap_supplier_list_created_by) as CreatedByUser,

      cast( '' as telf2) as PhoneNumber2,

      @Semantics.booleanIndicator
      @Consumption.filter.selectionType: #SINGLE
      cast( '' as stkzn) as IsNaturalPerson,
      cast( '' as stcd1) as TaxNumber1,
      cast( '' as stcd2) as TaxNumber2,
      cast( '' as stcd3) as TaxNumber3,
      cast( '' as stcd4) as TaxNumber4,
      cast( '' as stcd5) as TaxNumber5,

      @UI                            : {
        lineItem                     : [ { position: 120 } ]
      }
      cast( '' as bptaxnum) as VATRegistration,
      cast( '' as splr_tax_type_name) as TaxTypeName,

      cast( '' as supplist_j_1atoid) as ResponsibleType,
      cast( '' as farp_supplist_j_1atoid) as TaxNumberType,
      cast( '' as supplist_taxnumber) as TaxNumberResponsible,
      cast( '' as adrnr) as AddressID,

      @EndUserText.quickInfo         : 'Deletion Flag on Supplier Level'
      cast( '' as farp_supplist_loevm_x) as DeletionIndicator,

      cast( '' as rassc) as TradingPartner,

      //auth
      @UI                            : {
        lineItem                     : [ { position: 40 } ]
      }
      @ObjectModel.text.element      : ['AccountGroupName']
      @UI.textArrangement            : #TEXT_LAST
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_SupplierAccountGroupSTDVH', element: 'SupplierAccountGroup' } }]
      cast( '' as farp_supplier_account_group) as SupplierAccountGroup,

      cast( '' as suplr_account_grp_name) as AccountGroupName,
      cast( '' as brgru) as AuthorizationGroup,

      @UI                            : {
        lineItem                     : [ { position: 100 } ]
      }
      cast( '' as farp_supplist_sperr) as AccountIsBlockedForPosting,
      @Semantics.booleanIndicator
      @Consumption.filter.selectionType: #SINGLE
      cast( '' as supplist_sperz) as PaymentIsBlockedForSupplier,
      cast( '' as fap_supplier_list_lnrza) as AlternativePayeeAccountNumber,
      cast( '' as fap_supplier_list_lnrzb) as AlternativePayee,

      @UI.hidden                     : true
      cast( '' as bukrs) as SearchString,

      cast( '' as dzuawa) as LayoutSortingRule,
      cast( '' as farp_akont) as ReconciliationAccount,

      @UI                            : {
        lineItem                     : [ { position: 90 } ]
      }
      @EndUserText.quickInfo         : 'Payment Methods'
      cast( '' as dzwels) as PaymentMethodsList,
      cast( '' as farp_busab) as AccountingClerk,
      cast( '' as farp_supplist_tlfxs) as AccountingClerkFaxNumber,
      cast( '' as farp_supplist_intad) as SupplierClerkURL,
      cast( '' as supplier_list_tlfns) as AccountingClerkPhoneNumber,
      cast( '' as farp_dzterm_cc) as SuplrCoCodePaymentTerms,
      cast( '' as farp_dzlspr) as PaymentBlockingReason,
      cast( '' as farp_supplist_loevm_b) as SuplrIsDeltdCoCode,
      cast( '' as fap_supplier_list_fdgrv) as CashPlanningGroup,
      cast( '' as fap_supplier_list_reprf) as IsToBeCheckedForDuplicates,

      cast( '' as farp_supplist_sperb_b) as SupplierIsBlockedForPosting,

      cast( '' as kzaut) as PurOrdAutoGenerationIsAllowed,

      @Consumption.valueHelpDefinition: [{ entity:{ name: 'C_PurchasingGroupValueHelp', element: 'PurchasingGroup' } }]
      cast( '' as ekgrp) as PurchasingGroup,
      cast( '' as farp_dzterm_po) as SupplierPurgOrgPaymentTerms,
      cast( '' as supplist_sperm_m) as PurchasingIsBlockedForSupplier,
      cast( '' as supplist_loevm_m) as SuplrIsDeltdPurgOrg,
      cast( '' as webre) as InvoiceIsGoodsReceiptBased,
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'C_CurrencyValueHelp', element: 'Currency' } }]
      cast( '' as fap_supplier_list_bstwa) as PurchaseOrderCurrency,

      //adr6
      @UI.hidden: true
      cast( '' as supplist_smtpadr) as EmailAddress,

      @ObjectModel.text.element: ['EmailAddress']
      @Semantics.eMail.address: true
      @UI.textArrangement: #TEXT_ONLY
      cast( '' as ad_smtpad2) as SearchEmailAddress,

      //LFBK
      //      @Search.defaultSearchElement   : true
      //      @Search.fuzzinessThreshold     : 0.8
      @UI                            : {
        lineItem                     : [ { position: 60 } ]
      }
      cast( '' as banka) as BankName,

      cast( '' as farp_supplist_bankk) as BankInternalID,
      cast( '' as swift) as SWIFTCode,
      cast( '' as bu_iban) as IBAN,
      cast( '' as farp_supplist_bkont) as BankControlKey,
      cast( '' as fclm_bam_beneficiary_name) as BankAccountHolderName,
      @UI.hidden                     : true
      cast( '' as landx50) as CountryName,
      //@Consumption.valueHelpDefinition: [{ entity:{ name: 'P_CityValueHelp', element: 'CityName' } }]
      cast( '' as glo_partner_pobox_dvtg_city) as BusPartPOBoxDvtgCityName,

      cast( '' as stkzu) as VATLiability,

      @Consumption.valueHelpDefinition: [{ entity:{ name: 'C_WithHoldingTaxCountryTMPVH', element: 'WithholdingTaxCountry' } }]
      cast( '' as qland) as WithholdingTaxCountry,

      @UI.hidden                     : true
      cast( '' as ad_namtext) as FullName,

      cast( '' as bu_sort1) as SearchTerm1,
      cast( '' as bu_sort2) as SearchTerm2,

      @Consumption.filter.hidden     : true
      cast( '' as bcode) as BranchCode,
      @Consumption.filter.hidden     : true
      @EndUserText.quickInfo         : 'Branch Description'
      cast( '' as farp_supplist_branch_descr) as TH_BranchCodeDescription,
      @Consumption.filter.hidden     : true
      @Semantics.booleanIndicator
      @Consumption.filter.selectionType: #SINGLE
      cast( '' as fith_default_bcode) as IsDefaultValue,

      cast( '' as altkn) as PreviousAccountNumber,
      cast( '' as frgrp) as SupplierReleaseGroup,
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_SupplierMinorityGroupStdVH', element: 'MinorityGroup' }}]
      cast( '' as mindk) as MinorityGroup
}
