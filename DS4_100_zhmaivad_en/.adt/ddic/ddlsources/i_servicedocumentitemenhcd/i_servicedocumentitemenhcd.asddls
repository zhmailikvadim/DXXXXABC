@EndUserText.label: 'Service Transaction Item Enhanced'
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog: {
  sqlViewName: 'ISERVDOCITMENHCD',
  compiler.compareFilter: true,
  preserveKey: true
}

@VDM: {
  viewType: #COMPOSITE,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}

@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #('TRANSACTIONAL_DATA'),
  privilegedAssociations: ['_ServiceDocItemRefObj','_ServiceDocItemMainRefObj']
}

@ObjectModel: {
   representativeKey: 'ServiceDocumentItem',
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #C,
     sizeCategory:   #XXL
   },
   supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE],
   modelingPattern: #ANALYTICAL_DIMENSION
}
@Analytics.dataCategory: #DIMENSION
@Metadata.allowExtensions:true
@Metadata.ignorePropagatedAnnotations: true

define view I_ServiceDocumentItemEnhcd
  as select from I_ServiceDocumentItem
  association [1]    to I_ServiceDocumentEnhcd         as _ServiceDocument              on  $projection.ServiceObjectType = _ServiceDocument.ServiceObjectType
                                                                                        and $projection.ServiceDocument   = _ServiceDocument.ServiceDocument

  association [1]    to I_ServiceDocumentItemEnhcd     as _ParentServiceDocItem         on  $projection.ParentServiceDocumentItemUUID = _ParentServiceDocItem.ServiceDocumentItemUUID

  association [1]    to I_ServiceDocumentItemEnhcd     as _ParentServiceDocItem_2       on  $projection.ServiceObjectType             = _ParentServiceDocItem_2.ServiceObjectType
                                                                                        and $projection.ServiceDocument               = _ParentServiceDocItem_2.ServiceDocument
                                                                                        and $projection.ParentServiceDocumentItemUUID = _ParentServiceDocItem_2.ServiceDocumentItemUUID

  association [0..*] to I_ServiceDocumentRefObject     as _ServiceDocItemRefObj         on  $projection.ServiceObjectType   = _ServiceDocItemRefObj.ServiceObjectType
                                                                                        and $projection.ServiceDocument     = _ServiceDocItemRefObj.ServiceDocument
                                                                                        and $projection.ServiceDocumentItem = _ServiceDocItemRefObj.ServiceDocumentItem

  /*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
  association [0..1] to I_ServiceDocumentRefObject     as _ServiceDocItemMainRefObj     on  $projection.ServiceObjectType                    = _ServiceDocItemMainRefObj.ServiceObjectType
                                                                                        and $projection.ServiceDocument                      = _ServiceDocItemMainRefObj.ServiceDocument
                                                                                        and $projection.ServiceDocumentItem                  = _ServiceDocItemMainRefObj.ServiceDocumentItem
                                                                                        and _ServiceDocItemMainRefObj.SrvcRefObjIsMainObject = 'X'

  association [1..*] to I_ServiceDocItemNote           as _ServiceDocItemNote           on  $projection.ServiceDocumentItemUUID = _ServiceDocItemNote.ServiceDocumentItemUUID

  association [0..1] to I_ServiceDocItemTypeSlsSttg    as _ServiceDocItemTypeSlsSttg    on  $projection.ServiceDocItemCategory = _ServiceDocItemTypeSlsSttg.ServiceDocItemCategory

  association [1]    to I_ServiceDocumentItemPrdcssr   as _ServiceDocItmPredecessor     on  $projection.ServiceDocumentItemUUID       = _ServiceDocItmPredecessor.ServiceDocumentItemUUID
                                                                                        and $projection.ServiceDocumentItemObjectType = _ServiceDocItmPredecessor.ServiceDocumentItemObjectType
                                                                                        and _ServiceDocItmPredecessor.CharcLength     = 32

  association [0..*] to I_ServiceDocumentItemSuccessor as _ServiceDocItmSuccessor       on  $projection.ServiceDocumentItemUUID       = _ServiceDocItmSuccessor.ServiceDocumentItemUUID
                                                                                        and $projection.ServiceDocumentItemObjectType = _ServiceDocItmSuccessor.ServiceDocumentItemObjectType
                                                                                        and _ServiceDocItmSuccessor.CharcLength       = 32

  association [0..1] to I_ServiceDocumentItemPrdcssr_2 as _ServiceDocItmPrdcssr_2       on  $projection.ServiceDocumentItemCharUUID = _ServiceDocItmPrdcssr_2.ServiceDocumentItemCharUUID

  association [0..*] to I_ServiceDocumentItemSuccssr_2 as _ServiceDocItmSuccssr_2       on  $projection.ServiceDocumentItemCharUUID = _ServiceDocItmSuccssr_2.ServiceDocumentItemCharUUID

  association [0..1] to I_ServiceDocumentItemPrdcssr_3 as _ServiceDocumentItemPrdcssr_3 on  $projection.ServiceDocumentItemCharUUID = _ServiceDocumentItemPrdcssr_3.ServiceDocumentItemCharUUID

  association [0..*] to I_ServiceDocumentItemSuccssr_3 as _ServiceDocumentItemSuccssr_3 on  $projection.ServiceDocumentItemCharUUID = _ServiceDocumentItemSuccssr_3.ServiceDocumentItemCharUUID

  association [0..1] to I_MaterialPricingGroup         as _SrvcMaterialPricingGroup     on  $projection.SrvcMaterialPricingGroup = _SrvcMaterialPricingGroup.MaterialPricingGroup

  /*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }
  association [0..1] to I_StatusObjectUUIDStatus       as _SrvcDocItemUserStatus        on  $projection.ServiceDocumentItemUUID   = _SrvcDocItemUserStatus.StatusObjectUUID
                                                                                        and _SrvcDocItemUserStatus.IsUserStatus   = 'X'
                                                                                        and _SrvcDocItemUserStatus.StatusIsActive = 'X' */


  association [0..1] to E_ServiceDocumentItem          as _ServiceDocItemExt            on  $projection.ServiceObjectType   = _ServiceDocItemExt.ServiceCategory
                                                                                        and $projection.ServiceDocument     = _ServiceDocItemExt.ServiceOrderItem
                                                                                        and $projection.ServiceDocumentItem = _ServiceDocItemExt.ServiceLineExternalID
{

      //Header Keys
      @ObjectModel.foreignKey.association: '_ServiceObjType'
  key ServiceObjectType,
      @ObjectModel.foreignKey.association: '_ServiceDocument'
  key ServiceDocument,
      @ObjectModel.text.element: 'ServiceDocumentItemDescription'
  key ServiceDocumentItem,

      // Header Details
      ServiceDocumentDescription,
      // Process Type is required for Search by Document Type view
      @ObjectModel.foreignKey.association: '_ServiceDocumentType'
      ServiceDocumentType,
      ServiceDocumentItemPriority,
      PostingDate,
      ServicesRenderedDate,
      SrvcDocItmPostingDateTime,
      SrvcDocItmValdtyStartDateTime,
      SrvcDocItmValdtyEndDateTime,

      // Item Details
      ServiceDocumentItemUUID,
      ServiceDocumentItemCharUUID,
      ServiceDocumentItemObjectType,
      ServiceDocumentUUID,
      ParentServiceDocumentItemUUID,
      @Semantics.text: true
      ServiceDocumentItemDescription,
      Language,
      ServiceDocumentTemplateType,
      ServiceDocItemCreationDateTime,
      ServiceDocItemChangedDateTime,
      @Semantics.systemDate.createdAt: true
      cast( tstmp_to_dats( ServiceDocItemCreationDateTime,
                   abap_system_timezone( $session.client,'NULL' ),
                   $session.client,
                   'NULL' ) as crms4_created_on preserving type ) as ServiceDocItemCreationDate,
      @Semantics.systemDate.lastChangedAt: true
      cast( tstmp_to_dats( ServiceDocItemChangedDateTime,
                   abap_system_timezone( $session.client,'NULL' ),
                   $session.client,
                   'NULL' ) as crms4_changed_on preserving type ) as ServiceDocItemChangedDate,

      //      @Semantics.systemDate.createdAt: true
      //      cast( cast(substring( cast(ServiceDocItemCreationDateTime as abap.char(30)) , 1 , 8)
      //                            as abap.dats(8))  as crms4_created_on ) as ServiceDocItemCreationDate,
      //      @Semantics.systemDate.lastChangedAt: true
      //      cast( cast(substring( cast(ServiceDocItemChangedDateTime as abap.char(30)) , 1 , 8)
      //                            as abap.dats(8))  as crms4_changed_on ) as ServiceDocItemChangedDate,

      ServiceDocItemCreatedByUser,
      ServiceDocItemChangedByUser,
      OriginallyRequestedProduct,
      @ObjectModel.foreignKey.association: '_Product'
      Product,

      @ObjectModel.foreignKey.association: '_ServiceDocItemCategory'
      ServiceDocItemCategory,
      @ObjectModel.foreignKey.association: '_ProfitCenter'
      ProfitCenter,
      ResponsibleCostCenter,
      @ObjectModel.foreignKey.association: '_ControllingArea'
      ControllingArea,
      ProfitCenterDeterminationDate,
      RefBusinessSolutionOrder,
      RefBusinessSolutionOrderItem,

      // Item - Cumulated Value
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDocItemQuantityUnit'} }
      SrvcDocItmRequestedQuantity,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      InvoiceAmountInInvoiceDocCrcy,
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDocItemQuantityUnit'} }
      InvoiceQuantity,
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDocItemQuantityUnit'} }
      SrvcDocItmDeliveredQuantity,
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDocItemQuantityUnit'} }
      SrvcDocItmReleasedQuantity,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      SrvcDocItmReldAmtInTransCrcy,

      // Item - Product
      SrvcDocItmOrdToBaseQtyNmrtr,
      SrvcDocItmOrdToBaseQtyDnmntr,
      OrderToBaseQuantityExponent,
      @ObjectModel.foreignKey.association: '_SalesUnit'
      @Semantics.unitOfMeasure:true
      ServiceDocItemQuantityUnit,
      @ObjectModel.foreignKey.association: '_BaseUnit_2'
      @Semantics.unitOfMeasure:true
      SrvcDocItemBaseQuantityUnit,

      // Billing Set
      BillingDateTime,
      BillingDocCreationDateTime,
      BillingPlanTimeZone,

      // Item Pricing
      BillingPriceSourceName,
      cast( '' as abap.char( 16 ) )                               as DocumentDescription,

      // Partner Details
      @ObjectModel.foreignKey.association: '_SoldToPartyCountry'
      SoldToPartyCountry,
      @ObjectModel.foreignKey.association: '_SoldToPartyRegion'
      SoldToPartyRegion,
      @ObjectModel.foreignKey.association: '_SoldToParty'
      SoldToParty,
      @ObjectModel.foreignKey.association: '_ServiceTeam'
      ServiceTeam,
      @ObjectModel.foreignKey.association: '_RespEmployee'
      ResponsibleEmployee,
      @ObjectModel.foreignKey.association: '_ServiceEmployee'
      ServiceEmployee,
      @ObjectModel.foreignKey.association: '_ContactPerson'
      ContactPerson,
      @ObjectModel.foreignKey.association: '_PayerParty'
      PayerParty,
      @ObjectModel.foreignKey.association: '_BillToParty'
      BillToParty,
      @ObjectModel.foreignKey.association: '_ShipToParty'
      ShipToParty,

      // Status
      @ObjectModel.foreignKey.association: '_ServiceDocItemStatus'
      ServiceDocumentItemStatus,
      @ObjectModel.foreignKey.association: '_ServiceDocItemHasError'
      ServiceDocumentItemHasError,
      @ObjectModel.foreignKey.association: '_SrvcDocItemIsRelForBillgSts'
      SrvcDocItmIsReleasedForBilling,
      @ObjectModel.foreignKey.association: '_ServiceDocItemBillingStatus'
      ServiceDocItemBillingStatus,
      @ObjectModel.foreignKey.association: '_ServiceDocumentIsOpen'
      ServiceDocumentItemIsOpen,
      SrvcDocItmDeliveryStatus,
      SrvcDocItmGoodsIssueStatus,
      ServiceDocumentItemIsReleased,
      ServiceDocumentItemIsRejected,
      ServiceDocumentItemIsQuotation,

      @ObjectModel.foreignKey.association: '_SrvcDocItemTransferStatus'
      SrvcDocItemTransferStatus,
      MaintSrvcOrdExecutionStatus,

      // Item - Schedule Line
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDocItemQuantityUnit'} }
      ServiceDocumentItemQuantity,

      // Pricing Parameter Set
      @ObjectModel.foreignKey.association: '_TransactionCurrency'
      @Semantics.currencyCode:true
      TransactionCurrency,
      StatisticsCurrency,
      ExchangeRateType,
      ExchangeRateDate,
      AccountingExchangeRate,
      @ObjectModel.foreignKey.association: '_PaymentTerms'
      PaymentTerms,
      @ObjectModel.foreignKey.association: '_BillableControl'
      BillableControl,

      // Item - Pricing
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      ServiceDocumentItemNetAmount,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      ServiceDocumentItemTaxAmount,
      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      ServiceDocItemGrossAmount,

      // Billing Set
      @ObjectModel.foreignKey.association: '_BillingBlockReason'
      BillingBlockReason,

      // Item Product
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: 'SrvcMaterialPricingGroup'
      @ObjectModel.foreignKey.association: '_ProductGroup'
      ProductGroup,
      @ObjectModel.foreignKey.association: '_SrvcMaterialPricingGroup'
      ProductGroup                                                as SrvcMaterialPricingGroup,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup1'
      ProductGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup2'
      ProductGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup3'
      ProductGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup4'
      ProductGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup5'
      ProductGroup5,
      @ObjectModel.foreignKey.association: '_SrvcMgmtProductHierarchy'
      ProductHierarchy,

      // Item - Sales Set
      @ObjectModel.foreignKey.association: '_Industry'
      Industry,
      PurchaseOrderByCustomer,
      @ObjectModel.foreignKey.association: '_ServiceDocItemRejectionReason'
      ServiceDocItemRejectionReason,
      @ObjectModel.foreignKey.association: '_CustomerGroup'
      CustomerGroup,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup1'
      AdditionalCustomerGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup2'
      AdditionalCustomerGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup3'
      AdditionalCustomerGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup4'
      AdditionalCustomerGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup5'
      AdditionalCustomerGroup5,

      // Service Subject
      ServiceSchema1Category1UUID,
      ServiceSchema1Category2UUID,
      ServiceSchema1Category3UUID,
      ServiceSchema1Category4UUID,
      ServiceSchema1Category5UUID,
      ServiceSchema1Category6UUID,
      ServiceSchema1Category7UUID,
      ServiceSchema1Category8UUID,
      ServiceSchema1Category9UUID,
      ServiceSchema1Category10UUID,
      SrvcCatztnSchema1,
      SrvcCatztnSchemaCategory1,

      ServiceSchema2Category1UUID,
      ServiceSchema2Category2UUID,
      ServiceSchema2Category3UUID,
      ServiceSchema2Category4UUID,
      ServiceSchema2Category5UUID,
      ServiceSchema2Category6UUID,
      ServiceSchema2Category7UUID,
      ServiceSchema2Category8UUID,
      ServiceSchema2Category9UUID,
      ServiceSchema2Category10UUID,
      SrvcCatztnSchema2,
      SrvcCatztnSchemaCategory2,

      // Item - Billing Plan
      SettlementPeriodRuleUUID,
      BillingPlanBillingDateRuleUUID,

      // Organization Unit Set
      @ObjectModel.foreignKey.association: '_SalesOrganizationOrgUnit_2'
      SalesOrganizationOrgUnitID,

      @ObjectModel.foreignKey.association: '_SalesOfficeOrgUnit_2'
      SalesOfficeOrgUnitID,

      @ObjectModel.foreignKey.association: '_SalesGroupOrgUnit_2'
      SalesGroupOrgUnitID,

      @ObjectModel.foreignKey.association: '_DistributionChannel'
      DistributionChannel,

      @ObjectModel.foreignKey.association: '_Division'
      Division,
      ResponsibleSalesOrganization,
      @ObjectModel.foreignKey.association: '_ServiceOrganizationOrgUnit_2'
      ServiceOrganization,
      @ObjectModel.foreignKey.association: '_RespSrvcOrganizationOrgUnit_2'
      ResponsibleServiceOrganization,

      // Organizational units with the S/4 SD codes
      @ObjectModel.foreignKey.association: '_SalesOrganization'
      SalesOrganization,

      @ObjectModel.foreignKey.association: '_SalesOffice'
      SalesOffice,

      @ObjectModel.foreignKey.association: '_SalesGroup'
      SalesGroup,

      // Service Organizational Units with S/4 Code
      RespyMgmtServiceTeam,

      @ObjectModel.foreignKey.association: '_EnterpriseServiceOrg'
      EnterpriseServiceOrganization,

      //Service Organization-Enterprise Project
      EnterpriseProjectServiceOrg,

      // Date
      RequestedServiceStartDateTime,
      RequestedServiceEndDateTime,
      ServiceContrItemStartDateTime,
      ServiceContrItemEndDateTime,

      tstmp_to_dats( RequestedServiceStartDateTime,
                   abap_system_timezone( $session.client,'NULL' ),
                   $session.client,
                   'NULL' )                                       as RequestedServiceStartDate,
      tstmp_to_dats( RequestedServiceEndDateTime,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                     as RequestedServiceEndDate,
      tstmp_to_dats( ServiceContrItemStartDateTime,
                   abap_system_timezone( $session.client,'NULL' ),
                   $session.client,
                   'NULL' )                                       as ServiceContractItemStartDate,
      tstmp_to_dats( ServiceContrItemEndDateTime,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                     as ServiceContractItemEndDate,

      ServiceFirstResponseByDateTime,

      tstmp_to_dats( ServiceFirstResponseByDateTime,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                     as ServiceFirstResponseByDate,


      SrvcDocItemSLADueByDateTime,

      tstmp_to_dats( SrvcDocItemSLADueByDateTime,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                     as SrvcDocItemSLADueByDate,

      ActualServiceStartDateTime,
      ActualServiceEndDateTime,

      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'SrvcContrItemRnwlDurationUnit'} }
      SrvcContrItemRnwlDuration,

      @ObjectModel.foreignKey.association: '_SrvcContrItemRnwlDurationUnit'
      @Semantics.unitOfMeasure:true
      SrvcContrItemRnwlDurationUnit,

      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'SrvcContrItemExtnDurationUnit'} }
      SrvcContrItemExtensionDuration,

      @ObjectModel.foreignKey.association: '_SrvcContrItemExtnDurationUnit'
      @Semantics.unitOfMeasure:true
      SrvcContrItemExtnDurationUnit,

      PlannedServiceStartDateTime,
      PlannedServiceEndDateTime,

      tstmp_to_dats( PlannedServiceStartDateTime,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                     as PlannedServiceStartDate,

      tstmp_to_dats( PlannedServiceEndDateTime,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                     as PlannedServiceEndDate,
      @Semantics.dateTime: true
      SrvcDocItmTmeSliceStrtDteTme,
      @Semantics.dateTime: true
      SrvcDocItmTmeSliceEndDteTme,
      @Semantics.dateTime: true
      SrvcContrItemRenewalDateTime,

      // Item - Service
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ActualServiceDurationUnit'} }
      ActualServiceDuration,
      @ObjectModel.foreignKey.association: '_ActualServiceDurationUnit'
      @Semantics.unitOfMeasure:true
      ActualServiceDurationUnit,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'ServiceWorkDuration_2'
      ServiceWorkDuration,
      ServiceWorkDuration_2,
      ServiceWorkDurationUnit,
      SrvcOrderConfirmationRelevance, // Despite the DB field name, this is not a boolean value
      ServiceTransactionChargeType,
      SrvcTransactionValuationType,

      @ObjectModel.foreignKey.association: '_ResponseProfile'
      ResponseProfile,

      @ObjectModel.foreignKey.association: '_ServiceProfile'
      ServiceProfile,

      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDurationUnit'} }
      ServiceDuration,

      @ObjectModel.foreignKey.association: '_ServiceDurationUnit'
      @Semantics.unitOfMeasure:true
      ServiceDurationUnit,

      @ObjectModel.foreignKey.association: '_ServiceDocOvertimeCat'
      TimeSheetOvertimeCategory,

      // Business Solution Quotation
      MasterWarranty,
      ContractAccount,
      ItemOrderProbabilityInPercent,
      QuotationIsAccepted,
      ConfigurationNumber,
      IncotermsPart1,
      IncotermsPart2,
      DeliveryPriority,
      OrderCombinationIsAllowed,
      PartialDeliveryIsAllowed,

      CABillgCycle,
      RevenueAccountingReference,
      RevenueAccountingRefType,

      //Volume & Weights
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ItemGrossWeight,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ItemNetWeight,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_WeightUnit'
      ItemWeightUnit,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
      ItemVolume,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_VolumeUnit'
      ItemVolumeUnit,
      MaterialPricingGroup,

      // Delivery details
      DeliveryGroup,
      @ObjectModel.foreignKey.association: '_deliveryBlockReason'
      DeliveryBlockReason,
      RequestedDeliveryDateTime                                   as RequestedDeliveryUTCDateTime,

      //      FirstConfdDeliveryDateTime,
      ErlstConfirmedDeliveryDateTime,

      // Last Confirmation Delivery Date,
      LtstConfirmedDeliveryDateTime,

      //   tstmp_to_dats( ConfirmedDeliveryDateTime,
      //      abap_system_timezone( $session.client,'NULL' ),
      //       $session.client,
      //       'NULL' )                                              as ConfirmedDeliveryDate,

      tstmp_to_dats( RequestedDeliveryDateTime,
                   abap_system_timezone( $session.client,'NULL' ),
                   $session.client,
                   'NULL' )                                       as RequestedDeliveryDate,

      // Item - Subscription specific data
      SubscrpnOrdProdSelType,
      SubscriptionContract,
      SrvcTransChangeProcess,
      SrvcTransChangeProcessType,
      SrvcTransChgProcSourceItemUUID,
      CustMgmtMasterAgreement,
      CustMgmtMstrAgrmtItem,
      SubscrpnContrActivationStatus,
      SubscrpnContrTimeSliceStatus,
      SharingContractID,
      CrsCatalogMappingVersionNumber,
      CustMgmtMstrAgrmtParentItem,
      SubscrpnContractSharingGroupID,
      CAPartnerSettlementRule,
      ChangeProcessGroup,
      BusSolutionQtnItemIsPhased,
      BusSolnQtnItmPhasedPrdcssrItem,
      SubscriptionContractItem,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      SrvcDocItmRecrrgChrgNetAmount,
      @Semantics.booleanIndicator: true
      SubscrpnContrTrmsAreSpecified,
      @Semantics.booleanIndicator : true
      MidBillgCycExprtnIsAllowed,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      SrvcDocItmRecrrgChrgTaxAmount,
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      SrvcDocItmRecrrgChrgGrossAmt,
      SrvcDocItmRecrrgChrgDuration,
      SrvcDocItmRecrrgChrgDurnUnit,

      // Cancellation
      ServiceDocumentItemCanclnParty,
      ServiceDocumentItmCanclnReason,
      SrvcDocItmCanclnProcedure,

      // Auto renew
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDurationUnit'} }
      ServiceDocumentRnwlDuration,
      ServiceDocRnwlDurationUnit,
      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure: 'ServiceDurationUnit'} }
      ServiceDocExtensionDuration,
      ServiceDocExtnDurationUnit,

      // Subscription Contract
      SubscrpnContrAutoRnwlIsActv,

      // In-House Repair Reference
      ReferenceInHouseRepair,
      ReferenceInHouseRepairItem,
      RefInHouseRepairIsExisting,

      // Credit Status
      @ObjectModel.foreignKey.association: '_SrvcDocItemCreditStatus'
      SrvcDocItemCreditStatus,

      //_SrvcDocItemUserStatus.StatusCode                           as UserStatus,

      /* Associations */
      // Item Key Association
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_ParentServiceDocItem_2'
      _ParentServiceDocItem,
      _ParentServiceDocItem_2,
      _ServiceDocItemRefObj,
      _ServiceDocItemMainRefObj,
      _ServiceDocItemNote,
      _ServiceDocItemTypeSlsSttg,
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_ServiceDocItmPrdcssr_2'
      _ServiceDocItmPredecessor,
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_ServiceDocItmSuccssr_2'
      _ServiceDocItmSuccessor,
      _ServiceDocItmPrdcssr_2,
      _ServiceDocItmSuccssr_2,

      // Item Key Association
      _ServiceObjType,
      _ServiceDocument,

      // Header Details
      _ServiceDocumentType,
      _ServiceDocItemPriority,

      // Item Details
      _ServiceDocItemCategory,
      _ProfitCenter,
      _ControllingArea,
      _SrvcMgmtProductHierarchy,

      // Partner
      _SoldToParty,
      _RespEmployee,
      _ServiceTeam,
      _ServiceEmployee,
      _ContactPerson,
      _PayerParty,
      _BillToParty,
      _ShipToParty,

      // Status
      _ServiceDocItemStatus,
      _ServiceDocItemHasError,
      _ServiceDocItemBillingStatus,
      _SrvcDocItemIsRelForBillgSts,
      _ServiceDocumentIsOpen,
      _SrvcDocItemTransferStatus,

      // Billing Set
      _BillingBlockReason,
      _BillingRequestItem,
      _ServiceProductList,

      // Item - Product
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_BaseUnit_2'
      _BaseUnit,
      _BaseUnit_2,
      _SalesUnit,
      _WeightUnit,
      _VolumeUnit,
      _TransactionCurrency,
      _PaymentTerms,
      _FixedPrice,
      _StatusObjItemStatus,

      // Organization Unit Set
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_SalesOrganizationOrgUnit_2'
      _SalesOrganizationOrgUnit,
      _SalesOrganizationOrgUnit_2,
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_SalesOfficeOrgUnit_2'
      _SalesOfficeOrgUnit,
      _SalesOfficeOrgUnit_2,
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_SalesGroupOrgUnit_2'
      _SalesGroupOrgUnit,
      _SalesGroupOrgUnit_2,

      _SalesOrganization,
      _SalesOffice,
      _SalesGroup,
      _Division,
      _DistributionChannel,
      _ServiceTeamHeader,
      _EnterpriseServiceOrg,

      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_ServiceOrganizationOrgUnit_2'
      _ServiceOrganizationOrgUnit,
      _ServiceOrganizationOrgUnit_2,
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_RespSrvcOrganizationOrgUnit_2'
      _RespSrvcOrganizationOrgUnit,
      _RespSrvcOrganizationOrgUnit_2,

      _ServiceDocOvertimeCat,
      _Industry,
      _ServiceDocItemRejectionReason,
      _SoldToPartyRegion,
      _SoldToPartyCountry,
      _SettlementDateRule,
      _BillPlanDateRule,
      _ResponseProfile,
      _ServiceProfile,
      _TechResource,
      _MasterAgrmtItem,
      _BillableControl,
      _DeliveryBlockReason,

      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_SrvcMaterialPricingGroup'
      _ProductGroup,
      _Product,
      _SrvcMaterialPricingGroup,
      _AdditionalMaterialGroup1,
      _AdditionalMaterialGroup2,
      _AdditionalMaterialGroup3,
      _AdditionalMaterialGroup4,
      _AdditionalMaterialGroup5,
      _CustomerGroup,
      _AdditionalCustomerGroup1,
      _AdditionalCustomerGroup2,
      _AdditionalCustomerGroup3,
      _AdditionalCustomerGroup4,
      _AdditionalCustomerGroup5,

      // Item - Service Associations
      _ActualServiceDurationUnit,
      _ServiceDurationUnit,
      _SrvcContrItemRnwlDurationUnit,
      _SrvcContrItemExtnDurationUnit,
      _ServiceDocumentItemPrdcssr_3,
      _ServiceDocumentItemSuccssr_3,

      // Credit status associtation
      _SrvcDocItemCreditStatus
      //_SrvcDocItemUserStatus

}
