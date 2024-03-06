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
@AbapCatalog.sqlViewName: 'ZCSLSPRCGCNDNRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Price'
@VDM.viewType: #CONSUMPTION

@ObjectModel: {
   transactionalProcessingDelegated: true,
   compositionRoot: true,
   representativeKey: 'ConditionRecordUUID',
   semanticKey: [ 'ConditionRecord', 'ConditionSequentialNumber', 'ConditionValidityEndDate' ],
   draftEnabled:  true,
   createEnabled: true,
   updateEnabled: true,
   deleteEnabled: true,
    usageType: {
      sizeCategory: #XL,
      serviceQuality: #C,
      dataClass: #TRANSACTIONAL
    }
}
@ClientHandling: {
    algorithm: #SESSION_VARIABLE
}
@ObjectModel.lifecycle: {
    draft: {expiryInterval: 'PT5M' }
}
@Search.searchable: true
@Metadata.allowExtensions: true
@Consumption.semanticObject: 'SalesPrices'

define view ZC_SlsPricingConditionRecordTP
  as select from ZI_SlsPricingConditionRecordTP as RecordTP

{

  key RecordTP.ConditionRecordUUID,
      @Search.defaultSearchElement: true
      @ObjectModel.readOnly: true
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionRecord,

      @ObjectModel.readOnly: true
      RecordTP.ConditionSequentialNumber,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionValidityEndDate,

      RecordTP.ValidOnDate,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionValidityStartDate,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionTable,

      RecordTP.AccessNumberOfAccessSequence,

      @ObjectModel.readOnly: true
      RecordTP.ConditionApplication,

      @ObjectModel.text.element: ['ConditionTypeName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionType,
      
      @Semantics.text: true
      RecordTP.ConditionTypeName,
      
      @ObjectModel.readOnly: true
      RecordTP.CreatedByUser,
      @ObjectModel.readOnly: true
      RecordTP.CreationDate,
      //item
      RecordTP.ConditionTextID,
      RecordTP.PricingScaleType,
      RecordTP.PricingScaleBasis,
      //@Semantics.quantity.unitOfMeasure: 'ConditionScaleQuantityUnit'
      RecordTP.ConditionScaleQuantity,
      //@Semantics.unitOfMeasure: true
      RecordTP.ConditionScaleQuantityUnit,
      @Semantics.amount.currencyCode: 'ConditionScaleAmountCurrency'
      RecordTP.ConditionScaleAmount,
      @Semantics.currencyCode: true
      RecordTP.ConditionScaleAmountCurrency,
      @ObjectModel.text.element: ['ConditionCalculationTypeName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionCalculationType,

      @Semantics.text: true
      RecordTP.ConditionCalculationTypeName,

      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionRateValue,

      @Semantics.currencyCode: true
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionRateValueUnit,

      //@Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionQuantity,

      //@Semantics.unitOfMeasure: true
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionQuantityUnit,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionToBaseQtyNmrtr,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionToBaseQtyDnmntr,
      //@Semantics.unitOfMeasure: true
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.BaseUnit,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionLowerLimit,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionUpperLimit,
      @Semantics.currencyCode: true
      RecordTP.ConditionAlternativeCurrency,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionExclusion,
      RecordTP.ConditionIsDeleted,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.AdditionalValueDays,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.FixedValueDate,
      @ObjectModel.text.element: ['PaymentTermsName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.PaymentTerms,
      @Semantics.text: true
      RecordTP.PaymentTermsName,
      RecordTP.CndnMaxNumberOfSalesOrders,
      //@Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      RecordTP.MinimumConditionBasisValue,
      //@Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      RecordTP.MaximumConditionBasisValue,
      @Semantics.amount.currencyCode: 'ConditionAlternativeCurrency'
      RecordTP.MaximumConditionAmount,
      RecordTP.IncrementalScale,
      RecordTP.PricingScaleLine,

      //Validity
      @Feature: 'SD_PRICE_APPROVAL_BASIC_FUNCTION'
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.text.element: ['ConditionReleaseStatusText']
      @ObjectModel.sort.enabled:false
      //@UI.hidden: true
      RecordTP.ConditionReleaseStatus,  
      
        
      @Semantics.text: true
      RecordTP.ConditionReleaseStatusText,
      //_ConditionReleaseStatusText.ConditionReleaseStatusText,
     
      //@UI.hidden: true
//      RecordTP.Criticality,
        
          
      @ObjectModel.text.element: ['DepartureCountryName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.DepartureCountry,

      @Semantics.text: true
      RecordTP.DepartureCountryName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SalesDocument,

      @ObjectModel.text.element: ['SalesDocumentItemText']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SalesDocumentItem,

      @Semantics.text: true
      RecordTP.SalesDocumentItemText,

      @ObjectModel.text.element: ['BillableControlName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BillableControl,

      @Semantics.text: true
      RecordTP.BillableControlName,

      @ObjectModel.text.element: ['IndustryKeyText']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Industry,

      @Semantics.text: true
      RecordTP.IndustryKeyText,

      @ObjectModel.text.element: ['ProductHierarchyNodeText']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ProductHierarchyNode,

      @Semantics.text: true
      RecordTP.ProductHierarchyNodeText,


      @ObjectModel.text.element: ['CityCodeName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CityCode,

      @Semantics.text: true
      RecordTP.CityCodeName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionContract,

      @ObjectModel.text.element: ['CountyName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.County,

      @Semantics.text: true
      RecordTP.CountyName,

      @ObjectModel.text.element: ['TechnicalObjectTypeDesc']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TechnicalObjectType,

      @Semantics.text: true
      RecordTP.TechnicalObjectTypeDesc,

      @ObjectModel.text.element: ['EquipmentName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Equipment,

      @Semantics.text: true
      RecordTP.EquipmentName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerHierarchy,

      @ObjectModel.text.element: ['IncotermsClassificationName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.IncotermsClassification,

      @Semantics.text: true
      RecordTP.IncotermsClassificationName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.IncotermsTransferLocation,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.AccountTaxType,

      @ObjectModel.text.element: ['CustomerGroupName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerGroup,

      @Semantics.text: true
      RecordTP.CustomerGroupName,

      @ObjectModel.text.element: ['CustomerPriceGroupName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerPriceGroup,

      @Semantics.text: true
      RecordTP.CustomerPriceGroupName,

      @ObjectModel.text.element: ['MaterialPricingGroupName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.MaterialPricingGroup,

      @Semantics.text: true
      RecordTP.MaterialPricingGroupName,

      @ObjectModel.text.element: ['SoldToPartyName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SoldToParty,

      @Semantics.text: true
      RecordTP.SoldToPartyName,

      @ObjectModel.text.element: ['CustomerName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Customer,

      @Semantics.text: true
      RecordTP.CustomerName,

      @ObjectModel.text.element: ['PayerPartyName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.PayerParty,

      @Semantics.text: true
      RecordTP.PayerPartyName,

      @ObjectModel.text.element: ['ShipToPartyName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ShipToParty,

      @Semantics.text: true
      RecordTP.ShipToPartyName,

      @ObjectModel.text.element: ['SupplierName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Supplier,

      @Semantics.text: true
      RecordTP.SupplierName,

      @ObjectModel.text.element: ['DestinationCountryName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.DestinationCountry,

      @Semantics.text: true
      RecordTP.DestinationCountryName,

      @ObjectModel.text.element: ['MaterialGroupName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.MaterialGroup,

      @Semantics.text: true
      RecordTP.MaterialGroupName,

      @ObjectModel.text.element: ['ReturnsRefundExtentDesc']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ReturnsRefundExtent,

      @Semantics.text: true
      RecordTP.ReturnsRefundExtentDesc,

      @ObjectModel.text.element: ['AdditionalMaterialGroup1Name']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.AdditionalMaterialGroup1,

      @Semantics.text: true
      RecordTP.AdditionalMaterialGroup1Name,

      @ObjectModel.text.element: ['AdditionalMaterialGroup2Name']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.AdditionalMaterialGroup2,

      @Semantics.text: true
      RecordTP.AdditionalMaterialGroup2Name,

      @ObjectModel.text.element: ['AdditionalMaterialGroup3Name']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.AdditionalMaterialGroup3,

      @Semantics.text: true
      RecordTP.AdditionalMaterialGroup3Name,

      @ObjectModel.text.element: ['AdditionalMaterialGroup4Name']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.AdditionalMaterialGroup4,

      @Semantics.text: true
      RecordTP.AdditionalMaterialGroup4Name,

      @ObjectModel.text.element: ['AdditionalMaterialGroup5Name']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.AdditionalMaterialGroup5,

      @Semantics.text: true
      RecordTP.AdditionalMaterialGroup5Name,

      @ObjectModel.text.element: ['PersonFullName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Personnel,

      @Semantics.text: true
      RecordTP.PersonFullName,

      @ObjectModel.text.element: ['PriceListTypeName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.PriceListType,

      @Semantics.text: true
      RecordTP.PriceListTypeName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.PostalCode,

      @ObjectModel.text.element: ['RegionName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Region,

      @Semantics.text: true
      RecordTP.RegionName,

      @ObjectModel.text.element: ['EngmtProjectServiceOrgName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.EngagementProjectServiceOrg,

      @Semantics.text: true
      RecordTP.EngmtProjectServiceOrgName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.RequirementSegment,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.StockSegment,

      @ObjectModel.text.element: ['DivisionName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Division,

      @Semantics.text: true
      RecordTP.DivisionName,

      @ObjectModel.text.element: ['CommodityCodeText']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CommodityCode,

      @Semantics.text: true
      RecordTP.CommodityCodeText,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConsumptionTaxCtrlCode,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BRSpcfcTaxBasePercentageCode,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BRSpcfcTxGrpDynTaxExceptions,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerTaxClassification1,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerTaxClassification2,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerTaxClassification3,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerTaxClassification4,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ProductTaxClassification1,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ProductTaxClassification2,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ProductTaxClassification3,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ProductTaxClassification4,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TradingContract,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TradingContractItem,

      @ObjectModel.text.element: ['TaxJurisdictionName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TaxJurisdiction,

      @Semantics.text: true
      RecordTP.TaxJurisdictionName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BRSpcfcTaxDepartureRegion,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BRSpcfcTaxDestinationRegion,


      @ObjectModel.text.element: ['MainItmMatlPricingGroupName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.MainItemMaterialPricingGroup,

      @Semantics.text: true
      RecordTP.MainItmMatlPricingGroupName,

      @ObjectModel.text.element: ['MainItemPricingRefMaterialName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.MainItemPricingRefMaterial,

      @Semantics.text: true
      RecordTP.MainItemPricingRefMaterialName,

      @ObjectModel.text.element: ['VariantConditionName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.VariantCondition,

      @Semantics.text: true
      RecordTP.VariantConditionName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ValueAddedServiceChargeCode,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SDDocument,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ReferenceSDDocument,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ReferenceSDDocumentItem,

      @ObjectModel.text.element: ['SalesOfficeName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SalesOffice,

      @Semantics.text: true
      RecordTP.SalesOfficeName,

      @ObjectModel.text.element: ['SalesGroupName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SalesGroup,

      @Semantics.text: true
      RecordTP.SalesGroupName,

      @ObjectModel.text.element: ['SlsOrderSalesOrganizationName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SalesOrderSalesOrganization,

      @Semantics.text: true
      RecordTP.SlsOrderSalesOrganizationName,

      @ObjectModel.text.element: ['OrderQuantityUnitName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.OrderQuantityUnit,

      @Semantics.text: true
      RecordTP.OrderQuantityUnitName,

      @ObjectModel.text.element: ['SalesOrganizationName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SalesOrganization,

      @Semantics.text: true
      RecordTP.SalesOrganizationName,

      @ObjectModel.text.element: ['DistributionChannelName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.DistributionChannel,

      @Semantics.text: true
      RecordTP.DistributionChannelName,

      @ObjectModel.text.element: ['MaterialName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Material,

      @Semantics.text: true
      RecordTP.MaterialName,

      @ObjectModel.text.element: ['TransactionCurrencyName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TransactionCurrency,

      @Semantics.text: true
      RecordTP.TransactionCurrencyName,

      @ObjectModel.text.element: ['WBSDescription']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.WBSElementInternalID,

      @Semantics.text: true
      RecordTP.WBSDescription,

      @ObjectModel.text.element: ['WorkPackageName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.WorkPackage,

      @Semantics.text: true
      RecordTP.WorkPackageName,

      @ObjectModel.text.element: ['PlantName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.Plant,

      @Semantics.text: true
      RecordTP.PlantName,

      @ObjectModel.text.element: ['PlantRegionName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.PlantRegion,

      @Semantics.text: true
      RecordTP.PlantRegionName,

      @ObjectModel.text.element: ['WorkItemName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.WorkItem,

      @Semantics.text: true
      RecordTP.WorkItemName,
      
      @Feature: 'SD_PRICE_APPROVAL_BASIC_FUNCTION'
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionProcessingStatus,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.PricingDate,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionIsExclusive,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConditionScaleBasisValue,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TaxCode,

      @ObjectModel.text.element: ['EngagementProjectName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.EngagementProject,

      @Semantics.text: true
      RecordTP.EngagementProjectName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ConfigurationNumber,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BR_NFDocumentType,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BRSpcfcFreeDefinedField1,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BRSpcfcFreeDefinedField2,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BRSpcfcFreeDefinedField3,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.InternationalArticleNumber,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TxRlvnceClassfctnForArgentina,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.BR_TaxCode,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.LocalSalesTaxApplicabilityCode,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ServiceDocument,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ServiceDocumentItem,

      @ObjectModel.text.element: ['TimeSheetOvertimeCategoryText']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.TimeSheetOvertimeCategory,

      @Semantics.text: true
      RecordTP.TimeSheetOvertimeCategoryText,

      @ObjectModel.text.element: ['SDDocumentCategoryName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.SalesSDDocumentCategory,

      @Semantics.text: true
      RecordTP.SDDocumentCategoryName,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ReturnReason,

      RecordTP.ETag,

      RecordTP.ConditionRecordIsEditable,

      @ObjectModel.readOnly: true
      RecordTP.ConditionRecordIsDraft,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.CustomerConditionGroup,
      
      @ObjectModel.text.element: ['ShippingTypeName']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      RecordTP.ShippingType,

      @Semantics.text: true
      RecordTP.ShippingTypeName,

      @ObjectModel.sort.enabled:false
      RecordTP.Status,
      
      @Feature: 'SD_PRICE_APPROVAL_BASIC_FUNCTION'
      @ObjectModel.sort.enabled:false
      @ObjectModel.readOnly: true
      RecordTP.SalesPriceApprovalRequest,
      
      @Feature: 'SD_PRICE_APPROVAL_BASIC_FUNCTION'
      @ObjectModel.text.element: ['ConditionChangeReasonText']
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionChangeReason,
      
      @Semantics.text: true
      RecordTP.ConditionChangeReasonText,
      
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      @ObjectModel.sort.enabled:false
      RecordTP.ConditionText,
      
      // -------------  Added fields ------------------------ //     
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'       
      RecordTP.AUART_SD, 
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZ1_AUARTSD_PCH,                    
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZ1_AUART_REF_PCI,          
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.AUGRU,                  
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.BZIRK,                  
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.FSH_COLLECTION,
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'               
      RecordTP.FSH_SEASON,             
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.FSH_SEASON_YEAR,        
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.KNUMA_AG,               
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.KUNRE,                  
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.PROVG,                  
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.VSTEL,                  
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZ1_BSART_PCH,          
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZBSG,                  
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZFSH_KVGR7,
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'                  
      RecordTP.ZZFSH_KVGR8,            
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZKATR1,                
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZKATR9,
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'                      
      RecordTP.ZZKVGR2,                
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZKVGR4,                
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZLASTSEASON,           
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.ZZVMSTA,
//      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'      
      RecordTP.AKTNR,    
      RecordTP.ZZ1_M3SEASON_PCI,
      RecordTP.ZZ1_MM_FSH_MG_AT1_PCI        

}
