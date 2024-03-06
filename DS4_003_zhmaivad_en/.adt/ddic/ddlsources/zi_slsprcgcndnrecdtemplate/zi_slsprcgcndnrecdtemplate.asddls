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
@AbapCatalog.sqlViewName: 'ZISLSPRCGRECDTMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Template for Condition Record for Pricing in Sales'
define view ZI_SlsPrcgCndnRecdTemplate  as select from P_SlsPrcgConditionRecord as _SlsPrcgConditionRecord
  association [0..*] to ZI_SlsPrcgCndnRecdValidity as _SlsPrcgCndnRecdValidity on $projection.ConditionRecord = _SlsPrcgCndnRecdValidity.ConditionRecord
  
 
{
    @ObjectModel.mandatory: true
    @UI.fieldGroup:{ groupLabel: 'Key',
                     qualifier: 'ConditionRecord',
                     position: 10
                   }
    key _SlsPrcgConditionRecord.ConditionRecord ,
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionValidityEndDate',
                     position: 90
                   }
    key _SlsPrcgConditionRecord.ConditionValidityEndDate ,    
    @ObjectModel.mandatory: true
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_SalesPricingConditionTypeVH', element: 'ConditionType'}}]
    @ObjectModel.text.element: ['ConditionTypeName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConditionType',
                     position: 30
                   }
    _SlsPrcgConditionRecord.ConditionType ,
    cast ( '' as vtxtm ) as ConditionTypeName,

    @ObjectModel.mandatory: true
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConditionTable',
                     position: 40
                   }
    _SlsPrcgConditionRecord.ConditionTable ,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'AccessNumberOfAccessSequence',
                     position: 50
                   }
    //key _SlsPrcgKeyCombinationField.AccessNumberOfAccessSequence ,
    cast('' as kolnr) as AccessNumberOfAccessSequence,
    @ObjectModel.mandatory: true
    @UI.fieldGroup:{ groupLabel: 'Key',
                     qualifier: 'ConditionSequentialNumber',
                     position: 60
                   }
    cast('' as kopos_long) as ConditionSequentialNumber ,
    @UI.fieldGroup:{ groupLabel: 'Key',
                     qualifier: 'ConditionScaleLine',
                     position: 70
                   }
    @EndUserText. label: 'Scale Line Number'
    //key _SlsPrcgCndnRecordScale.ConditionScaleLine ,
    cast('' as klfn1) as ConditionScaleLine,
    
    @UI.fieldGroup:{ groupLabel: 'Key Hidden',
                     qualifier: 'ConditionHasScales',
                     position: 80
                   }
    cast('' as kostkz) as ConditionHasScales,
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionValidityStartDate',
                     position: 20
                   }
    _SlsPrcgCndnRecdValidity.ConditionValidityStartDate ,
    @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionRateValue',
                     position: 100
                   }
    _SlsPrcgConditionRecord.ConditionRateValue ,
    @Semantics.currencyCode: true
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionRateValueUnit',
                     position: 110
                   }
    _SlsPrcgConditionRecord.ConditionRateValueUnit ,
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionQuantity',
                     position: 120
                   }
    _SlsPrcgConditionRecord.ConditionQuantity,
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionQuantityUnit',
                     position: 130
                   }
    _SlsPrcgConditionRecord.ConditionQuantityUnit,
    @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
    @EndUserText.label: 'Lower Limit'
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionLowerLimit',
                     position: 135
                   }
    _SlsPrcgConditionRecord.ConditionLowerLimit,
    @Semantics.amount.currencyCode: 'ConditionRateValueUnit'
    @EndUserText.label: 'Upper Limit'
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionUpperLimit',
                     position: 136
                   }
    _SlsPrcgConditionRecord.ConditionUpperLimit,
    @Semantics.quantity.unitOfMeasure: 'ConditionScaleQuantityUnit'
    @UI.fieldGroup:{ groupLabel: 'Condition Scale',
                     qualifier: 'ConditionScaleQuantity',
                     position: 140
                   }      
    _SlsPrcgConditionRecord.ConditionScaleQuantity ,
    @Consumption.filter.hidden: true
    @Semantics.unitOfMeasure: true
    @UI.fieldGroup:{ groupLabel: 'Condition Scale',
                     qualifier: 'ConditionScaleQuantityUnit',
                     position: 150
                   }
    _SlsPrcgConditionRecord.ConditionScaleQuantityUnit,
    @Semantics.amount.currencyCode: 'ConditionScaleAmountCurrency'
    @UI.fieldGroup:{ groupLabel: 'Condition Scale',
                     qualifier: 'ConditionScaleAmount',
                     position: 160
                   }
    _SlsPrcgConditionRecord.ConditionScaleAmount ,
    @Semantics.currencyCode: true
    @Consumption.filter.hidden: true
    @UI.fieldGroup:{ groupLabel: 'Condition Scale',
                     qualifier: 'ConditionScaleAmountCurrency',
                     position: 170
                   }
    _SlsPrcgConditionRecord.ConditionScaleAmountCurrency,
    
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionText',
                     position: 180
                   }
    @EndUserText.label: 'Condition Description'
    cast ( '' as bezei40 ) as  ConditionText,
        
    @Consumption.valueHelpDefinition: [{entity:{name: 'I_CustomerPaymentTerms', element :'CustomerPaymentTerms'}}]
    @ObjectModel.text.element: ['PaymentTermsName']
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'PaymentTerms',
                     position: 190
                   }   
    _SlsPrcgConditionRecord.PaymentTerms, 
    cast ( '' as dzterm_bez ) as PaymentTermsName,
     
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'FixedValueDate',
                     position: 200
                   }   
    _SlsPrcgConditionRecord.FixedValueDate,
    
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'AdditionalValueDays',
                     position: 210
                   }   
    _SlsPrcgConditionRecord.AdditionalValueDays,
        
    @Consumption.valueHelpDefinition: [{entity:{name: 'I_ConditionCalculationType', element :'ConditionCalculationType'}}]
    @ObjectModel.text.element: ['ConditionCalculationTypeName']
    @UI.fieldGroup:{ groupLabel: 'Condition Details',
                     qualifier: 'ConditionCalculationType',
                     position: 220
                   }
    cast('' as krech_long) as ConditionCalculationType,
    cast ( '' as prct_calculation_type_descr ) as ConditionCalculationTypeName,
    //_SlsPrcgConditionRecord.ConditionCalculationType,
    @Consumption.filter.hidden: true
    @UI.fieldGroup:{ groupLabel: 'Condition Scale Hidden',
                     qualifier: 'PricingScaleType',
                     position: 230
                   }
    _SlsPrcgConditionRecord.PricingScaleType,
    @Consumption.filter.hidden: true
    @UI.fieldGroup:{ groupLabel: 'Condition Scale Hidden',
                     qualifier: 'PricingScaleBasis',
                     position: 240
                   }
    cast('' as kzbzg_long) as PricingScaleBasis,
    //_SlsPrcgConditionRecord.PricingScaleBasis,
    //@Semantics.amount.currencyCode: 'ConditionRateValueUnit'
    @UI.fieldGroup:{ groupLabel: 'Condition Scale',
                     qualifier: 'ConditionScaleRateValue',
                     position: 250
                   }
    cast(_SlsPrcgConditionRecord.ConditionRateValue as vfprc_element_amount) as ConditionScaleRateValue ,
    @UI.fieldGroup:{ groupLabel: 'Key',
                     qualifier: 'ConditionIsScale',
                     position: 260
                   }
    cast('' as condition_is_scale) as ConditionIsScale,
    
    //Validity, VAKEY 
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CountryVH', element: 'Country'}}] 
    @ObjectModel.text.element: ['DepartureCountryName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'DepartureCountry',
                     position: 270
                   }
    _SlsPrcgCndnRecdValidity.DepartureCountry,
    cast( '' as landx50 ) as DepartureCountryName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SalesDocument',
                     position: 280
                   }
    _SlsPrcgCndnRecdValidity.SalesDocument,
    @Consumption.valueHelpDefinition: [
                                     {entity: {name: 'I_SalesDocumentItemStdVH', element: 'SalesDocumentItem'},
                                      additionalBinding: [{ localElement: 'SalesDocument', element: 'SalesDocument' }]}
                                    ] 
    @ObjectModel.text.element: ['SalesDocumentItemText']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SalesDocumentItem',
                     position: 290
                   }
    _SlsPrcgCndnRecdValidity.SalesDocumentItem,
    cast( '' as arktx ) as SalesDocumentItemText,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_BillableControl', element: 'BillableControl'}}]
    @ObjectModel.text.element: ['BillableControlName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BillableControl',
                     position: 300
                   }
    _SlsPrcgCndnRecdValidity.BillableControl,
    cast( '' as bemot_txt ) as BillableControlName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_IndustryHelp', element: 'Industry'}}] 
    @ObjectModel.text.element: ['IndustryKeyText']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Industry',
                     position: 310
                   }
    _SlsPrcgCndnRecdValidity.Industry,
    cast( '' as text1_016t ) as IndustryKeyText, 
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CityCode', element: 'CityCode'}}]
    @ObjectModel.text.element: ['CityCodeName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CityCode',
                     position: 320
                   }
    _SlsPrcgCndnRecdValidity.CityCode,
    cast( '' as bezei20 ) as CityCodeName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConditionContract',
                     position: 330
                   }
    _SlsPrcgCndnRecdValidity.ConditionContract,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CountyCode', element: 'County'}}] 
    @ObjectModel.text.element: ['CountyName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'County',
                     position: 340
                   }
    _SlsPrcgCndnRecdValidity.County,
    cast( '' as bezei20 ) as CountyName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CustomerProject', element: 'CustomerProject'}}]
    @ObjectModel.text.element: ['EngagementProjectName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'EngagementProject',
                     position: 350
                   }
    _SlsPrcgCndnRecdValidity.EngagementProject,
    cast( '' as /cpd/short_text ) as EngagementProjectName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConfigurationNumber',
                     position: 360
                   }
    _SlsPrcgCndnRecdValidity.ConfigurationNumber,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BR_NFDocumentType',
                     position: 370
                   }
    _SlsPrcgCndnRecdValidity.BR_NFDocumentType,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BRSpcfcFreeDefinedField1',
                     position: 380
                   }
    _SlsPrcgCndnRecdValidity.BRSpcfcFreeDefinedField1,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BRSpcfcFreeDefinedField2',
                     position: 390
                   }
    _SlsPrcgCndnRecdValidity.BRSpcfcFreeDefinedField2,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BRSpcfcFreeDefinedField3',
                     position: 400
                   }
    _SlsPrcgCndnRecdValidity.BRSpcfcFreeDefinedField3,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'InternationalArticleNumber',
                     position: 410
                   }
    _SlsPrcgCndnRecdValidity.InternationalArticleNumber,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_TechnicalObjectTypeStdVH', element: 'TechnicalObjectType'}}]
    @ObjectModel.text.element: ['TechnicalObjectTypeDesc']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TechnicalObjectType',
                     position: 420
                   }
    _SlsPrcgCndnRecdValidity.TechnicalObjectType,
    cast( '' as eartx ) as TechnicalObjectTypeDesc,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_EquipmentStdVH', element: 'Equipment'}}]
    @ObjectModel.text.element: ['EquipmentName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Equipment',
                     position: 430
                   }
    _SlsPrcgCndnRecdValidity.Equipment,
    cast( '' as ktx01 ) as EquipmentName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_IncotermsClassification', element: 'IncotermsClassification'}}]
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerHierarchy',
                     position: 440
                   }
    _SlsPrcgCndnRecdValidity.CustomerHierarchy,
    @ObjectModel.text.element: ['IncotermsClassificationName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'IncotermsClassification',
                     position: 450
                   }
    _SlsPrcgCndnRecdValidity.IncotermsClassification,
    cast( '' as bezei30 ) as IncotermsClassificationName,     
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'IncotermsTransferLocation',
                     position: 460
                   }
    _SlsPrcgCndnRecdValidity.IncotermsTransferLocation,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'AccountTaxType',
                     position: 470
                   }
    _SlsPrcgCndnRecdValidity.AccountTaxType,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TxRlvnceClassfctnForArgentina',
                     position: 480
                   }
    _SlsPrcgCndnRecdValidity.TxRlvnceClassfctnForArgentina,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BR_TaxCode',
                     position: 490
                   }
    _SlsPrcgCndnRecdValidity.BR_TaxCode,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'LocalSalesTaxApplicabilityCode',
                     position: 500
                   }
    _SlsPrcgCndnRecdValidity.LocalSalesTaxApplicabilityCode,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CustomerGroup', element: 'CustomerGroup'}}] 
    @ObjectModel.text.element: ['CustomerGroupName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerGroup',
                     position: 510
                   }
    _SlsPrcgCndnRecdValidity.CustomerGroup,
    cast( '' as vtxtk ) as CustomerGroupName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CustomerPriceGroup', element: 'CustomerPriceGroup'}}]
    @ObjectModel.text.element: ['CustomerPriceGroupName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerPriceGroup',
                     position: 520
                   }
    _SlsPrcgCndnRecdValidity.CustomerPriceGroup,
    cast( '' as bezei20 ) as CustomerPriceGroupName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_MaterialPricingGroup', element: 'MaterialPricingGroup'}}] 
    @ObjectModel.text.element: ['MaterialPricingGroupName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'MaterialPricingGroup',
                     position: 530
                   }
