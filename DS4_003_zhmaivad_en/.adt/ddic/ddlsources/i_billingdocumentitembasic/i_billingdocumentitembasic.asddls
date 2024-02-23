@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.modelingPattern:         #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #SQL_DATA_SOURCE ]
@EndUserText.label: 'Billing Document Item Basic'
@VDM.viewType: #BASIC
@AccessControl: {
  authorizationCheck: #CHECK
  //privilegedAssociations: [ '_CreatedByUser' ]
}
@AbapCatalog: {
  sqlViewName: 'ISDBILLDOCITBC',
  compiler.compareFilter: true,
  preserveKey: true
}
@ObjectModel.representativeKey: 'BillingDocumentItem'
@Analytics.dataCategory: #DIMENSION

//--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
@AccessControl.privilegedAssociations: ['_MaterialGroupText', '_MainItemPricingRefMatlText', '_PricingReferenceMaterialText', '_OriginallyRequestedMatlText', '_MaterialText', '_ProductText', '_CreatedByUser', '_ShippingPointText', '_WBSElementText', '_BusinessAreaText']
// ]--GENERATED

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define view I_BillingDocumentItemBasic
  as select from vbrp
  //Association

  //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
  association [0..*] to I_MaterialText                 as _MaterialText                  on  $projection.Material = _MaterialText.Material
  association [0..*] to I_ProductText                  as _ProductText                   on  $projection.Product = _ProductText.Product
  association [0..*] to I_MaterialText                 as _OriginallyRequestedMatlText   on  $projection.OriginallyRequestedMaterial = _OriginallyRequestedMatlText.Material
  association [0..*] to I_MaterialText                 as _PricingReferenceMaterialText  on  $projection.PricingReferenceMaterial = _PricingReferenceMaterialText.Material
  association [0..*] to I_MaterialText                 as _MainItemPricingRefMatlText    on  $projection.MainItemPricingRefMaterial = _MainItemPricingRefMatlText.Material
  association [0..*] to I_MaterialGroupText            as _MaterialGroupText             on  $projection.MaterialGroup = _MaterialGroupText.MaterialGroup
  association [0..*] to I_ShippingPointText            as _ShippingPointText             on  $projection.ShippingPoint = _ShippingPointText.ShippingPoint
  association [0..*] to I_WBSElementText               as _WBSElementText                on  $projection.WBSElement = _WBSElementText.WBSElementObject
  association [0..*] to I_BusinessAreaText             as _BusinessAreaText              on  $projection.BusinessArea = _BusinessAreaText.BusinessArea
  // ]--GENERATED
  association [1..1] to I_BillingDocumentBasic         as _BillingDocumentBasic          on  $projection.BillingDocument = _BillingDocumentBasic.BillingDocument
  association [0..*] to I_BillingDocItemPartnerBasic   as _PartnerBasic                  on  $projection.BillingDocument     = _PartnerBasic.BillingDocument
                                                                                         and $projection.BillingDocumentItem = _PartnerBasic.BillingDocumentItem
  association [0..*] to I_BillingDocItemPrcgElmntBasic as _PricingElementBasic           on  $projection.BillingDocument     = _PricingElementBasic.BillingDocument
                                                                                         and $projection.BillingDocumentItem = _PricingElementBasic.BillingDocumentItem
  association [0..1] to I_SalesDocumentItemCategory    as _SalesDocumentItemCategory     on  $projection.SalesDocumentItemCategory = _SalesDocumentItemCategory.SalesDocumentItemCategory
  association [0..1] to I_SalesDocumentItemType        as _SalesDocumentItemType         on  $projection.SalesDocumentItemType = _SalesDocumentItemType.SalesDocumentItemType
  association [0..1] to I_User                         as _CreatedByUser                 on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_LogicalSystem                as _ReferenceLogicalSystem        on  $projection.ReferenceLogicalSystem = _ReferenceLogicalSystem.LogicalSystem
  association [0..1] to I_Division                     as _OrganizationDivision          on  $projection.OrganizationDivision = _OrganizationDivision.Division
  association [0..1] to I_Division                     as _Division                      on  $projection.Division = _Division.Division
  association [0..1] to I_SalesOffice                  as _SalesOffice                   on  $projection.SalesOffice = _SalesOffice.SalesOffice
  association [0..1] to I_Material                     as _Material                      on  $projection.Material = _Material.Material
  association [0..1] to I_Product                      as _Product                       on  $projection.Product = _Product.Product
  association [0..1] to I_Material                     as _OriginallyRequestedMaterial   on  $projection.OriginallyRequestedMaterial = _OriginallyRequestedMaterial.Material
  association [0..1] to I_Material                     as _PricingReferenceMaterial      on  $projection.PricingReferenceMaterial = _PricingReferenceMaterial.Material
  association [0..1] to I_Batch                        as _Batch                         on  $projection.Plant    = _Batch.Plant
                                                                                         and $projection.Material = _Batch.Material
                                                                                         and $projection.Batch    = _Batch.Batch
  association [0..1] to I_ProductHierarchyNode         as _ProductHierarchyNode          on  $projection.ProductHierarchyNode = _ProductHierarchyNode.ProductHierarchyNode
  association [0..1] to I_MaterialGroup                as _MaterialGroup                 on  $projection.MaterialGroup = _MaterialGroup.MaterialGroup
  association [0..1] to I_ProductGroup_2               as _ProductGroup                  on  $projection.ProductGroup = _ProductGroup.ProductGroup
  association [0..1] to I_AdditionalMaterialGroup1     as _AdditionalMaterialGroup1      on  $projection.AdditionalMaterialGroup1 = _AdditionalMaterialGroup1.AdditionalMaterialGroup1
  association [0..1] to I_AdditionalMaterialGroup2     as _AdditionalMaterialGroup2      on  $projection.AdditionalMaterialGroup2 = _AdditionalMaterialGroup2.AdditionalMaterialGroup2
  association [0..1] to I_AdditionalMaterialGroup3     as _AdditionalMaterialGroup3      on  $projection.AdditionalMaterialGroup3 = _AdditionalMaterialGroup3.AdditionalMaterialGroup3
  association [0..1] to I_AdditionalMaterialGroup4     as _AdditionalMaterialGroup4      on  $projection.AdditionalMaterialGroup4 = _AdditionalMaterialGroup4.AdditionalMaterialGroup4
  association [0..1] to I_AdditionalMaterialGroup5     as _AdditionalMaterialGroup5      on  $projection.AdditionalMaterialGroup5 = _AdditionalMaterialGroup5.AdditionalMaterialGroup5
  association [0..1] to I_MaterialCommissionGroup      as _MaterialCommissionGroup       on  $projection.MaterialCommissionGroup = _MaterialCommissionGroup.MaterialCommissionGroup
  association [0..1] to I_Plant                        as _Plant                         on  $projection.Plant = _Plant.Plant
  association [0..1] to I_StorageLocation              as _StorageLocation               on  $projection.Plant           = _StorageLocation.Plant
                                                                                         and $projection.StorageLocation = _StorageLocation.StorageLocation
  association [0..1] to I_Region                       as _PlantRegion                   on  $projection.DepartureCountry = _PlantRegion.Country
                                                                                         and $projection.PlantRegion      = _PlantRegion.Region
  association [0..1] to I_Plant                        as _TransitPlant                  on  $projection.TransitPlant = _TransitPlant.Plant
  association [0..1] to I_ValueChainCategory           as _ValueChainCategory            on  $projection.ValueChainCategory = _ValueChainCategory.ValueChainCategory
  association [0..1] to I_UnitOfMeasure                as _BillingQuantityUnit           on  $projection.BillingQuantityUnit = _BillingQuantityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _BaseUnit                      on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ItemWeightUnit                on  $projection.ItemWeightUnit = _ItemWeightUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ItemVolumeUnit                on  $projection.ItemVolumeUnit = _ItemVolumeUnit.UnitOfMeasure
  association [0..1] to I_Country                      as _BillToPartyCountry            on  $projection.BillToPartyCountry = _BillToPartyCountry.Country
  association [0..1] to I_Region                       as _BillToPartyRegion             on  $projection.BillToPartyCountry = _BillToPartyRegion.Country
                                                                                         and $projection.BillToPartyRegion  = _BillToPartyRegion.Region
  association [0..1] to I_BillingPlanRule              as _BillingPlanRule               on  $projection.BillingPlanRule = _BillingPlanRule.BillingPlanRule
  association [0..1] to I_Currency                     as _TransactionCurrency           on  $projection.TransactionCurrency = _TransactionCurrency.Currency
  association [0..1] to I_StatisticalValueControl      as _StatisticalValueControl       on  $projection.StatisticalValueControl = _StatisticalValueControl.StatisticalValueControl
  association [0..1] to I_MaterialPricingGroup         as _MaterialPricingGroup          on  $projection.MaterialPricingGroup = _MaterialPricingGroup.MaterialPricingGroup
  association [0..1] to I_Material                     as _MainItemPricingRefMaterial    on  $projection.MainItemPricingRefMaterial = _MainItemPricingRefMaterial.Material
  association [0..1] to I_MaterialPricingGroup         as _MainItemMaterialPricingGroup  on  $projection.MainItemMaterialPricingGroup = _MainItemMaterialPricingGroup.MaterialPricingGroup
  association [0..1] to I_TimeSheetOvertimeCat         as _TimeSheetOvertimeCat          on  $projection.TimeSheetOvertimeCategory = _TimeSheetOvertimeCat.TimeSheetOvertimeCategory
  association [0..1] to I_PricingRelevance             as _PricingRelevance              on  $projection.PricingRelevance = _PricingRelevance.PricingRelevance  
  association [0..1] to I_Country                      as _DepartureCountry              on  $projection.DepartureCountry = _DepartureCountry.Country
  association [0..1] to I_Country                      as _CountryOfOrigin               on  $projection.CountryOfOrigin = _CountryOfOrigin.Country
  association [0..1] to I_Region                       as _RegionOfOrigin                on  $projection.CountryOfOrigin = _RegionOfOrigin.Country
                                                                                         and $projection.RegionOfOrigin  = _RegionOfOrigin.Region
  association [0..1] to I_BusinessArea                 as _BusinessArea                  on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [0..1] to I_WBSElement                   as _WBSElement                    on  $projection.WBSElement = _WBSElement.WBSElement
  association [0..1] to I_WBSElementBasicData          as _WBSElementBasicData           on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID
  association [0..1] to I_ControllingArea              as _ControllingArea               on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association [0..1] to I_MatlAccountAssignmentGroup   as _MatlAccountAssignmentGroup    on  $projection.MatlAccountAssignmentGroup = _MatlAccountAssignmentGroup.MatlAccountAssignmentGroup
  association [0..1] to I_CostCenter                   as _CostCenter                    on  $projection.CostCenter        = _CostCenter.CostCenter
                                                                                         and $projection.ControllingArea   = _CostCenter.ControllingArea
                                                                                         and _CostCenter.ValidityEndDate   >= $projection.CreationDate
                                                                                         and _CostCenter.ValidityStartDate <= $projection.CreationDate                                                                                         
  association [0..*] to I_CostCenter                   as _CostCenter_2                  on  $projection.CostCenter        = _CostCenter_2.CostCenter
                                                                                         and $projection.ControllingArea   = _CostCenter_2.ControllingArea                                                                                                                                                                         
  association [0..*] to I_ProfitCenter                 as _ProfitCenter                  on  $projection.ProfitCenter    = _ProfitCenter.ProfitCenter
                                                                                         and $projection.ControllingArea = _ProfitCenter.ControllingArea                                                                                           
  association [0..1] to I_SalesDocumentItem            as _ReferenceSalesDocumentItem    on  $projection.ReferenceSDDocument           = _ReferenceSalesDocumentItem.SalesDocument
                                                                                         and $projection.ReferenceSDDocumentItem       = _ReferenceSalesDocumentItem.SalesDocumentItem
                                                                                         and (
                                                                                            $projection.ReferenceSDDocumentCategory    = 'C' // Order
                                                                                            or $projection.ReferenceSDDocumentCategory = 'G' // Contract
                                                                                            or $projection.ReferenceSDDocumentCategory = 'H' // Returns
                                                                                            or $projection.ReferenceSDDocumentCategory = 'I' // Order wo Charge
                                                                                            or $projection.ReferenceSDDocumentCategory = 'K' // Credit Memo Request
                                                                                            or $projection.ReferenceSDDocumentCategory = 'L' // Debit Memo Request
                                                                                            or $projection.ReferenceSDDocumentCategory = ':' // Service Order
                                                                                          )
  association [0..1] to I_DeliveryDocumentItem         as _ReferenceDeliveryDocumentItem on  $projection.ReferenceSDDocument           = _ReferenceDeliveryDocumentItem.DeliveryDocument
                                                                                         and $projection.ReferenceSDDocumentItem       = _ReferenceDeliveryDocumentItem.DeliveryDocumentItem
                                                                                         and (
                                                                                            $projection.ReferenceSDDocumentCategory    = 'J' // Delivery
                                                                                            or $projection.ReferenceSDDocumentCategory = 'T' // Returns Delivery for Order
                                                                                          )
  association [0..1] to I_BillingDocumentItemBasic     as _ReferenceBillingDocItemBasic  on  $projection.ReferenceSDDocument           = _ReferenceBillingDocItemBasic.BillingDocument
                                                                                         and $projection.ReferenceSDDocumentItem       = _ReferenceBillingDocItemBasic.BillingDocumentItem
                                                                                         and (
                                                                                            $projection.ReferenceSDDocumentCategory    = 'M'    // Invoice
                                                                                            or $projection.ReferenceSDDocumentCategory = 'N'    // Invoice Canceled
                                                                                            or $projection.ReferenceSDDocumentCategory = 'O'    // Credit Memo
                                                                                            or $projection.ReferenceSDDocumentCategory = 'P'    // Debit Memo
                                                                                            or $projection.ReferenceSDDocumentCategory = 'S'    // Credit Memo Canceled
                                                                                            or $projection.ReferenceSDDocumentCategory = 'U'    // Pro Forma Invoice
                                                                                            or $projection.ReferenceSDDocumentCategory = '3'    // Invoice List
                                                                                            or $projection.ReferenceSDDocumentCategory = '4'    // Credit Memo List
                                                                                            or $projection.ReferenceSDDocumentCategory = '5'    // Intercompany Invoice
                                                                                            or $projection.ReferenceSDDocumentCategory = '6'    // Intercompany Credit Memo
                                                                                            or $projection.ReferenceSDDocumentCategory = 'EBDR' // External Billing Document Request
                                                                                            or $projection.ReferenceSDDocumentCategory = 'PBD'  // Preliminary Billing Document
                                                                                          )
  association [0..1] to I_SDDocumentCategory           as _ReferenceSDDocumentCategory   on  $projection.ReferenceSDDocumentCategory = _ReferenceSDDocumentCategory.SDDocumentCategory
  association [0..1] to I_SalesDocument                as _SalesDocument                 on  $projection.SalesDocument = _SalesDocument.SalesDocument
  association [0..1] to I_SalesDocumentItem            as _SalesDocumentItem             on  $projection.SalesDocument     = _SalesDocumentItem.SalesDocument
                                                                                         and $projection.SalesDocumentItem = _SalesDocumentItem.SalesDocumentItem
  association [0..1] to I_SDDocumentCategory           as _SalesSDDocumentCategory       on  $projection.SalesSDDocumentCategory = _SalesSDDocumentCategory.SDDocumentCategory
  association [0..1] to I_BillingDocumentItemBasic     as _HigherLevelItemBasic          on  $projection.BillingDocument = _HigherLevelItemBasic.BillingDocument
                                                                                         and $projection.HigherLevelItem = _HigherLevelItemBasic.BillingDocumentItem
  association [0..1] to I_PrelimBillingDocument        as _PrelimBillingDocument         on  $projection.PrelimBillingDocument = _PrelimBillingDocument.PrelimBillingDocument
  association [0..1] to I_PrelimBillingDocumentItem    as _PrelimBillingDocumentItem     on  $projection.PrelimBillingDocument     = _PrelimBillingDocumentItem.PrelimBillingDocument
                                                                                         and $projection.PrelimBillingDocumentItem = _PrelimBillingDocumentItem.PrelimBillingDocumentItem
  association [0..1] to I_SalesGroup                   as _SalesGroup                    on  $projection.SalesGroup = _SalesGroup.SalesGroup
  association [0..1] to I_AdditionalCustomerGroup1     as _AdditionalCustomerGroup1      on  $projection.AdditionalCustomerGroup1 = _AdditionalCustomerGroup1.AdditionalCustomerGroup1
  association [0..1] to I_AdditionalCustomerGroup2     as _AdditionalCustomerGroup2      on  $projection.AdditionalCustomerGroup2 = _AdditionalCustomerGroup2.AdditionalCustomerGroup2
  association [0..1] to I_AdditionalCustomerGroup3     as _AdditionalCustomerGroup3      on  $projection.AdditionalCustomerGroup3 = _AdditionalCustomerGroup3.AdditionalCustomerGroup3
  association [0..1] to I_AdditionalCustomerGroup4     as _AdditionalCustomerGroup4      on  $projection.AdditionalCustomerGroup4 = _AdditionalCustomerGroup4.AdditionalCustomerGroup4
  association [0..1] to I_AdditionalCustomerGroup5     as _AdditionalCustomerGroup5      on  $projection.AdditionalCustomerGroup5 = _AdditionalCustomerGroup5.AdditionalCustomerGroup5
  association [0..1] to I_SDDocumentReason             as _SDDocumentReason              on  $projection.SDDocumentReason = _SDDocumentReason.SDDocumentReason
  association [0..1] to I_RetailPromotion              as _RetailPromotion               on  $projection.RetailPromotion = _RetailPromotion.RetailPromotion
  association [0..1] to I_SalesDeal                    as _SalesDeal                     on  $projection.SalesDeal = _SalesDeal.SalesDeal
  association [0..1] to I_SalesDistrict                as _SalesOrderSalesDistrict       on  $projection.SalesOrderSalesDistrict = _SalesOrderSalesDistrict.SalesDistrict
  association [0..1] to I_CustomerGroup                as _SalesOrderCustomerGroup       on  $projection.SalesOrderCustomerGroup = _SalesOrderCustomerGroup.CustomerGroup
  association [0..1] to I_CustomerPriceGroup           as _SalesOrderCustomerPriceGroup  on  $projection.SalesOrderCustomerPriceGroup = _SalesOrderCustomerPriceGroup.CustomerPriceGroup
  association [0..1] to I_PriceListType                as _SalesOrderPriceListType       on  $projection.SalesOrderPriceListType = _SalesOrderPriceListType.PriceListType
  association [0..1] to I_SalesOrganization            as _SalesOrderSalesOrganization   on  $projection.SalesOrderSalesOrganization = _SalesOrderSalesOrganization.SalesOrganization
  association [0..1] to I_DistributionChannel          as _SalesOrderDistributionChannel on  $projection.SalesOrderDistributionChannel = _SalesOrderDistributionChannel.DistributionChannel
  association [0..1] to I_ShippingPoint                as _ShippingPoint                 on  $projection.ShippingPoint = _ShippingPoint.ShippingPoint
  association [0..1] to I_ServiceDocumentType          as _ServiceDocumentType           on  $projection.ServiceDocumentType = _ServiceDocumentType.ServiceDocumentType
  association [0..1] to I_ProviderContract             as _ProviderContract              on  $projection.ProviderContract = _ProviderContract.ProviderContract
  association [0..1] to I_ProviderContractItem         as _ProviderContractItem          on  $projection.ProviderContract     = _ProviderContractItem.ProviderContract
                                                                                         and $projection.ProviderContractItem = _ProviderContractItem.ProviderContractItem

  //Extension Association
  association [1]    to E_BillingDocumentItem          as _Extension                     on  $projection.BillingDocument     = _Extension.BillingDocument
                                                                                         and $projection.BillingDocumentItem = _Extension.BillingDocumentItem
{
      //Key
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BillingDocumentBasicStdVH',
                     element: 'BillingDocument' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_BillingDocumentBasic'
  key vbeln                                                             as BillingDocument,
      @ObjectModel.text.element:  ['BillingDocumentItemText']
  key posnr                                                             as BillingDocumentItem,

      @ObjectModel.foreignKey.association: '_SalesDocumentItemCategory'
      cast(pstyv as sales_doc_item_category preserving type)            as SalesDocumentItemCategory,

      @ObjectModel.foreignKey.association: '_SalesDocumentItemType'
      posar                                                             as SalesDocumentItemType,
      shkzg                                                             as ReturnItemProcessingType,

      //Admin
      @Semantics.user.createdBy: true
      ernam                                                             as CreatedByUser,
      @Semantics.systemDate.createdAt: true
      erdat                                                             as CreationDate,
      @Semantics.systemTime.createdAt
      erzet                                                             as CreationTime,
      @ObjectModel.foreignKey.association: '_ReferenceLogicalSystem'
      logsys                                                            as ReferenceLogicalSystem,

      //Organization
      @ObjectModel.foreignKey.association: '_OrganizationDivision'
      cast(spara as sales_order_divison preserving type)                as OrganizationDivision,
      @ObjectModel.foreignKey.association: '_Division'
      spart                                                             as Division,
      @ObjectModel.foreignKey.association: '_SalesOffice'
      vkbur                                                             as SalesOffice,

      //Product
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_MaterialText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Material'
      @API.element: { releaseState: #DEPRECATED, successor: 'Product' }
      matnr                                                             as Material,
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ProductStdVH',
                     element: 'Product' }
        }]
      @ObjectModel.text.association: '_ProductText'
      @ObjectModel.foreignKey.association: '_Product'
      cast (matnr as productnumber preserving type)                     as Product,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_OriginallyRequestedMatlText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_OriginallyRequestedMaterial'
      matwa                                                             as OriginallyRequestedMaterial,
      ean11                                                             as InternationalArticleNumber,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_PricingReferenceMaterialText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_PricingReferenceMaterial'
      pmatn                                                             as PricingReferenceMaterial,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BatchStdVH',
                     element: 'Batch' },
          additionalBinding: [{ localElement: 'Plant',
                                element: 'Plant' },
                              { localElement: 'Material',
                                element: 'Material' }]
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Batch'
      charg                                                             as Batch,
      @ObjectModel.foreignKey.association: '_ProductHierarchyNode'
      prodh                                                             as ProductHierarchyNode,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_MaterialGroup',
                     element: 'MaterialGroup' }
        }]
      @ObjectModel.text.association: '_MaterialGroupText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_MaterialGroup'
      @API.element: { releaseState: #DEPRECATED, successor: 'ProductGroup' }
      matkl                                                             as MaterialGroup,
      @ObjectModel.foreignKey.association: '_ProductGroup'
      cast (matkl as productgroup preserving type )                     as ProductGroup,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup1'
      mvgr1                                                             as AdditionalMaterialGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup2'
      mvgr2                                                             as AdditionalMaterialGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup3'
      mvgr3                                                             as AdditionalMaterialGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup4'
      mvgr4                                                             as AdditionalMaterialGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup5'
      mvgr5                                                             as AdditionalMaterialGroup5,
      cuobj                                                             as ProductConfiguration,
      @ObjectModel.foreignKey.association: '_MaterialCommissionGroup'
      provg                                                             as MaterialCommissionGroup,
      @ObjectModel.foreignKey.association: '_Plant'
      werks                                                             as Plant,
      @ObjectModel.foreignKey.association: '_StorageLocation'
      lgort                                                             as StorageLocation,
      atpkz                                                             as ReplacementPartType,
      wgru1                                                             as MaterialGroupHierarchy1,
      wgru2                                                             as MaterialGroupHierarchy2,
      @ObjectModel.foreignKey.association: '_PlantRegion'
      wkreg                                                             as PlantRegion,
      wkcou                                                             as PlantCounty,
      wkcty                                                             as PlantCity,
      @ObjectModel.foreignKey.association: '_TransitPlant'
      transit_plant                                                     as TransitPlant,
      @ObjectModel.foreignKey.association: '_ValueChainCategory'
      vcm_chain_category                                                as ValueChainCategory,
      sernr                                                             as BOMExplosion,
      prosa                                                             as MaterialDeterminationType,


      //Billing
      @Semantics.text: true
      arktx                                                             as BillingDocumentItemText,
      fbuda                                                             as ServicesRenderedDate,

      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      fkimg                                                             as BillingQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BillingQuantityUnit'
      vrkme                                                             as BillingQuantityUnit,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      fklmg                                                             as BillingQuantityInBaseUnit,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnit'
      meins                                                             as BaseUnit,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      lmeng                                                             as MRPRequiredQuantityInBaseUnit,
      umvkn                                                             as BillingToBaseQuantityDnmntr,
      umvkz                                                             as BillingToBaseQuantityNmrtr,

      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      brgew                                                             as ItemGrossWeight,

      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ntgew                                                             as ItemNetWeight,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ItemWeightUnit'
      gewei                                                             as ItemWeightUnit,

      @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
      volum                                                             as ItemVolume,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ItemVolumeUnit'
      voleh                                                             as ItemVolumeUnit,
      @ObjectModel.foreignKey.association: '_BillToPartyCountry'
      lland_auft                                                        as BillToPartyCountry,
      @ObjectModel.foreignKey.association: '_BillToPartyRegion'
      regio_auft                                                        as BillToPartyRegion,
      @ObjectModel.foreignKey.association: '_BillingPlanRule'
      fareg                                                             as BillingPlanRule,
      fplnr                                                             as BillingPlan,
      fpltr                                                             as BillingPlanItem,

      //Status
      // foreign key association has to be defined (in next release (?)), target: I_DocBillingStatus
      fksaa                                                             as DocumentBillingStatus,

      //Pricing

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      netwr                                                             as NetAmount,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_TransactionCurrency'
      waerk                                                             as TransactionCurrency,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      brtwr                                                             as GrossAmount,
      prsdt                                                             as PricingDate,
      cast(kursk as kursk_not_converted preserving type )               as PriceDetnExchangeRate,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      smeng                                                             as PricingScaleQuantityInBaseUnit,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      mwsbp                                                             as TaxAmount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      wavwr                                                             as CostAmount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi1                                                             as Subtotal1Amount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi2                                                             as Subtotal2Amount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi3                                                             as Subtotal3Amount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi4                                                             as Subtotal4Amount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi5                                                             as Subtotal5Amount,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi6                                                             as Subtotal6Amount,
      @ObjectModel.foreignKey.association: '_StatisticalValueControl'
      kowrr                                                             as StatisticalValueControl,
      sktof                                                             as CashDiscountIsDeductible,
      kdkg1                                                             as CustomerConditionGroup1,
      kdkg2                                                             as CustomerConditionGroup2,
      kdkg3                                                             as CustomerConditionGroup3,
      kdkg4                                                             as CustomerConditionGroup4,
      kdkg5                                                             as CustomerConditionGroup5,
      mprok                                                             as ManualPriceChangeType,
      @ObjectModel.foreignKey.association: '_MaterialPricingGroup'
      kondm                                                             as MaterialPricingGroup,
      cast(stcur as stcur_ap_not_converted preserving type )            as StatisticsExchangeRate,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_MainItemPricingRefMatlText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_MainItemPricingRefMaterial'
      upmat                                                             as MainItemPricingRefMaterial,
      @ObjectModel.foreignKey.association: '_MainItemMaterialPricingGroup'
      ukonm                                                             as MainItemMaterialPricingGroup,
      @ObjectModel.foreignKey.association: '_TimeSheetOvertimeCat'
      cats_overtime_category                                            as TimeSheetOvertimeCategory,
      @ObjectModel.foreignKey.association: '_PricingRelevance'
      prsfd                                                             as PricingRelevance,
      
      // Tax
      @ObjectModel.foreignKey.association: '_DepartureCountry'
      aland                                                             as DepartureCountry,
      txjcd                                                             as TaxJurisdiction,
      taxm1                                                             as ProductTaxClassification1,
      taxm2                                                             as ProductTaxClassification2,
      taxm3                                                             as ProductTaxClassification3,
      taxm4                                                             as ProductTaxClassification4,
      taxm5                                                             as ProductTaxClassification5,
      taxm6                                                             as ProductTaxClassification6,
      taxm7                                                             as ProductTaxClassification7,
      taxm8                                                             as ProductTaxClassification8,
      taxm9                                                             as ProductTaxClassification9,
      j_1arfz                                                           as ZeroVATRsn,
      mwsk1                                                             as TaxCode,
      txdat_from                                                        as TaxRateValidityStartDate,

      // Foreign trade
      @ObjectModel.foreignKey.association: '_CountryOfOrigin'
      spe_herkl                                                         as CountryOfOrigin,
      @ObjectModel.foreignKey.association: '_RegionOfOrigin'
      spe_herkr                                                         as RegionOfOrigin,
      itm_comco                                                         as CommodityCode,

      //Payment
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      skfbp                                                             as EligibleAmountForCashDiscount,

      //Accounting
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BusinessAreaStdVH',
                     element: 'BusinessArea' }
        }]
      @ObjectModel.text.association: '_BusinessAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_BusinessArea'
      gsber                                                             as BusinessArea,
      @ObjectModel.foreignKey.association: '_ProfitCenter'
      prctr                                                             as ProfitCenter,

      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_WBSElementStdVH',
                     element: 'WBSElement' }
        }]
      @ObjectModel.text.association: '_WBSElementText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_WBSElement'
      @API.element: { releaseState: #DEPRECATED, successor: 'WBSElementInternalID' }
      ps_psp_pnr                                                        as WBSElement,
      @ObjectModel.foreignKey.association: '_WBSElementBasicData'
      cast( ps_psp_pnr as ps_s4_pspnr preserving type )                 as WBSElementInternalID,

      @ObjectModel.foreignKey.association: '_ProviderContract'
      vtkey                                                             as ProviderContract,
      @ObjectModel.foreignKey.association: '_ProviderContractItem'
      cast(vtpos as provider_contract_item preserving type)             as ProviderContractItem,
      perop_beg                                                         as BillingPerformancePeriodStrDte,
      perop_end                                                         as BillingPerformancePeriodEndDte,

      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ControllingAreaStdVH',
                     element: 'ControllingArea' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ControllingArea'
      kokrs                                                             as ControllingArea,
      @API.element: { releaseState: #DEPRECATED, successor: 'ProfitabilitySegment_2' }
      cast(paobjnr as rkeobjnr_numc)                                    as ProfitabilitySegment,
      cast(paobjnr as rkeobjnr_char)                                    as ProfitabilitySegment_2,

      aufnr                                                             as OrderID,
      @ObjectModel.foreignKey.association: '_CostCenter_2'
      kostl                                                             as CostCenter,     
      vbelv                                                             as OriginSDDocument,
      posnv                                                             as OriginSDDocumentItem,
      kursk_dat                                                         as PriceDetnExchangeRateDate,

      @ObjectModel.foreignKey.association: '_MatlAccountAssignmentGroup'
      ktgrm                                                             as MatlAccountAssignmentGroup,

      //Reference
      vgbel                                                             as ReferenceSDDocument,
      vgpos                                                             as ReferenceSDDocumentItem,
      @ObjectModel.foreignKey.association: '_ReferenceSDDocumentCategory'
      cast(vgtyp as reference_doc_category preserving type)             as ReferenceSDDocumentCategory,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_SalesDocumentStdVH',
                     element: 'SalesDocument' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_SalesDocument'
      aubel                                                             as SalesDocument,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_SalesDocumentItemStdVH',
                     element: 'SalesDocumentItem' },
          additionalBinding: [{ localElement: 'SalesDocument',
                                element: 'SalesDocument' }]
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_SalesDocumentItem'
      aupos                                                             as SalesDocumentItem,
      @ObjectModel.foreignKey.association: '_SalesSDDocumentCategory'
      cast(autyp as sales_document_category preserving type)            as SalesSDDocumentCategory,


      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BillgDocItmBscStdVH',
                     element: 'BillingDocumentItem' },
          additionalBinding: [{ localElement: 'BillingDocument',
                                element: 'BillingDocument' }]
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_HigherLevelItemBasic'
      uepos                                                             as HigherLevelItem,
      pospa                                                             as BillingDocumentItemInPartSgmt,
      cast( vgbel_ex as ext_reference_document preserving type )        as ExternalReferenceDocument,
      @API.element: { releaseState: #DEPRECATED, successor: 'BillingDocExtReferenceDocItem' }
      cast( vgpos_ex as ext_reference_document_item preserving type )   as ExternalReferenceDocumentItem,
      cast( vgpos_ex as billingdocextreferencedocitem preserving type ) as BillingDocExtReferenceDocItem,
      @ObjectModel.foreignKey.association: '_PrelimBillingDocument'
      pbd_id                                                            as PrelimBillingDocument,
      @ObjectModel.foreignKey.association: '_PrelimBillingDocumentItem'
      pbd_item_id                                                       as PrelimBillingDocumentItem,

      //Sales
      @ObjectModel.foreignKey.association: '_SalesGroup'
      vkgrp                                                             as SalesGroup,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup1'
      kvgr1                                                             as AdditionalCustomerGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup2'
      kvgr2                                                             as AdditionalCustomerGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup3'
      kvgr3                                                             as AdditionalCustomerGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup4'
      kvgr4                                                             as AdditionalCustomerGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup5'
      kvgr5                                                             as AdditionalCustomerGroup5,
      @ObjectModel.foreignKey.association: '_SDDocumentReason'
      augru_auft                                                        as SDDocumentReason,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_RetailPromotionStdVH',
                     element: 'RetailPromotion' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_RetailPromotion'
      aktnr                                                             as RetailPromotion,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      bonba                                                             as RebateBasisAmount,
      bonus                                                             as VolumeRebateGroup,
      cmpnt                                                             as ItemIsRelevantForCredit,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cmpre                                                             as CreditRelatedPrice,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_SalesDealStdVH',
                     element: 'SalesDeal' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_SalesDeal'
      knuma_ag                                                          as SalesDeal,
      knuma_pi                                                          as SalesPromotion,
      @ObjectModel.foreignKey.association: '_SalesOrderSalesDistrict'
      bzirk_auft                                                        as SalesOrderSalesDistrict,
      @ObjectModel.foreignKey.association: '_SalesOrderCustomerGroup'
      kdgrp_auft                                                        as SalesOrderCustomerGroup,
      @ObjectModel.foreignKey.association: '_SalesOrderCustomerPriceGroup'
      konda_auft                                                        as SalesOrderCustomerPriceGroup,
      @ObjectModel.foreignKey.association: '_SalesOrderPriceListType'
      pltyp_auft                                                        as SalesOrderPriceListType,
      @ObjectModel.foreignKey.association: '_SalesOrderSalesOrganization'
      vkorg_auft                                                        as SalesOrderSalesOrganization,
      @ObjectModel.foreignKey.association: '_SalesOrderDistributionChannel'
      vtweg_auft                                                        as SalesOrderDistributionChannel,
      auref                                                             as SalesDocIsCreatedFromReference,

      //Shipping
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ShippingPointStdVH',
                     element: 'ShippingPoint' }
        }]
      @ObjectModel.text.association: '_ShippingPointText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ShippingPoint'
      vstel                                                             as ShippingPoint,

      // CRM
      @ObjectModel.foreignKey.association: '_ServiceDocumentType'
      service_doc_type                                                  as ServiceDocumentType,
      service_doc_id                                                    as ServiceDocument,
      service_doc_item_id                                               as ServiceDocumentItem,

      solution_order_id                                                 as BusinessSolutionOrder,
      solution_order_item_id                                            as BusinessSolutionOrderItem,

      //Other fields
      uepvw                                                             as HigherLevelItemUsage,

      //association
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _BillingDocumentBasic,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _PartnerBasic,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _PricingElementBasic,
      _SalesDocumentItemCategory,
      _SalesDocumentItemType,
      _CreatedByUser,
      _ReferenceLogicalSystem,
      _OrganizationDivision,
      _Division,
      _SalesOffice,
      @API.element: { releaseState: #DEPRECATED, successor: '_Product' }
      _Material,
      _Product,
      _OriginallyRequestedMaterial,
      _PricingReferenceMaterial,
      _Batch,
      _ProductHierarchyNode,
      @API.element: { releaseState: #DEPRECATED, successor: '_ProductGroup' }
      _MaterialGroup,
      _ProductGroup,
      _AdditionalMaterialGroup1,
      _AdditionalMaterialGroup2,
      _AdditionalMaterialGroup3,
      _AdditionalMaterialGroup4,
      _AdditionalMaterialGroup5,
      _MaterialCommissionGroup,
      _Plant,
      _StorageLocation,
      _PlantRegion,
      _TransitPlant,
      _ValueChainCategory,
      _BillingQuantityUnit,
      _BaseUnit,
      _ItemWeightUnit,
      _ItemVolumeUnit,
      _BillToPartyCountry,
      _BillToPartyRegion,
      _BillingPlanRule,
      _TransactionCurrency,
      _StatisticalValueControl,
      _MaterialPricingGroup,
      _MainItemPricingRefMaterial,
      _MainItemMaterialPricingGroup,
      _TimeSheetOvertimeCat,
      _PricingRelevance,      
      _DepartureCountry,
      _CountryOfOrigin,
      _RegionOfOrigin,
      _BusinessArea,   
      _ProfitCenter,
      @API.element: { releaseState: #DEPRECATED, successor: '_WBSElementBasicData' }
      _WBSElement,
      _WBSElementBasicData,
      _ControllingArea,
      _MatlAccountAssignmentGroup,
      @API.element: { releaseState: #DEPRECATED, successor: '_CostCenter_2' }
      _CostCenter,
      _CostCenter_2,
      _ReferenceSalesDocumentItem,
      _ReferenceDeliveryDocumentItem,
      _ReferenceBillingDocItemBasic,
      _ReferenceSDDocumentCategory,
      _SalesDocument,
      _SalesDocumentItem,
      _SalesSDDocumentCategory,
      _HigherLevelItemBasic,
      _PrelimBillingDocument,
      _PrelimBillingDocumentItem,
      _SalesGroup,
      _AdditionalCustomerGroup1,
      _AdditionalCustomerGroup2,
      _AdditionalCustomerGroup3,
      _AdditionalCustomerGroup4,
      _AdditionalCustomerGroup5,
      _SDDocumentReason,
      _RetailPromotion,
      _SalesDeal,
      _SalesOrderSalesDistrict,
      _SalesOrderCustomerGroup,
      _SalesOrderCustomerPriceGroup,
      _SalesOrderPriceListType,
      _SalesOrderSalesOrganization,
      _SalesOrderDistributionChannel,
      _ShippingPoint,
      _ServiceDocumentType,
      _ProviderContract,
      _ProviderContractItem,
      //--[ GENERATED:012:GlBfhyJl7jY4t}SRJ6dMpW
      @Consumption.hidden: true
      _MaterialGroupText,
      @Consumption.hidden: true
      _ShippingPointText,
      @Consumption.hidden: true
      _BusinessAreaText,
      @Consumption.hidden: true
      @API.element: { releaseState: #DEPRECATED, successor: '_WBSElementBasicData' }
      _WBSElementText,
      @Consumption.hidden: true
      @API.element: { releaseState: #DEPRECATED, successor: '_ProductText' }
      _MaterialText,
      @Consumption.hidden: true
      _ProductText,
      @Consumption.hidden: true
      _PricingReferenceMaterialText,
      @Consumption.hidden: true
      _MainItemPricingRefMatlText,
      @Consumption.hidden: true
      _OriginallyRequestedMatlText
      // ]--GENERATED

}
