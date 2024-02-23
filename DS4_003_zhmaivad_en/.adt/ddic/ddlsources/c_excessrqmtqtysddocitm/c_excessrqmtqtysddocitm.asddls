@AbapCatalog.sqlViewName: 'CEXRQMTSDITM'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@EndUserText.label: 'Manage Excess Requirements'
@AbapCatalog.preserveKey: true
@Search.searchable: true

@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #D,
     sizeCategory:   #XL
   }
}
@ClientHandling.type: #INHERITED
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #CONSUMPTION

@UI.headerInfo: {
    typeName:       'Item', // Page Header
    title:          {value: 'FormattedSalesDocumentItem'}// item, value is a path
  }

@UI.selectionVariant: [
  { qualifier: 'OrderTypeSO',
    text: 'Sales Orders',
    filter: 'RequirementType EQ "VC"'},
  { qualifier: 'OrderTypeSTO',
    text: 'Stock Transport Orders',
    filter: 'RequirementType EQ "U1"'},
  { qualifier: 'OrderTypeCON',
    text: 'Fashion Contracts',
    filter: 'RequirementType EQ "VG"'},
  { qualifier: 'OrderTypeACC',
    text: 'Account Assigned Sales Orders',
    filter: 'RequirementType EQ "ACC"'}
]
@UI.presentationVariant: [{
     requestAtLeast: [ 'FormattedSalesDocumentItem' ],
      sortOrder: [
       { by: 'SitnNumberOfInstances', direction: #DESC },
       { by: 'SalesDocument', direction: #DESC },
       { by: 'SalesDocumentItem', direction: #ASC }]

     }]
define view C_ExcessRqmtQtySDDocItm
  as select from I_ExcessRqmtQtySDDocItm as _Item
  association [0..1] to C_ExcessRqmtQtySlsContrItm     as _SlsContrItm                  on  $projection.SalesDocument         = _SlsContrItm.SalesDocument
                                                                                        and $projection.SalesDocumentItem     = _SlsContrItm.SalesDocumentItem
                                                                                        and $projection.SalesDocumentItemUUID = _SlsContrItm.SalesDocumentItemUUID
  association [0..1] to C_ExcessRqmtQtyAcctAssgdItm    as _AcctAssgdItm                 on  $projection.SalesDocument         = _AcctAssgdItm.SalesDocument
                                                                                        and $projection.SalesDocumentItem     = _AcctAssgdItm.SalesDocumentItem
                                                                                        and $projection.SalesDocumentItemUUID = _AcctAssgdItm.SalesDocumentItemUUID
  association [0..*] to C_ExcessRqmtQtySTOItm          as _StockTransportOrderItm       on  $projection.SalesDocument = _StockTransportOrderItm.PurchaseOrder
  association [0..1] to C_ExcessRqmtQtyEditSDDocItm    as _EditSDDocItm                 on  $projection.SalesDocument         = _EditSDDocItm.SalesDocument
                                                                                        and $projection.SalesDocumentItem     = _EditSDDocItm.SalesDocumentItem
                                                                                        and $projection.SalesDocumentItemUUID = _EditSDDocItm.SalesDocumentItemUUID
  association [0..1] to I_Material                     as _ConfigurableProduct          on  $projection.CrossPlantConfigurableProduct = _ConfigurableProduct.Material
  // Text Associations
  association [0..1] to I_MaterialText                 as _MaterialText                 on  $projection.Material   = _MaterialText.Material
                                                                                        and _MaterialText.Language = $session.system_language
  association [0..1] to I_MaterialText                 as _ConfigurableProductText      on  $projection.CrossPlantConfigurableProduct = _ConfigurableProductText.Material
                                                                                        and _ConfigurableProductText.Language         = $session.system_language
  association [0..1] to I_MaterialGroupText            as _MaterialGroupText            on  $projection.MaterialGroup   = _MaterialGroupText.MaterialGroup
                                                                                        and _MaterialGroupText.Language = $session.system_language
  association [0..1] to I_AdditionalMaterialGroup1Text as _AdditionalMaterialGroup1Name on  $projection.AdditionalMaterialGroup1   = _AdditionalMaterialGroup1Name.AdditionalMaterialGroup1
                                                                                        and _AdditionalMaterialGroup1Name.Language = $session.system_language
  association [0..1] to I_AdditionalMaterialGroup2Text as _AdditionalMaterialGroup2Name on  $projection.AdditionalMaterialGroup2   = _AdditionalMaterialGroup2Name.AdditionalMaterialGroup2
                                                                                        and _AdditionalMaterialGroup2Name.Language = $session.system_language
  association [0..1] to I_AdditionalMaterialGroup3Text as _AdditionalMaterialGroup3Name on  $projection.AdditionalMaterialGroup3   = _AdditionalMaterialGroup3Name.AdditionalMaterialGroup3
                                                                                        and _AdditionalMaterialGroup3Name.Language = $session.system_language
  association [0..1] to I_AdditionalMaterialGroup4Text as _AdditionalMaterialGroup4Name on  $projection.AdditionalMaterialGroup4   = _AdditionalMaterialGroup4Name.AdditionalMaterialGroup4
                                                                                        and _AdditionalMaterialGroup4Name.Language = $session.system_language
  association [0..1] to I_AdditionalMaterialGroup5Text as _AdditionalMaterialGroup5Name on  $projection.AdditionalMaterialGroup5   = _AdditionalMaterialGroup5Name.AdditionalMaterialGroup5
                                                                                        and _AdditionalMaterialGroup5Name.Language = $session.system_language
  association [0..1] to I_ShippingPointText            as _ShippingPointText            on  $projection.ShippingPoint   = _ShippingPointText.ShippingPoint
                                                                                        and _ShippingPointText.Language = $session.system_language
  association [0..1] to I_SalesDocumentTypeText        as _SalesDocumentTypeText        on  $projection.SalesDocumentType   = _SalesDocumentTypeText.SalesDocumentType
                                                                                        and _SalesDocumentTypeText.Language = $session.system_language
  association [0..1] to I_RetailCharacteristicValueT   as _CharValTexts1                on  $projection.ProductCharacteristic1   = _CharValTexts1.RetailCharacteristicValue
                                                                                        and $projection.ProdCharc1InternalNumber = _CharValTexts1.CharacteristicInternalID
                                                                                        and _CharValTexts1.Language              = $session.system_language
  association [0..1] to I_RetailCharacteristicValueT   as _CharValTexts2                on  $projection.ProductCharacteristic2   = _CharValTexts2.RetailCharacteristicValue
                                                                                        and $projection.ProdCharc2InternalNumber = _CharValTexts2.CharacteristicInternalID
                                                                                        and _CharValTexts2.Language              = $session.system_language
  association [0..1] to I_RetailCharacteristicValueT   as _CharValTexts3                on  $projection.ProductCharacteristic3   = _CharValTexts3.RetailCharacteristicValue
                                                                                        and $projection.ProdCharc3InternalNumber = _CharValTexts3.CharacteristicInternalID
                                                                                        and _CharValTexts3.Language              = $session.system_language
  association [0..1] to I_DeliveryPriorityText         as _DeliveryPriorityText         on  $projection.DeliveryPriority   = _DeliveryPriorityText.DeliveryPriority
                                                                                        and _DeliveryPriorityText.Language = $session.system_language
  association [0..1] to I_SalesDocumentItemCategoryT   as _ItemCategoryText             on  $projection.SalesDocumentItemCategory = _ItemCategoryText.SalesDocumentItemCategory
                                                                                        and _ItemCategoryText.Language            = $session.system_language
  association [0..1] to I_CustomerPaymentTermsText     as _CustomerPaymentTermsText     on  $projection.CustomerPaymentTerms   = _CustomerPaymentTermsText.CustomerPaymentTerms
                                                                                        and _CustomerPaymentTermsText.Language = $session.system_language
  association [0..1] to I_IncotermsClassificationText  as _IncotermsClassificationText  on  $projection.IncotermsClassification   = _IncotermsClassificationText.IncotermsClassification
                                                                                        and _IncotermsClassificationText.Language = $session.system_language
  association [0..1] to I_CustomerGroupText            as _CustomerGroupText            on  $projection.CustomerGroup   = _CustomerGroupText.CustomerGroup
                                                                                        and _CustomerGroupText.Language = $session.system_language
  association [0..1] to I_SalesDistrictText            as _SalesDistrictText            on  $projection.SalesDistrict   = _SalesDistrictText.SalesDistrict
                                                                                        and _SalesDistrictText.Language = $session.system_language
  association [0..1] to I_SDDocumentReasonText         as _SDDocumentReasonText         on  $projection.SDDocumentReason   = _SDDocumentReasonText.SDDocumentReason
                                                                                        and _SDDocumentReasonText.Language = $session.system_language
  association [0..1] to I_User                         as _CreatedByUser                on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [1..1] to I_SalesDocument                as _SalesDocument                on  $projection.SalesDocument = _SalesDocument.SalesDocument
  association [1..1] to I_SalesDocumentItem            as _SalesDocumentItem            on  $projection.SalesDocumentItem = _SalesDocumentItem.SalesDocumentItem
                                                                                        and $projection.SalesDocument     = _SalesDocumentItem.SalesDocument

  association [1..*] to I_SalesDocumentPartner         as _HeaderPartner                on  $projection.SalesDocument = _HeaderPartner.SalesDocument
  association [0..*] to I_SalesDocumentItemPartner     as _ItemPartner                  on  $projection.SalesDocument     = _ItemPartner.SalesDocument
                                                                                        and $projection.SalesDocumentItem = _ItemPartner.SalesDocumentItem
  association [0..1] to E_SalesDocumentBasic           as _SalesDocHeaderExtension      on  _Item.SalesDocument = _SalesDocHeaderExtension.SalesDocument
  association [0..1] to E_SalesDocumentItemBasic       as _SalesDocItemExtension        on  _Item.SalesDocument     = _SalesDocItemExtension.SalesDocument
                                                                                        and _Item.SalesDocumentItem = _SalesDocItemExtension.SalesDocumentItem
{
       @ObjectModel.foreignKey.association: '_SalesDocument'
       @Consumption: {semanticObject: 'SalesDocument' }
       @EndUserText.label: 'Sales Document'
       @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
       @UI.selectionField.position:60
  key  SalesDocument,
       @EndUserText.label: 'Sales Document Item'
       @Consumption.filter.hidden: true
  key  SalesDocumentItem,
       @UI.hidden: true
  key  SalesDocumentItemUUID,
       FormattedSalesDocumentItem,
       @UI.hidden: true
       DocumentItemConcatenatedID,
       @Consumption.filter.hidden: true
       @EndUserText.label: 'Number of Situations'
       _Item._SitnInstceIndicator.SitnNumberOfInstances,
       @ObjectModel.text.element: 'UserDescription'
       CreatedByUser,
       @UI.hidden: true
       _CreatedByUser.UserDescription,
       @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
       @UI.selectionField.position:20
       @Consumption: {  filter:{ selectionType: #INTERVAL, multipleSelections: false} }
       CreationDate,
       @Consumption.semanticObject: 'Material'
       @UI.lineItem: [ { position: 30 } ]
       @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
       @UI.selectionField.position:40
       @EndUserText.label: 'Product'
       @ObjectModel.text.element: 'MaterialName'
       @UI.identification: [{ position: 20, importance: #HIGH, type: #STANDARD }]
       Material,
       @UI.hidden: true
       _MaterialText.MaterialName,
       @ObjectModel.text.element: 'CrsPlntConfigurableProductName'
       @ObjectModel.foreignKey.association: '_ConfigurableProduct'
       @EndUserText.label: 'Generic Product'
       CrossPlantConfigurableProduct,
       @UI.hidden: true
       _ConfigurableProductText.MaterialName        as CrsPlntConfigurableProductName,

       @ObjectModel.text.element: 'MaterialGroupName'
       @ObjectModel.foreignKey.association: '_MaterialGroup'
       MaterialGroup,
       @UI.hidden: true
       _MaterialGroupText.MaterialGroupName,

       @ObjectModel.text.element: 'AdditionalMaterialGroup1Name'
       @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup1'
       AdditionalMaterialGroup1,
       @UI.hidden: true
       _AdditionalMaterialGroup1Name.AdditionalMaterialGroup1Name,
       @ObjectModel.text.element: 'AdditionalMaterialGroup2Name'
       @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup2'
       AdditionalMaterialGroup2,
       @UI.hidden: true
       _AdditionalMaterialGroup2Name.AdditionalMaterialGroup2Name,
       @ObjectModel.text.element: 'AdditionalMaterialGroup3Name'
       @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup3'
       AdditionalMaterialGroup3,
       @UI.hidden: true
       _AdditionalMaterialGroup3Name.AdditionalMaterialGroup3Name,
       @ObjectModel.text.element: 'AdditionalMaterialGroup4Name'
       @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup4'
       AdditionalMaterialGroup4,
       @UI.hidden: true
       _AdditionalMaterialGroup4Name.AdditionalMaterialGroup4Name,
       @ObjectModel.text.element: 'AdditionalMaterialGroup5Name'
       @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup5'
       AdditionalMaterialGroup5,
       @UI.hidden: true
       _AdditionalMaterialGroup5Name.AdditionalMaterialGroup5Name,

       @UI.lineItem: [ { position: 40 } ]
       @EndUserText.label: 'Requested Quantity'
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       @UI.identification: [{ position: 30, importance: #HIGH, type: #STANDARD }]
       RequestedQuantityInBaseUnit,
       @EndUserText.label: 'Confirmed Quantity'
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       @UI.identification: [{ position: 40, importance: #HIGH, type: #STANDARD }]
       ConfirmedRqmtQtyInBaseUnit,
       @UI.lineItem: [ { position: 50 } ]
       @EndUserText.label: 'Open Quantity for Confirmation'
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        @UI.identification: [{ position: 50, importance: #HIGH, type: #STANDARD }]
       OpenForConfQtyInBaseUnit,
       @EndUserText.label: 'Assigned Quantity'
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        @UI.identification: [{ position: 60, importance: #HIGH, type: #STANDARD }]
       AssignedQuantityInBaseUnit,
       @UI.lineItem: [ { position: 60 } ]
       @EndUserText.label: 'Open Quantity for Assignment'
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        @UI.identification: [{ position: 70, importance: #HIGH, type: #STANDARD }]
       OpenForAssignmentQtyInBsUnt,
       @EndUserText.label: 'Delivered Quantity'
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        @UI.identification: [{ position: 80, importance: #HIGH, type: #STANDARD }]
       DeliveredQuantityInBaseUnit,
       @UI.lineItem: [ { position: 70 } ]
       @EndUserText.label: 'Open Quantity for Delivery'
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        @UI.identification: [{ position: 90, importance: #HIGH, type: #STANDARD }]
       OpenForDeliveryQtyInBsUnt,
       @EndUserText.label: 'Base Unit'
       @ObjectModel.foreignKey.association: '_BaseUnit'
       BaseUnit,
       @ObjectModel.foreignKey.association: '_SalesDocumentType'
       @ObjectModel.text.element: 'SalesDocumentTypeName'
       SalesDocumentType,
       @UI.hidden: true
       _SalesDocumentTypeText.SalesDocumentTypeName,
       @ObjectModel.foreignKey.association: '_SalesOrganization'
       SalesOrganization,
       @ObjectModel.foreignKey.association: '_DistributionChannel'
       DistributionChannel,
       @ObjectModel.foreignKey.association: '_OrganizationDivision'
       @EndUserText.label: 'Header Division'
       OrganizationDivision,
       @EndUserText.label: 'Item Division'
       @ObjectModel.foreignKey.association: '_Division'
       Division,

       @ObjectModel.foreignKey.association: '_SalesDistrict'
       @ObjectModel.text.element: 'SalesDistrictName'
       SalesDistrict,
       @UI.hidden: true
       _SalesDistrictText.SalesDistrictName,

       @ObjectModel.foreignKey.association: '_SDDocumentReason'
       @ObjectModel.text.element: 'SDDocumentReasonText'
       SDDocumentReason,
       @UI.hidden: true
       _SDDocumentReasonText.SDDocumentReasonText,

       @ObjectModel.foreignKey.association: '_ItemCategory'
       @ObjectModel.text.element: 'SalesDocumentItemCategoryName'
       SalesDocumentItemCategory,
       @UI.hidden: true
       _ItemCategoryText.SalesDocumentItemCategoryName,

       @ObjectModel.foreignKey.association: '_SDDocumentCategory'
       SDDocumentCategory,
       @ObjectModel.foreignKey.association: '_Plant'
       @ObjectModel.text.element: 'PlantName'
       @Consumption.semanticObject: 'Plant'
       @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
       @UI.selectionField.position:50

       Plant,
       @UI.hidden: true
       _Plant.PlantName,
       @EndUserText.label: 'Requested Delivery Date'
       //@UI.selectionField.position:30
//        @Consumption.filter.defaultValue: #($session.system_date)
       //      @Consumption.filter.defaultValue: '18.10.2019'
       @Consumption: {  filter:{ selectionType: #INTERVAL, multipleSelections: false} }
       RequestedDeliveryDate,

       @ObjectModel.foreignKey.association: '_CustomerGroup'
       @ObjectModel.text.element: 'CustomerGroupName'
       CustomerGroup,
       @UI.hidden
       _CustomerGroupText.CustomerGroupName,
       @Consumption: {  filter:{ selectionType: #INTERVAL, multipleSelections: false} }
       @Feature:'SW:RFM_CANC_DTE_UI'
       FashionCancelDate,

       @ObjectModel.foreignKey.association: '_TotalCreditCheckStatus'
       TotalCreditCheckStatus,
       @ObjectModel.foreignKey.association: '_SoldToParty'
       @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
       @UI.selectionField.position:10
       @UI.identification: [{ position: 10, importance: #HIGH, type: #STANDARD }]
       SoldToParty,
       @EndUserText.label: 'Company Code'
       @ObjectModel.foreignKey.association: '_BillingCompanyCode'
       BillingCompanyCode,
       @ObjectModel.foreignKey.association: '_StorageLocation'
       @Consumption.semanticObject: 'StorageLocation'
       @ObjectModel.text.element: 'StorageLocationName'
       StorageLocation,
       @UI.hidden: true
       _StorageLocation.StorageLocationName,
       @UI.hidden
       SalesDocumentRjcnReason,
       @Feature:'SW:RFM_SEGMTN_UI'
       RequirementSegment,
       @Consumption.valueHelpDefinition: [{entity.name: 'C_ProductSeasonYearVH', entity.element: 'ProductSeasonYear'}]
       @Feature:'SW:RFM_SEASON_UI'
       ProductSeasonYear,
       @Consumption.valueHelpDefinition: [{entity.name: 'C_ProductSeasonYearVH', entity.element: 'ProductSeason'}]
       @Feature:'SW:RFM_SEASON_UI'
       ProductSeason,
       @Consumption.valueHelpDefinition: [{entity.name: 'C_ProductSeasonYearVH', entity.element: 'ProductCollection'}]
       @Feature:'SW:RFM_SEASON_UI'
       ProductCollection,
       @Consumption.valueHelpDefinition: [{entity.name: 'C_ProductSeasonYearVH', entity.element: 'ProductTheme'}]
       @Feature:'SW:RFM_SEASON_UI'
       ProductTheme,
       @Consumption.valueHelpDefinition: [{entity.name: 'C_MATLDOCOVWCHARVALUEVH', entity.element: 'ProductCharacteristic1'}]
       @EndUserText.label: 'Product Characteristic 1'
       @ObjectModel.text.element: 'ProductCharacteristic1Desc'
       @Feature:'SW:RFM_CHARC_VALS_UI'
       ProductCharacteristic1,
       @UI.hidden: true
       @Feature:'SW:RFM_CHARC_VALS_UI'
       _CharValTexts1.RetailCharacteristicValueDesc as ProductCharacteristic1Desc,
       @Consumption.valueHelpDefinition: [{entity.name: 'C_MATLDOCOVWCHARVALUEVH', entity.element: 'ProductCharacteristic2'}]
       @EndUserText.label: 'Product Characteristic 2'
       @ObjectModel.text.element: 'ProductCharacteristic2Desc'
       @Feature:'SW:RFM_CHARC_VALS_UI'
       ProductCharacteristic2,
       @UI.hidden: true
       @Feature:'SW:RFM_CHARC_VALS_UI'
       _CharValTexts1.RetailCharacteristicValueDesc as ProductCharacteristic2Desc,
       @Consumption.valueHelpDefinition: [{entity.name: 'C_MATLDOCOVWCHARVALUEVH', entity.element: 'ProductCharacteristic3'}]
       @EndUserText.label: 'Product Characteristic 3'
       @ObjectModel.text.association: '_CharValTexts3'
       @ObjectModel.text.element: 'ProductCharacteristic3Desc'
       @Feature:'SW:RFM_CHARC_VALS_UI'
       ProductCharacteristic3,
       @UI.hidden: true
       @Feature:'SW:RFM_CHARC_VALS_UI'
       _CharValTexts1.RetailCharacteristicValueDesc as ProductCharacteristic3Desc,
       @ObjectModel.foreignKey.association: '_DeliveryPriority'
       @ObjectModel.text.element: 'DeliveryPriorityDesc'
       DeliveryPriority,
       @UI.hidden: true
       _DeliveryPriorityText.DeliveryPriorityDesc,
       @Consumption.valueHelpDefinition: [
         { entity:  { name:    'I_BatchStdVH',
                      element: 'Batch' },
           additionalBinding: [{ localElement: 'Plant',
                                 element: 'Plant' },
                               { localElement: 'Material',
                                 element: 'Material' }]
          }]
       Batch,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       NetPriceAmount,
       @Semantics.currencyCode: true
       @UI.hidden
       TransactionCurrency,
       @Consumption.valueHelpDefinition: [
         { entity:  { name:    'I_ShippingPointStdVH',
                      element: 'ShippingPoint' }
         }]


       @ObjectModel.foreignKey.association: '_ShippingPoint'
       @ObjectModel.text.element: 'ShippingPointName'
       ShippingPoint,
       @UI.hidden
       _ShippingPointText.ShippingPointName,
       @ObjectModel.foreignKey.association: '_CustomerPaymentTerms'
       @ObjectModel.text.element: 'CustomerPaymentTermsName'
       CustomerPaymentTerms,
       @UI.hidden
       _CustomerPaymentTermsText.CustomerPaymentTermsName,
       @ObjectModel.foreignKey.association: '_IncotermsClassification'
       @ObjectModel.text.element: 'IncotermsClassificationName'
       IncotermsClassification,
       @UI.hidden
       _IncotermsClassificationText.IncotermsClassificationName,

       @EndUserText.label: 'Open Quantity for Confirmation (%)'
       OpenForConfReqdQtyRatioPct,

       @EndUserText.label: 'Open Quantity for Assignment (%)'
       OpenForAssgmtReqdQtyRatioPct,

       @EndUserText.label: 'Open Quantity for Delivery (%)'
       OpenForDeliveryReqdQtyRatioPct,

       @UI.hidden
       cast ('' as rfm_document_type )              as ExcessRqmtDocumentType,
       @UI.hidden
       cast ('' as rfm_rejection_type )             as ExcessRqmtQtyRejectionType,
       @UI.hidden: true
       cast (0 as rfm_rejection_qty )               as ExcessRqmtRejectionQuantity,
       @UI.hidden
       cast ('' as apj_job_text )                   as ApplicationJobDescription,

       @ObjectModel.foreignKey.association: '_ItemGeneralIncompletionStatus'
       @EndUserText.label: 'Item Incompletion Status'
       ItemGeneralIncompletionStatus,
       @ObjectModel.foreignKey.association: '_ItemBillingIncompletionStatus'
       @EndUserText.label: 'Item Billing Incompletion Status'
       ItemBillingIncompletionStatus,
       @ObjectModel.foreignKey.association: '_ItemDelivIncompletionSts'
       @EndUserText.label: 'Item Delivery Incompletion Status'
       ItemDeliveryIncompletionStatus,
       @EndUserText.label: 'Supply Assignment Relevancy Status'
       RqmtIsSupAssgmtRelevant,
       @EndUserText: { label: 'Stock Transport Order', quickInfo: 'Stock Transport Order' }
       @UI.selectionField.position:70
       @Consumption.valueHelpDefinition: [{ entity: { name : 'I_StockTransportOrderStdVH', element : 'PurchaseOrder' } }]
       cast ('' as ebeln )                          as PurchaseOrder,
       @Consumption.semanticObject: 'PurchasingOrganization'
       @EndUserText: {label: 'Purchasing Organization', quickInfo: 'Purchasing Organization'}
       @Consumption.valueHelpDefinition: [{ entity: { name : 'C_PurchasingOrgValueHelp', element : 'PurchasingOrganization' } }]
       cast ('' as ekorg )                          as PurchasingOrganization,
       @Consumption.semanticObject: 'PurchasingGroup'
       @Consumption.valueHelpDefinition: [{ entity: { name : 'C_PurchasingGroupValueHelp', element : 'PurchasingGroup' } }]
       cast ('' as ekgrp )                          as PurchasingGroup,
       @EndUserText: {label: 'Order Type', quickInfo: 'Purchase Order Type'}
       @Consumption.valueHelpDefinition: [{ entity: { name : 'C_POItemOrderTypeValueHelp', element : 'PurchaseOrderType' } }]
       cast ('' as bsart )                          as PurchaseOrderType,
       @Consumption.semanticObject: 'Plant'
       @Consumption.valueHelpDefinition: [{ entity: { name : 'C_MM_PlantValueHelp', element : 'Plant' } }]
       @EndUserText: {quickInfo: 'Supplying Plant'}
       cast ('' as reswk )                          as SupplyingPlant,

       @UI.hidden: true
       ProdCharc1InternalNumber,
       @UI.hidden: true
       ProdCharc2InternalNumber,
       @UI.hidden: true
       ProdCharc3InternalNumber,
       @Consumption.filter.hidden: true
       SalesDocument as SalesOrder,

       @Consumption.filter.hidden: true
       _SlsContrItm,
       @Consumption.filter.hidden: true
       _SalesDocumentRjcnReason,
       @Consumption.filter.hidden: true
       _StockTransportOrderItm,
       @Consumption.filter.hidden: true
       _AcctAssgdItm,
       @Consumption.filter.hidden: true
       _SalesDocument,
       @Consumption.filter.hidden: true
       _SalesDocumentItem,
       @Consumption.filter.hidden: true
       _SalesDocumentType,
       @Consumption.filter.hidden: true
       _SalesOrganization,
       @Consumption.filter.hidden: true
       _DistributionChannel,
       @Consumption.filter.hidden: true
       _OrganizationDivision,
       @Consumption.filter.hidden: true
       _Division,
       @Consumption.filter.hidden: true
       _Plant,
       @Consumption.filter.hidden: true
       _CustomerGroup,
       @Consumption.filter.hidden: true
       _TotalCreditCheckStatus,
       @Consumption.filter.hidden: true
       _ItemGeneralIncompletionStatus,
       @Consumption.filter.hidden: true
       _ItemBillingIncompletionStatus,
       @Consumption.filter.hidden: true
       _ItemDelivIncompletionSts,
       @Consumption.filter.hidden: true
       _BaseUnit,
       @Consumption.filter.hidden: true
       _ItemCategory,
       @Consumption.filter.hidden: true
       _SDDocumentCategory,
       @Consumption.filter.hidden: true
       _StorageLocation,
       @Consumption.filter.hidden: true
       _DeliveryPriority,
       @Consumption.filter.hidden: true
       _ShippingPoint,
       @Consumption.filter.hidden: true
       _CustomerPaymentTerms,
       @Consumption.filter.hidden: true
       _IncotermsClassification,
       @Consumption.filter.hidden: true
       _Material,
       @Consumption.filter.hidden: true
       _MaterialGroup,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup1,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup2,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup3,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup4,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup5,
       @Consumption.filter.hidden: true
       _MaterialText,
       @Consumption.filter.hidden: true
       _ShippingPointText,
       @Consumption.filter.hidden: true
       _SalesDocumentTypeText,
       @Consumption.filter.hidden: true
       _CharValTexts1,
       @Consumption.filter.hidden: true
       _CharValTexts2,
       @Consumption.filter.hidden: true
       _CharValTexts3,
       @Consumption.filter.hidden: true
       _DeliveryPriorityText,
       @Consumption.filter.hidden: true
       _ItemCategoryText,
       @Consumption.filter.hidden: true
       _CustomerPaymentTermsText,
       @Consumption.filter.hidden: true
       _IncotermsClassificationText,
       @Consumption.filter.hidden: true
       _CustomerGroupText,
       @Consumption.filter.hidden: true
       _MaterialGroupText,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup1Name,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup2Name,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup3Name,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup4Name,
       @Consumption.filter.hidden: true
       _AdditionalMaterialGroup5Name,
       @Consumption.filter.hidden: true
       _CreatedByUser,
       @Consumption.filter.hidden: true
       _SalesDistrictText,
       @Consumption.filter.hidden: true
       _ConfigurableProduct,
       @Consumption.filter.hidden: true
       _ConfigurableProductText,
       @Consumption.filter.hidden: true
       _SalesDistrict,
       @Consumption.filter.hidden: true
       _SDDocumentReason,
       @Consumption.filter.hidden: true
       _SDDocumentReasonText,
       @Consumption.filter.hidden: true
       _SoldToParty,
       @Consumption.filter.hidden: true
       _BillingCompanyCode,
       @Consumption.filter.hidden: true
       _HeaderPartner,
       @Consumption.filter.hidden: true
       _ItemPartner,
       @Consumption.filter.hidden: true
       _EditSDDocItm
}