//    _SlsPrcgCndnRecdValidity.MaterialPricingGroup,
    cast (_SlsPrcgCndnRecdValidity.MaterialPricingGroup as pricespecificationproductgroup preserving type )     as MaterialPricingGroup,
    cast( '' as bezei20 ) as MaterialPricingGroupName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Customer_VH', element: 'Customer'}}] 
    @ObjectModel.text.element: ['SoldToPartyName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SoldToParty',
                     position: 540
                   }
    _SlsPrcgCndnRecdValidity.SoldToParty,
    cast( '' as md_customer_name ) as SoldToPartyName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BPForSoldToParty',
                     position: 550
                   }
    _SlsPrcgCndnRecdValidity.BPForSoldToParty,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Customer_VH', element: 'Customer'}}]
    @ObjectModel.text.element: ['CustomerName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Customer',
                     position: 560
                   }
    _SlsPrcgCndnRecdValidity.Customer,
    cast( '' as md_customer_name ) as CustomerName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BPForCustomer',
                     position: 570
                   }
    _SlsPrcgCndnRecdValidity.BPForCustomer,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Customer_VH', element: 'Customer'}}]
    @ObjectModel.text.element: ['PayerPartyName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'PayerParty',
                     position: 580
                   }
    _SlsPrcgCndnRecdValidity.PayerParty,
    cast( '' as md_customer_name ) as PayerPartyName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BPForPayerParty',
                     position: 590
                   }
    _SlsPrcgCndnRecdValidity.BPForPayerParty,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Customer_VH', element: 'Customer'}}]
    @ObjectModel.text.element: ['ShipToPartyName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ShipToParty',
                     position: 600
                   }
    _SlsPrcgCndnRecdValidity.ShipToParty,
    cast( '' as md_customer_name ) as ShipToPartyName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BPForShipToParty',
                     position: 610
                   }
    _SlsPrcgCndnRecdValidity.BPForShipToParty,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Supplier_VH', element: 'Supplier'}}] 
    @ObjectModel.text.element: ['SupplierName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Supplier',
                     position: 620
                   }
    _SlsPrcgCndnRecdValidity.Supplier,
    cast( '' as md_supplier_name ) as SupplierName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BPForSupplier',
                     position: 630
                   }
    _SlsPrcgCndnRecdValidity.BPForSupplier,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CountryVH', element: 'Country'}}]
    @ObjectModel.text.element: ['DestinationCountryName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'DestinationCountry',
                     position: 640
                   }
    _SlsPrcgCndnRecdValidity.DestinationCountry,
    cast( '' as landx50 ) as DestinationCountryName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_MaterialGroup', element: 'MaterialGroup'}}]
    @ObjectModel.text.element: ['MaterialGroupName']
    @EndUserText.label: 'Product Group'
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'MaterialGroup',
                     position: 650
                   }
