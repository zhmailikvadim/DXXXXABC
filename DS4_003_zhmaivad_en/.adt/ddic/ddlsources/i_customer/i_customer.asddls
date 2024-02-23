@AbapCatalog.sqlViewName: 'I_CUSTOMER_CDS'
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@AccessControl.personalData.blockingIndicator: 'IsBusinessPurposeCompleted'
@AccessControl.privilegedAssociations: [ '_StandardAddress', '_AddressDefaultRepresentation' ]
@Analytics: {
  dataCategory: #DIMENSION,
  dataExtraction: {
    enabled: true,
    delta.changeDataCapture: {
      automatic: true
    }
  }
}
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Customer'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE,
                                     #CDS_MODELING_DATA_SOURCE,
                                     #CDS_MODELING_ASSOCIATION_TARGET,
                                     #ANALYTICAL_DIMENSION,
                                     #EXTRACTION_DATA_SOURCE]
@ObjectModel.modelingPattern: #ANALYTICAL_DIMENSION
@ObjectModel.representativeKey: 'Customer'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER
@VDM.viewType: #BASIC

define view I_Customer
  as select from kna1
  association [1..1] to I_CustomerToBusinessPartner    as _CustomerToBusinessPartner on $projection.Customer = _CustomerToBusinessPartner.Customer
  association [0..1] to I_Supplier                     as _CorrespondingSupplier     on _CorrespondingSupplier.Supplier = $projection.Supplier
  association [0..*] to I_CustomerAccountGroupText     as _CustomerAccountGroupText  on $projection.CustomerAccountGroup = _CustomerAccountGroupText.CustomerAccountGroup
  association [0..1] to I_CustomerClassification       as _CustomerClassification    on $projection.CustomerClassification = _CustomerClassification.CustomerClassification
  association [0..*] to I_CustomerClassificationText   as _CustomerClassificationText  on $projection.CustomerClassification = _CustomerClassificationText.CustomerClassification
  association [1..*] to I_CustomerCompany              as _CustomerCompany           on $projection.Customer = _CustomerCompany.Customer
  association [1..*] to I_CustomerSalesArea            as _CustomerSalesArea         on $projection.Customer = _CustomerSalesArea.Customer
  association [1..1] to I_User                         as _CreatedByUser             on $projection.CreatedByUser = _CreatedByUser.UserID
  association [1..1] to I_Address                      as _StandardAddress           on $projection.AddressID = _StandardAddress.AddressID
  association [1..*] to I_CustSalesAreaTax             as _CustomerSalesAreaTax      on $projection.Customer = _CustomerSalesAreaTax.Customer
  association [0..1] to E_Customer                     as _CustomerExt               on $projection.Customer = _CustomerExt.Customer
  association [1..*] to I_CustAddrDepdntInformation    as _CustomerAddr              on $projection.Customer = _CustomerAddr.Customer
  association [1..*] to I_CustSlsAreaAddrDepdntTaxInfo as _CustomerAddrSalesAreaTax  on $projection.Customer = _CustomerAddrSalesAreaTax.Customer
  association [0..*] to I_ContactPerson                as _ContactPerson             on $projection.Customer = _ContactPerson.Customer
  association [0..*] to I_CustUnivHierarchyNode        as _CustomerHierarchyNode     on $projection.Customer = _CustomerHierarchyNode.Customer
  association [0..1] to I_Globalcompany                as _GlobalCompany             on $projection.TradingPartner = _GlobalCompany.Company
 // association [1..1] to I_BusinessPartnerAddress       as _BusinessPartnerAddress   on $projection.BusinessPartner = _BusinessPartnerAddress.BusinessPartner
                                                                       //            and $projection.AddressID =  _BusinessPartnerAddress.AddressNumber
  association [0..1] to I_OrganizationAddress          as _AddressDefaultRepresentation on $projection.AddressID = _AddressDefaultRepresentation.AddressID
                                                                                         and _AddressDefaultRepresentation.AddressRepresentationCode is initial                                                                                  
{
      //Key
      @ObjectModel.text.element: ['CustomerName']
      @ObjectModel: {
        hierarchy.association: '_CustomerHierarchyNode'
      }
  key cast(kna1.kunnr as kunnr preserving type)                                                                   as Customer,
      //@VDM.deprecated:true
      //Please use from association as _CustomerToBusinessPartner._BusinessPartner.BusinessPartner instead
      //_cvi._BusinessPartner.BusinessPartner,
      //@VDM.deprecated:true
      //Please use from association as _CustomerToBusinessPartner.BusinessPartnerUUID instead
      //_cvi.BusinessPartnerUUID,
      
     // _CustomerToBusinessPartner._BusinessPartner.BusinessPartner                                                 as BusinessPartner,
      @Semantics.text:true
      cast(substring(rtrim(replace(concat(name1, concat(' &@', name2)), '&@', ''),' '),1,80) as md_customer_name) as CustomerName,
      cast(concat( concat( concat( concat( concat( concat_with_space( anred, name1, 1 ), name2 ), name3 ), name4 ), '/' ),
              concat_with_space(pstlz, ort01, 1 ) ) as md_customer_full_name)                                     as CustomerFullName, //KF: different with S4

      kna1.ernam                                                                                                  as CreatedByUser,
      kna1.erdat                                                                                                  as CreationDate,
      kna1.adrnr                                                                                                  as AddressID,
      @ObjectModel.foreignKey.association:'_CustomerClassification'
      @ObjectModel.text.association: '_CustomerClassificationText'
      kna1.kukla                                                                                                  as CustomerClassification,
      kna1.stceg                                                                                                  as VATRegistration,
      kna1.ktokd                                                                                                  as CustomerAccountGroup,
      kna1.begru                                                                                                  as AuthorizationGroup,
      kna1.lifsd                                                                                                  as DeliveryIsBlocked,
      kna1.sperr                                                                                                  as PostingIsBlocked,
      kna1.faksd                                                                                                  as BillingIsBlockedForCustomer, // Used in CDS based Customer Object Page
      kna1.aufsd                                                                                                  as OrderIsBlockedForCustomer, //Used in CDS based Customer Object Page
      kna1.bbbnr                                                                                                  as InternationalLocationNumber1, //Used in CDS based Customer Object Page
      kna1.xcpdk                                                                                                  as IsOneTimeAccount,
      kna1.txjcd                                                                                                  as TaxJurisdiction,
      kna1.brsch                                                                                                  as Industry,
      kna1.stcdt                                                                                                  as TaxNumberType,
      kna1.stcd1                                                                                                  as TaxNumber1, // same as kna1.stcd1 ?
      kna1.stcd2                                                                                                  as TaxNumber2, // same as kna1.stcd2 ?
      kna1.stcd3                                                                                                  as TaxNumber3,
      kna1.stcd4                                                                                                  as TaxNumber4,
      kna1.stcd5                                                                                                  as TaxNumber5,
      kna1.stcd6                                                                                                  as TaxNumber6,
      kna1.konzs                                                                                                  as CustomerCorporateGroup,
      kna1.lifnr                                                                                                  as Supplier,
      kna1.niels                                                                                                  as NielsenRegion,
      kna1.bran1                                                                                                  as IndustryCode1,
      kna1.bran2                                                                                                  as IndustryCode2,
      kna1.bran3                                                                                                  as IndustryCode3,
      kna1.bran4                                                                                                  as IndustryCode4,
      kna1.bran5                                                                                                  as IndustryCode5,
      kna1.land1                                                                                                  as Country,
      kna1.name1                                                                                                  as OrganizationBPName1,
      kna1.name2                                                                                                  as OrganizationBPName2,
      kna1.ort01                                                                                                  as CityName,
      kna1.pstlz                                                                                                  as PostalCode,
      kna1.stras                                                                                                  as StreetName,
      kna1.sortl                                                                                                  as SortField,
      kna1.telfx                                                                                                  as FaxNumber,
      kna1.suframa                                                                                                as BR_SUFRAMACode,
      kna1.regio                                                                                                  as Region,
      kna1.telf1                                                                                                  as TelephoneNumber1,
      kna1.telf2                                                                                                  as TelephoneNumber2,
      kna1.knrza                                                                                                  as AlternativePayerAccount,
      kna1.dtams                                                                                                  as DataMediumExchangeIndicator,
      kna1.stkzu                                                                                                  as VATLiability,
      kna1.cvp_xblck                                                                                              as IsBusinessPurposeCompleted,
      kna1.fityp                                                                                                  as ResponsibleType,
      kna1.fiskn                                                                                                  as FiscalAddress,
      kna1.stkzn                                                                                                  as NFPartnerIsNaturalPerson,
      kna1.loevm                                                                                                  as DeletionIndicator,
      kna1.spras                                                                                                  as Language,
      @ObjectModel.foreignKey.association:'_GlobalCompany'
      kna1.vbund                                                                                                  as TradingPartner,
      kna1.delivery_date_rule                                                                                     as DeliveryDateTypeRule,
      kna1.bahne                                                                                                  as ExpressTrainStationName,
      kna1.bahns                                                                                                  as TrainStationName,
      kna1.bbsnr                                                                                                  as InternationalLocationNumber2,
      kna1.bubkz                                                                                                  as InternationalLocationNumber3,
      kna1.cityc                                                                                                  as CityCode,
      kna1.counc                                                                                                  as County,
      kna1.exabl                                                                                                  as CustomerHasUnloadingPoint,
      kna1.knazk                                                                                                  as CustomerWorkingTimeCalendar,
      kna1.dear1                                                                                                  as IsCompetitor,
      j_1kfrepre                                                                                                  as TaxInvoiceRepresentativeName,
      j_1kftbus                                                                                                   as BusinessType,
      j_1kftind                                                                                                   as IndustryType,
      consolidate_invoice                                                                                         as TW_CollvBillingIsSupported,

      xzemp                                                                                                       as AlternativePayeeIsAllowed,

      katr1                                                                                                       as FreeDefinedAttribute01,
      katr2                                                                                                       as FreeDefinedAttribute02,
      katr3                                                                                                       as FreeDefinedAttribute03,
      katr4                                                                                                       as FreeDefinedAttribute04,
      katr5                                                                                                       as FreeDefinedAttribute05,
      katr6                                                                                                       as FreeDefinedAttribute06,
      katr7                                                                                                       as FreeDefinedAttribute07,
      katr8                                                                                                       as FreeDefinedAttribute08,
      katr9                                                                                                       as FreeDefinedAttribute09,
      katr10                                                                                                      as FreeDefinedAttribute10,
      kna1.paytrsn                                                                                                as PaymentReason,
      
      @Semantics.booleanIndicator
      kna1.dear3                                                                                                  as IsSalesProspect,
      kna1.sperz                                                                                                  as PaymentIsBlockedForCustomer,
      
//      _CustomerToBusinessPartner._BusinessPartner.BusinessPartner, //Uncommenting it for BP Data Controller Usage
      //Associations
      _CustomerToBusinessPartner,
      _StandardAddress,
      _AddressDefaultRepresentation,
      _CreatedByUser,
      _CorrespondingSupplier,
      _CustomerClassification,
      _CustomerClassificationText,
      _CustomerAccountGroupText,
      _CustomerCompany,
      _CustomerSalesArea,
      _CustomerSalesAreaTax,
      _CustomerAddr,
      _CustomerAddrSalesAreaTax,
      _ContactPerson,
      _CustomerHierarchyNode,
      _GlobalCompany
 //     _CustomerToBusinessPartner._BusinessPartner._BPDataControllerUsage as _BPDataControllerUsage
   //   _BusinessPartnerAddress   
}
