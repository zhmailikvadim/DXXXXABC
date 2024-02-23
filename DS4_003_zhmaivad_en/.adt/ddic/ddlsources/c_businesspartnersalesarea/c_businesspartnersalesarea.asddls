@AbapCatalog.sqlViewName: 'CBUPASALESAREA'
@AbapCatalog.compiler.compareFilter: true

@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED

@EndUserText.label: 'Consumption view for customer sales area'

@Metadata.allowExtensions: true

@ObjectModel.type: #CONSUMPTION
@ObjectModel.writeEnabled: true
@ObjectModel: {
    semanticKey: ['BusinessPartner','SalesOrganizationForEdit','DistributionChannelForEdit','DivisionForEdit'],
    createEnabled,
    updateEnabled,
    deleteEnabled,
    text.control: #ASSOCIATED_TEXT_UI_HIDDEN //texts will be shown together with the Code values. if the Code values are hidden, then texts wont be visible in UI. no independent visibility for text fields
}
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

@Search.searchable: true

@UI.headerInfo:{
  typeName: 'Sales Area',
  typeNamePlural: 'Sales Areas',
  title:  { label: 'Sales Organization Description', value: 'SalesOrganizationName' }
}

@VDM.viewType: #CONSUMPTION

define view C_BusinessPartnerSalesArea
  as select from I_BusinessPartnerSalesAreaTP as BusinessPartnerSalesArea
  association [1..*] to C_Businesspartnersalesareatax  as _BusinessPartnerSalesAreaTax   on  $projection.BusinessPartner     = _BusinessPartnerSalesAreaTax.BusinessPartner
                                                                                         and $projection.SalesOrganization   = _BusinessPartnerSalesAreaTax.SalesOrganization
                                                                                         and $projection.DistributionChannel = _BusinessPartnerSalesAreaTax.DistributionChannel
                                                                                         and $projection.Division            = _BusinessPartnerSalesAreaTax.Division
  association [1..*] to C_BusinessPartnerPartFunc      as _BusinessPartnerPartFunc       on  $projection.BusinessPartner     = _BusinessPartnerPartFunc.BusinessPartner
                                                                                         and $projection.SalesOrganization   = _BusinessPartnerPartFunc.SalesOrganization
                                                                                         and $projection.DistributionChannel = _BusinessPartnerPartFunc.DistributionChannel
                                                                                         and $projection.Division            = _BusinessPartnerPartFunc.Division

  association [1..*] to C_BPSalesAreaText              as _BPSalesAreaText               on  $projection.BusinessPartner     = _BPSalesAreaText.BusinessPartner
                                                                                         and $projection.SalesOrganization   = _BPSalesAreaText.SalesOrganization
                                                                                         and $projection.DistributionChannel = _BPSalesAreaText.DistributionChannel
                                                                                         and $projection.Division            = _BPSalesAreaText.Division

  association [1..1] to C_BusinessPartnerCustomer      as _BusinessPartnerCustomer       on  $projection.BusinessPartner = _BusinessPartnerCustomer.BusinessPartner
  association [1..1] to C_BusinessPartner              as _BusinessPartner               on  $projection.BusinessPartner = _BusinessPartner.BusinessPartner
  //Value help views
  association [0..1] to C_SalesOrgVHTemp               as _SalesOrgValueHelp             on  $projection.SalesOrganizationForEdit   = _SalesOrgValueHelp.SalesOrganization
                                                                                         and $projection.DistributionChannelForEdit = _SalesOrgValueHelp.DistributionChannel
                                                                                         and $projection.DivisionForEdit            = _SalesOrgValueHelp.Division

  association [0..1] to C_SalesOrgVHTemp               as _DistrChnlValueHelp            on  $projection.SalesOrganizationForEdit   = _DistrChnlValueHelp.SalesOrganization
                                                                                         and $projection.DistributionChannelForEdit = _DistrChnlValueHelp.DistributionChannel
                                                                                         and $projection.DivisionForEdit            = _DistrChnlValueHelp.Division

  association [0..1] to C_SalesOrgVHTemp               as _DivisionValueHelp             on  $projection.DivisionForEdit            = _DivisionValueHelp.Division
                                                                                         and $projection.SalesOrganizationForEdit   = _DivisionValueHelp.SalesOrganization
                                                                                         and $projection.DistributionChannelForEdit = _DivisionValueHelp.DistributionChannel
  //Text views
  association [0..*] to I_CustomerPaytGuarProcedT      as _PaymentGuaranteeProcedureText on  $projection.PaymentGuaranteeProcedure = _PaymentGuaranteeProcedureText.CustomerPaytGuarProced
  association [0..*] to C_SalesOrgTextVHTemp           as _SalesOrgText                  on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
  association [0..*] to C_Distrchnltextvhtemp          as _DistrChnlText                 on  $projection.DistributionChannel = _DistrChnlText.DistributionChannel
  association [0..*] to C_Divisiontextvhtemp           as _DivisionText                  on  $projection.Division = _DivisionText.Division
  association [0..*] to I_SalesOfficeText              as _SalesOfficeText               on  $projection.SalesOffice = _SalesOfficeText.SalesOffice
  association [0..*] to I_SalesGroupText               as _SalesGroupText                on  $projection.SalesGroup = _SalesGroupText.SalesGroup
  association [0..*] to C_Currencytextvhtemp           as _CurrencyText                  on  $projection.Currency = _CurrencyText.Currency
  association [1..*] to C_InvoiceDatesTextVHTemp       as _InvoiceDatesText              on  $projection.InvoiceDate = _InvoiceDatesText.FactoryCalendar
  association [0..*] to C_IncotermsVersionTextVHTemp   as _IncotermsVersionText          on  $projection.IncotermsVersion = _IncotermsVersionText.IncotermsVersion
  association [0..*] to C_IncotermsClassfctnTextVHTemp as _IncotermsText                 on  $projection.IncotermsClassification = _IncotermsText.IncotermsClassification
  association [0..*] to C_CustPaymentTermsTextVHTemp   as _CustPaymentTermsText          on  $projection.CustomerPaymentTerms = _CustPaymentTermsText.CustomerPaymentTerms
  association [0..*] to C_Partialdeliperitemtextvhtemp as _PartialDeliveryText           on  $projection.PartialDeliveryIsAllowed = _PartialDeliveryText.PartialDeliveryIsAllowed
  association [1..*] to C_CustPriceProcedureTextVHTemp as _CustPriceProcedureText        on  $projection.CustomerPricingProcedure = _CustPriceProcedureText.CustomerPricingProcedure
  association [0..1] to I_PriceListType                as _PriceListType                 on  $projection.PriceListType = _PriceListType.PriceListType
  association [0..*] to I_PriceListTypeText            as _PriceListTypeText             on  $projection.PriceListType = _PriceListTypeText.PriceListType
  association [0..1] to C_DeliveryPlantTextVHTEMP      as _DeliveryPlantText             on  $projection.SupplyingPlant      = _DeliveryPlantText.Plant
                                                                                         and $projection.SalesOrganization   = _DeliveryPlantText.SalesOrganization
                                                                                         and $projection.DistributionChannel = _DeliveryPlantText.DistributionChannel
  association [0..*] to I_DeliveryPriorityText         as _DeliveryPriorityText          on  $projection.DeliveryPriority = _DeliveryPriorityText.DeliveryPriority
  association [0..1] to C_OrderIsBlockedTextVHTemp     as _OrderBlockValueHelp           on  $projection.OrderIsBlockedForCustomer = _OrderBlockValueHelp.OrderIsBlockedForCustomer
  association [0..*] to I_UOMGroup                     as _ProductUnitGroup              on  $projection.ProductUnitGroup = _ProductUnitGroup.ProductUnitGroup
  association [0..*] to I_CreditControlAreaText        as _CreditControlAreaText         on  $projection.CreditControlArea = _CreditControlAreaText.CreditControlArea

  association [0..*] to I_AdditionalCustomerGroup1Text as _AdditionalCustGroupOneText    on  $projection.AdditionalCustomerGroup1 = _AdditionalCustGroupOneText.AdditionalCustomerGroup1
  association [0..*] to I_AdditionalCustomerGroup2Text as _AdditionalCustGroupTwoText    on  $projection.AdditionalCustomerGroup2 = _AdditionalCustGroupTwoText.AdditionalCustomerGroup2
  association [0..*] to I_AdditionalCustomerGroup3Text as _AdditionalCustGroupThreeText  on  $projection.AdditionalCustomerGroup3 = _AdditionalCustGroupThreeText.AdditionalCustomerGroup3
  association [0..*] to I_AdditionalCustomerGroup4Text as _AdditionalCustGroupFourText   on  $projection.AdditionalCustomerGroup4 = _AdditionalCustGroupFourText.AdditionalCustomerGroup4
  association [0..*] to I_AdditionalCustomerGroup5Text as _AdditionalCustGroupFiveText   on  $projection.AdditionalCustomerGroup5 = _AdditionalCustGroupFiveText.AdditionalCustomerGroup5



  association [1..*] to I_BusPartAuthorizationGroupTxt as _AuthorizationGrpText          on  $projection.AuthorizationGroup            = _AuthorizationGrpText.AuthorizationGroup
                                                                                         and _AuthorizationGrpText.AuthorizationObject = 'BUPA'
  association [1..*] to C_BPCustSlsAreaAddrDepdntInfo  as _CustSlsAreaAddrDepdntInfo     on  $projection.BusinessPartner     = _CustSlsAreaAddrDepdntInfo.BusinessPartner
                                                                                         and $projection.SalesOrganization   = _CustSlsAreaAddrDepdntInfo.SalesOrganization
                                                                                         and $projection.DistributionChannel = _CustSlsAreaAddrDepdntInfo.DistributionChannel
                                                                                         and $projection.Division            = _CustSlsAreaAddrDepdntInfo.Division
  association [0..1] to I_TransportationLocationVH     as _TransportLocationVHText       on  $projection.IncotermsSupChnDvtgLocAddlUUID = _TransportLocationVHText.LocationAdditionalUUID

