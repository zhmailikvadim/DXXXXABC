@AbapCatalog.sqlViewName: 'IMDCUSTSLSAREA'

@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@AccessControl.personalData.blockingIndicator: 'IsBusinessPurposeCompleted'
@Analytics: {
    dataCategory: #DIMENSION,
    dataExtraction: {
       enabled: true,
       delta.changeDataCapture: {
          automatic : true
       }
    }
}

@ClientHandling.algorithm : #SESSION_VARIABLE

@EndUserText.label: 'Customer Sales Area'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE,
                                     #CDS_MODELING_DATA_SOURCE,
                                     #CDS_MODELING_ASSOCIATION_TARGET,
                                     #ANALYTICAL_DIMENSION,
                                     #EXTRACTION_DATA_SOURCE]
@ObjectModel.modelingPattern:#ANALYTICAL_DIMENSION
@ObjectModel.representativeKey:'Division'
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

@VDM.viewType: #BASIC

define view I_CustomerSalesArea
  as select from knvv
  association [1..1] to I_Customer                   as _Customer                     on  $projection.Customer = _Customer.Customer
  association [0..1] to I_SalesOrganization          as _SalesOrganization            on  $projection.SalesOrganization = _SalesOrganization.SalesOrganization
  association [0..1] to I_DistributionChannel        as _DistributionChannel          on  $projection.DistributionChannel = _DistributionChannel.DistributionChannel
  association [0..1] to I_Division                   as _Division                     on  $projection.Division = _Division.Division
  association [0..1] to I_SalesOffice                as _SalesOffice                  on  $projection.SalesOffice = _SalesOffice.SalesOffice
  association [0..1] to I_SalesGroup                 as _SalesGroup                   on  $projection.SalesGroup = _SalesGroup.SalesGroup
  association [0..1] to I_Currency                   as _Currency                     on  $projection.Currency = _Currency.Currency
  association [0..1] to I_DeliveryPriority           as _DeliveryPriority             on  $projection.DeliveryPriority = _DeliveryPriority.DeliveryPriority
  association [0..1] to I_ShippingCondition          as _ShippingCondition            on  $projection.ShippingCondition = _ShippingCondition.ShippingCondition
  association [0..1] to I_IncotermsClassification    as _IncotermsClassification      on  $projection.IncotermsClassification = _IncotermsClassification.IncotermsClassification
  association [0..1] to I_Plant                      as _SupplyingPlant               on  $projection.SupplyingPlant = _SupplyingPlant.Plant
  association [0..1] to I_DeliveryBlockReason        as _DeliveryIsBlockedForCustomer on  $projection.DeliveryIsBlockedForCustomer = _DeliveryIsBlockedForCustomer.DeliveryBlockReason
  association [0..1] to I_BillingBlockReason         as _BillingIsBlockedForCustomer  on  $projection.BillingIsBlockedForCustomer = _BillingIsBlockedForCustomer.BillingBlockReason
  association [0..1] to I_CustomerPaymentTerms       as _CustomerPaymentTerms         on  $projection.CustomerPaymentTerms = _CustomerPaymentTerms.CustomerPaymentTerms
  association [0..1] to I_CustomerAccountAssgmtGroup as _CustomerAccountAssgmtGroup   on  $projection.CustomerAccountAssignmentGroup = _CustomerAccountAssgmtGroup.CustomerAccountAssignmentGroup
  association [0..1] to I_FactoryCalendar            as _FactoryCalendar              on  $projection.InvoiceListSchedule = _FactoryCalendar.FactoryCalendar
  association [0..1] to I_ExchangeRateType           as _ExchangeRateType             on  $projection.ExchangeRateType = _ExchangeRateType.ExchangeRateType
  association [0..1] to I_CustProdProposalProcedure  as _CustProdProposalProcedure    on  $projection.CustProdProposalProcedure = _CustProdProposalProcedure.CustProdProposalProcedure

  association [0..1] to E_BPSALESAREA_D              as _SalesAreaExt                 on  $projection.SalesOrganization   = _SalesAreaExt.SalesOrganization
                                                                                      and $projection.DistributionChannel = _SalesAreaExt.DistributionChannel
                                                                                      and $projection.Division            = _SalesAreaExt.Division
                                                                                      and $projection.Customer            = _SalesAreaExt.Customer
  association [0..1] to I_CustomerPaytGuarProced     as _PaytGuarProcedVH             on  $projection.PaymentGuaranteeProcedure = _PaytGuarProcedVH.CustomerPaytGuarProced

  association [1..*] to I_CustSlsAreaAddrDepdntInfo  as _SalesAreaAddr                on  $projection.SalesOrganization   = _SalesAreaAddr.SalesOrganization
                                                                                      and $projection.DistributionChannel = _SalesAreaAddr.DistributionChannel
                                                                                      and $projection.Division            = _SalesAreaAddr.Division
                                                                                      and $projection.Customer            = _SalesAreaAddr.Customer
  
 
  // association [0..1] to I_TransportationLocation     as _Tlocation1             on  $projection.IncotermsSupChnLoc1AddlUUID = _Tlocation1.LocationUUID