//    _SlsPrcgCndnRecdValidity.MaterialGroup,
    cast (_SlsPrcgCndnRecdValidity.MaterialGroup as productgroup preserving type )     as MaterialGroup,
    cast( '' as wgbez ) as MaterialGroupName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_ProductStdVH', element: 'Product'}}]
    @ObjectModel.text.element: ['MaterialName']
    @EndUserText.label: 'Product'
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Material',
                     position: 660
                   }
//    _SlsPrcgCndnRecdValidity.Material,
    cast (_SlsPrcgCndnRecdValidity.Material as productnumber preserving type )         as Material,
    cast( '' as maktx )                     as MaterialName,       
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_ReturnsRefundExtent', element: 'ReturnsRefundExtent'}}]            
    @ObjectModel.text.element: ['ReturnsRefundExtentDesc']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ReturnsRefundExtent',
                     position: 670
                   }
    _SlsPrcgCndnRecdValidity.ReturnsRefundExtent,
    cast( '' as msr_refund_code_text ) as ReturnsRefundExtentDesc,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_AdditionalMaterialGroup1', element: 'AdditionalMaterialGroup1'}}] 
    @ObjectModel.text.element: ['AdditionalMaterialGroup1Name']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'AdditionalMaterialGroup1',
                     position: 680
                   }
