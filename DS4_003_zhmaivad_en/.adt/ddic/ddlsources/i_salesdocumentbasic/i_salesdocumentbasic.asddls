@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Sales Document Basic'
@VDM.viewType: #BASIC
@AccessControl: {
  authorizationCheck: #CHECK,
  privilegedAssociations: [ '_CreatedByUser', '_LastChangedByUser', '_BusinessAreaText','_CostCenterBusinessAreaText','_CreditControlAreaText' ]
}
@AbapCatalog: {
  sqlViewName: 'ISDSALESDOCBSC',
  preserveKey: true,
  compiler.compareFilter: true
}
@ObjectModel: {
   compositionRoot: true,
   representativeKey: 'SalesDocument',
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #L
   }
}
@Analytics.dataCategory: #DIMENSION
@Metadata.allowExtensions: true

define view I_SalesDocumentBasic
  as select from vbak

  //Association

  //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
  association [0..*] to I_BusinessAreaText             as _BusinessAreaText              on  $projection.BusinessArea = _BusinessAreaText.BusinessArea
  association [0..*] to I_BusinessAreaText             as _CostCenterBusinessAreaText    on  $projection.CostCenterBusinessArea = _CostCenterBusinessAreaText.BusinessArea
  association [0..*] to I_CreditControlAreaText        as _CreditControlAreaText         on  $projection.CreditControlArea = _CreditControlAreaText.CreditControlArea
  // ]--GENERATED
  association [0..*] to I_SalesDocumentItemBasic       as _ItemBasic                     on  $projection.SalesDocument = _ItemBasic.SalesDocument
  association [0..1] to I_SDDocumentCategory           as _SDDocumentCategory            on  $projection.SDDocumentCategory = _SDDocumentCategory.SDDocumentCategory
  association [0..1] to I_SalesDocumentType            as _SalesDocumentType             on  $projection.SalesDocumentType = _SalesDocumentType.SalesDocumentType
  association [0..1] to I_User                         as _CreatedByUser                 on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_User                         as _LastChangedByUser             on  $projection.LastChangedByUser = _LastChangedByUser.UserID
  association [0..1] to I_SalesOrganization            as _SalesOrganization             on  $projection.SalesOrganization = _SalesOrganization.SalesOrganization
  association [0..1] to I_DistributionChannel          as _DistributionChannel           on  $projection.DistributionChannel = _DistributionChannel.DistributionChannel
  association [0..1] to I_Division                     as _OrganizationDivision          on  $projection.OrganizationDivision = _OrganizationDivision.Division
  association [0..1] to I_SalesGroup                   as _SalesGroup                    on  $projection.SalesGroup = _SalesGroup.SalesGroup
  association [0..1] to I_SalesOffice                  as _SalesOffice                   on  $projection.SalesOffice = _SalesOffice.SalesOffice
  association [0..1] to I_Customer                     as _SoldToParty                   on  $projection.SoldToParty = _SoldToParty.Customer
  association [0..1] to I_AdditionalCustomerGroup1     as _AdditionalCustomerGroup1      on  $projection.AdditionalCustomerGroup1 = _AdditionalCustomerGroup1.AdditionalCustomerGroup1
  association [0..1] to I_AdditionalCustomerGroup2     as _AdditionalCustomerGroup2      on  $projection.AdditionalCustomerGroup2 = _AdditionalCustomerGroup2.AdditionalCustomerGroup2
  association [0..1] to I_AdditionalCustomerGroup3     as _AdditionalCustomerGroup3      on  $projection.AdditionalCustomerGroup3 = _AdditionalCustomerGroup3.AdditionalCustomerGroup3
  association [0..1] to I_AdditionalCustomerGroup4     as _AdditionalCustomerGroup4      on  $projection.AdditionalCustomerGroup4 = _AdditionalCustomerGroup4.AdditionalCustomerGroup4
  association [0..1] to I_AdditionalCustomerGroup5     as _AdditionalCustomerGroup5      on  $projection.AdditionalCustomerGroup5 = _AdditionalCustomerGroup5.AdditionalCustomerGroup5
  association [0..1] to I_CreditControlArea            as _CreditControlArea             on  $projection.CreditControlArea = _CreditControlArea.CreditControlArea
  association [0..1] to I_SDDocumentReason             as _SDDocumentReason              on  $projection.SDDocumentReason = _SDDocumentReason.SDDocumentReason
  association [0..1] to I_CustomerPurchaseOrderType    as _CustomerPurchaseOrderType     on  $projection.CustomerPurchaseOrderType = _CustomerPurchaseOrderType.CustomerPurchaseOrderType

  association [0..1] to I_Currency                     as _StatisticsCurrency            on  $projection.StatisticsCurrency = _StatisticsCurrency.Currency
  association [0..1] to I_RetsMgmtProcess              as _RetsMgmtProcess               on  $projection.RetsMgmtProcess = _RetsMgmtProcess.RetsMgmtProcess
  association [0..1] to I_DelivSchedTypeMRPRlvnceCode  as _DelivSchedTypeMRPRlvnceCode   on  $projection.DelivSchedTypeMRPRlvnceCode = _DelivSchedTypeMRPRlvnceCode.DelivSchedTypeMRPRlvnceCode
  association [0..1] to I_Currency                     as _TransactionCurrency           on  $projection.TransactionCurrency = _TransactionCurrency.Currency
  association [0..1] to I_ShippingCondition            as _ShippingCondition             on  $projection.ShippingCondition = _ShippingCondition.ShippingCondition
  association [0..1] to I_DeliveryBlockReason          as _DeliveryBlockReason           on  $projection.DeliveryBlockReason = _DeliveryBlockReason.DeliveryBlockReason
  association [0..1] to I_CompanyCode                  as _BillingCompanyCode            on  $projection.BillingCompanyCode = _BillingCompanyCode.CompanyCode
  association [0..1] to I_BillingBlockReason           as _HeaderBillingBlockReason      on  $projection.HeaderBillingBlockReason = _HeaderBillingBlockReason.BillingBlockReason
  association [0..1] to I_SalesDocApprovalReason       as _SalesDocApprovalReason        on  $projection.SDDocumentCategory     = _SalesDocApprovalReason.SDDocumentCategory
                                                                                         and $projection.SalesDocApprovalReason = _SalesDocApprovalReason.SalesDocApprovalReason

  association [0..1] to I_ExchangeRateType             as _ExchangeRateType              on  $projection.ExchangeRateType = _ExchangeRateType.ExchangeRateType
  association [0..1] to I_BusinessArea                 as _BusinessArea                  on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [0..1] to I_BusinessArea                 as _CostCenterBusinessArea        on  $projection.CostCenterBusinessArea = _CostCenterBusinessArea.BusinessArea
  association [0..1] to I_CostCenter                   as _CostCenter                    on  $projection.CostCenter        = _CostCenter.CostCenter
                                                                                         and $projection.ControllingArea   = _CostCenter.ControllingArea
                                                                                         and _CostCenter.ValidityEndDate   >= $projection.SalesDocumentDate
                                                                                         and _CostCenter.ValidityStartDate <= $projection.SalesDocumentDate

  association [0..1] to I_SlsPricingProcedure          as _SDPricingProcedure            on  $projection.SDPricingProcedure = _SDPricingProcedure.PricingProcedure

  association [0..1] to I_ControllingArea              as _ControllingArea               on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association [0..1] to I_ControllingObject            as _ControllingObject             on  $projection.ControllingObject = _ControllingObject.ControllingObject
  association [0..1] to I_SDDocumentCategory           as _ReferenceSDDocumentCategory   on  $projection.ReferenceSDDocumentCategory = _ReferenceSDDocumentCategory.SDDocumentCategory
  association [0..*] to I_EngagementProjectItem        as _EngagementProjectItem         on  $projection.SalesDocument                        = _EngagementProjectItem.EngagementProjectItem
                                                                                         and _EngagementProjectItem.EngagementProjectItemType = '0SOH'
  association [0..1] to I_SalesArea                    as _SalesArea                     on  $projection.SalesOrganization    = _SalesArea.SalesOrganization
                                                                                         and $projection.DistributionChannel  = _SalesArea.DistributionChannel
                                                                                         and $projection.OrganizationDivision = _SalesArea.Division

  association [0..1] to I_OverallSDProcessStatus       as _OverallSDProcessStatus        on  $projection.OverallSDProcessStatus = _OverallSDProcessStatus.OverallSDProcessStatus
  association [0..1] to I_OverallPurchaseConfStatus    as _OverallPurchaseConfStatus     on  $projection.OverallPurchaseConfStatus = _OverallPurchaseConfStatus.OverallPurchaseConfStatus
  association [0..1] to I_OverallSDDocumentRjcnStatus  as _OverallSDDocumentRejectionSts on  $projection.OverallSDDocumentRejectionSts = _OverallSDDocumentRejectionSts.OverallSDDocumentRejectionSts
  association [0..1] to I_TotalBlockStatus             as _TotalBlockStatus              on  $projection.TotalBlockStatus = _TotalBlockStatus.TotalBlockStatus
  association [0..1] to I_OverallDelivConfStatus       as _OverallDelivConfStatus        on  $projection.OverallDelivConfStatus = _OverallDelivConfStatus.OverallDelivConfStatus
  association [0..1] to I_OverallTotalDeliveryStatus   as _OverallTotalDeliveryStatus    on  $projection.OverallTotalDeliveryStatus = _OverallTotalDeliveryStatus.OverallTotalDeliveryStatus
  association [0..1] to I_OverallDeliveryStatus        as _OverallDeliveryStatus         on  $projection.OverallDeliveryStatus = _OverallDeliveryStatus.OverallDeliveryStatus
  association [0..1] to I_OverallDeliveryBlockStatus   as _OverallDeliveryBlockStatus    on  $projection.OverallDeliveryBlockStatus = _OverallDeliveryBlockStatus.OverallDeliveryBlockStatus
  association [0..1] to I_OverallOrdReltdBillgStatus   as _OverallOrdReltdBillgStatus    on  $projection.OverallOrdReltdBillgStatus = _OverallOrdReltdBillgStatus.OverallOrdReltdBillgStatus
  association [0..1] to I_OverallBillingBlockStatus    as _OverallBillingBlockStatus     on  $projection.OverallBillingBlockStatus = _OverallBillingBlockStatus.OverallBillingBlockStatus
  association [0..1] to I_OverallTotalSDDocRefStatus   as _OverallTotalSDDocRefStatus    on  $projection.OverallTotalSDDocRefStatus = _OverallTotalSDDocRefStatus.OverallTotalSDDocRefStatus
  association [0..1] to I_OverallSDDocReferenceStatus  as _OverallSDDocReferenceStatus   on  $projection.OverallSDDocReferenceStatus = _OverallSDDocReferenceStatus.OverallSDDocReferenceStatus
  association [0..1] to I_TotalCreditCheckStatus       as _TotalCreditCheckStatus        on  $projection.TotalCreditCheckStatus = _TotalCreditCheckStatus.TotalCreditCheckStatus
  association [0..1] to I_MaxDocValueCreditCheckSts    as _MaxDocValueCreditCheckStatus  on  $projection.MaxDocValueCreditCheckStatus = _MaxDocValueCreditCheckStatus.MaxDocValueCreditCheckStatus
  association [0..1] to I_PaymentTermCreditCheckSts    as _PaymentTermCreditCheckStatus  on  $projection.PaymentTermCreditCheckStatus = _PaymentTermCreditCheckStatus.PaymentTermCreditCheckStatus
  association [0..1] to I_FinDocCreditCheckStatus      as _FinDocCreditCheckStatus       on  $projection.FinDocCreditCheckStatus = _FinDocCreditCheckStatus.FinDocCreditCheckStatus
  association [0..1] to I_ExprtInsurCreditCheckStatus  as _ExprtInsurCreditCheckStatus   on  $projection.ExprtInsurCreditCheckStatus = _ExprtInsurCreditCheckStatus.ExprtInsurCreditCheckStatus
  association [0..1] to I_PaytAuthsnCreditCheckSts     as _PaytAuthsnCreditCheckSts      on  $projection.PaytAuthsnCreditCheckSts = _PaytAuthsnCreditCheckSts.PaytAuthsnCreditCheckSts
  association [0..1] to I_CentralCreditCheckStatus     as _CentralCreditCheckStatus      on  $projection.CentralCreditCheckStatus = _CentralCreditCheckStatus.CentralCreditCheckStatus
  association [0..1] to I_CentralCreditChkTechErrSts   as _CentralCreditChkTechErrSts    on  $projection.CentralCreditChkTechErrSts = _CentralCreditChkTechErrSts.CentralCreditChkTechErrSts
  association [0..1] to I_HdrGenIncompletionStatus     as _HdrGeneralIncompletionStatus  on  $projection.HdrGeneralIncompletionStatus = _HdrGeneralIncompletionStatus.HdrGeneralIncompletionStatus
  association [0..1] to I_OverallPrcIncompletionSts    as _OverallPricingIncompletionSts on  $projection.OverallPricingIncompletionSts = _OverallPricingIncompletionSts.OverallPricingIncompletionSts
  association [0..1] to I_HdrDelivIncompletionStatus   as _HeaderDelivIncompletionStatus on  $projection.HeaderDelivIncompletionStatus = _HeaderDelivIncompletionStatus.HeaderDelivIncompletionStatus
  association [0..1] to I_HdrBillgIncompletionStatus   as _HeaderBillgIncompletionStatus on  $projection.HeaderBillgIncompletionStatus = _HeaderBillgIncompletionStatus.HeaderBillgIncompletionStatus
  association [0..1] to I_OvrlItmGenIncompletionSts    as _OvrlItmGeneralIncompletionSts on  $projection.OvrlItmGeneralIncompletionSts = _OvrlItmGeneralIncompletionSts.OvrlItmGeneralIncompletionSts
  association [0..1] to I_OvrlItmBillgIncompltnSts     as _OvrlItmBillingIncompletionSts on  $projection.OvrlItmBillingIncompletionSts = _OvrlItmBillingIncompletionSts.OvrlItmBillingIncompletionSts
  association [0..1] to I_OvrlItmDelivIncompletionSts  as _OvrlItmDelivIncompletionSts   on  $projection.OvrlItmDelivIncompletionSts = _OvrlItmDelivIncompletionSts.OvrlItmDelivIncompletionSts
  association [0..1] to I_OverallChmlCmplncStatus      as _OverallChmlCmplncStatus       on  $projection.OverallChmlCmplncStatus = _OverallChmlCmplncStatus.OverallChmlCmplncStatus
  association [0..1] to I_OverallDangerousGoodsStatus  as _OverallDangerousGoodsStatus   on  $projection.OverallDangerousGoodsStatus = _OverallDangerousGoodsStatus.OverallDangerousGoodsStatus
  association [0..1] to I_OvrlSftyDataSheetSts         as _OvrlSftyDataSheetSts          on  $projection.OverallSafetyDataSheetStatus = _OvrlSftyDataSheetSts.OverallSafetyDataSheetStatus
  association [0..1] to I_SalesDocApprovalStatus       as _SalesDocApprovalStatus        on  $projection.SalesDocApprovalStatus = _SalesDocApprovalStatus.SalesDocApprovalStatus
  association [0..1] to I_OvrlTradeCmplncEmbargoStatus as _OvrlTradeCmplncEmbargoStatus  on  $projection.OverallTrdCmplncEmbargoSts = _OvrlTradeCmplncEmbargoStatus.OverallTrdCmplncEmbargoSts
  association [0..1] to I_OvTrdCmplncSnctndListChkSts  as _OvTrdCmplncSnctndListChkSts   on  $projection.OvrlTrdCmplncSnctndListChkSts = _OvTrdCmplncSnctndListChkSts.OvrlTrdCmplncSnctndListChkSts
  association [0..1] to I_OvrlTrdCmplncLegalCtrlChkSts as _OvrlTrdCmplncLegalCtrlChkSts  on  $projection.OvrlTrdCmplncLegalCtrlChkSts = _OvrlTrdCmplncLegalCtrlChkSts.OvrlTrdCmplncLegalCtrlChkSts
  association [0..1] to I_OmniChnlSalesPromotionStatus as _OmniChnlSalesPromotionStatus  on  $projection.OmniChnlSalesPromotionStatus = _OmniChnlSalesPromotionStatus.OmniChnlSalesPromotionStatus
  association [0..1] to I_Customer                     as _CustomerCreditAccount         on  $projection.CustomerCreditAccount = _CustomerCreditAccount.Customer
  association [0..1] to I_Currency                     as _ControllingAreaCurrency       on  $projection.ControllingAreaCurrency = _ControllingAreaCurrency.Currency
  association [0..1] to I_Country                      as _TaxDepartureCountry           on  $projection.TaxDepartureCountry = _TaxDepartureCountry.Country
  association [0..1] to I_Country                      as _VATRegistrationCountry        on  $projection.VATRegistrationCountry = _VATRegistrationCountry.Country
  association [0..1] to I_ContractDownPaymentStatus    as _DownPaymentStatus             on  $projection.ContractDownPaymentStatus = _DownPaymentStatus.ContractDownPaymentStatus
  association [0..1] to I_DeliveryDateTypeRule         as _DeliveryDateTypeRule          on  $projection.DeliveryDateTypeRule = _DeliveryDateTypeRule.DeliveryDateTypeRule

  //Solution Order Reference
  association [0..1] to I_ServiceDocumentEnhcd         as _SolutionOrder                 on  $projection.BusinessSolutionOrder = _SolutionOrder.ServiceDocument
                                                                                         and _SolutionOrder.ServiceObjectType  = 'BUS2000172'

