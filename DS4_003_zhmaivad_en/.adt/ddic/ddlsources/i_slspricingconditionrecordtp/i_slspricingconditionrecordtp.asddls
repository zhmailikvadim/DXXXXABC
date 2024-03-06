@AbapCatalog.sqlViewName: 'ISLSPRCDCNDNRTP'
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
    writeDraftPersistence: 'SDPRCG_CNDNR_D',
    representativeKey: 'ConditionRecordUUID',
    semanticKey: [ 'ConditionRecord', 'ConditionSequentialNumber', 'ConditionValidityEndDate'],
    draftEnabled: true,
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    usageType: {
      sizeCategory: #XL,
      serviceQuality: #C,
      dataClass: #TRANSACTIONAL
    }
 }

@ObjectModel.lifecycle: {

   enqueue: {
     expiryBehavior : #RELATIVE_TO_LAST_CHANGE,
     expiryInterval : 'P7D'
   },
   processing: {
     expiryBehavior : #RELATIVE_TO_LAST_CHANGE,
     expiryInterval : 'PT12H'
   },
   draft: {
     expiryBehavior : #RELATIVE_TO_LAST_CHANGE,
     expiryInterval : 'P28D'
   }   
}


define view I_SlsPricingConditionRecordTP
  as select from sdprcg_cndnr              as Record
    inner join   I_SlsPrcgCndnRecdValidity as Validity on Record.conditionrecord = Validity.ConditionRecord
    //Extensibility
  association [0..1] to E_SlsPrcgCndnRecdValidity as _Extension on  $projection.ConditionRecord          = _Extension.ConditionRecord
                                                                and $projection.ConditionValidityEndDate = _Extension.ConditionValidityEndDate
  association [0..*] to I_SlsPrcgCndnRecordScaleTP  as _SlsPricingCndnRecdScaleTP on  $projection.ConditionRecordUUID           = _SlsPricingCndnRecdScaleTP.ConditionRecordUUID                                                                                                                               