{
      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Customer_VH',
                     element: 'Customer' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Customer'
  key kunnr                                                                       as Customer,
      @ObjectModel.foreignKey.association: '_SalesOrganization'
  key vkorg                                                                       as SalesOrganization,
      @ObjectModel.foreignKey.association: '_DistributionChannel'
  key vtweg                                                                       as DistributionChannel,
      @ObjectModel.foreignKey.association:'_Division' //Still need to clarify the compatibility of @Analytics and @representativeKey annotation
  key spart                                                                       as Division,
      klabc                                                                       as CustomerABCClassification,
      @ObjectModel.foreignKey.association: '_SalesOffice'
      vkbur                                                                       as SalesOffice,
      @ObjectModel.foreignKey.association: '_SalesGroup'
      vkgrp                                                                       as SalesGroup,
      aufsd                                                                       as OrderIsBlockedForCustomer,
      @ObjectModel.foreignKey.association: '_Currency'
      waers                                                                       as Currency,
      konda                                                                       as CustomerPriceGroup,
      pltyp                                                                       as PriceListType,
      @ObjectModel.foreignKey.association: '_DeliveryPriority'
      lprio                                                                       as DeliveryPriority,
      @ObjectModel.foreignKey.association: '_ShippingCondition'
      vsbed                                                                       as ShippingCondition,
      @ObjectModel.foreignKey.association: '_IncotermsClassification'
      inco1                                                                       as IncotermsClassification,
      @ObjectModel.foreignKey.association: '_SupplyingPlant'
      vwerk                                                                       as SupplyingPlant,
      autlf                                                                       as CompleteDeliveryIsDefined,
      @ObjectModel.foreignKey.association: '_DeliveryIsBlockedForCustomer'
      lifsd                                                                       as DeliveryIsBlockedForCustomer,
      @ObjectModel.foreignKey.association: '_BillingIsBlockedForCustomer'
      faksd                                                                       as BillingIsBlockedForCustomer,
      @ObjectModel.foreignKey.association: '_CustomerPaymentTerms'
      zterm                                                                       as CustomerPaymentTerms,
      ktgrd                                                                       as CustomerAccountAssignmentGroup,
      eikto                                                                       as AccountByCustomer, //needed in customer_supplier app
      kdgrp                                                                       as CustomerGroup, //gfn doubt //needed in customer_supplier app
      kalks                                                                       as CustomerPricingProcedure, //needed in customer_supplier app
      kzazu                                                                       as OrderCombinationIsAllowed, //gfn doubt //needed in customer_supplier app
      kztlf                                                                       as PartialDeliveryIsAllowed, //needed in customer_supplier app
      // transpzone                                                                            as TransportZone, //gfn doubt //needed in customer_supplier app
      perfk                                                                       as InvoiceDate, //gfn doubt //needed in customer_supplier app
      zterm                                                                       as PaymentTerms,              //needed in customer_supplier app
      inco2                                                                       as IncotermsTransferLocation, //needed in customer_supplier app

      awahr                                                                       as ItemOrderProbabilityInPercent,
      inco3_l                                                                     as IncotermsLocation2,
      begru                                                                       as AuthorizationGroup,
      bzirk                                                                       as SalesDistrict,

      incov                                                                       as IncotermsVersion,
      inco2_l                                                                     as IncotermsLocation1,
      loevm                                                                       as DeletionIndicator,
      cvp_xblck_v                                                                 as IsBusinessPurposeCompleted,
      vsort                                                                       as SalesItemProposal,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_CustProdProposalProcedure'
      pvksm                                                                       as CustProdProposalProcedure,

      cast( left( cast( div(podtg, 240000) as abap.char(13) ), 6 ) as abap.tims ) as ProofOfDeliveryTime, //in hhhhhhh:mm:ss, divide by 24 for number of days *Conversion Exit ATC*
      antlf                                                                       as MaxNmbrOfPartialDelivery,
      untto                                                                       as UnderdelivTolrtdLmtRatioInPct,
      uebto                                                                       as OverdelivTolrtdLmtRatioInPct,
      //For extensibility
      cast( 'X' as sdraft_is_active preserving type )                             as IsActiveEntity,

      kvgr1                                                                       as AdditionalCustomerGroup1,
      kvgr2                                                                       as AdditionalCustomerGroup2,
      kvgr3                                                                       as AdditionalCustomerGroup3,
      kvgr4                                                                       as AdditionalCustomerGroup4,
      kvgr5                                                                       as AdditionalCustomerGroup5,

      @ObjectModel.foreignKey.association: '_FactoryCalendar'
      perrl                                                                       as InvoiceListSchedule,
      @ObjectModel.foreignKey.association: '_ExchangeRateType'
      kurst                                                                       as ExchangeRateType,
      @ObjectModel.foreignKey.association: '_PaytGuarProcedVH'
      kabss                                                                       as PaymentGuaranteeProcedure,

      agrel                                                                       as SuplrIsRlvtForSettlmtMgmt,
      megru                                                                       as ProductUnitGroup,
      podkz                                                                       as SlsDocIsRlvtForProofOfDeliv,
      uebtk                                                                       as SlsUnlmtdOvrdelivIsAllwd,
      kkber                                                                       as CreditControlArea,
      bokre                                                                       as CustomerIsRebateRelevant,
      prfre                                                                       as InspSbstHasNoTimeOrQuantity,
      mrnkz                                                                       as ManualInvoiceMaintIsRelevant,
      cast(   inco2_key  as /sapapo/location_uuid)                                as IncotermsSupChnLoc1AddlUUID,
      cast(   inco3_key  as /sapapo/location_uuid)                                as IncotermsSupChnLoc2AddlUUID,
      cast(   inco4_key  as /sapapo/location_uuid)                                as IncotermsSupChnDvtgLocAddlUUID,
    
      //cast( cassd as abap.char(1))                                                           as SalesIsBlockedForCustomer,



      _Customer,
      _SalesOrganization,
      _DistributionChannel,
      _Division,
      _SalesOffice,
      _SalesGroup,
      _Currency,
      _DeliveryPriority,
      _ShippingCondition,
      _IncotermsClassification,
      _SupplyingPlant,
      _DeliveryIsBlockedForCustomer,
      _BillingIsBlockedForCustomer,
      _CustomerPaymentTerms,
      _CustomerAccountAssgmtGroup,
      _CustProdProposalProcedure,
      _FactoryCalendar,
      _ExchangeRateType,
      _PaytGuarProcedVH,
      _SalesAreaAddr
      //  _Tlocation1

}