{
      //Key
  key vbak.vbeln                                                      as SalesDocument,

      //Category
      @ObjectModel.foreignKey.association: '_SDDocumentCategory'
      vbak.vbtyp                                                      as SDDocumentCategory,
      @ObjectModel.foreignKey.association: '_SalesDocumentType'
      vbak.auart                                                      as SalesDocumentType,
      vbak.vbklt                                                      as SalesDocumentProcessingType,

      //Admin
      //Delete because I_user view no catagory annotation    @ObjectModel.foreignKey.association: '_CreatedByUser'
      vbak.ernam                                                      as CreatedByUser,
      vbak.last_changed_by_user                                       as LastChangedByUser,
      @Semantics.systemDate.createdAt: true
      vbak.erdat                                                      as CreationDate,
      cast( vbak.erzet as creation_time preserving type )             as CreationTime,
      @Semantics.systemDate.lastChangedAt: true
      vbak.aedat                                                      as LastChangeDate,
      @Semantics.systemDateTime.lastChangedAt: true
      vbak.upd_tmstmp                                                 as LastChangeDateTime,
      vbak.mahdt                                                      as LastCustomerContactDate,
      vbak.ext_bus_syst_id                                            as SenderBusinessSystemName,
      vbak.ext_ref_doc_id                                             as ExternalDocumentID,
      vbak.ext_rev_tmstmp                                             as ExternalDocLastChangeDateTime,

      //Organization
      @ObjectModel.foreignKey.association: '_SalesOrganization'
      vbak.vkorg                                                      as SalesOrganization,
      @ObjectModel.foreignKey.association: '_DistributionChannel'
      vbak.vtweg                                                      as DistributionChannel,
      @ObjectModel.foreignKey.association: '_OrganizationDivision'
      vbak.spart                                                      as OrganizationDivision,
      @ObjectModel.foreignKey.association: '_SalesGroup'
      vbak.vkgrp                                                      as SalesGroup,
      @ObjectModel.foreignKey.association: '_SalesOffice'
      vbak.vkbur                                                      as SalesOffice,

      //Sales
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Customer_VH',
                     element: 'Customer' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_SoldToParty'
      vbak.kunnr                                                      as SoldToParty,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup1'
      vbak.kvgr1                                                      as AdditionalCustomerGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup2'
      vbak.kvgr2                                                      as AdditionalCustomerGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup3'
      vbak.kvgr3                                                      as AdditionalCustomerGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup4'
      vbak.kvgr4                                                      as AdditionalCustomerGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup5'
      vbak.kvgr5                                                      as AdditionalCustomerGroup5,
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_CreditControlAreaStdVH',
                     element: 'CreditControlArea' }
        }]
      @ObjectModel.text.association: '_CreditControlAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CreditControlArea'
      vbak.kkber                                                      as CreditControlArea,
      vbak.knuma                                                      as CustomerRebateAgreement,
      vbak.audat                                                      as SalesDocumentDate,
      @ObjectModel.foreignKey.association: '_SDDocumentReason'
      vbak.augru                                                      as SDDocumentReason,
      vbak.submi                                                      as SDDocumentCollectiveNumber,
      @ObjectModel.foreignKey.association: '_CustomerPurchaseOrderType'
      vbak.bsark                                                      as CustomerPurchaseOrderType,
      vbak.bstdk                                                      as CustomerPurchaseOrderDate,
      vbak.bstzd                                                      as CustomerPurchaseOrderSuplmnt,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_StatisticsCurrency'
      vbak.stwae                                                      as StatisticsCurrency,
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_RetsMgmtProcessStdVH',
                     element: 'RetsMgmtProcess' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_RetsMgmtProcess'
      vbak.msr_id                                                     as RetsMgmtProcess,
      vbak.cmnup                                                      as NextCreditCheckDate,

      //Quotation
      vbak.angdt                                                      as BindingPeriodValidityStartDate,
      vbak.bnddt                                                      as BindingPeriodValidityEndDate,
      vbak.awahr                                                      as HdrOrderProbabilityInPercent,

      //SchedulingAgreement
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'DelivSchedTypeMRPRlvnceCode'
      vbak.abdis                                                      as SchedulingAgreementProfileCode,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_DelivSchedTypeMRPRlvnceCode'
      vbak.abdis                                                      as DelivSchedTypeMRPRlvnceCode,
      vbak.guebg                                                      as AgrmtValdtyStartDate,
      vbak.gueen                                                      as AgrmtValdtyEndDate,

      //Material Usage Indicator
      vbak.abrvw                                                      as MatlUsageIndicator,

      //Pricing
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbak.netwr                                                      as TotalNetAmount,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_TransactionCurrency'
      vbak.waerk                                                      as TransactionCurrency,
      vbak.knumv                                                      as SalesDocumentCondition,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SDPricingProcedure'
      vbak.kalsm                                                      as SDPricingProcedure,

      vbak.taxk1                                                      as CustomerTaxClassification1,
      vbak.taxk2                                                      as CustomerTaxClassification2,
      vbak.taxk3                                                      as CustomerTaxClassification3,
      vbak.taxk4                                                      as CustomerTaxClassification4,
      vbak.taxk5                                                      as CustomerTaxClassification5,
      vbak.taxk6                                                      as CustomerTaxClassification6,
      vbak.taxk7                                                      as CustomerTaxClassification7,
      vbak.taxk8                                                      as CustomerTaxClassification8,
      vbak.taxk9                                                      as CustomerTaxClassification9,

      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_TaxDepartureCountry'
      vbak.landtx                                                     as TaxDepartureCountry,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_VATRegistrationCountry'
      vbak.stceg_l                                                    as VATRegistrationCountry,

      //Shipping
      cast(vbak.vdatu as reqd_delivery_date preserving type)          as RequestedDeliveryDate,
      @ObjectModel.foreignKey.association: '_ShippingCondition'
      vbak.vsbed                                                      as ShippingCondition,
      vbak.autlf                                                      as CompleteDeliveryIsDefined,
      @ObjectModel.foreignKey.association: '_DeliveryBlockReason'
      vbak.lifsk                                                      as DeliveryBlockReason,

      //Fashion
      vbak.fsh_candate                                                as FashionCancelDate,

      //Billing
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_CompanyCodeStdVH',
                     element: 'CompanyCode' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_BillingCompanyCode'
      vbak.bukrs_vf                                                   as BillingCompanyCode,
      @ObjectModel.foreignKey.association: '_HeaderBillingBlockReason'
      vbak.faksk                                                      as HeaderBillingBlockReason,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesDocApprovalReason'
      vbak.apm_approval_reason                                        as SalesDocApprovalReason,

      //Accounting
      @ObjectModel.foreignKey.association: '_ExchangeRateType'
      vbak.kurst                                                      as ExchangeRateType,
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BusinessAreaStdVH',
                     element: 'BusinessArea' }
        }]
      @ObjectModel.text.association: '_BusinessAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_BusinessArea'
      vbak.gsber                                                      as BusinessArea,
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BusinessAreaStdVH',
                     element: 'BusinessArea' }
        }]
      @ObjectModel.text.association: '_CostCenterBusinessAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CostCenterBusinessArea'
      vbak.gskst                                                      as CostCenterBusinessArea,
      //Delete because I_costcenter view no catagory annotation @ObjectModel.foreignKey.association: '_CostCenter'
      vbak.kostl                                                      as CostCenter,
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ControllingAreaStdVH',
                     element: 'ControllingArea' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ControllingArea'
      vbak.kokrs                                                      as ControllingArea,
      vbak.aufnr                                                      as OrderID,
      //--[ GENERATED:012:GlBfhyFV7kY4hGXbseDAyW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ControllingObjectStdVH',
                     element: 'ControllingObject' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ControllingObject'
      vbak.objnr                                                      as ControllingObject,
      vbak.zuonr                                                      as AssignmentReference,
      vbak.rplnr                                                      as PaymentPlan,
      //Credit Block
      //vbak.bstnk     as PurchaseOrderByCustomer,
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Customer_VH',
                     element: 'Customer' }
        }]
      @ObjectModel.foreignKey.association: '_CustomerCreditAccount'
      vbak.knkli                                                      as CustomerCreditAccount,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_ControllingAreaCurrency'
      vbak.cmwae                                                      as ControllingAreaCurrency,
      @Semantics.amount.currencyCode: 'ControllingAreaCurrency'
      vbak.amtbl                                                      as ReleasedCreditAmount,
      vbak.cmfre                                                      as CreditBlockReleaseDate,
      vbak.cmngv                                                      as NextShippingDate,

      //Reference
      vbak.vgbel                                                      as ReferenceSDDocument,
      @Analytics.internalName: #LOCAL
      vbak.xblnr                                                      as AccountingDocExternalReference,
      @Analytics.internalName: #LOCAL
      vbak.vbeln_grp                                                  as MasterSalesContract,
      @ObjectModel.foreignKey.association: '_ReferenceSDDocumentCategory'
      vbak.vgtyp                                                      as ReferenceSDDocumentCategory,
      vbak.ktext                                                      as SalesItemProposalDescription,
      vbak.ihrez                                                      as CorrespncExternalReference,
      @Analytics.internalName: #LOCAL
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BusinessSolutionOrderStdVH',
                     element: 'BusinessSolutionOrder' }
        }]
      @ObjectModel.foreignKey.association: '_SolutionOrder'
      vbak.solution_order_id                                          as BusinessSolutionOrder,

      //Status
      @ObjectModel.foreignKey.association: '_OverallSDProcessStatus'
      vbak.gbstk                                                      as OverallSDProcessStatus,
      @ObjectModel.foreignKey.association: '_OverallPurchaseConfStatus'
      vbak.costa                                                      as OverallPurchaseConfStatus,
      @ObjectModel.foreignKey.association: '_OverallSDDocumentRejectionSts'
      vbak.abstk                                                      as OverallSDDocumentRejectionSts,
      @ObjectModel.foreignKey.association: '_TotalBlockStatus'
      vbak.spstg                                                      as TotalBlockStatus,
      @ObjectModel.foreignKey.association: '_OverallDelivConfStatus'
      vbak.bestk                                                      as OverallDelivConfStatus,
      @ObjectModel.foreignKey.association: '_OverallTotalDeliveryStatus'
      vbak.lfgsk                                                      as OverallTotalDeliveryStatus,
      @ObjectModel.foreignKey.association: '_OverallDeliveryStatus'
      vbak.lfstk                                                      as OverallDeliveryStatus,
      @ObjectModel.foreignKey.association: '_OverallDeliveryBlockStatus'
      vbak.lsstk                                                      as OverallDeliveryBlockStatus,
      @ObjectModel.foreignKey.association: '_OverallOrdReltdBillgStatus'
      vbak.fksak                                                      as OverallOrdReltdBillgStatus,
      @ObjectModel.foreignKey.association: '_OverallBillingBlockStatus'
      vbak.fsstk                                                      as OverallBillingBlockStatus,
      @ObjectModel.foreignKey.association: '_OverallTotalSDDocRefStatus'
      vbak.rfgsk                                                      as OverallTotalSDDocRefStatus,
      @ObjectModel.foreignKey.association: '_OverallSDDocReferenceStatus'
      vbak.rfstk                                                      as OverallSDDocReferenceStatus,
      @ObjectModel.foreignKey.association: '_TotalCreditCheckStatus'
      vbak.cmgst                                                      as TotalCreditCheckStatus,
      @ObjectModel.foreignKey.association: '_MaxDocValueCreditCheckStatus'
      vbak.cmpsc                                                      as MaxDocValueCreditCheckStatus,
      @ObjectModel.foreignKey.association: '_PaymentTermCreditCheckStatus'
      vbak.cmpsd                                                      as PaymentTermCreditCheckStatus,
      @ObjectModel.foreignKey.association: '_FinDocCreditCheckStatus'
      vbak.cmpsi                                                      as FinDocCreditCheckStatus,
      @ObjectModel.foreignKey.association: '_ExprtInsurCreditCheckStatus'
      vbak.cmpsj                                                      as ExprtInsurCreditCheckStatus,
      @ObjectModel.foreignKey.association: '_PaytAuthsnCreditCheckSts'
      vbak.cmpsk                                                      as PaytAuthsnCreditCheckSts,
      @ObjectModel.foreignKey.association: '_CentralCreditCheckStatus'
      vbak.cmps_cm                                                    as CentralCreditCheckStatus,
      @ObjectModel.foreignKey.association: '_CentralCreditChkTechErrSts'
      vbak.cmps_te                                                    as CentralCreditChkTechErrSts,
      @ObjectModel.foreignKey.association: '_HdrGeneralIncompletionStatus'
      vbak.uvall                                                      as HdrGeneralIncompletionStatus,
      @ObjectModel.foreignKey.association: '_OverallPricingIncompletionSts'
      vbak.uvprs                                                      as OverallPricingIncompletionSts,
      @ObjectModel.foreignKey.association: '_HeaderDelivIncompletionStatus'
      vbak.uvvlk                                                      as HeaderDelivIncompletionStatus,
      @ObjectModel.foreignKey.association: '_HeaderBillgIncompletionStatus'
      vbak.uvfak                                                      as HeaderBillgIncompletionStatus,
      @ObjectModel.foreignKey.association: '_OvrlItmGeneralIncompletionSts'
      vbak.uvals                                                      as OvrlItmGeneralIncompletionSts,
      @ObjectModel.foreignKey.association: '_OvrlItmBillingIncompletionSts'
      vbak.uvfas                                                      as OvrlItmBillingIncompletionSts,
      @ObjectModel.foreignKey.association: '_OvrlItmDelivIncompletionSts'
      vbak.uvvls                                                      as OvrlItmDelivIncompletionSts,
      @ObjectModel.foreignKey.association: '_OverallChmlCmplncStatus'
      cast(vbak.total_pcsta as mon_tdd_total_pcsta preserving type)   as OverallChmlCmplncStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_OverallDangerousGoodsStatus'
      cast(vbak.total_dgsta as mon_tdd_total_dgsta preserving type)   as OverallDangerousGoodsStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_OvrlSftyDataSheetSts'
      cast(vbak.total_sdssta as mon_tdd_total_sdssta preserving type) as OverallSafetyDataSheetStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesDocApprovalStatus'
      vbak.apm_approval_status                                        as SalesDocApprovalStatus,
      vbak.manek                                                      as ContractManualCompletion,
      @ObjectModel.foreignKey.association: '_DownPaymentStatus'
      vbak.dp_clear_sta_hdr                                           as ContractDownPaymentStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_OvrlTradeCmplncEmbargoStatus'
      vbak.total_emcst                                                as OverallTrdCmplncEmbargoSts,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_OvTrdCmplncSnctndListChkSts'
      vbak.total_slcst                                                as OvrlTrdCmplncSnctndListChkSts,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_OvrlTrdCmplncLegalCtrlChkSts'
      vbak.total_lccst                                                as OvrlTrdCmplncLegalCtrlChkSts,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_DeliveryDateTypeRule'
      vbak.delivery_date_type_rule                                    as DeliveryDateTypeRule,

      vbak.crossitem_prc_date                                         as AlternativePricingDate,
      vbak.bob_status                                                 as OmniChnlSalesPromotionStatus,
      
      vbak.xegdr                                                      as IsEUTriangularDeal,

      //Associations
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _ItemBasic,
      _SDDocumentCategory,
      _SalesDocumentType,
      _CreatedByUser,
      _LastChangedByUser,
      _SalesOrganization,
      _DistributionChannel,
      _OrganizationDivision,
      _SalesGroup,
      _SalesOffice,
      _SoldToParty,
      _AdditionalCustomerGroup1,
      _AdditionalCustomerGroup2,
      _AdditionalCustomerGroup3,
      _AdditionalCustomerGroup4,
      _AdditionalCustomerGroup5,
      _CreditControlArea,
      _SDDocumentReason,
      _CustomerPurchaseOrderType,
      _StatisticsCurrency,
      _RetsMgmtProcess,
      _DelivSchedTypeMRPRlvnceCode,
      _TransactionCurrency,
      _ShippingCondition,
      _DeliveryBlockReason,
      _BillingCompanyCode,
      _HeaderBillingBlockReason,
      _SalesDocApprovalReason,
      _ExchangeRateType,
      _BusinessArea,
      _CostCenterBusinessArea,
      _CostCenter,
      _SDPricingProcedure,
      _ControllingArea,
      _ControllingObject,
      _ReferenceSDDocumentCategory,
      _EngagementProjectItem,
      _SalesArea,

      _OverallSDProcessStatus,
      _OverallPurchaseConfStatus,
      _OverallSDDocumentRejectionSts,
      _TotalBlockStatus,
      _OverallDelivConfStatus,
      _OverallTotalDeliveryStatus,
      _OverallDeliveryStatus,
      _OverallDeliveryBlockStatus,
      _OverallOrdReltdBillgStatus,
      _OverallBillingBlockStatus,
      _OverallTotalSDDocRefStatus,
      _OverallSDDocReferenceStatus,
      _TotalCreditCheckStatus,
      _MaxDocValueCreditCheckStatus,
      _PaymentTermCreditCheckStatus,
      _FinDocCreditCheckStatus,
      _ExprtInsurCreditCheckStatus,
      _PaytAuthsnCreditCheckSts,
      _CentralCreditCheckStatus,
      _CentralCreditChkTechErrSts,
      _HdrGeneralIncompletionStatus,
      _OverallPricingIncompletionSts,
      _HeaderDelivIncompletionStatus,
      _HeaderBillgIncompletionStatus,
      _OvrlItmGeneralIncompletionSts,
      _OvrlItmBillingIncompletionSts,
      _OvrlItmDelivIncompletionSts,
      _OverallChmlCmplncStatus,
      _OverallDangerousGoodsStatus,
      _OvrlSftyDataSheetSts,
      _SalesDocApprovalStatus,
      _DownPaymentStatus,
      _OvrlTradeCmplncEmbargoStatus,
      _OvTrdCmplncSnctndListChkSts,
      _OvrlTrdCmplncLegalCtrlChkSts,
      _OmniChnlSalesPromotionStatus,
      @Consumption.hidden: true
      _BusinessAreaText,
      @Consumption.hidden: true
      _CostCenterBusinessAreaText,
      @Consumption.hidden: true
      _CreditControlAreaText,
      _CustomerCreditAccount,
      _ControllingAreaCurrency,
      _DeliveryDateTypeRule,
      _SolutionOrder,
      _TaxDepartureCountry,
      _VATRegistrationCountry

};