{
  key BusinessPartnerSalesArea.BusinessPartner,

  key BusinessPartnerSalesArea.SalesOrganization,

  key BusinessPartnerSalesArea.DistributionChannel,

  key BusinessPartnerSalesArea.Division,

      BusinessPartnerSalesArea.Customer,

      BusinessPartnerSalesArea.BusinessPartnerForEdit,

      BusinessPartnerSalesArea.BusinessPartnerUUID,

      @ObjectModel.text.association: '_SalesOrgText'
      //@ObjectModel: {
      //          foreignKey.association: '_SalesOrgValueHelp'
      //         }
      BusinessPartnerSalesArea.SalesOrganizationForEdit,

      @ObjectModel.readOnly: true
      BusinessPartnerSalesArea.SalesOrganizationName,

      @ObjectModel.text.association: '_DistrChnlText'
      @ObjectModel: {
                 foreignKey.association: '_DistrChnlValueHelp'
               }
      BusinessPartnerSalesArea.DistributionChannelForEdit,

      @ObjectModel.text.association: '_DivisionText'
      @ObjectModel: {
                  foreignKey.association: '_DivisionValueHelp'
                }
      BusinessPartnerSalesArea.DivisionForEdit,

      BusinessPartnerSalesArea.SalesDistrict,

      BusinessPartnerSalesArea.CustomerGroup,

      @ObjectModel.text.association: '_SalesOfficeText'
      BusinessPartnerSalesArea.SalesOffice,

      @ObjectModel.text.association: '_SalesGroupText'
      BusinessPartnerSalesArea.SalesGroup,

      BusinessPartnerSalesArea.AccountByCustomer,

      BusinessPartnerSalesArea.CustomerABCClassification,

      @ObjectModel.text.association: '_CurrencyText'
      BusinessPartnerSalesArea.Currency,

      BusinessPartnerSalesArea.CustomerPriceGroup,

      @ObjectModel.text.association: '_CustPriceProcedureText'
      BusinessPartnerSalesArea.CustomerPricingProcedure,

      @ObjectModel.text.association: '_PriceListTypeText'
      BusinessPartnerSalesArea.PriceListType,

      @ObjectModel.text.association: '_DeliveryPriorityText'
      BusinessPartnerSalesArea.DeliveryPriority,

      BusinessPartnerSalesArea.OrderCombinationIsAllowed,

      BusinessPartnerSalesArea.ShippingCondition,

      @ObjectModel.text.association: '_DeliveryPlantText'
      BusinessPartnerSalesArea.SupplyingPlant,

      @ObjectModel: {
        foreignKey.association: '_OrderBlockValueHelp'
      }
      BusinessPartnerSalesArea.OrderIsBlockedForCustomer,

      BusinessPartnerSalesArea.DeliveryIsBlockedForCustomer,

      BusinessPartnerSalesArea.BillingIsBlockedForCustomer,

      BusinessPartnerSalesArea.CompleteDeliveryIsDefined,

      @ObjectModel.text.association: '_PartialDeliveryText'
      BusinessPartnerSalesArea.PartialDeliveryIsAllowed,

      @ObjectModel.text.association: '_InvoiceDatesText'
      BusinessPartnerSalesArea.InvoiceDate,

      @ObjectModel.text.association: '_IncotermsVersionText'
      BusinessPartnerSalesArea.IncotermsVersion,

      @ObjectModel.text.association: '_IncotermsText'
      BusinessPartnerSalesArea.IncotermsClassification,

      BusinessPartnerSalesArea.IncotermsTransferLocation,

      BusinessPartnerSalesArea.IncotermsLocation1,

      BusinessPartnerSalesArea.IncotermsLocation2,

      @ObjectModel.text.association: '_CustPaymentTermsText'
      BusinessPartnerSalesArea.CustomerPaymentTerms,

      BusinessPartnerSalesArea.CustomerAccountAssignmentGroup,

      @ObjectModel.text.association: '_AuthorizationGrpText'
      BusinessPartnerSalesArea.AuthorizationGroup,

      @ObjectModel.text.association: '_PaymentGuaranteeProcedureText'
      BusinessPartnerSalesArea.PaymentGuaranteeProcedure,

      BusinessPartnerSalesArea.InvoiceListSchedule,
      BusinessPartnerSalesArea.ExchangeRateType,
      BusinessPartnerSalesArea.ItemOrderProbabilityInPercent,
      @ObjectModel.text.association: '_AdditionalCustGroupOneText'
      BusinessPartnerSalesArea.AdditionalCustomerGroup1,
      @ObjectModel.text.association: '_AdditionalCustGroupTwoText'
      BusinessPartnerSalesArea.AdditionalCustomerGroup2,
      @ObjectModel.text.association: '_AdditionalCustGroupThreeText'
      BusinessPartnerSalesArea.AdditionalCustomerGroup3,
      @ObjectModel.text.association: '_AdditionalCustGroupFourText'
      BusinessPartnerSalesArea.AdditionalCustomerGroup4,
      @ObjectModel.text.association: '_AdditionalCustGroupFiveText'
      BusinessPartnerSalesArea.AdditionalCustomerGroup5,


      BusinessPartnerSalesArea.UnderdelivTolrtdLmtRatioInPct,
      BusinessPartnerSalesArea.OverdelivTolrtdLmtRatioInPct,
      BusinessPartnerSalesArea.MaxNmbrOfPartialDelivery,
      BusinessPartnerSalesArea.SuplrIsRlvtForSettlmtMgmt,
      BusinessPartnerSalesArea.ProductUnitGroup,
      BusinessPartnerSalesArea.SlsDocIsRlvtForProofOfDeliv,
      BusinessPartnerSalesArea.SlsUnlmtdOvrdelivIsAllwd,
      @ObjectModel.text.association: '_CreditControlAreaText'
      BusinessPartnerSalesArea.CreditControlArea,
      BusinessPartnerSalesArea.CustomerIsRebateRelevant,
      BusinessPartnerSalesArea.InspSbstHasNoTimeOrQuantity,
      BusinessPartnerSalesArea.ManualInvoiceMaintIsRelevant,
      BusinessPartnerSalesArea.SalesItemProposal,
      BusinessPartnerSalesArea.CustProdProposalProcedure,
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_BP_MULTI_ADDR_BF_CALC_EXIT'
      cast(' ' as abap_boolean preserving type)    as BPCustMultiAddrIsActive,
      // BusinessPartnerSalesArea.SalesIsBlockedForCustomer,
      BusinessPartnerSalesArea.IncotermsLocation1Identifier,
      BusinessPartnerSalesArea.IncotermsLocation2Identifier,
      @ObjectModel.readOnly: true
      @Semantics.text: true
      _TransportLocationVHText.LocationDescription as IncotermsDvtgLocDescription,
      @ObjectModel.text.element: ['IncotermsDvtgLocDescription']
      BusinessPartnerSalesArea.IncotermsDvtgLocIdentifier,
      BusinessPartnerSalesArea.IncotermsSupChnDvtgLocAddlUUID,

      @ObjectModel.association.type: [ #TO_COMPOSITION_ROOT , #TO_COMPOSITION_PARENT ]
      _BusinessPartnerCustomer,
      @ObjectModel.association.type: [ #TO_COMPOSITION_ROOT , #TO_COMPOSITION_PARENT ]
      _BusinessPartner,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _BusinessPartnerPartFunc,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _BusinessPartnerSalesAreaTax,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _BPSalesAreaText,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _CustSlsAreaAddrDepdntInfo,
      _ShippingConditionValueHelp,
      _CustomerGroupValueHelp,
      _CustomerPriceGroupValueHelp,
      _OrderBlockValueHelp,
      _DelivBlkRsnValueHelp,
      _BillingBlockReasonValueHelp,
      _AccountAssgmtGroupValueHelp,
      _SalesDistrictValueHelp,
      _SalesOrgValueHelp,
      _DistrChnlValueHelp,
      _DivisionValueHelp,
      _SalesOrgText,
      _DistrChnlText,
      _DivisionText,
      _SalesOfficeText,
      _SalesGroupText,
      _CurrencyText,
      _InvoiceDatesText,
      _IncotermsVersionText,
      _IncotermsText,
      _CustPaymentTermsText,
      _PaymentGuaranteeProcedureText,
      _PartialDeliveryText,
      _CustPriceProcedureText,
      _PriceListType,
      _PriceListTypeText,
      _DeliveryPlantText,
      _FactoryCalendar,
      _ExchangeRateType,
      _DeliveryPriorityText,
      _ProductUnitGroup,
      _CreditControlAreaText,
      _AdditionalCustGroupOneText,
      _AdditionalCustGroupTwoText,
      _AdditionalCustGroupThreeText,
      _AdditionalCustGroupFourText,
      _AdditionalCustGroupFiveText,
      _AuthorizationGrpText,
      _TransportLocationVHText
}
