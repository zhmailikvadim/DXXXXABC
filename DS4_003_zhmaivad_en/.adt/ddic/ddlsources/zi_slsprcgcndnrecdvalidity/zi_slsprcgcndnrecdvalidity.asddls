/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* DEREVOLE     | 21.10.2022 | T4MTEMP-846 [Build] BE -                 *
*              |            | Pricing Mass Upload Tool                 *
*              |            | DS4K929425, Change number 13489          *
*----------------------------------------------------------------------*
* BOBRULA      | 07.11.2023 | 26564 : Pricing Mass Upload Tool         *
*              |            | DS4K969470                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewName: 'ZISLSPRCGCNDNVA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Validity of pricing Condition Record for Pricing in Sales'
define view ZI_SlsPrcgCndnRecdValidity as select from ZP_SlsPrcgCndnRecdValidity
  association [0..1] to I_SlsPrcgConditionRecord as _SlsPrcgConditionRecord on $projection.ConditionRecord = _SlsPrcgConditionRecord.ConditionRecord
  association [0..*] to I_SlsPrcgCndnRecdSuplmnt as _SlsPrcgCndnRecdSuplmnt on $projection.ConditionRecord = _SlsPrcgCndnRecdSuplmnt.ConditionRecord
{
  key ConditionRecord,
  key ConditionValidityEndDate,
      ConditionValidityStartDate,
      ConditionApplication,
      ConditionType,
      ConditionReleaseStatus,
      DepartureCountry,
      SalesDocument,
      SalesDocumentItem,
      BillableControl,
      Industry,
      CityCode,
      ConditionContract,
      County,
      EngagementProject,
      ConfigurationNumber,
      BR_NFDocumentType,
      BRSpcfcFreeDefinedField1,
      BRSpcfcFreeDefinedField2,
      BRSpcfcFreeDefinedField3,
      InternationalArticleNumber,
      TechnicalObjectType,
      Equipment,
      CustomerHierarchy,
      IncotermsClassification,
      IncotermsTransferLocation,
      AccountTaxType,
      TxRlvnceClassfctnForArgentina,
      BR_TaxCode,
      LocalSalesTaxApplicabilityCode,
      CustomerGroup,
      CustomerPriceGroup,
      MaterialPricingGroup,
      SoldToParty,
      BPForSoldToParty,
      Customer,
      BPForCustomer,
      PayerParty,
      BPForPayerParty,
      ShipToParty,
      BPForShipToParty,
      Supplier,
      BPForSupplier,
      DestinationCountry,
      MaterialGroup,
      Material,
      ReturnsRefundExtent,
      AdditionalMaterialGroup1,
      AdditionalMaterialGroup2,
      AdditionalMaterialGroup3,
      AdditionalMaterialGroup4,
      AdditionalMaterialGroup5,
      Personnel,
      PriceListType,
      PostalCode,
      Region,
      EngagementProjectServiceOrg,
      RequirementSegment,
      StockSegment,
      Division,
      CommodityCode,
      ConsumptionTaxCtrlCode,
      BRSpcfcTaxBasePercentageCode,
      BRSpcfcTxGrpDynTaxExceptions,
      CustomerTaxClassification1,
      CustomerTaxClassification2,
      CustomerTaxClassification3,
      CustomerTaxClassification4,
      ProductTaxClassification1,
      ProductTaxClassification2,
      ProductTaxClassification3,
      ProductTaxClassification4,
      TradingContract,
      TradingContractItem,
      TaxJurisdiction,
      BRSpcfcTaxDepartureRegion,
      BRSpcfcTaxDestinationRegion,
      MainItemMaterialPricingGroup,
      MainItemPricingRefMaterial,
      VariantCondition,
      ValueAddedServiceChargeCode,
      SDDocument,
      ReferenceSDDocument,
      ReferenceSDDocumentItem,
      SalesOffice,
      SalesGroup,
      SalesOrganization,
      SalesOrderSalesOrganization,
      OrderQuantityUnit,
      DistributionChannel,
      TransactionCurrency,
      WBSElementInternalID,
      WBSElementExternalID,
      WorkPackage,
      Plant,
      PlantRegion,
      WorkItem,
      ConditionProcessingStatus,
      PricingDate,
      ConditionIsExclusive,
      ConditionScaleBasisValue,
      TaxCode,
      ServiceDocument,
      ServiceDocumentItem,
      TimeSheetOvertimeCategory,
      SalesSDDocumentCategory,
      ReturnReason,
      ProductHierarchyNode,
      CustomerConditionGroup,
      ShippingType,
      SubscriptionContractDuration,
      SubscrpnContrDurationUnit,
      SubscriptionContractLockReason,
      CrsCtlgMappgPriceVersionNumber,
      AUART_SD,  
      ZZ1_AUARTSD_PCH,             
      ZZ1_AUART_REF_PCI,          
      AUGRU,                  
      BZIRK,                  
      FSH_COLLECTION,         
      FSH_SEASON,             
      FSH_SEASON_YEAR,        
      KNUMA_AG,               
      KUNRE,                  
      PROVG,                  
      VSTEL,                  
      ZZ1_BSART_PCH,          
      ZZBSG,                  
      ZZFSH_KVGR7,            
      ZZFSH_KVGR8,            
      ZZKATR1,                
      ZZKATR9,                
      ZZKVGR2,                
      ZZKVGR4,                
      ZZLASTSEASON,           
      ZZVMSTA, 
      AKTNR,
      ZZ1_M3SEASON_PCI,
      ZZ1_MM_FSH_MG_AT1_PCI,                  
      
      _SlsPrcgConditionRecord,
      _SlsPrcgCndnRecdSuplmnt
}