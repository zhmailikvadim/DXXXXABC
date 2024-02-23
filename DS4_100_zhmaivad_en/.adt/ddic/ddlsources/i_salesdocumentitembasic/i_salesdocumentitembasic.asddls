@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Sales Document Item Basic'
@VDM.viewType: #BASIC
@AccessControl: {
  authorizationCheck: #CHECK,
  privilegedAssociations: [ '_CreatedByUser', '_BusinessAreaText','_MaterialText','_ProductText','_OrigMaterialText','_ShippingPointText' ]
}
@AbapCatalog: {
  sqlViewName: 'ISDSLSDOCITMBSC',
  preserveKey: true,
  compiler.compareFilter: true
}
@ObjectModel: {
   representativeKey: 'SalesDocumentItem',
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XL
   }
}
@Analytics.dataCategory: #DIMENSION
@Metadata.allowExtensions: true

define view I_SalesDocumentItemBasic
  as select from vbap

  //Association

  //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
  association [0..*] to I_BusinessAreaText             as _BusinessAreaText              on  $projection.BusinessArea = _BusinessAreaText.BusinessArea
  association [0..*] to I_MaterialText                 as _MaterialText                  on  $projection.Material = _MaterialText.Material
  association [0..*] to I_ProductText                  as _ProductText                   on  $projection.Product = _ProductText.Product
  association [0..*] to I_MaterialText                 as _OrigMaterialText              on  $projection.OriginallyRequestedMaterial = _OrigMaterialText.Material
  association [0..*] to I_ShippingPointText            as _ShippingPointText             on  $projection.ShippingPoint = _ShippingPointText.ShippingPoint
  // ]--GENERATED
  association [1..1] to I_SalesDocumentBasic           as _SalesDocumentBasic            on  $projection.SalesDocument = _SalesDocumentBasic.SalesDocument
  association [0..1] to I_SalesDocumentItemCategory    as _ItemCategory                  on  $projection.SalesDocumentItemCategory = _ItemCategory.SalesDocumentItemCategory
  association [0..1] to I_User                         as _CreatedByUser                 on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_Division                     as _Division                      on  $projection.Division = _Division.Division
  association [0..1] to I_Material                     as _Material                      on  $projection.Material = _Material.Material
  association [0..1] to I_Product                      as _Product                       on  $projection.Product = _Product.Product
  association [0..1] to I_Material                     as _OriginallyRequestedMaterial   on  $projection.OriginallyRequestedMaterial = _OriginallyRequestedMaterial.Material
  association [0..1] to I_Batch                        as _Batch                         on  $projection.Plant    = _Batch.Plant
                                                                                         and $projection.Material = _Batch.Material
                                                                                         and $projection.Batch    = _Batch.Batch
  association [0..1] to I_ProductHierarchyNode         as _ProductHierarchyNode          on  $projection.ProductHierarchyNode = _ProductHierarchyNode.ProductHierarchyNode
  association [0..1] to I_MaterialSubstitutionReason   as _MaterialSubstitutionReason    on  $projection.MaterialSubstitutionReason = _MaterialSubstitutionReason.MaterialSubstitutionReason
  association [0..1] to I_MaterialGroup                as _MaterialGroup                 on  $projection.MaterialGroup = _MaterialGroup.MaterialGroup
  association [0..1] to I_ProductGroup_2               as _ProductGroup                  on  $projection.ProductGroup = _ProductGroup.ProductGroup
  association [0..1] to I_MaterialPricingGroup         as _MaterialPricingGroup          on  $projection.MaterialPricingGroup = _MaterialPricingGroup.MaterialPricingGroup
  association [0..1] to I_AdditionalMaterialGroup1     as _AdditionalMaterialGroup1      on  $projection.AdditionalMaterialGroup1 = _AdditionalMaterialGroup1.AdditionalMaterialGroup1
  association [0..1] to I_AdditionalMaterialGroup2     as _AdditionalMaterialGroup2      on  $projection.AdditionalMaterialGroup2 = _AdditionalMaterialGroup2.AdditionalMaterialGroup2
  association [0..1] to I_AdditionalMaterialGroup3     as _AdditionalMaterialGroup3      on  $projection.AdditionalMaterialGroup3 = _AdditionalMaterialGroup3.AdditionalMaterialGroup3
  association [0..1] to I_AdditionalMaterialGroup4     as _AdditionalMaterialGroup4      on  $projection.AdditionalMaterialGroup4 = _AdditionalMaterialGroup4.AdditionalMaterialGroup4
  association [0..1] to I_AdditionalMaterialGroup5     as _AdditionalMaterialGroup5      on  $projection.AdditionalMaterialGroup5 = _AdditionalMaterialGroup5.AdditionalMaterialGroup5
  association [0..1] to I_UnitOfMeasure                as _OrderQuantityUnit             on  $projection.OrderQuantityUnit = _OrderQuantityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _TargetQuantityUnit            on  $projection.TargetQuantityUnit = _TargetQuantityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _BaseUnit                      on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _RequestedQuantityUnit         on  $projection.RequestedQuantityUnit = _RequestedQuantityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ItemWeightUnit                on  $projection.ItemWeightUnit = _ItemWeightUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ItemVolumeUnit                on  $projection.ItemVolumeUnit = _ItemVolumeUnit.UnitOfMeasure
  association [0..1] to I_SalesDeal                    as _SalesDeal                     on  $projection.SalesDeal = _SalesDeal.SalesDeal
  association [0..1] to I_SalesDocumentRjcnReason      as _SalesDocumentRjcnReason       on  $projection.SalesDocumentRjcnReason = _SalesDocumentRjcnReason.SalesDocumentRjcnReason
  association [0..1] to I_ReturnReason                 as _ReturnReason                  on  $projection.ReturnReason = _ReturnReason.ReturnReason
  association [0..1] to I_ReturnsRefundExtent          as _ReturnsRefundExtent           on  $projection.ReturnsRefundExtent = _ReturnsRefundExtent.ReturnsRefundExtent
  association [0..1] to I_UnitOfMeasure                as _NetPriceQuantityUnit          on  $projection.NetPriceQuantityUnit = _NetPriceQuantityUnit.UnitOfMeasure
  association [0..1] to I_StatisticalValueControl      as _StatisticalValueControl       on  $projection.StatisticalValueControl = _StatisticalValueControl.StatisticalValueControl
  association [0..1] to I_Currency                     as _TransactionCurrency           on  $projection.TransactionCurrency = _TransactionCurrency.Currency
  association [0..1] to I_ShippingPoint                as _ShippingPoint                 on  $projection.ShippingPoint = _ShippingPoint.ShippingPoint
  association [0..1] to I_DeliveryPriority             as _DeliveryPriority              on  $projection.DeliveryPriority = _DeliveryPriority.DeliveryPriority
  association [0..1] to I_PartialDeliveryItem          as _PartialDeliveryItem           on  $projection.PartialDeliveryIsAllowed = _PartialDeliveryItem.PartialDeliveryIsAllowed
  association [0..1] to I_Plant                        as _Plant                         on  $projection.Plant = _Plant.Plant
  association [0..1] to I_Plant                        as _TransitPlant                  on  $projection.TransitPlant = _TransitPlant.Plant
  association [0..1] to I_StorageLocation              as _StorageLocation               on  $projection.Plant           = _StorageLocation.Plant
                                                                                         and $projection.StorageLocation = _StorageLocation.StorageLocation
  association [0..1] to I_Route                        as _Route                         on  $projection.Route = _Route.Route
  association [0..1] to I_BillingRelevanceCode         as _ItemIsBillingRelevant         on  $projection.ItemIsBillingRelevant = _ItemIsBillingRelevant.BillingRelevanceCode
  association [0..1] to I_BillingBlockReason           as _ItemBillingBlockReason        on  $projection.ItemBillingBlockReason = _ItemBillingBlockReason.BillingBlockReason
  association [0..1] to I_BusinessArea                 as _BusinessArea                  on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [0..1] to I_SalesDocument                as _ReferenceSDDocument           on  $projection.ReferenceSDDocument = _ReferenceSDDocument.SalesDocument
  association [0..1] to I_SalesDocumentItem            as _ReferenceSDDocumentItem       on  $projection.ReferenceSDDocument     = _ReferenceSDDocumentItem.SalesDocument
                                                                                         and $projection.ReferenceSDDocumentItem = _ReferenceSDDocumentItem.SalesDocumentItem
  association [0..1] to I_SDDocumentCategory           as _ReferenceSDDocumentCategory   on  $projection.ReferenceSDDocumentCategory = _ReferenceSDDocumentCategory.SDDocumentCategory

  association [0..1] to I_SDProcessStatus              as _SDProcessStatus               on  $projection.SDProcessStatus = _SDProcessStatus.SDProcessStatus
  association [0..1] to I_PurchaseConfirmationStatus   as _PurchaseConfirmationStatus    on  $projection.PurchaseConfirmationStatus = _PurchaseConfirmationStatus.PurchaseConfirmationStatus
  association [0..1] to I_TotalDeliveryStatus          as _TotalDeliveryStatus           on  $projection.TotalDeliveryStatus = _TotalDeliveryStatus.TotalDeliveryStatus
  association [0..1] to I_DeliveryStatus               as _DeliveryStatus                on  $projection.DeliveryStatus = _DeliveryStatus.DeliveryStatus
  association [0..1] to I_DeliveryBlockStatus          as _DeliveryBlockStatus           on  $projection.DeliveryBlockStatus = _DeliveryBlockStatus.DeliveryBlockStatus
  association [0..1] to I_DeliveryConfirmationStatus   as _DeliveryConfirmationStatus    on  $projection.DeliveryConfirmationStatus = _DeliveryConfirmationStatus.DeliveryConfirmationStatus
  association [0..1] to I_OrderRelatedBillingStatus    as _OrderRelatedBillingStatus     on  $projection.OrderRelatedBillingStatus = _OrderRelatedBillingStatus.OrderRelatedBillingStatus
  association [0..1] to I_BillingBlockStatus           as _BillingBlockStatus            on  $projection.BillingBlockStatus = _BillingBlockStatus.BillingBlockStatus
  association [0..1] to I_SDDocumentRejectionStatus    as _SDDocumentRejectionStatus     on  $projection.SDDocumentRejectionStatus = _SDDocumentRejectionStatus.SDDocumentRejectionStatus
  association [0..1] to I_ItemGenIncompletionStatus    as _ItemGeneralIncompletionStatus on  $projection.ItemGeneralIncompletionStatus = _ItemGeneralIncompletionStatus.ItemGeneralIncompletionStatus
  association [0..1] to I_ItemBillingIncompletionSts   as _ItemBillingIncompletionStatus on  $projection.ItemBillingIncompletionStatus = _ItemBillingIncompletionStatus.ItemBillingIncompletionStatus
  association [0..1] to I_PricingIncompletionStatus    as _PricingIncompletionStatus     on  $projection.PricingIncompletionStatus = _PricingIncompletionStatus.PricingIncompletionStatus
  association [0..1] to I_ItemDelivIncompletionSts     as _ItemDelivIncompletionSts      on  $projection.ItemDeliveryIncompletionStatus = _ItemDelivIncompletionSts.ItemDeliveryIncompletionStatus
  association [0..1] to I_TotalSDDocReferenceStatus    as _TotalSDDocReferenceStatus     on  $projection.TotalSDDocReferenceStatus = _TotalSDDocReferenceStatus.TotalSDDocReferenceStatus
  association [0..1] to I_SDDocReferenceStatus         as _SDDocReferenceStatus          on  $projection.SDDocReferenceStatus = _SDDocReferenceStatus.SDDocReferenceStatus
  association [0..1] to I_ChmlCmplncStatus             as _ChmlCmplncStatus              on  $projection.ChmlCmplncStatus = _ChmlCmplncStatus.ChmlCmplncStatus
  association [0..1] to I_DangerousGoodsStatus         as _DangerousGoodsStatus          on  $projection.DangerousGoodsStatus = _DangerousGoodsStatus.DangerousGoodsStatus
  association [0..1] to I_SafetyDataSheetStatus        as _SafetyDataSheetStatus         on  $projection.SafetyDataSheetStatus = _SafetyDataSheetStatus.SafetyDataSheetStatus

  association [0..1] to I_TrdCmplncCheckStatus         as _TrdCmplncEmbargoSts           on  $projection.TrdCmplncEmbargoSts = _TrdCmplncEmbargoSts.TrdCmplncCheckStatus
  association [0..1] to I_TrdCmplncCheckStatus         as _TrdCmplncSnctndListChkSts     on  $projection.TrdCmplncSnctndListChkSts = _TrdCmplncSnctndListChkSts.TrdCmplncCheckStatus
  association [0..1] to I_OvrlTrdCmplncLegalCtrlChkSts as _OvrlTrdCmplncLegalCtrlChkSts  on  $projection.OvrlTrdCmplncLegalCtrlChkSts = _OvrlTrdCmplncLegalCtrlChkSts.OvrlTrdCmplncLegalCtrlChkSts
  
  //Analytics fields
  association [0..1] to I_SDDocumentCategory           as _SDDocumentCategory            on  $projection.SDDocumentCategory = _SDDocumentCategory.SDDocumentCategory
  association [0..1] to I_SalesDocumentType            as _SalesDocumentType             on  $projection.SalesDocumentType = _SalesDocumentType.SalesDocumentType
  association [0..1] to I_SalesOrganization            as _SalesOrganization             on  $projection.SalesOrganization = _SalesOrganization.SalesOrganization
  association [0..1] to I_DistributionChannel          as _DistributionChannel           on  $projection.DistributionChannel = _DistributionChannel.DistributionChannel
  association [0..1] to I_Division                     as _OrganizationDivision          on  $projection.OrganizationDivision = _OrganizationDivision.Division
  association [0..1] to I_SalesOffice                  as _SalesOffice                   on  $projection.SalesOffice = _SalesOffice.SalesOffice
  association [0..1] to I_SalesGroup                   as _SalesGroup                    on  $projection.SalesGroup = _SalesGroup.SalesGroup
  association [0..1] to I_SDDocumentReason             as _SDDocumentReason              on  $projection.SDDocumentReason = _SDDocumentReason.SDDocumentReason
  association [0..1] to I_Customer                     as _SoldToParty                   on  $projection.SoldToParty = _SoldToParty.Customer
  association [0..1] to I_AdditionalCustomerGroup1     as _AdditionalCustomerGroup1      on  $projection.AdditionalCustomerGroup1 = _AdditionalCustomerGroup1.AdditionalCustomerGroup1
  association [0..1] to I_AdditionalCustomerGroup2     as _AdditionalCustomerGroup2      on  $projection.AdditionalCustomerGroup2 = _AdditionalCustomerGroup2.AdditionalCustomerGroup2
  association [0..1] to I_AdditionalCustomerGroup3     as _AdditionalCustomerGroup3      on  $projection.AdditionalCustomerGroup3 = _AdditionalCustomerGroup3.AdditionalCustomerGroup3
  association [0..1] to I_AdditionalCustomerGroup4     as _AdditionalCustomerGroup4      on  $projection.AdditionalCustomerGroup4 = _AdditionalCustomerGroup4.AdditionalCustomerGroup4
  association [0..1] to I_AdditionalCustomerGroup5     as _AdditionalCustomerGroup5      on  $projection.AdditionalCustomerGroup5 = _AdditionalCustomerGroup5.AdditionalCustomerGroup5
  association [0..1] to I_ShippingCondition            as _ShippingCondition             on  $projection.ShippingCondition = _ShippingCondition.ShippingCondition
  association [0..1] to I_SalesDistrict                as _SalesDistrict                 on  $projection.SalesDistrict = _SalesDistrict.SalesDistrict
  association [0..1] to I_CustomerGroup                as _CustomerGroup                 on  $projection.CustomerGroup = _CustomerGroup.CustomerGroup
  association [0..1] to I_ShippingType                 as _ShippingType                  on  $projection.ShippingType = _ShippingType.ShippingType
  association [0..1] to I_Customer                     as _ShipToParty                   on  $projection.ShipToParty = _ShipToParty.Customer
  association [0..1] to I_Customer                     as _BillToParty                   on  $projection.BillToParty = _BillToParty.Customer
  association [0..1] to I_Customer                     as _PayerParty                    on  $projection.PayerParty = _PayerParty.Customer
  association [0..1] to I_PersonWorkAgreement_1        as _SalesEmployee                 on  $projection.SalesEmployee = _SalesEmployee.PersonWorkAgreement
  association [0..1] to I_PersonWorkAgreement_1        as _ResponsibleEmployee           on  $projection.ResponsibleEmployee = _ResponsibleEmployee.PersonWorkAgreement
  association [0..1] to I_ConsumptionPosting           as _ConsumptionPosting            on  $projection.ConsumptionPosting = _ConsumptionPosting.ConsumptionPosting
  
  //Solution Order Reference
  association [0..1] to I_ServiceDocumentEnhcd         as _SolutionOrder                 on  $projection.BusinessSolutionOrder = _SolutionOrder.ServiceDocument
                                                                                             and _SolutionOrder.ServiceObjectType = 'BUS2000172'  
                                                                                             
  //Solution Order Item Reference
  association [1] to I_ServiceDocumentItemEnhcd        as _SolutionOrderItem             on  _SolutionOrderItem.ServiceObjectType = 'BUS2000172'
                                                                                             and $projection.BusinessSolutionOrder = _SolutionOrderItem.ServiceDocument
                                                                                             and $projection.BusinessSolutionOrderItem = _SolutionOrderItem.ServiceDocumentItem
  
  // ValueChain Management
  association [0..1] to I_SalesValueChainCategory      as _SalesValueChainCategory       on  $projection.ValueChainCategory = _SalesValueChainCategory.ValueChainCategory

