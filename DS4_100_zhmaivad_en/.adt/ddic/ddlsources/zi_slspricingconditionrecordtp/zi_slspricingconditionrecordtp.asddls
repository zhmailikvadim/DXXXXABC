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
@AbapCatalog.sqlViewName: 'ZISLSPRCDCNDNRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Condition Record for Pricing in Sales'

@VDM.viewType:#TRANSACTIONAL

@ClientHandling: {
    algorithm: #SESSION_VARIABLE
}

@ObjectModel: {
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeDraftPersistence: 'ZSDPRCG_CNDNR_D',
    representativeKey: 'ConditionRecordUUID',
    semanticKey: [ 'ConditionRecord', 'ConditionSequentialNumber', 'ConditionValidityEndDate'],
    draftEnabled: true,
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    lifecycle.enqueue.expiryBehavior: #RELATIVE_TO_LAST_CHANGE,
    lifecycle.enqueue.expiryInterval: 'PT12H', 
    usageType: {
      sizeCategory: #XL,
      serviceQuality: #C,
      dataClass: #TRANSACTIONAL
    }
 }

define view ZI_SlsPricingConditionRecordTP
  as select from sdprcg_cndnr              as Record
    inner join   ZI_SlsPrcgCndnRecdValidity as Validity on Record.conditionrecord = Validity.ConditionRecord
{
  key Record.conditionrecorduuid                      as        ConditionRecordUUID,
      Record.conditionrecord as ConditionRecord,
      Record.conditionsequentialnumber as ConditionSequentialNumber,
      @ObjectModel.readOnly: false
      Validity.ConditionValidityEndDate,
      @ObjectModel.readOnly: false
      Validity.ConditionValidityStartDate,
      @ObjectModel.readOnly: false
      Record.conditiontable as ConditionTable,
      @ObjectModel.readOnly: false
      Record.conditionapplication as ConditionApplication,
      @ObjectModel.readOnly: false
      Record.conditiontype as ConditionType,
      cast ( '' as vtxtm ) as ConditionTypeName,
      @ObjectModel.readOnly: false
      Record.createdbyuser as CreatedByUser,
      Record.creationdate as CreationDate,
      Record.conditiontextid as ConditionTextID,
      Record.pricingscaletype as PricingScaleType,
      Record.pricingscalebasis as PricingScaleBasis,
      Record.conditionscalequantity as ConditionScaleQuantity,
      Record.conditionscalequantityunit as ConditionScaleQuantityUnit,
      @Semantics.amount.currencyCode: 'ConditionScaleAmountCurrency'
      Record.conditionscaleamount as ConditionScaleAmount,
      @Semantics.currencyCode: true
      Record.conditionscaleamountcurrency as ConditionScaleAmountCurrency,
      Record.conditioncalculationtype as ConditionCalculationType,
      cast ( '' as prct_calculation_type_descr ) as ConditionCalculationTypeName,
      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      Record.conditionratevalue as ConditionRateValue,
      @Semantics.currencyCode: true
      Record.conditionratevalueunit as ConditionRateValueUnit,
      @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      Record.conditionquantity as ConditionQuantity,
      @Semantics.unitOfMeasure: true
      Record.conditionquantityunit as ConditionQuantityUnit,
      Record.conditiontobaseqtynmrtr as ConditionToBaseQtyNmrtr,
      Record.conditiontobaseqtydnmntr as ConditionToBaseQtyDnmntr,
      @Semantics.unitOfMeasure: true
      Record.baseunit as BaseUnit,
      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      Record.conditionlowerlimit as ConditionLowerLimit,
      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      Record.conditionupperlimit as ConditionUpperLimit,
      @Semantics.currencyCode: true
      Record.conditionalternativecurrency as ConditionAlternativeCurrency,
      Record.conditionexclusion as ConditionExclusion,
      Record.conditionisdeleted as ConditionIsDeleted,
      Record.additionalvaluedays as AdditionalValueDays,
      Record.fixedvaluedate as FixedValueDate,
      Record.paymentterms as PaymentTerms,
      cast ( '' as dzterm_bez ) as PaymentTermsName,
      Record.cndnmaxnumberofsalesorders as CndnMaxNumberOfSalesOrders,
      Record.minimumconditionbasisvalue as MinimumConditionBasisValue,
      Record.maximumconditionbasisvalue as MaximumConditionBasisValue,
      @Semantics.amount.currencyCode: 'ConditionAlternativeCurrency'
      Record.maximumconditionamount as MaximumConditionAmount,
      Record.incrementalscale as IncrementalScale,
      Record.pricingscaleline as PricingScaleLine,

      Validity.ConditionReleaseStatus,
      cast( '' as ddtext ) as ConditionReleaseStatusText,
      
      Validity.DepartureCountry,
      cast( '' as landx50 ) as DepartureCountryName,
      Validity.SalesDocument,
      Validity.SalesDocumentItem,
      cast( '' as arktx ) as SalesDocumentItemText,
      Validity.BillableControl,
      cast( '' as bemot_txt ) as BillableControlName,
      Validity.Industry,
      cast( '' as text1_016t ) as IndustryKeyText,     
      Validity.CityCode,
      cast( '' as bezei20 ) as CityCodeName,      
      Validity.ConditionContract,
      Validity.County,
      cast( '' as bezei20 ) as CountyName,
      Validity.TechnicalObjectType,
      cast( '' as eartx ) as TechnicalObjectTypeDesc,
      Validity.Equipment,
      cast( '' as ktx01 ) as EquipmentName,  
      Validity.CustomerHierarchy,
      Validity.IncotermsClassification,
      cast( '' as bezei30 ) as IncotermsClassificationName,      
      Validity.IncotermsTransferLocation,
      Validity.AccountTaxType,          
      Validity.CustomerGroup,
      cast( '' as vtxtk ) as CustomerGroupName,
      Validity.CustomerPriceGroup,
      cast( '' as bezei20 ) as CustomerPriceGroupName,
      Validity.MaterialPricingGroup,
      cast( '' as bezei20 ) as MaterialPricingGroupName,
      Validity.SoldToParty,
      cast( '' as md_customer_name ) as SoldToPartyName,
      Validity.Customer,
      cast( '' as md_customer_name ) as CustomerName,
      Validity.PayerParty,
      cast( '' as md_customer_name ) as PayerPartyName,
      Validity.ShipToParty,
      cast( '' as md_customer_name ) as ShipToPartyName,
      Validity.Supplier,
      cast( '' as md_supplier_name ) as SupplierName,
      Validity.DestinationCountry,
      cast( '' as landx50 ) as DestinationCountryName,
      Validity.MaterialGroup,
      cast( '' as wgbez ) as MaterialGroupName,
      Validity.ReturnsRefundExtent,
      cast( '' as msr_refund_code_text ) as ReturnsRefundExtentDesc,
      Validity.AdditionalMaterialGroup1,
      cast( '' as bezei40 ) as AdditionalMaterialGroup1Name,
      Validity.AdditionalMaterialGroup2,
      cast( '' as bezei40 ) as AdditionalMaterialGroup2Name,
      Validity.AdditionalMaterialGroup3,
      cast( '' as bezei40 ) as AdditionalMaterialGroup3Name,
      Validity.AdditionalMaterialGroup4,
      cast( '' as bezei40 ) as AdditionalMaterialGroup4Name,
      Validity.AdditionalMaterialGroup5,
      cast( '' as bezei40 ) as AdditionalMaterialGroup5Name,
      Validity.Personnel,
      cast( '' as bu_name1tx ) as PersonFullName, 
      Validity.PriceListType,
      cast( '' as text20 ) as PriceListTypeName,
      Validity.PostalCode,
      Validity.Region,
      cast( '' as bezei20 ) as RegionName,
      Validity.EngagementProjectServiceOrg,
      cast( '' as /cpd/pws_ws_org_unit_id_desc ) as EngmtProjectServiceOrgName,
      Validity.RequirementSegment,
      Validity.StockSegment,
      Validity.Division,
      cast( '' as divisionname ) as DivisionName,
      Validity.CommodityCode,
      cast( '' as bezei40 ) as CommodityCodeText,
      Validity.ProductHierarchyNode,
      cast( '' as prod_hier_node_value_text ) as ProductHierarchyNodeText,
      Validity.ConsumptionTaxCtrlCode,
      Validity.BRSpcfcTaxBasePercentageCode,
      Validity.BRSpcfcTxGrpDynTaxExceptions,
      Validity.CustomerTaxClassification1,
      Validity.CustomerTaxClassification2,
      Validity.CustomerTaxClassification3,
      Validity.CustomerTaxClassification4,
      Validity.ProductTaxClassification1,
      Validity.ProductTaxClassification2,
      Validity.ProductTaxClassification3,
      Validity.ProductTaxClassification4,
      Validity.TradingContract,
      Validity.TradingContractItem,
      Validity.TaxJurisdiction,
      cast( '' as text1_txjt ) as TaxJurisdictionName,
      Validity.BRSpcfcTaxDepartureRegion,
      Validity.BRSpcfcTaxDestinationRegion,
      Validity.MainItemMaterialPricingGroup,
      cast( '' as bezei20 ) as MainItmMatlPricingGroupName,  
      Validity.MainItemPricingRefMaterial,
      cast( '' as maktx ) as MainItemPricingRefMaterialName,       
      Validity.VariantCondition,
      cast( '' as varcond ) as VariantConditionName,      
      Validity.ValueAddedServiceChargeCode,
      Validity.SDDocument,
      Validity.ReferenceSDDocument,
      Validity.ReferenceSDDocumentItem,
      Validity.SalesOffice,
      cast( '' as bezei20 ) as SalesOfficeName,
      Validity.SalesGroup, 
      cast( '' as bezei20 ) as SalesGroupName, 
      Validity.SalesOrderSalesOrganization,
      cast( '' as vtxtk ) as SlsOrderSalesOrganizationName,    
      Validity.OrderQuantityUnit,
      cast( '' as msehl ) as OrderQuantityUnitName, 
      Validity.SalesOrganization,
      cast( '' as vtext ) as SalesOrganizationName,      
      Validity.DistributionChannel,
      cast( '' as vtext ) as DistributionChannelName,
      Validity.Material,
      cast( '' as maktx )                     as MaterialName,
      Validity.TransactionCurrency,
      cast( '' as ltext ) as TransactionCurrencyName,
      //cast( '' as waerk ) 
      cast( Validity.WBSElementInternalID as ps_posid ) as  WBSElementInternalID,
      cast( '' as ps_post1 ) as  WBSDescription,
      cast( Validity.WorkPackage as ps_posid ) as  WorkPackage,
      cast( '' as ps_post1 ) as  WorkPackageName, 
      Validity.Plant,
      cast( '' as name1 ) as  PlantName, 
      Validity.PlantRegion,
      cast( '' as bezei20 ) as  PlantRegionName, 
      
      Validity.WorkItem,
      cast( '' as /cpd/pfp_workitem_name ) as WorkItemName,
      Validity.ConditionProcessingStatus,
      Validity.PricingDate,
      Validity.ConditionIsExclusive,
      Validity.ConditionScaleBasisValue,
      Validity.TaxCode,
      Validity.EngagementProject,
      cast( '' as /cpd/short_text ) as EngagementProjectName,
      Validity.ConfigurationNumber,
      Validity.BR_NFDocumentType,
      Validity.BRSpcfcFreeDefinedField1,
      Validity.BRSpcfcFreeDefinedField2,
      Validity.BRSpcfcFreeDefinedField3,
      Validity.InternationalArticleNumber,
      Validity.TxRlvnceClassfctnForArgentina,
      Validity.BR_TaxCode,
      Validity.LocalSalesTaxApplicabilityCode,
      Validity.ServiceDocument,
      Validity.ServiceDocumentItem,
      Validity.TimeSheetOvertimeCategory,
      cast( '' as cats_ssc_overtimecattext) as TimeSheetOvertimeCategoryText,
      Validity.SalesSDDocumentCategory,
      cast( '' as val_text ) as SDDocumentCategoryName,
      Validity.ReturnReason,
      Validity.CustomerConditionGroup,
      Validity.ShippingType,
      cast( '' as versartbez ) as ShippingTypeName,
      Validity.SubscriptionContractDuration,
      Validity.SubscrpnContrDurationUnit,
      Validity.SubscriptionContractLockReason,

      cast( '00000000' as datam )                     as        ValidOnDate,
      cast( '000' as kolnr )                          as        AccessNumberOfAccessSequence,
      cast( '' as char40 )                            as        ETag,
      cast( '' as boolean) as ConditionRecordIsEditable,
      cast( '' as boolean) as ConditionRecordIsDraft,
      cast( '' as char1) as Status,
      
      Record.salespriceapprovalrequest as SalesPriceApprovalRequest,
      Record.conditionchangereason as ConditionChangeReason,
      cast ( '' as text ) as  ConditionChangeReasonText,
      cast ( '' as bezei40 ) as  ConditionText,
// -------------  Added fields ------------------------ //      
      Validity.AUART_SD, 
      Validity.ZZ1_AUARTSD_PCH,              
      Validity.ZZ1_AUART_REF_PCI,          
      Validity.AUGRU,                  
      Validity.BZIRK,                  
      Validity.FSH_COLLECTION,         
      Validity.FSH_SEASON,             
      Validity.FSH_SEASON_YEAR,        
      Validity.KNUMA_AG,               
      Validity.KUNRE,                  
      Validity.PROVG,                  
      Validity.VSTEL,                  
      Validity.ZZ1_BSART_PCH,          
      Validity.ZZBSG,                  
      Validity.ZZFSH_KVGR7,            
      Validity.ZZFSH_KVGR8,            
      Validity.ZZKATR1,                
      Validity.ZZKATR9,                
      Validity.ZZKVGR2,                
      Validity.ZZKVGR4,                
      Validity.ZZLASTSEASON,           
      Validity.ZZVMSTA,
      Validity.AKTNR,
      Validity.ZZ1_M3SEASON_PCI,
      Validity.ZZ1_MM_FSH_MG_AT1_PCI               
      
}