//    _SlsPrcgCndnRecdValidity.AdditionalMaterialGroup1,
    cast (_SlsPrcgCndnRecdValidity.AdditionalMaterialGroup1 as firstsalesspecproductgroup preserving type )         as AdditionalMaterialGroup1,
    cast( '' as bezei40 ) as AdditionalMaterialGroup1Name,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_AdditionalMaterialGroup2', element: 'AdditionalMaterialGroup2'}}] 
    @ObjectModel.text.element: ['AdditionalMaterialGroup2Name']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'AdditionalMaterialGroup2',
                     position: 690
                   }
//    _SlsPrcgCndnRecdValidity.AdditionalMaterialGroup2,
    cast (_SlsPrcgCndnRecdValidity.AdditionalMaterialGroup2 as secondsalesspecproductgroup preserving type )        as AdditionalMaterialGroup2,
    cast( '' as bezei40 ) as AdditionalMaterialGroup2Name,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_AdditionalMaterialGroup3', element: 'AdditionalMaterialGroup3'}}]
    @ObjectModel.text.element: ['AdditionalMaterialGroup3Name']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'AdditionalMaterialGroup3',
                     position: 700
                   }
//    _SlsPrcgCndnRecdValidity.AdditionalMaterialGroup3,
    cast (_SlsPrcgCndnRecdValidity.AdditionalMaterialGroup3 as thirdsalesspecproductgroup preserving type )         as AdditionalMaterialGroup3,
    cast( '' as bezei40 ) as AdditionalMaterialGroup3Name,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_AdditionalMaterialGroup4', element: 'AdditionalMaterialGroup4'}}]
    @ObjectModel.text.element: ['AdditionalMaterialGroup4Name']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'AdditionalMaterialGroup4',
                     position: 710
                   }