// association [0..1] to I_ConditionReleaseStatusText as _ConditionReleaseStatusText on $projection.ConditionReleaseStatus = _ConditionReleaseStatusText.ConditionReleaseStatus
//                                                                                   and _ConditionReleaseStatusText.Language        = $session.system_language                                                               
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
      cast ( '' as price_element_scale_type_descr )    as PricingScaleTypeName,
      Record.pricingscalebasis as PricingScaleBasis,
      cast ( '' as price_element_scbasetype_descr )    as PricingScaleBasisName,
      Record.pricingscalecheckingrule as PricingScaleCheckingRule,
      cast ( '' as price_element_description )   as PricingScaleCheckingRuleName,
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
      @Semantics.quantity.unitOfMeasure: 'ConditionRateRatioUnit'
      Record.conditionrateratio as ConditionRateRatio,
      @Semantics.unitOfMeasure: true
      Record.conditionrateratiounit as ConditionRateRatioUnit,
      @Semantics.amount.currencyCode: 'ConditionCurrency' 
      @OData.v2.amount.noDecimalShift: true
      Record.conditionrateamount as ConditionRateAmount,
      @Semantics.currencyCode: true
      Record.conditioncurrency as ConditionCurrency,
      @Semantics.booleanIndicator: true
      cast(
        case
          when conditionrateratiounit = ''
          then 'X'
        else ''
      end as boole_d )                        as ConditionRateValueIsAmount,

      @Semantics.booleanIndicator: true
      cast(
        case
          when conditionrateratiounit = ''
          then ''
        else 'X'
      end as boole_d )                         as ConditionRateValueIsRatio,
      @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      Record.conditionquantity as ConditionQuantity,
      @Semantics.unitOfMeasure: true
      Record.conditionquantityunit as ConditionQuantityUnit,
      Record.conditiontobaseqtynmrtr as ConditionToBaseQtyNmrtr,
      Record.conditiontobaseqtydnmntr as ConditionToBaseQtyDnmntr,
      @Semantics.unitOfMeasure: true
      Record.baseunit as BaseUnit,
      cast ( '' as text60 ) as ConditionUnitConversionText,      
      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      Record.conditionlowerlimit as ConditionLowerLimit,
      @Semantics.amount.currencyCode: 'ConditionCurrency' 
      @OData.v2.amount.noDecimalShift: true      
      Record.conditionlowerlimitamount as ConditionLowerLimitAmount,
      @Semantics.quantity.unitOfMeasure: 'ConditionRateRatioUnit'
      Record.conditionlowerlimitratio as ConditionLowerLimitRatio,  
      @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
      Record.conditionupperlimit as ConditionUpperLimit,
      @Semantics.amount.currencyCode: 'ConditionCurrency' 
      @OData.v2.amount.noDecimalShift: true     
      Record.conditionupperlimitamount as ConditionUpperLimitAmount,
      @Semantics.quantity.unitOfMeasure: 'ConditionRateRatioUnit'
      Record.conditionupperlimitratio as ConditionUpperLimitRatio,
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
      cast( '0' as eve_tv_criticality ) as Criticality,
       
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
//      Validity.ProdUnivHierarchyNode,
//      cast( '' as prod_hier_node_value_text ) as ProdUnivHierarchyNodeText,
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
      cast( '' as vtxtk ) as ConditionProcessingStatusText,
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
      Validity.OrderType,
      cast( '' as pph_auarttext ) as OrderTypeName,
      Validity.SalesDocumentType,
      cast( '' as bezei ) as SalesDocumentTypeName,
      Validity.SDDocumentReason,
      cast( '' as bezei ) as SDDocumentReasonText,
      Validity.VolumeRebateGroup,
      cast( '' as vtext ) as VolumeRebateGroupName,
      Validity.ValuationType,
      Validity.SalesDistrict,
      cast( '' as bztxt ) as SalesDistrictName,
      Validity.Batch,
      Validity.PurgDocSupplyingPlant,
      cast( '' as werks_name ) as SupplyingPlantName,
      Validity.MatUsageIndicator,
      cast( '' as bezei20 ) as MatlUsageIndicatorText,
      Validity.ShippingCondition,
      cast( '' as vsbed_bez ) as ShippingConditionName,
      Validity.PlantCounty,
      cast( '' as ad_county ) as PlantCountyName,
      Validity.PlantCity,
      cast( '' as ort01 ) as PlantCityName,
      Validity.MaterialExternalGroup,
      cast( '' as ewbez ) as ExternalProductGroupName,
      Validity.CustomerHierarchyRootNode,
      cast( '' as hrytxt ) as CustomerUniversalHierarchyText,
      Validity.CustomerHierarchyNodeID,
      cast( '' as cust_hier_node_value_text ) as CustUnivHierarchyNodeText,
      Validity.CustomerHierarchyNodeType,
      cast( '' as mdbp_custh_nodetypet ) as CustomerHierarchyNodeTypeText,
//      Validity.BusinessPartner,
//      cast( '' as bpname ) as BusinessPartnerName,
//      Validity.CAMaterial,
//      cast( '' as lgtxt_kk ) as CAProductText,
//      Validity.CAServiceType,
//      cast( '' as rai_service_type_txt_kk ) as CARevnAcctgServiceTypeText,
      Validity.AdditionalCustomerGroup1,
      cast( '' as bezei20 ) as AdditionalCustomerGroup1Name,
      Validity.AdditionalCustomerGroup2,
      cast( '' as bezei20 ) as AdditionalCustomerGroup2Name,
      Validity.AdditionalCustomerGroup3,
      cast( '' as bezei20 ) as AdditionalCustomerGroup3Name,
      Validity.AdditionalCustomerGroup4,
      cast( '' as bezei20 ) as AdditionalCustomerGroup4Name,
      Validity.AdditionalCustomerGroup5,
      cast( '' as bezei20 ) as AdditionalCustomerGroup5Name,
      Validity.SDDocumentItem,
      
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
      Record.prevapprovedconditionrecord as PrevApprovedConditionRecord,
       @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ] 
      _SlsPricingCndnRecdScaleTP
}