{
      //Key
      @ObjectModel.foreignKey.association: '_SalesDocumentBasic'
  key vbeln                                                                        as SalesDocument,
      @ObjectModel.text.element: 'SalesDocumentItemText'
  key posnr                                                                        as SalesDocumentItem,
      handle                                                                       as SalesDocumentItemUUID,

      //Category
      @ObjectModel.foreignKey.association: '_ItemCategory'
      pstyv                                                                        as SalesDocumentItemCategory,
      posar                                                                        as SalesDocumentItemType,
      shkzg                                                                        as IsReturnsItem,
      erlre                                                                        as CompletionRule,

      //Admin
      ernam                                                                        as CreatedByUser,
      @Semantics.systemDate.createdAt: true
      erdat                                                                        as CreationDate,
      cast( erzet as creation_time preserving type )                               as CreationTime,
      @Semantics.systemDate.lastChangedAt: true
      aedat                                                                        as LastChangeDate,

      //Organization
      @ObjectModel.foreignKey.association: '_Division'
      spart                                                                        as Division,

      //Product
      @Consumption.valueHelpDefinition: [                  //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_MaterialText'       // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Material'
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'Product'
      matnr                                                                        as Material,
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ProductStdVH',
                     element: 'Product' }
        }]
      @ObjectModel.text.association: '_ProductText'       
      @ObjectModel.foreignKey.association: '_Product'
      @Analytics.internalName: #LOCAL
      cast (vbap.matnr as productnumber preserving type)                           as  Product,
      
      @Consumption.valueHelpDefinition: [                  //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_OrigMaterialText'    // ]--GENERATED
      @ObjectModel.foreignKey.association: '_OriginallyRequestedMaterial'
      matwa                                                                        as OriginallyRequestedMaterial,
      kdmat                                                                        as MaterialByCustomer,
      ean11                                                                        as InternationalArticleNumber,

      @Consumption.valueHelpDefinition: [                  //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
        { entity:  { name:    'I_BatchStdVH',
                     element: 'Batch' },
          additionalBinding: [{ localElement: 'Plant',
                                element: 'Plant' },
                              { localElement: 'Material',
                                element: 'Material' }]
        }]                                                 // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Batch'
      charg                                                                        as Batch,
      @ObjectModel.foreignKey.association: '_ProductHierarchyNode'
      prodh                                                                        as ProductHierarchyNode,
      @ObjectModel.foreignKey.association: '_MaterialSubstitutionReason'
      sugrd                                                                        as MaterialSubstitutionReason,
      @ObjectModel.foreignKey.association: '_MaterialGroup'
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'ProductGroup'
      matkl                                                                        as MaterialGroup,
      @ObjectModel.foreignKey.association: '_ProductGroup'
      @Analytics.internalName: #LOCAL
      cast (vbap.matkl as productgroup preserving type )                           as ProductGroup,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup1'
      mvgr1                                                                        as AdditionalMaterialGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup2'
      mvgr2                                                                        as AdditionalMaterialGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup3'
      mvgr3                                                                        as AdditionalMaterialGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup4'
      mvgr4                                                                        as AdditionalMaterialGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup5'
      mvgr5                                                                        as AdditionalMaterialGroup5,
      cuobj                                                                        as ProductConfiguration,
      prosa                                                                        as MaterialDeterminationType,
      berid                                                                        as MRPArea,
      stlnr                                                                        as BillOfMaterial,
      stdat                                                                        as BOMExplosionDate,
      mtvfp                                                                        as ProdAvailabilityCheckGroup,

      //Sales
      @Semantics.text: true
      arktx                                                                        as SalesDocumentItemText,
      posex                                                                        as UnderlyingPurchaseOrderItem,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      kwmeng                                                                       as OrderQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_OrderQuantityUnit'
      vrkme                                                                        as OrderQuantityUnit,
      umvkn                                                                        as OrderToBaseQuantityDnmntr,
      umvkz                                                                        as OrderToBaseQuantityNmrtr,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'TargetQuantityUnit'
      zmeng                                                                        as TargetQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_TargetQuantityUnit'
      zieme                                                                        as TargetQuantityUnit,
      umzin                                                                        as TargetToBaseQuantityDnmntr,
      umziz                                                                        as TargetToBaseQuantityNmrtr,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      kbmeng                                                                       as ConfdDelivQtyInOrderQtyUnit,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      lsmeng                                                                       as TargetDelivQtyInOrderQtyUnit,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      klmeng                                                                       as ConfdDeliveryQtyInBaseUnit,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnit'
      meins                                                                        as BaseUnit,

      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      cast( cmtd_deliv_qty_su   as committeddelivqtyinordqtyunit preserving type ) as CommittedDelivQtyInOrdQtyUnit,
      cast( cmtd_deliv_creadate as committeddelivcreationdate    preserving type ) as CommittedDelivCreationDate,
      cast( cmtd_deliv_date     as committeddeliverydate         preserving type ) as CommittedDeliveryDate,

      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      cast( case when
          vbap.kwmeng > 0
      then
          vbap.kwmeng
      else
          vbap.zmeng
      end as reqd_qty )                                                            as RequestedQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_RequestedQuantityUnit'
      cast( case when
          vbap.kwmeng > 0
      then
          vbap.vrkme
      else
          vbap.zieme
      end as reqd_qty_unit )                                                       as RequestedQuantityUnit,

      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      reqqty_bu                                                                    as RequestedQuantityInBaseUnit,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      brgew                                                                        as ItemGrossWeight,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      ntgew                                                                        as ItemNetWeight,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ItemWeightUnit'
      gewei                                                                        as ItemWeightUnit,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
      volum                                                                        as ItemVolume,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ItemVolumeUnit'
      voleh                                                                        as ItemVolumeUnit,
      @Consumption.valueHelpDefinition: [              //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
        { entity:  { name:    'I_SalesDealStdVH',
                     element: 'SalesDeal' }
        }]                                             // ]--GENERATED
      @ObjectModel.foreignKey.association: '_SalesDeal'
      knuma_ag                                                                     as SalesDeal,
      knuma_pi                                                                     as SalesPromotion,
      @ObjectModel.foreignKey.association: '_SalesDocumentRjcnReason'
      abgru                                                                        as SalesDocumentRjcnReason,
      grpos                                                                        as AlternativeToItem,
      @ObjectModel.foreignKey.association: '_ReturnReason'
      msr_ret_reason                                                               as ReturnReason,
      @ObjectModel.foreignKey.association: '_ReturnsRefundExtent'
      msr_refund_code                                                              as ReturnsRefundExtent,
      msr_approv_block                                                             as RetsMgmtProcessingBlock,
      sgt_rcat                                                                     as RequirementSegment,
      fmeng                                                                        as QuantityIsFixed,

      //Quotation
      awahr                                                                        as ItemOrderProbabilityInPercent,

      //Contract
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      zwert                                                                        as OutlineAgreementTargetAmount,

      //Pricing
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      netwr                                                                        as NetAmount,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_TransactionCurrency'
      waerk                                                                        as TransactionCurrency,
      pmatn                                                                        as PricingReferenceMaterial,
      @ObjectModel.foreignKey.association: '_MaterialPricingGroup'
      kondm                                                                        as MaterialPricingGroup,
      taxm1                                                                        as ProductTaxClassification1,
      taxm2                                                                        as ProductTaxClassification2,
      taxm3                                                                        as ProductTaxClassification3,
      taxm4                                                                        as ProductTaxClassification4,
      taxm5                                                                        as ProductTaxClassification5,
      taxm6                                                                        as ProductTaxClassification6,
      taxm7                                                                        as ProductTaxClassification7,
      taxm8                                                                        as ProductTaxClassification8,
      taxm9                                                                        as ProductTaxClassification9,
      ktgrm                                                                        as MatlAccountAssignmentGroup,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      netpr                                                                        as NetPriceAmount,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'NetPriceQuantityUnit'
      kpein                                                                        as NetPriceQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_NetPriceQuantityUnit'
      kmein                                                                        as NetPriceQuantityUnit,
      @ObjectModel.foreignKey.association: '_StatisticalValueControl'
      kowrr                                                                        as StatisticalValueControl,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      mwsbp                                                                        as TaxAmount,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      wavwr                                                                        as CostAmount,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi1                                                                        as Subtotal1Amount,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi2                                                                        as Subtotal2Amount,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi3                                                                        as Subtotal3Amount,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi4                                                                        as Subtotal4Amount,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi5                                                                        as Subtotal5Amount,
      @DefaultAggregation: #NONE
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      kzwi6                                                                        as Subtotal6Amount,

      //Shipping
      //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ShippingPointStdVH',
                     element: 'ShippingPoint' }
        }]
      @ObjectModel.text.association: '_ShippingPointText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ShippingPoint'
      vstel                                                                        as ShippingPoint,
      sobkz                                                                        as InventorySpecialStockType,
      kzbws                                                                        as InventorySpecialStockValnType,
      @ObjectModel.foreignKey.association: '_DeliveryPriority'
      lprio                                                                        as DeliveryPriority,
      @ObjectModel.foreignKey.association: '_Plant'
      werks                                                                        as Plant,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_TransitPlant'
      transit_plant                                                                as TransitPlant,
      @ObjectModel.foreignKey.association: '_StorageLocation'
      lgort                                                                        as StorageLocation,
      @ObjectModel.foreignKey.association: '_Route'
      route                                                                        as Route,
      grkor                                                                        as DeliveryGroup,
      fixmg                                                                        as DeliveryDateQuantityIsFixed,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_PartialDeliveryItem'
      kztlf                                                                        as PartialDeliveryIsAllowed,
      antlf                                                                        as MaxNmbrOfPartialDelivery,
      uebtk                                                                        as UnlimitedOverdeliveryIsAllowed,
      uebto                                                                        as OverdelivTolrtdLmtRatioInPct,
      untto                                                                        as UnderdelivTolrtdLmtRatioInPct,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      lfmng                                                                        as MinDeliveryQtyInBaseUnit,
      kzfme                                                                        as OpenDeliveryLeadingUnitCode,
      lfrel                                                                        as ItemIsDeliveryRelevant,

      //Fashion
      fsh_season_year                                                              as ProductSeasonYear,
      fsh_season                                                                   as ProductSeason,
      fsh_collection                                                               as ProductCollection,
      fsh_theme                                                                    as ProductTheme,
      fsh_candate                                                                  as FashionCancelDate,
      wrf_charstc1                                                                 as ProductCharacteristic1,
      wrf_charstc2                                                                 as ProductCharacteristic2,
      wrf_charstc3                                                                 as ProductCharacteristic3,
      rfm_psst_group                                                               as ShippingGroupNumber,
      rfm_psst_rule                                                                as ShippingGroupRule,

      //Billing
      @ObjectModel.foreignKey.association: '_ItemIsBillingRelevant'
      fkrel                                                                        as ItemIsBillingRelevant,
      @ObjectModel.foreignKey.association: '_ItemBillingBlockReason'
      faksp                                                                        as ItemBillingBlockReason,

      //Accounting
      //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BusinessAreaStdVH',
                     element: 'BusinessArea' }
        }]
      @ObjectModel.text.association: '_BusinessAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_BusinessArea'
      gsber                                                                        as BusinessArea,
      prctr                                                                        as ProfitCenter,
      ps_psp_pnr                                                                   as WBSElement,
      aufnr                                                                        as OrderID,
      objnr                                                                        as ControllingObject,
      paobjnr                                                                      as ProfitabilitySegment,
      vbelv                                                                        as OriginSDDocument,
      posnv                                                                        as OriginSDDocumentItem,

      //Reference
      @ObjectModel.foreignKey.association: '_ReferenceSDDocument'
      vgbel                                                                        as ReferenceSDDocument,
      @ObjectModel.foreignKey.association: '_ReferenceSDDocumentItem'
      vgpos                                                                        as ReferenceSDDocumentItem,
      @ObjectModel.foreignKey.association: '_ReferenceSDDocumentCategory'
      vgtyp                                                                        as ReferenceSDDocumentCategory,
      uepos                                                                        as HigherLevelItem,
      wktnr                                                                        as ValueContract,
      wktps                                                                        as ValueContractItem,
      vbkd_posnr                                                                   as SlsDocBusinessDataItem,

      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SolutionOrder'
      solution_order_id                                                            as BusinessSolutionOrder,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SolutionOrderItem'
      solution_order_itm_id                                                        as BusinessSolutionOrderItem,
      
      //Status
      @ObjectModel.foreignKey.association: '_SDProcessStatus'
      gbsta                                                                        as SDProcessStatus,
      @ObjectModel.foreignKey.association: '_DeliveryConfirmationStatus'
      besta                                                                        as DeliveryConfirmationStatus,
      @ObjectModel.foreignKey.association: '_PurchaseConfirmationStatus'
      costa                                                                        as PurchaseConfirmationStatus,
      @ObjectModel.foreignKey.association: '_TotalDeliveryStatus'
      lfgsa                                                                        as TotalDeliveryStatus,
      @ObjectModel.foreignKey.association: '_DeliveryStatus'
      lfsta                                                                        as DeliveryStatus,
      @ObjectModel.foreignKey.association: '_DeliveryBlockStatus'
      lssta                                                                        as DeliveryBlockStatus,
      @ObjectModel.foreignKey.association: '_OrderRelatedBillingStatus'
      fksaa                                                                        as OrderRelatedBillingStatus,
      @ObjectModel.foreignKey.association: '_BillingBlockStatus'
      fssta                                                                        as BillingBlockStatus,
      @ObjectModel.foreignKey.association: '_ItemGeneralIncompletionStatus'
      uvall                                                                        as ItemGeneralIncompletionStatus,
      @ObjectModel.foreignKey.association: '_ItemBillingIncompletionStatus'
      uvfak                                                                        as ItemBillingIncompletionStatus,
      @ObjectModel.foreignKey.association: '_PricingIncompletionStatus'
      uvprs                                                                        as PricingIncompletionStatus,
      @ObjectModel.foreignKey.association: '_ItemDelivIncompletionSts'
      uvvlk                                                                        as ItemDeliveryIncompletionStatus,
      @ObjectModel.foreignKey.association: '_SDDocumentRejectionStatus'
      absta                                                                        as SDDocumentRejectionStatus,
      @ObjectModel.foreignKey.association: '_TotalSDDocReferenceStatus'
      rfgsa                                                                        as TotalSDDocReferenceStatus,
      @ObjectModel.foreignKey.association: '_SDDocReferenceStatus'
      rfsta                                                                        as SDDocReferenceStatus,
      @ObjectModel.foreignKey.association: '_ChmlCmplncStatus'
      pcsta                                                                        as ChmlCmplncStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_DangerousGoodsStatus'
      dgsta                                                                        as DangerousGoodsStatus,
      @ObjectModel.foreignKey.association: '_SafetyDataSheetStatus'
      sdssta                                                                       as SafetyDataSheetStatus,

      @ObjectModel.foreignKey.association: '_TrdCmplncEmbargoSts'
      emcst                                                                        as TrdCmplncEmbargoSts,
      @ObjectModel.foreignKey.association: '_TrdCmplncSnctndListChkSts'
      slcst                                                                        as TrdCmplncSnctndListChkSts,
      @ObjectModel.foreignKey.association: '_OvrlTrdCmplncLegalCtrlChkSts'
      total_lccst                                                                  as OvrlTrdCmplncLegalCtrlChkSts,
      
      // Value Chain Management
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesValueChainCategory'
      vcm_chain_category                                                           as ValueChainCategory,
      
      // Analytics relevant fields
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SDDocumentCategory'
      vbap.vbtyp_ana                                                               as SDDocumentCategory,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesDocumentType'
      vbap.auart_ana                                                               as SalesDocumentType,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesOrganization'
      vbap.vkorg_ana                                                               as SalesOrganization,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_DistributionChannel'
      vbap.vtweg_ana                                                               as DistributionChannel,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_OrganizationDivision'
      vbap.spart_ana                                                               as OrganizationDivision,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesOffice'
      vbap.vkbur_ana                                                               as SalesOffice,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesGroup'
      vbap.vkgrp_ana                                                               as SalesGroup,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SDDocumentReason'
      vbap.augru_ana                                                               as SDDocumentReason,
      @Analytics.internalName: #LOCAL
      vbap.audat_ana                                                               as SalesDocumentDate,
      @Analytics.internalName: #LOCAL    
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup1'
      vbap.kvgr1_ana                                                               as AdditionalCustomerGroup1,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup2'
      vbap.kvgr2_ana                                                               as AdditionalCustomerGroup2,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup3'
      vbap.kvgr3_ana                                                               as AdditionalCustomerGroup3,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup4'
      vbap.kvgr4_ana                                                               as AdditionalCustomerGroup4,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup5'
      vbap.kvgr5_ana                                                               as AdditionalCustomerGroup5,
      @Analytics.internalName: #LOCAL
      cast(vbap.vdatu_ana as reqd_delivery_date preserving type)                   as RequestedDeliveryDate,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_ShippingCondition'
      vbap.vsbed_ana                                                               as ShippingCondition,    
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Customer_VH',
                     element: 'Customer' }
        }]
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SoldToParty'
      vbap.kunnr_ana                                                               as SoldToParty,
      @Analytics.internalName: #LOCAL
      vbap.knumv_ana                                                               as SalesDocumentCondition,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesDistrict'     
      vbap.bzirk_ana                                                               as SalesDistrict,
      @Analytics.internalName: #LOCAL
      vbap.bstkd_ana                                                               as PurchaseOrderByCustomer,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_CustomerGroup'
      vbap.kdgrp_ana                                                               as CustomerGroup,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_ShippingType'
      vbap.vsart_ana                                                               as ShippingType,
      @Analytics.internalName: #LOCAL
      vbap.fkdat_ana                                                               as BillingDocumentDate,
      @Analytics.internalName: #LOCAL
      vbap.fplnr_ana                                                               as BillingPlan,
      // Analytics partner fields
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_ShipToParty'
      vbap.kunwe_ana                                                               as ShipToParty,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_BillToParty'
      vbap.kunre_ana                                                               as BillToParty,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesEmployee'
      vbap.perve_ana                                                               as SalesEmployee,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_ResponsibleEmployee'
      vbap.perzm_ana                                                               as ResponsibleEmployee,
      @Analytics.internalName: #LOCAL
      cast(vbap.perve_ana as sales_empl preserving type)                           as SalesEmployeeWorkAgreement,
      @Analytics.internalName: #LOCAL
      cast(vbap.perzm_ana as resp_empl  preserving type)                           as ResponsibleEmployeeWorkAgrmt,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_PayerParty'
      vbap.kunrg_ana                                                               as PayerParty,
      @ObjectModel.foreignKey.association: '_ConsumptionPosting'
      vbap.kzvbr                                                                   as ConsumptionPosting,


      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _SalesDocumentBasic,
      _ItemCategory,
      _CreatedByUser,
      _Division,
      _Material,
      _Product,
      _OriginallyRequestedMaterial,
      _Batch,
      _ProductHierarchyNode,
      _MaterialSubstitutionReason,
      _MaterialGroup,
      _ProductGroup,
      _MaterialPricingGroup,
      _AdditionalMaterialGroup1,
      _AdditionalMaterialGroup2,
      _AdditionalMaterialGroup3,
      _AdditionalMaterialGroup4,
      _AdditionalMaterialGroup5,
      _OrderQuantityUnit,
      _TargetQuantityUnit,
      _BaseUnit,
      _RequestedQuantityUnit,
      _ItemWeightUnit,
      _ItemVolumeUnit,
      _SalesDeal,
      _SalesDocumentRjcnReason,
      _ReturnReason,
      _ReturnsRefundExtent,
      _NetPriceQuantityUnit,
      _StatisticalValueControl,
      _TransactionCurrency,
      _ShippingPoint,
      _DeliveryPriority,
      _PartialDeliveryItem,
      _Plant,
      _TransitPlant,
      _StorageLocation,
      _Route,
      _ItemIsBillingRelevant,
      _ItemBillingBlockReason,
      _BusinessArea,
      _ReferenceSDDocument,
      _ReferenceSDDocumentItem,
      _ReferenceSDDocumentCategory,

      _SDProcessStatus,
      _PurchaseConfirmationStatus,
      _TotalDeliveryStatus,
      _DeliveryStatus,
      _DeliveryBlockStatus,
      _DeliveryConfirmationStatus,
      _OrderRelatedBillingStatus,
      _BillingBlockStatus,
      _SDDocumentRejectionStatus,
      _ItemGeneralIncompletionStatus,
      _ItemBillingIncompletionStatus,
      _PricingIncompletionStatus,
      _ItemDelivIncompletionSts,
      _TotalSDDocReferenceStatus,
      _SDDocReferenceStatus,
      _ChmlCmplncStatus,
      _DangerousGoodsStatus,
      _SafetyDataSheetStatus,

      _TrdCmplncEmbargoSts,
      _TrdCmplncSnctndListChkSts,
      _OvrlTrdCmplncLegalCtrlChkSts,
      _ConsumptionPosting,
      
      // Analytics relevant associations
      _SDDocumentCategory,
      _SalesDocumentType,
      _SalesOrganization,
      _DistributionChannel,
      _OrganizationDivision,
      _SalesOffice,
      _SalesGroup,
      _SDDocumentReason,    
      _AdditionalCustomerGroup1,
      _AdditionalCustomerGroup2,
      _AdditionalCustomerGroup3,
      _AdditionalCustomerGroup4,
      _AdditionalCustomerGroup5,
      _ShippingCondition,
      _SoldToParty,
      _SalesDistrict,
      _CustomerGroup,
      _ShippingType,
      _ShipToParty,
      _BillToParty,
      _SalesEmployee,
      _PayerParty,
      _ResponsibleEmployee,
      
      _SolutionOrder,
      _SolutionOrderItem,
      
      _SalesValueChainCategory,

      //--[ GENERATED:012:E6ExH29r7jY4oVPP85Dqk0
      @Consumption.hidden: true
      _BusinessAreaText,
      @Consumption.hidden: true
      _MaterialText,
      @Consumption.hidden: true
      _ProductText,
      @Consumption.hidden: true
      _OrigMaterialText,
      @Consumption.hidden: true
      _ShippingPointText
      // ]--GENERATED

}