//    _SlsPrcgCndnRecdValidity.AdditionalMaterialGroup4,
    cast (_SlsPrcgCndnRecdValidity.AdditionalMaterialGroup4 as fourthsalesspecproductgroup preserving type )        as AdditionalMaterialGroup4,
    cast( '' as bezei40 ) as AdditionalMaterialGroup4Name,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_AdditionalMaterialGroup5', element: 'AdditionalMaterialGroup5'}}]
    @ObjectModel.text.element: ['AdditionalMaterialGroup5Name']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'AdditionalMaterialGroup5',
                     position: 720
                   }
//    _SlsPrcgCndnRecdValidity.AdditionalMaterialGroup5,
    cast (_SlsPrcgCndnRecdValidity.AdditionalMaterialGroup5 as fifthsalesspecproductgroup preserving type )         as AdditionalMaterialGroup5,
    cast( '' as bezei40 ) as AdditionalMaterialGroup5Name,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_PersonWorkAgreement_1', element: 'PersonWorkAgreement'}}]
    @ObjectModel.text.element: ['PersonFullName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Personnel',
                     position: 730
                   }
    _SlsPrcgCndnRecdValidity.Personnel,
    cast( '' as bu_name1tx ) as PersonFullName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_PriceListType', element: 'PriceListType'}}]
    @ObjectModel.text.element: ['PriceListTypeName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'PriceListType',
                     position: 740
                   }
    _SlsPrcgCndnRecdValidity.PriceListType,
    cast( '' as text20 ) as PriceListTypeName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'PostalCode',
                     position: 750
                   }
    _SlsPrcgCndnRecdValidity.PostalCode,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Region', element: 'Region' },
                                       additionalBinding: [{ localElement: 'DepartureCountry', element: 'Country' }
                                                          ]},
                                     { entity: { name: 'I_Region', element: 'Region' },
                                       additionalBinding: [{ localElement: 'DestinationCountry', element: 'Country' }
                                                          ],
                                       qualifier: 'Destination'}
                                     ]                     
    @ObjectModel.text.element: ['RegionName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Region',
                     position: 760
                   }
    _SlsPrcgCndnRecdValidity.Region,
    cast( '' as bezei20 ) as RegionName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_EngmntProjSrvcOrgStdVH', element: 'EngagementProjectServiceOrg'}}]
    @ObjectModel.text.element: ['EngmtProjectServiceOrgName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'EngagementProjectServiceOrg',
                     position: 770
                   }
    _SlsPrcgCndnRecdValidity.EngagementProjectServiceOrg,
    cast( '' as /cpd/pws_ws_org_unit_id_desc ) as EngmtProjectServiceOrgName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'RequirementSegment',
                     position: 780
                   }
    _SlsPrcgCndnRecdValidity.RequirementSegment,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'StockSegment',
                     position: 790
                   }
    _SlsPrcgCndnRecdValidity.StockSegment,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Division', element: 'Division'}}]
    @ObjectModel.text.element: ['DivisionName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Division',
                     position: 800
                   }
    _SlsPrcgCndnRecdValidity.Division,
    cast( '' as divisionname ) as DivisionName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'C_PurOrdIntrastatCmmdtyCodeVH', element: 'CommodityCode'}}]
    @ObjectModel.text.element: ['CommodityCodeText']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CommodityCode',
                     position: 810
                   }
    //_SlsPrcgCndnRecdValidity.CommodityCode,
    cast('' as /sapsll/comco) as CommodityCode,
    cast( '' as bezei40 ) as CommodityCodeText,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConsumptionTaxCtrlCode',
                     position: 820
                   }
    _SlsPrcgCndnRecdValidity.ConsumptionTaxCtrlCode,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BRSpcfcTaxBasePercentageCode',
                     position: 830
                   }
    _SlsPrcgCndnRecdValidity.BRSpcfcTaxBasePercentageCode,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BRSpcfcTxGrpDynTaxExceptions',
                     position: 840
                   }
    _SlsPrcgCndnRecdValidity.BRSpcfcTxGrpDynTaxExceptions,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerTaxClassification1',
                     position: 850
                   }
    _SlsPrcgCndnRecdValidity.CustomerTaxClassification1,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerTaxClassification2',
                     position: 860
                   }
    _SlsPrcgCndnRecdValidity.CustomerTaxClassification2,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerTaxClassification3',
                     position: 870
                   }
    _SlsPrcgCndnRecdValidity.CustomerTaxClassification3,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerTaxClassification4',
                     position: 880
                   }
    _SlsPrcgCndnRecdValidity.CustomerTaxClassification4,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ProductTaxClassification1',
                     position: 890
                   }
    _SlsPrcgCndnRecdValidity.ProductTaxClassification1,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ProductTaxClassification2',
                     position: 900
                   }
    _SlsPrcgCndnRecdValidity.ProductTaxClassification2,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ProductTaxClassification3',
                     position: 910
                   }
    _SlsPrcgCndnRecdValidity.ProductTaxClassification3,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ProductTaxClassification4',
                     position: 920
                   }
    _SlsPrcgCndnRecdValidity.ProductTaxClassification4,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TradingContract',
                     position: 930
                   }
    _SlsPrcgCndnRecdValidity.TradingContract,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TradingContractItem',
                     position: 940
                   }
    _SlsPrcgCndnRecdValidity.TradingContractItem,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_TaxJurisdiction', element: 'TaxJurisdiction'}}]
    @ObjectModel.text.element: ['TaxJurisdictionName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TaxJurisdiction',
                     position: 950
                   }
    _SlsPrcgCndnRecdValidity.TaxJurisdiction,
    cast( '' as text1_txjt ) as TaxJurisdictionName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BRSpcfcTaxDepartureRegion',
                     position: 960
                   }
    _SlsPrcgCndnRecdValidity.BRSpcfcTaxDepartureRegion,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'BRSpcfcTaxDestinationRegion',
                     position: 970
                   }
    _SlsPrcgCndnRecdValidity.BRSpcfcTaxDestinationRegion,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_MaterialPricingGroup', element: 'MaterialPricingGroup'}}] 
    @ObjectModel.text.element: ['MainItemMaterialPricingGroup']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'MainItemMaterialPricingGroup',
                     position: 980
                   }
    @EndUserText.label: 'Material Pricing Group of Main Item'
    @EndUserText.quickInfo: 'Material Pricing Group of Main Item'
    _SlsPrcgCndnRecdValidity.MainItemMaterialPricingGroup,
    cast( '' as bezei20 ) as MainItmMatlPricingGroupName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_MaterialStdVH', element: 'Material'}}]
    @ObjectModel.text.element: ['MainItemPricingRefMaterialName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'MainItemPricingRefMaterial',
                     position: 990
                   }
    @EndUserText.label: 'Pricing Reference Material of Main Item'
    @EndUserText.quickInfo: 'Pricing Reference Material of Main Item'
    _SlsPrcgCndnRecdValidity.MainItemPricingRefMaterial,
    cast( '' as maktx ) as MainItemPricingRefMaterialName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_VariantCondition', element: 'VariantCondition'}}]
    @ObjectModel.text.element: ['VariantConditionName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'VariantCondition',
                     position: 1000
                   }
    _SlsPrcgCndnRecdValidity.VariantCondition,
    cast( '' as varcond ) as VariantConditionName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ValueAddedServiceChargeCode',
                     position: 1010
                   }
    _SlsPrcgCndnRecdValidity.ValueAddedServiceChargeCode,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SDDocument',
                     position: 1020
                   }
    _SlsPrcgCndnRecdValidity.SDDocument,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ReferenceSDDocument',
                     position: 1030
                   }
    _SlsPrcgCndnRecdValidity.ReferenceSDDocument,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ReferenceSDDocumentItem',
                     position: 1040
                   }
    _SlsPrcgCndnRecdValidity.ReferenceSDDocumentItem,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_SalesOffice', element: 'SalesOffice'}}]
    @ObjectModel.text.element: ['SalesOfficeName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SalesOffice',
                     position: 1050
                   }
    _SlsPrcgCndnRecdValidity.SalesOffice,
    cast( '' as bezei20 ) as SalesOfficeName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_SalesGroup', element: 'SalesGroup'}}]
    @ObjectModel.text.element: ['SalesGroupName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SalesGroup',
                     position: 1060
                   }
    _SlsPrcgCndnRecdValidity.SalesGroup,
    cast( '' as bezei20 ) as SalesGroupName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_SalesOrganization', element: 'SalesOrganization'}}]
    @ObjectModel.text.element: ['SalesOrganizationName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SalesOrganization',
                     position: 1070
                   }
    _SlsPrcgCndnRecdValidity.SalesOrganization,
    cast( '' as vtext ) as SalesOrganizationName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_SalesOrganization', element: 'SalesOrganization'}}]
    @ObjectModel.text.element: ['SlsOrderSalesOrganizationName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SalesOrderSalesOrganization',
                     position: 1080
                   }
    _SlsPrcgCndnRecdValidity.SalesOrderSalesOrganization,
    cast( '' as vtxtk ) as SlsOrderSalesOrganizationName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_BillOfMaterialUoMVH', element: 'VariableSizeCompUnitOfMeasure'}}]
    @ObjectModel.text.element: ['OrderQuantityUnitName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'OrderQuantityUnit',
                     position: 1090
                   }
    _SlsPrcgCndnRecdValidity.OrderQuantityUnit,
    cast( '' as msehl ) as OrderQuantityUnitName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_DistributionChannel', element: 'DistributionChannel'}}]
    @ObjectModel.text.element: ['DistributionChannelName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'DistributionChannel',
                     position: 1100
                   }
    _SlsPrcgCndnRecdValidity.DistributionChannel,
    cast( '' as vtext ) as DistributionChannelName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency'}}] 
    @ObjectModel.text.element: ['TransactionCurrencyName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TransactionCurrency',
                     position: 1110
                   }
    _SlsPrcgCndnRecdValidity.TransactionCurrency,
    cast( '' as ltext ) as TransactionCurrencyName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_WBSElementStdVH', element: 'WBSElement'}}]
    @ObjectModel.text.element: ['WBSDescription']
    @EndUserText.label: 'WBS Billing Element'
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'WBSElementInternalID',
                     position: 1120
                   }
    _SlsPrcgCndnRecdValidity.WBSElementInternalID,
    cast( '' as ps_post1 ) as  WBSDescription,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_WBSElementStdVH', element: 'WBSElement'}}]
    @ObjectModel.text.element: ['WBSDescription']   
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'WBSElementExternalID',
                     position: 1130
                   }
    _SlsPrcgCndnRecdValidity.WBSElementExternalID,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_WorkPackageStdVH', element: 'WorkPackage'}}]
    @ObjectModel.text.element: ['WorkPackageName']
    @EndUserText.label: 'WBS Work Package'
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'WorkPackage',
                     position: 1140
                   }
    //_SlsPrcgCndnRecdValidity.WorkPackage,
    cast('' as /cpd/plan_item_id) as WorkPackage,
    cast( '' as ps_post1 ) as  WorkPackageName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_PlantStdVH', element: 'Plant'}}]
    @ObjectModel.text.element: ['PlantName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'Plant',
                     position: 1150
                   }
    _SlsPrcgCndnRecdValidity.Plant,
    cast( '' as name1 ) as  PlantName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Region', element: 'Region'}}]
    @ObjectModel.text.element: ['PlantRegionName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'PlantRegion',
                     position: 1160
                   }
    _SlsPrcgCndnRecdValidity.PlantRegion,
    cast( '' as bezei20 ) as  PlantRegionName,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_WorkItem', element: 'WorkItem'}}]
    @ObjectModel.text.element: ['WorkItemName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'WorkItem',
                     position: 1170
                   }
    _SlsPrcgCndnRecdValidity.WorkItem,
    cast( '' as /cpd/pfp_workitem_name ) as WorkItemName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConditionProcessingStatus',
                     position: 1180
                   }
    _SlsPrcgCndnRecdValidity.ConditionProcessingStatus,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'PricingDate',
                     position: 1190
                   }
    @EndUserText.label: 'Condition Pricing Date'
    @EndUserText.quickInfo: 'Condition Pricing Date'   
    _SlsPrcgCndnRecdValidity.PricingDate,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConditionIsExclusive',
                     position: 1200
                   }
    _SlsPrcgCndnRecdValidity.ConditionIsExclusive,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConditionScaleBasisValue',
                     position: 1210
                   }
    _SlsPrcgCndnRecdValidity.ConditionScaleBasisValue,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TaxCode',
                     position: 1220
                   }
    _SlsPrcgCndnRecdValidity.TaxCode,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ServiceDocument',
                     position: 1230
                   }
    _SlsPrcgCndnRecdValidity.ServiceDocument,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ServiceDocumentItem',
                     position: 1240
                   }
    _SlsPrcgCndnRecdValidity.ServiceDocumentItem,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_TimeSheetOvertimeCat', element: 'TimeSheetOvertimeCategory'}}] 
    @ObjectModel.text.element: ['TimeSheetOvertimeCategoryText']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'TimeSheetOvertimeCategory',
                     position: 1250
                   }
    _SlsPrcgCndnRecdValidity.TimeSheetOvertimeCategory,
    cast( '' as cats_ssc_overtimecattext) as TimeSheetOvertimeCategoryText,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_SDDocumentCategory', element: 'SDDocumentCategory'}}] 
    @ObjectModel.text.element: ['SDDocumentCategoryName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SalesSDDocumentCategory',
                     position: 1260
                   }
    _SlsPrcgCndnRecdValidity.SalesSDDocumentCategory,
    cast( '' as val_text ) as SDDocumentCategoryName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ReturnReason',
                     position: 1270
                   }
    _SlsPrcgCndnRecdValidity.ReturnReason,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_ProductHierarchyNormalNode', element: 'ProductHierarchyNode'}}] 
    @ObjectModel.text.element: ['ProductHierarchyNodeText']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ProductHierarchyNode',
                     position: 1280
                   }
    //_SlsPrcgCndnRecdValidity.ProductHierarchyNode,
    cast('' as prodh_d) as ProductHierarchyNode,
    cast( '' as prod_hier_node_value_text ) as ProductHierarchyNodeText,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CustomerConditionGroup',
                     position: 1290
                   }
    @EndUserText.label: 'Customer Condition Group'
    @EndUserText.quickInfo: 'Customer Condition Group'
    _SlsPrcgCndnRecdValidity.CustomerConditionGroup,
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_ShippingType', element: 'ShippingType'}}]
    @ObjectModel.text.element: ['ShippingTypeName']
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ShippingType',
                     position: 1300
                   }
    _SlsPrcgCndnRecdValidity.ShippingType,
    cast( '' as versartbez ) as ShippingTypeName,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SubscriptionContractDuration',
                     position: 1310
                   }
    _SlsPrcgCndnRecdValidity.SubscriptionContractDuration,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SubscrpnContrDurationUnit',
                     position: 1320
                   }
    //_SlsPrcgCndnRecdValidity.SubscrpnContrDurationUnit,
    cast('' as crms4_som_ctr_term_unit) as SubscrpnContrDurationUnit,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'SubscriptionContractLockReason',
                     position: 1330
                   }
    _SlsPrcgCndnRecdValidity.SubscriptionContractLockReason,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'CrsCtlgMappgPriceVersionNumber',
                     position: 1340
                   }
    _SlsPrcgCndnRecdValidity.CrsCtlgMappgPriceVersionNumber,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                     qualifier: 'ConditionReleaseStatus',
                     position: 1350
                   }     
    _SlsPrcgCndnRecdValidity.ConditionReleaseStatus,    
    @ObjectModel.mandatory: true
    @Consumption.filter.hidden: true
    @UI.fieldGroup:{ groupLabel: 'Key',
                     qualifier: 'PhysDocFileName',
                     position: 1360
                   }
    cast('' as esh_e_fl_filename) as PhysDocFileName,
    @UI.fieldGroup:{ groupLabel: 'Key',
                     qualifier: 'Etag',
                     position: 1370
                   }
    cast('' as char40) as ETag,
    @UI.fieldGroup:{ groupLabel: 'Condition Key',
                   qualifier: 'AUART_SD',
                   position: 1380
                 }
      cast('' as auart)                 as AUART_SD,
      
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                   qualifier: 'ZZ1_AUARTSD_PCH',
                   position: 1385
                 }    
      cast('' as zz1_auartsd)           as ZZ1_AUARTSD_PCH, 
 
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'ZZ1_AUART_REF',
                       position: 1390
                     }               
      cast('' as zz1_auart_ref)         as ZZ1_AUART_REF_PCI,
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'AUGRU',
                       position: 1400
                     }
      cast('' as augru)                 as AUGRU,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'BZIRK',
                       position: 1410
                     }
      cast('' as bzirk)                 as BZIRK,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'FSH_COLLECTION',
                       position: 1420
                     }
      cast('' as fsh_collection)        as FSH_COLLECTION,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'FSH_SEASON',
                       position: 1430
                     }
      cast('' as fsh_saiso)             as FSH_SEASON,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'FSH_SEASON_YEAR',
                       position: 1440
                     }
      cast('' as fsh_saisj)             as FSH_SEASON_YEAR,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'KNUMA_AG',
                       position: 1460
                     }
      cast('' as knuma_ag)              as KNUMA_AG,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'KUNRE',
                       position: 1470
                     }
      cast('' as kunre)                 as KUNRE,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'PROVG',
                       position: 1480
                     }
      cast('' as provg)                 as PROVG,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'VSTEL',
                       position: 1490
                     }
      cast('' as vstel)                 as VSTEL,
    
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'ZZ1_BSART_PCH',
                       position: 1510
                     }
      cast('' as zz1_bsart)             as ZZ1_BSART_PCH,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'ZZ1_BSART_PCH',
                       position: 1510
                     }
      cast('' as zmm_bsg)               as ZZBSG,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'ZZFSH_KVGR7',
                       position: 1520
                     }
      cast('' as fsh_kvgr7)             as ZZFSH_KVGR7,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'ZZFSH_KVGR8',
                       position: 1530
                     }
      cast('' as fsh_kvgr8)             as ZZFSH_KVGR8,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'ZZKATR1',
                       position: 1540
                     }
      cast('' as  katr1)                as ZZKATR1,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                       qualifier: 'ZZKATR9',
                       position: 1550
                     }
      cast('' as  katr9)                as ZZKATR9,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                        qualifier: 'ZZKVGR2',
                        position: 1560
                      }
      cast('' as  kvgr2)                as ZZKVGR2,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                        qualifier: 'ZZKVGR4',
                        position: 1570
                      }
      cast('' as  kvgr4)                as ZZKVGR4,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                        qualifier: 'ZZLASTSEASON',
                        position: 1580
                      }
      cast('' as  zmm_last_sale_season) as ZZLASTSEASON,
    
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                        qualifier: 'ZZVMSTA',
                        position: 1590
                      }
      cast('' as  vmsta) as ZZVMSTA,
      
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                        qualifier: 'AKTNR',
                        position: 1600
                      }      
      cast('' as  waktion) as AKTNR, 
      
      @UI.fieldGroup:{ groupLabel: 'Condition Details',
                        qualifier: 'ZZ1_M3SEASON_PCI',
                        position: 1610
                      }       
      cast('' as zz1_m3season ) as ZZ1_M3SEASON_PCI, 
      
      @UI.fieldGroup:{ groupLabel: 'Condition Key',
                        qualifier: 'ZZ1_MM_FSH_MG_AT1',
                        position: 1620
                      }      
      cast('' as  zz1_mm_fsh_mg_at1 ) as ZZ1_MM_FSH_MG_AT1_PCI,      
  
    _SlsPrcgCndnRecdValidity
}
