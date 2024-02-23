@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Sales Document Item'
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #('TRANSACTIONAL_DATA'),
  privilegedAssociations: [ '_CreatedByUser',  '_BusinessAreaText', '_MaterialText', '_ProductText', '_OrigMaterialText', '_ShippingPointText', '_PrecedingDocument', '_SubsequentDocument' ]
}
@AbapCatalog: {
  sqlViewName: 'ISDSALESDOCITEM',
  compiler.compareFilter: true,
  preserveKey: true
}
@ObjectModel: {
   representativeKey: 'SalesDocumentItem',
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XL
   },
   supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ],
   modelingPattern: [ #ANALYTICAL_DIMENSION ]
}
@Analytics.dataCategory: #DIMENSION
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define view I_SalesDocumentItem
  as select from           vbap
    left outer to one join vbak on vbap.vbeln = vbak.vbeln
    left outer to one join vbkd on  vbap.vbeln      = vbkd.vbeln
                                and vbap.vbkd_posnr = vbkd.posnr
    left outer to one join veda on  vbap.vbeln      = veda.vbeln
                                and vbap.veda_posnr = veda.vposn

  //Association

  //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
  association [0..*] to I_BusinessAreaText             as _BusinessAreaText              on  $projection.BusinessArea = _BusinessAreaText.BusinessArea
  association [0..*] to I_MaterialText                 as _MaterialText                  on  $projection.Material = _MaterialText.Material
  association [0..*] to I_ProductText                  as _ProductText                   on  $projection.Product = _ProductText.Product
  association [0..*] to I_MaterialText                 as _OrigMaterialText              on  $projection.OriginallyRequestedMaterial = _OrigMaterialText.Material
  association [0..*] to I_ShippingPointText            as _ShippingPointText             on  $projection.ShippingPoint = _ShippingPointText.ShippingPoint
  // ]--GENERATED
  association [1..1] to I_SlsDocItemEnhancedFields     as _SlsDocItemEnhancedFields      on  $projection.SalesDocument     = _SlsDocItemEnhancedFields.SalesDocument
                                                                                         and $projection.SalesDocumentItem = _SlsDocItemEnhancedFields.SalesDocumentItem
  association [1..1] to I_SalesDocument                as _SalesDocument                 on  $projection.SalesDocument = _SalesDocument.SalesDocument
  association [0..*] to I_SalesDocumentScheduleLine    as _ScheduleLine                  on  $projection.SalesDocument     = _ScheduleLine.SalesDocument
                                                                                         and $projection.SalesDocumentItem = _ScheduleLine.SalesDocumentItem
  association [0..*] to I_SalesDocumentItemPartner     as _Partner                       on  $projection.SalesDocument     = _Partner.SalesDocument
                                                                                         and $projection.SalesDocumentItem = _Partner.SalesDocumentItem
  association [0..*] to I_SalesDocItemPricingElement   as _PricingElement                on  $projection.SalesDocument     = _PricingElement.SalesDocument
                                                                                         and $projection.SalesDocumentItem = _PricingElement.SalesDocumentItem
  association [0..1] to I_SalesDocItemBillingPlan      as _ItemBillingPlan               on  $projection.SalesDocument     = _ItemBillingPlan.SalesDocument
                                                                                         and $projection.SalesDocumentItem = _ItemBillingPlan.SalesDocumentItem
                                                                                         and $projection.BillingPlan       = _ItemBillingPlan.BillingPlan

  //Subsequent Document
  association [0..*] to I_SDDocumentMultiLevelProcFlow as _SubsequentDocument            on  $projection.SalesDocument      = _SubsequentDocument.PrecedingDocument
                                                                                         and $projection.SalesDocumentItem  = _SubsequentDocument.PrecedingDocumentItem
                                                                                         and $projection.SDDocumentCategory = _SubsequentDocument.PrecedingDocumentCategory
  //Preceding Document
  association [0..*] to I_SDDocumentMultiLevelProcFlow as _PrecedingDocument             on  $projection.SalesDocument      = _PrecedingDocument.SubsequentDocument
                                                                                         and $projection.SalesDocumentItem  = _PrecedingDocument.SubsequentDocumentItem
                                                                                         and $projection.SDDocumentCategory = _PrecedingDocument.SubsequentDocumentCategory

  association [0..*] to I_SalesDocItmPrecdgProcFlow    as _PrecedingProcFlowDocItem      on  _PrecedingProcFlowDocItem.SalesDocument     = $projection.SalesDocument
                                                                                         and _PrecedingProcFlowDocItem.SalesDocumentItem = $projection.SalesDocumentItem


  association [0..*] to I_SalesDocItmSubsqntProcFlow   as _SubsequentProcFlowDocItem     on  _SubsequentProcFlowDocItem.SalesDocument     = $projection.SalesDocument
                                                                                         and _SubsequentProcFlowDocItem.SalesDocumentItem = $projection.SalesDocumentItem

  association [0..1] to I_SDDocumentCategory           as _SDDocumentCategory            on  $projection.SDDocumentCategory = _SDDocumentCategory.SDDocumentCategory
  association [0..1] to I_SalesDocumentItemCategory    as _ItemCategory                  on  $projection.SalesDocumentItemCategory = _ItemCategory.SalesDocumentItemCategory
  association [0..1] to I_SalesDocumentItem            as _HigherLevelItem               on  $projection.SalesDocument   = _HigherLevelItem.SalesDocument
                                                                                         and $projection.HigherLevelItem = _HigherLevelItem.SalesDocumentItem
  association [0..1] to I_User                         as _CreatedByUser                 on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_Division                     as _Division                      on  $projection.Division = _Division.Division
  association [0..1] to I_Material                     as _Material                      on  $projection.Material = _Material.Material
  association [0..1] to I_Product                      as _Product                       on  $projection.Product = _Product.Product
  association [0..1] to I_Product                      as _PlanningProduct               on  $projection.PlanningMaterial = _PlanningProduct.Product
  association [0..1] to I_Product                      as _MainItemPricingRefProduct     on  $projection.MainItemPricingRefProduct = _MainItemPricingRefProduct.Product

  association [0..1] to I_Material                     as _OriginallyRequestedMaterial   on  $projection.OriginallyRequestedMaterial = _OriginallyRequestedMaterial.Material
  association [1..1] to I_MaterialPlant                as _MaterialPlant                 on  $projection.Material = _MaterialPlant.Material
                                                                                         and $projection.Plant    = _MaterialPlant.Plant
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

  association [0..1] to I_MatlAccountAssignmentGroup   as _MatlAccountAssignmentGroup    on  $projection.MatlAccountAssignmentGroup = _MatlAccountAssignmentGroup.MatlAccountAssignmentGroup
  association [0..1] to I_UnitOfMeasure                as _OrderQuantityUnit             on  $projection.OrderQuantityUnit = _OrderQuantityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _TargetQuantityUnit            on  $projection.TargetQuantityUnit = _TargetQuantityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _BaseUnit                      on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _RequestedQuantityUnit         on  $projection.RequestedQuantityUnit = _RequestedQuantityUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ItemWeightUnit                on  $projection.ItemWeightUnit = _ItemWeightUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ItemVolumeUnit                on  $projection.ItemVolumeUnit = _ItemVolumeUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ProductUnit                   on  $projection.ProductBaseUnit = _ProductUnit.UnitOfMeasure
  association [0..1] to I_SalesDistrict                as _SalesDistrict                 on  $projection.SalesDistrict = _SalesDistrict.SalesDistrict
  association [0..1] to I_SalesDeal                    as _SalesDeal                     on  $projection.SalesDeal = _SalesDeal.SalesDeal
  association [0..1] to I_CustomerGroup                as _CustomerGroup                 on  $projection.CustomerGroup = _CustomerGroup.CustomerGroup
  association [0..1] to I_SalesDocumentRjcnReason      as _SalesDocumentRjcnReason       on  $projection.SalesDocumentRjcnReason = _SalesDocumentRjcnReason.SalesDocumentRjcnReason
  association [0..1] to I_ReturnReason                 as _ReturnReason                  on  $projection.ReturnReason = _ReturnReason.ReturnReason
  association [0..1] to I_ReturnsRefundExtent          as _ReturnsRefundExtent           on  $projection.ReturnsRefundExtent = _ReturnsRefundExtent.ReturnsRefundExtent
  association [0..1] to I_SalesContrValdtyPerdUnit     as _SalesContractValidityPerdUnit on  $projection.SalesContractValidityPerdUnit = _SalesContractValidityPerdUnit.SalesContractValidityPerdUnit
  association [0..1] to I_SalesContractCanclnParty     as _SalesContractCanclnParty      on  $projection.SalesContractCanclnParty = _SalesContractCanclnParty.SalesContractCanclnParty
  association [0..1] to I_SalesContractCanclnReason    as _SalesContractCanclnReason     on  $projection.SalesContractCanclnReason = _SalesContractCanclnReason.SalesContractCanclnReason
  association [0..1] to I_ContractDownPaymentStatus    as _ContractItemDownPaymentStatus on  $projection.ContractItemDownPaymentStatus = _ContractItemDownPaymentStatus.ContractDownPaymentStatus
  association [0..1] to I_UnitOfMeasure                as _NetPriceQuantityUnit          on  $projection.NetPriceQuantityUnit = _NetPriceQuantityUnit.UnitOfMeasure
  association [0..1] to I_StatisticalValueControl      as _StatisticalValueControl       on  $projection.StatisticalValueControl = _StatisticalValueControl.StatisticalValueControl
  association [0..1] to I_Currency                     as _TransactionCurrency           on  $projection.TransactionCurrency = _TransactionCurrency.Currency

  association [0..1] to I_ShippingPoint                as _ShippingPoint                 on  $projection.ShippingPoint = _ShippingPoint.ShippingPoint
  association [0..1] to I_ShippingType                 as _ShippingType                  on  $projection.ShippingType = _ShippingType.ShippingType
  association [0..1] to I_DeliveryPriority             as _DeliveryPriority              on  $projection.DeliveryPriority = _DeliveryPriority.DeliveryPriority
  association [0..1] to I_PartialDeliveryItem          as _PartialDeliveryItem           on  $projection.PartialDeliveryIsAllowed = _PartialDeliveryItem.PartialDeliveryIsAllowed
  association [0..1] to I_Plant                        as _Plant                         on  $projection.Plant = _Plant.Plant
  association [0..1] to I_Plant                        as _OriginalPlant                 on  $projection.OriginalPlant = _OriginalPlant.Plant
  association [0..1] to I_Plant                        as _TransitPlant                  on  $projection.TransitPlant = _TransitPlant.Plant
  association [0..1] to I_Plant                        as _PlanningPlant                 on  $projection.PlanningPlant = _PlanningPlant.Plant
  association [0..1] to I_StorageLocation              as _StorageLocation               on  $projection.Plant           = _StorageLocation.Plant
                                                                                         and $projection.StorageLocation = _StorageLocation.StorageLocation
  association [0..1] to I_Route                        as _Route                         on  $projection.Route = _Route.Route

  association [0..1] to I_BillingRelevanceCode         as _ItemIsBillingRelevant         on  $projection.ItemIsBillingRelevant = _ItemIsBillingRelevant.BillingRelevanceCode
  association [0..1] to I_BillingBlockReason           as _ItemBillingBlockReason        on  $projection.ItemBillingBlockReason = _ItemBillingBlockReason.BillingBlockReason
  association [0..1] to I_SlsDocItemBillingPlan        as _BillingPlan                   on  $projection.BillingPlan = _BillingPlan.BillingPlan
  association [0..1] to I_CustomerPaymentTerms         as _CustomerPaymentTerms          on  $projection.CustomerPaymentTerms = _CustomerPaymentTerms.CustomerPaymentTerms
  association [0..1] to I_IncotermsVersion             as _IncotermsVersion              on  $projection.IncotermsVersion = _IncotermsVersion.IncotermsVersion
  association [0..1] to I_IncotermsClassification      as _IncotermsClassification       on  $projection.IncotermsClassification = _IncotermsClassification.IncotermsClassification
  association [0..1] to I_CustomerAccountAssgmtGroup   as _CustomerAccountAssgmtGroup    on  $projection.CustomerAccountAssignmentGroup = _CustomerAccountAssgmtGroup.CustomerAccountAssignmentGroup
  association [0..1] to I_BusinessArea                 as _BusinessArea                  on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [0..1] to I_ControllingArea              as _ControllingArea               on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association [0..*] to I_ProfitCenter                 as _ProfitCenter                  on  $projection.ProfitCenter    = _ProfitCenter.ProfitCenter
                                                                                         and $projection.ControllingArea = _ProfitCenter.ControllingArea
  association [0..1] to I_WBSElementBasicData          as _WBSElementBasicData           on  $projection.WBSElement = _WBSElementBasicData.WBSElementInternalID
  association [0..1] to I_WBSElementBasicData          as _WBSElementBasicData_2         on  $projection.WBSElementInternalID = _WBSElementBasicData_2.WBSElementInternalID
  association [0..1] to I_SalesDocument                as _ReferenceSDDocument           on  $projection.ReferenceSDDocument = _ReferenceSDDocument.SalesDocument
  association [0..1] to I_SalesDocumentItem            as _ReferenceSDDocumentItem       on  $projection.ReferenceSDDocument     = _ReferenceSDDocumentItem.SalesDocument
                                                                                         and $projection.ReferenceSDDocumentItem = _ReferenceSDDocumentItem.SalesDocumentItem
  association [0..1] to I_SDDocumentCategory           as _ReferenceSDDocumentCategory   on  $projection.ReferenceSDDocumentCategory = _ReferenceSDDocumentCategory.SDDocumentCategory
  association [0..1] to I_PlngDelivSchedInstrn         as _PlngDelivSchedInstrn          on  $projection.PlngDelivSchedInstrn = _PlngDelivSchedInstrn.PlngDelivSchedInstrn

  association [0..1] to I_SDProcessStatus              as _SDProcessStatus               on  $projection.SDProcessStatus = _SDProcessStatus.SDProcessStatus
  association [0..1] to I_PurchaseConfirmationStatus   as _PurchaseConfirmationStatus    on  $projection.PurchaseConfirmationStatus = _PurchaseConfirmationStatus.PurchaseConfirmationStatus
  association [0..1] to I_TotalDeliveryStatus          as _TotalDeliveryStatus           on  $projection.TotalDeliveryStatus = _TotalDeliveryStatus.TotalDeliveryStatus
  association [0..1] to I_DeliveryStatus               as _DeliveryStatus                on  $projection.DeliveryStatus = _DeliveryStatus.DeliveryStatus
  association [0..1] to I_DeliveryBlockStatus          as _DeliveryBlockStatus           on  $projection.DeliveryBlockStatus = _DeliveryBlockStatus.DeliveryBlockStatus
  association [0..1] to I_DeliveryConfirmationStatus   as _DeliveryConfirmationStatus    on  $projection.DeliveryConfirmationStatus = _DeliveryConfirmationStatus.DeliveryConfirmationStatus
  association [0..1] to I_DeliveryDateTypeRule         as _DeliveryDateTypeRule          on  $projection.DeliveryDateTypeRule = _DeliveryDateTypeRule.DeliveryDateTypeRule
  association [0..1] to I_OrderRelatedBillingStatus    as _OrderRelatedBillingStatus     on  $projection.OrderRelatedBillingStatus = _OrderRelatedBillingStatus.OrderRelatedBillingStatus
  association [0..1] to I_BillingBlockStatus           as _BillingBlockStatus            on  $projection.BillingBlockStatus = _BillingBlockStatus.BillingBlockStatus
  association [0..1] to I_SDDocumentRejectionStatus    as _SDDocumentRejectionStatus     on  $projection.SDDocumentRejectionStatus = _SDDocumentRejectionStatus.SDDocumentRejectionStatus
  association [0..1] to I_ItemGenIncompletionStatus    as _ItemGeneralIncompletionStatus on  $projection.ItemGeneralIncompletionStatus = _ItemGeneralIncompletionStatus.ItemGeneralIncompletionStatus
  association [0..1] to I_ItemBillingIncompletionSts   as _ItemBillingIncompletionStatus on  $projection.ItemBillingIncompletionStatus = _ItemBillingIncompletionStatus.ItemBillingIncompletionStatus
  association [0..1] to I_PricingIncompletionStatus    as _PricingIncompletionStatus     on  $projection.PricingIncompletionStatus = _PricingIncompletionStatus.PricingIncompletionStatus
  association [0..1] to I_ItemDelivIncompletionSts     as _ItemDelivIncompletionSts      on  $projection.ItemDeliveryIncompletionStatus = _ItemDelivIncompletionSts.ItemDeliveryIncompletionStatus
  association [0..1] to I_TotalSDDocReferenceStatus    as _TotalSDDocReferenceStatus     on  $projection.TotalSDDocReferenceStatus = _TotalSDDocReferenceStatus.TotalSDDocReferenceStatus
  association [0..1] to I_SDDocReferenceStatus         as _SDDocReferenceStatus          on  $projection.SDDocReferenceStatus = _SDDocReferenceStatus.SDDocReferenceStatus
  association [0..1] to I_AltvBsdConfSubstitutionSts   as _AltvBsdConfSubstitutionSts    on  $projection.AltvBsdConfSubstitutionStatus = _AltvBsdConfSubstitutionSts.AltvBsdConfSubstitutionStatus
  association [0..1] to I_ChmlCmplncStatus             as _ChmlCmplncStatus              on  $projection.ChmlCmplncStatus = _ChmlCmplncStatus.ChmlCmplncStatus
  association [0..1] to I_DangerousGoodsStatus         as _DangerousGoodsStatus          on  $projection.DangerousGoodsStatus = _DangerousGoodsStatus.DangerousGoodsStatus
  association [0..1] to I_SafetyDataSheetStatus        as _SafetyDataSheetStatus         on  $projection.SafetyDataSheetStatus = _SafetyDataSheetStatus.SafetyDataSheetStatus

  association [0..1] to I_TrdCmplncCheckStatus         as _TrdCmplncEmbargoSts           on  $projection.TrdCmplncEmbargoSts = _TrdCmplncEmbargoSts.TrdCmplncCheckStatus
  association [0..1] to I_TrdCmplncCheckStatus         as _TrdCmplncSnctndListChkSts     on  $projection.TrdCmplncSnctndListChkSts = _TrdCmplncSnctndListChkSts.TrdCmplncCheckStatus
  association [0..1] to I_OvrlTrdCmplncLegalCtrlChkSts as _OvrlTrdCmplncLegalCtrlChkSts  on  $projection.OvrlTrdCmplncLegalCtrlChkSts = _OvrlTrdCmplncLegalCtrlChkSts.OvrlTrdCmplncLegalCtrlChkSts

  association [0..1] to I_ServiceDocumentType          as _ServiceDocumentType           on  $projection.ServiceDocumentType = _ServiceDocumentType.ServiceDocumentType
  association [0..1] to I_SalesDocumentItemProcgCode   as _SalesDocumentItemProcgCode    on  $projection.SalesDocumentItemProcgCode = _SalesDocumentItemProcgCode.SalesDocumentItemProcgCode
  association [0..1] to I_CustomerPriceGroup           as _CustomerPriceGroup            on  $projection.CustomerPriceGroup = _CustomerPriceGroup.CustomerPriceGroup

  //Analytics fields
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
  association [0..1] to I_Customer                     as _ShipToParty                   on  $projection.ShipToParty = _ShipToParty.Customer
  association [0..1] to I_Customer                     as _BillToParty                   on  $projection.BillToParty = _BillToParty.Customer
  association [0..1] to I_Customer                     as _PayerParty                    on  $projection.PayerParty = _PayerParty.Customer
  association [0..1] to I_PersonWorkAgreement_1        as _SalesEmployee                 on  $projection.SalesEmployee = _SalesEmployee.PersonWorkAgreement
  association [0..1] to I_PersonWorkAgreement_1        as _ResponsibleEmployee           on  $projection.ResponsibleEmployee = _ResponsibleEmployee.PersonWorkAgreement
  association [0..1] to I_ConsumptionPosting           as _ConsumptionPosting            on  $projection.ConsumptionPosting = _ConsumptionPosting.ConsumptionPosting

  //Solution Order Reference
  association [0..1] to I_ServiceDocumentEnhcd         as _SolutionOrder                 on  $projection.BusinessSolutionOrder = _SolutionOrder.ServiceDocument
                                                                                         and _SolutionOrder.ServiceObjectType  = 'BUS2000172'

  //Solution Order Item Reference
  association [1]    to I_ServiceDocumentItemEnhcd     as _SolutionOrderItem             on  _SolutionOrderItem.ServiceObjectType  = 'BUS2000172'
                                                                                         and $projection.BusinessSolutionOrder     = _SolutionOrderItem.ServiceDocument
                                                                                         and $projection.BusinessSolutionOrderItem = _SolutionOrderItem.ServiceDocumentItem
    
  // ValueChain Management
  association [0..1] to I_SalesValueChainCategory      as _SalesValueChainCategory       on  $projection.ValueChainCategory = _SalesValueChainCategory.ValueChainCategory
  
  //Extensibility
  association [0..1] to E_SalesDocumentItemBasic       as _Extension                     on  $projection.SalesDocument     = _Extension.SalesDocument
                                                                                         and $projection.SalesDocumentItem = _Extension.SalesDocumentItem

{
      //Key
      @ObjectModel.foreignKey.association: '_SalesDocument'
  key vbap.vbeln                                                                        as SalesDocument,
      @ObjectModel.text.element: 'SalesDocumentItemText'
  key vbap.posnr                                                                        as SalesDocumentItem,
      vbap.handle                                                                       as SalesDocumentItemUUID,

      //Category
      @ObjectModel.foreignKey.association: '_SDDocumentCategory'
      vbap.vbtyp_ana                                                                    as SDDocumentCategory,
      @ObjectModel.foreignKey.association: '_ItemCategory'
      vbap.pstyv                                                                        as SalesDocumentItemCategory,
      vbap.posar                                                                        as SalesDocumentItemType,
      vbap.shkzg                                                                        as IsReturnsItem,
      vbap.erlre                                                                        as CompletionRule,

      //Admin
      vbap.ernam                                                                        as CreatedByUser,
      @Semantics.systemDate.createdAt: true
      vbap.erdat                                                                        as CreationDate,
      cast ( vbap.erzet as creation_time preserving type )                              as CreationTime,
      @Semantics.systemDate.lastChangedAt: true
      vbap.aedat                                                                        as LastChangeDate,

      //Organization
      @ObjectModel.foreignKey.association: '_Division'
      vbap.spart                                                                        as Division,

      //Product
      //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_MaterialText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Material'
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'Product'
      vbap.matnr                                                                        as Material,

      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ProductVH',
                     element: 'Product' }
        }]
      @ObjectModel.text.association: '_ProductText'
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_Product'
      cast (vbap.matnr as productnumber preserving type)                                as Product,

      //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_MaterialStdVH',
                     element: 'Material' }
        }]
      @ObjectModel.text.association: '_OrigMaterialText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_OriginallyRequestedMaterial'
      vbap.matwa                                                                        as OriginallyRequestedMaterial,
      vbap.kdmat                                                                        as MaterialByCustomer,
      vbap.ean11                                                                        as InternationalArticleNumber,
      //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
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
      vbap.charg                                                                        as Batch,
      @ObjectModel.foreignKey.association: '_ProductHierarchyNode'
      vbap.prodh                                                                        as ProductHierarchyNode,
      vbkd.wminr                                                                        as ProductCatalog,
      @ObjectModel.foreignKey.association: '_MaterialSubstitutionReason'
      vbap.sugrd                                                                        as MaterialSubstitutionReason,
      @ObjectModel.foreignKey.association: '_MaterialGroup'
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'ProductGroup'
      vbap.matkl                                                                        as MaterialGroup,
      @ObjectModel.foreignKey.association: '_ProductGroup'
      @Analytics.internalName: #LOCAL
      cast (vbap.matkl as productgroup preserving type )                                as ProductGroup,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup1'
      vbap.mvgr1                                                                        as AdditionalMaterialGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup2'
      vbap.mvgr2                                                                        as AdditionalMaterialGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup3'
      vbap.mvgr3                                                                        as AdditionalMaterialGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup4'
      vbap.mvgr4                                                                        as AdditionalMaterialGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalMaterialGroup5'
      vbap.mvgr5                                                                        as AdditionalMaterialGroup5,
      vbap.cuobj                                                                        as ProductConfiguration,
      vbap.prosa                                                                        as MaterialDeterminationType,
      vbap.uepvw                                                                        as HigherLevelItemUsage,
      vbap.berid                                                                        as MRPArea,
      vbap.stlnr                                                                        as BillOfMaterial,
      vbap.stdat                                                                        as BOMExplosionDate,
      vbap.mtvfp                                                                        as ProdAvailabilityCheckGroup,

      //Sales
      @Semantics.text: true
      vbap.arktx                                                                        as SalesDocumentItemText,
      vbap.bstkd_ana                                                                    as PurchaseOrderByCustomer,
      vbkd.bstkd_e                                                                      as PurchaseOrderByShipToParty,
      @Analytics.internalName: #LOCAL
      vbkd.bstdk                                                                        as CustomerPurchaseOrderDate,
      vbap.posex                                                                        as UnderlyingPurchaseOrderItem,
      vbap.ext_ref_item_id                                                              as ExternalItemID,

      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbap.kwmeng                                                                       as OrderQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_OrderQuantityUnit'
      vbap.vrkme                                                                        as OrderQuantityUnit,
      vbap.umvkn                                                                        as OrderToBaseQuantityDnmntr,
      vbap.umvkz                                                                        as OrderToBaseQuantityNmrtr,
      @Semantics.quantity.unitOfMeasure: 'TargetQuantityUnit'
      vbap.zmeng                                                                        as TargetQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_TargetQuantityUnit'
      vbap.zieme                                                                        as TargetQuantityUnit,
      vbap.umzin                                                                        as TargetToBaseQuantityDnmntr,
      vbap.umziz                                                                        as TargetToBaseQuantityNmrtr,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbap.kbmeng                                                                       as ConfdDelivQtyInOrderQtyUnit,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbap.lsmeng                                                                       as TargetDelivQtyInOrderQtyUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      vbap.klmeng                                                                       as ConfdDeliveryQtyInBaseUnit,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnit'
      vbap.meins                                                                        as BaseUnit,
      vbap.substn_numerator                                                             as MDSubstnConversionNumerator,
      vbap.substn_denominator                                                           as MDSubstnConversionDenominator,

      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      cast( vbap.cmtd_deliv_qty_su   as committeddelivqtyinordqtyunit preserving type ) as CommittedDelivQtyInOrdQtyUnit,
      cast( vbap.cmtd_deliv_creadate as committeddelivcreationdate    preserving type ) as CommittedDelivCreationDate,
      cast( vbap.cmtd_deliv_date     as committeddeliverydate         preserving type ) as CommittedDeliveryDate,

      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      cast( case when
          vbap.kwmeng > 0
      then
          vbap.kwmeng
      else
          vbap.zmeng
      end as reqd_qty )                                                                 as RequestedQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_RequestedQuantityUnit'
      cast( case when
          vbap.kwmeng > 0
      then
          vbap.vrkme
      else
          vbap.zieme
      end as reqd_qty_unit )                                                            as RequestedQuantityUnit,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      vbap.reqqty_bu                                                                    as RequestedQuantityInBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      vbap.brgew                                                                        as ItemGrossWeight,
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
      vbap.ntgew                                                                        as ItemNetWeight,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ItemWeightUnit'
      vbap.gewei                                                                        as ItemWeightUnit,
      @Semantics.quantity.unitOfMeasure: 'ItemVolumeUnit'
      vbap.volum                                                                        as ItemVolume,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ItemVolumeUnit'
      vbap.voleh                                                                        as ItemVolumeUnit,
      vbkd.fbuda                                                                        as ServicesRenderedDate,
      @ObjectModel.foreignKey.association: '_SalesDistrict'
      vbap.bzirk_ana                                                                    as SalesDistrict,
      //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_SalesDealStdVH',
                     element: 'SalesDeal' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_SalesDeal'
      vbap.knuma_ag                                                                     as SalesDeal,
      vbap.knuma_pi                                                                     as SalesPromotion,
      vbkd.waktion                                                                      as RetailPromotion,
      @ObjectModel.foreignKey.association: '_CustomerGroup'
      vbap.kdgrp_ana                                                                    as CustomerGroup,
      vbkd.podkz                                                                        as SlsDocIsRlvtForProofOfDeliv,

      @ObjectModel.foreignKey.association: '_SalesDocumentRjcnReason'
      vbap.abgru                                                                        as SalesDocumentRjcnReason,
      vbap.grpos                                                                        as AlternativeToItem,
      @ObjectModel.foreignKey.association: '_ReturnReason'
      vbap.msr_ret_reason                                                               as ReturnReason,
      @ObjectModel.foreignKey.association: '_ReturnsRefundExtent'
      vbap.msr_refund_code                                                              as ReturnsRefundExtent,
      vbap.msr_approv_block                                                             as RetsMgmtProcessingBlock,
      vbap.sgt_rcat                                                                     as RequirementSegment,
      vbap.fmeng                                                                        as QuantityIsFixed,

      //Quotation
      vbap.awahr                                                                        as ItemOrderProbabilityInPercent,

      //Contract
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.zwert                                                                        as OutlineAgreementTargetAmount,
      veda.vbegdat                                                                      as SalesContractValidityStartDate,
      veda.venddat                                                                      as SalesContractValidityEndDate,
      veda.vlaufz                                                                       as NmbrOfSalesContractValdtyPerd,
      @ObjectModel.foreignKey.association: '_SalesContractValidityPerdUnit'
      veda.vlauez                                                                       as SalesContractValidityPerdUnit,
      veda.vlaufk                                                                       as SalesContractValidityPerdCat,
      veda.vuntdat                                                                      as SalesContractSignedDate,
      veda.vinsdat                                                                      as EquipmentInstallationDate,
      veda.vabndat                                                                      as EquipmentDeliveryAccptcDate,
      veda.vdemdat                                                                      as EquipmentDismantlingDate,
      veda.vkuesch                                                                      as SalesContractCanclnProcedure,
      veda.vwundat                                                                      as RequestedCancellationDate,
      veda.veindat                                                                      as SlsContractCanclnReqRcptDate,
      veda.vbelkue                                                                      as CanclnDocByContrPartner,
      veda.vbedkue                                                                      as ContractPartnerCanclnDocDate,
      @ObjectModel.foreignKey.association: '_SalesContractCanclnParty'
      veda.vkuepar                                                                      as SalesContractCanclnParty,
      @ObjectModel.foreignKey.association: '_SalesContractCanclnReason'
      veda.vkuegru                                                                      as SalesContractCanclnReason,
      veda.vaktsch                                                                      as SalesContractFollowUpAction,
      veda.vasda                                                                        as SlsContractFollowUpActionDate,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesDocumentItemProcgCode'
      vbap.process_code                                                                 as SalesDocumentItemProcgCode,

      //Sales Scheduling Agreement
      @ObjectModel.foreignKey.association: '_PlngDelivSchedInstrn'
      vbap.plavo                                                                        as PlngDelivSchedInstrn,

      //Pricing
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.netwr                                                                        as NetAmount,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_TransactionCurrency'
      vbap.waerk                                                                        as TransactionCurrency,
      vbap.pmatn                                                                        as PricingReferenceMaterial,
      @ObjectModel.foreignKey.association: '_MaterialPricingGroup'
      vbap.kondm                                                                        as MaterialPricingGroup,
      vbap.taxm1                                                                        as ProductTaxClassification1,
      vbap.taxm2                                                                        as ProductTaxClassification2,
      vbap.taxm3                                                                        as ProductTaxClassification3,
      vbap.taxm4                                                                        as ProductTaxClassification4,
      vbap.taxm5                                                                        as ProductTaxClassification5,
      vbap.taxm6                                                                        as ProductTaxClassification6,
      vbap.taxm7                                                                        as ProductTaxClassification7,
      vbap.taxm8                                                                        as ProductTaxClassification8,
      vbap.taxm9                                                                        as ProductTaxClassification9,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_MatlAccountAssignmentGroup'
      vbap.ktgrm                                                                        as MatlAccountAssignmentGroup,
      vbkd.prsdt                                                                        as PricingDate,
      vbkd.kursk_dat                                                                    as ExchangeRateDate,
      cast(vbkd.kursk as kursk_not_converted preserving type)                           as PriceDetnExchangeRate,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.netpr                                                                        as NetPriceAmount,
      @Semantics.quantity.unitOfMeasure: 'NetPriceQuantityUnit'
      vbap.kpein                                                                        as NetPriceQuantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_NetPriceQuantityUnit'
      vbap.kmein                                                                        as NetPriceQuantityUnit,

      @ObjectModel.foreignKey.association: '_StatisticalValueControl'
      vbap.kowrr                                                                        as StatisticalValueControl,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.mwsbp                                                                        as TaxAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.wavwr                                                                        as CostAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.kzwi1                                                                        as Subtotal1Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.kzwi2                                                                        as Subtotal2Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.kzwi3                                                                        as Subtotal3Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.kzwi4                                                                        as Subtotal4Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.kzwi5                                                                        as Subtotal5Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.kzwi6                                                                        as Subtotal6Amount,
      vbap.knumv_ana                                                                    as SalesDocumentCondition,

      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_MainItemPricingRefProduct'
      cast (vbap.upmat as main_item_pricing_ref_product preserving type)                as MainItemPricingRefProduct,

      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_CustomerPriceGroup'
      vbkd.konda                                                                        as CustomerPriceGroup,

      //Shipping
      //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ShippingPointStdVH',
                     element: 'ShippingPoint' }
        }]
      @ObjectModel.text.association: '_ShippingPointText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ShippingPoint'
      vbap.vstel                                                                        as ShippingPoint,
      @ObjectModel.foreignKey.association: '_ShippingType'
      vbap.vsart_ana                                                                    as ShippingType,
      vbap.sobkz                                                                        as InventorySpecialStockType,
      vbap.kzbws                                                                        as InventorySpecialStockValnType,
      @ObjectModel.foreignKey.association: '_DeliveryPriority'
      vbap.lprio                                                                        as DeliveryPriority,
      @ObjectModel.foreignKey.association: '_Plant'
      vbap.werks                                                                        as Plant,
      @ObjectModel.foreignKey.association: '_OriginalPlant'
      vbap.original_plant                                                               as OriginalPlant,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_TransitPlant'
      vbap.transit_plant                                                                as TransitPlant,

      @ObjectModel.foreignKey.association: '_StorageLocation'
      vbap.lgort                                                                        as StorageLocation,
      @ObjectModel.foreignKey.association: '_Route'
      vbap.route                                                                        as Route,
      vbap.grkor                                                                        as DeliveryGroup,
      vbap.fixmg                                                                        as DeliveryDateQuantityIsFixed,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_PartialDeliveryItem'
      cast (vbap.kztlf as partial_delivery_allowed_flag preserving type )               as PartialDeliveryIsAllowed,
      cast (vbap.antlf as nmbrpartialdeliv preserving type )                            as MaxNmbrOfPartialDelivery,
      vbap.uebtk                                                                        as UnlimitedOverdeliveryIsAllowed,
      vbap.uebto                                                                        as OverdelivTolrtdLmtRatioInPct,
      vbap.untto                                                                        as UnderdelivTolrtdLmtRatioInPct,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      vbap.lfmng                                                                        as MinDeliveryQtyInBaseUnit,
      vbap.kzfme                                                                        as OpenDeliveryLeadingUnitCode,
      vbap.lfrel                                                                        as ItemIsDeliveryRelevant,
      @Semantics.booleanIndicator: true
      vbap.xchar                                                                        as BatchManagementIsSalesInternal,

      //Fashion
      vbap.fsh_season_year                                                              as ProductSeasonYear,
      vbap.fsh_season                                                                   as ProductSeason,
      vbap.fsh_collection                                                               as ProductCollection,
      vbap.fsh_theme                                                                    as ProductTheme,
      vbap.fsh_candate                                                                  as FashionCancelDate,
      vbap.wrf_charstc1                                                                 as ProductCharacteristic1,
      vbap.wrf_charstc2                                                                 as ProductCharacteristic2,
      vbap.wrf_charstc3                                                                 as ProductCharacteristic3,
      vbap.rfm_psst_group                                                               as ShippingGroupNumber,
      vbap.rfm_psst_rule                                                                as ShippingGroupRule,
      vbap.assignment_priority                                                          as ARunPriorityValue,
      vbap.arun_group_prio                                                              as ARunDemandGroupPriority,

      //Billing
      vbap.fkdat_ana                                                                    as BillingDocumentDate,
      @ObjectModel.foreignKey.association: '_ItemIsBillingRelevant'
      vbap.fkrel                                                                        as ItemIsBillingRelevant,
      @ObjectModel.foreignKey.association: '_ItemBillingBlockReason'
      vbap.faksp                                                                        as ItemBillingBlockReason,
      vbap.fplnr_ana                                                                    as BillingPlan,

      @Analytics.internalName: #LOCAL
      vbkd.dpbp_ref_fplnr                                                               as ReferenceBillingPlan,
      @Analytics.internalName: #LOCAL
      vbkd.dpbp_ref_fpltr                                                               as ReferenceBillingPlanItem,

      //Payment
      @ObjectModel.foreignKey.association: '_IncotermsVersion'
      vbkd.incov                                                                        as IncotermsVersion,
      @ObjectModel.foreignKey.association: '_IncotermsClassification'
      vbkd.inco1                                                                        as IncotermsClassification,
      vbkd.inco2                                                                        as IncotermsTransferLocation,
      vbkd.inco2_l                                                                      as IncotermsLocation1,
      vbkd.inco3_l                                                                      as IncotermsLocation2,
      @ObjectModel.foreignKey.association: '_CustomerPaymentTerms'
      vbkd.zterm                                                                        as CustomerPaymentTerms,
      vbkd.zlsch                                                                        as PaymentMethod,
      vbkd.valdt                                                                        as FixedValueDate,
      vbkd.valtg                                                                        as AdditionalValueDays,

      //Accounting
      vbkd.vkont                                                                        as ContractAccount,
      vbkd.gjahr                                                                        as FiscalYear,
      vbkd.poper                                                                        as FiscalPeriod,
      @ObjectModel.foreignKey.association: '_CustomerAccountAssgmtGroup'
      vbkd.ktgrd                                                                        as CustomerAccountAssignmentGroup,
      //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BusinessAreaStdVH',
                     element: 'BusinessArea' }
        }]
      @ObjectModel.text.association: '_BusinessAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_BusinessArea'
      vbap.gsber                                                                        as BusinessArea,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_ControllingArea'
      vbak.kokrs                                                                        as ControllingArea,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_ProfitCenter'
      vbap.prctr                                                                        as ProfitCenter,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_WBSElementBasicData'
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: 'WBSElementInternalID'
      vbap.ps_psp_pnr                                                                   as WBSElement,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_WBSElementBasicData_2'
      cast ( vbap.ps_psp_pnr as ps_s4_pspnr preserving type )                           as WBSElementInternalID,
      vbap.aufnr                                                                        as OrderID,
      vbap.objnr                                                                        as ControllingObject,
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: 'ProfitabilitySegment_2'
      cast(vbap.paobjnr as rkeobjnr_numc )                                              as ProfitabilitySegment,
      cast(vbap.paobjnr as rkeobjnr_char )                                              as ProfitabilitySegment_2,
      vbap.vbelv                                                                        as OriginSDDocument,
      vbap.posnv                                                                        as OriginSDDocumentItem,
      vbkd.kurrf                                                                        as AccountingExchangeRate,

      //Reference
      @ObjectModel.foreignKey.association: '_ReferenceSDDocument'
      vbap.vgbel                                                                        as ReferenceSDDocument,
      @ObjectModel.foreignKey.association: '_ReferenceSDDocumentItem'
      vbap.vgpos                                                                        as ReferenceSDDocumentItem,
      @ObjectModel.foreignKey.association: '_ReferenceSDDocumentCategory'
      vbap.vgtyp                                                                        as ReferenceSDDocumentCategory,
      @ObjectModel.foreignKey.association: '_HigherLevelItem'
      @Analytics.internalName: #LOCAL
      vbap.uepos                                                                        as HigherLevelItem,
      vbap.wktnr                                                                        as ValueContract,
      vbap.wktps                                                                        as ValueContractItem,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SolutionOrder'
      vbap.solution_order_id                                                            as BusinessSolutionOrder,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SolutionOrderItem'
      vbap.solution_order_itm_id                                                        as BusinessSolutionOrderItem,

      // Status
      @ObjectModel.foreignKey.association: '_SDProcessStatus'
      vbap.gbsta                                                                        as SDProcessStatus,
      @ObjectModel.foreignKey.association: '_DeliveryConfirmationStatus'
      vbap.besta                                                                        as DeliveryConfirmationStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_DeliveryDateTypeRule'
      vbap.delivery_date_type_rule                                                      as DeliveryDateTypeRule,
      @ObjectModel.foreignKey.association: '_PurchaseConfirmationStatus'
      vbap.costa                                                                        as PurchaseConfirmationStatus,
      @ObjectModel.foreignKey.association: '_TotalDeliveryStatus'
      vbap.lfgsa                                                                        as TotalDeliveryStatus,
      @ObjectModel.foreignKey.association: '_DeliveryStatus'
      vbap.lfsta                                                                        as DeliveryStatus,
      @ObjectModel.foreignKey.association: '_DeliveryBlockStatus'
      cast(vbap.lssta as delivery_block_status preserving type )                        as DeliveryBlockStatus,
      @ObjectModel.foreignKey.association: '_OrderRelatedBillingStatus'
      vbap.fksaa                                                                        as OrderRelatedBillingStatus,
      @ObjectModel.foreignKey.association: '_BillingBlockStatus'
      vbap.fssta                                                                        as BillingBlockStatus,
      @ObjectModel.foreignKey.association: '_ItemGeneralIncompletionStatus'
      vbap.uvall                                                                        as ItemGeneralIncompletionStatus,
      @ObjectModel.foreignKey.association: '_ItemBillingIncompletionStatus'
      vbap.uvfak                                                                        as ItemBillingIncompletionStatus,
      @ObjectModel.foreignKey.association: '_PricingIncompletionStatus'
      vbap.uvprs                                                                        as PricingIncompletionStatus,
      @ObjectModel.foreignKey.association: '_ItemDelivIncompletionSts'
      vbap.uvvlk                                                                        as ItemDeliveryIncompletionStatus,
      @ObjectModel.foreignKey.association: '_SDDocumentRejectionStatus'
      vbap.absta                                                                        as SDDocumentRejectionStatus,
      @ObjectModel.foreignKey.association: '_TotalSDDocReferenceStatus'
      vbap.rfgsa                                                                        as TotalSDDocReferenceStatus,
      @ObjectModel.foreignKey.association: '_SDDocReferenceStatus'
      vbap.rfsta                                                                        as SDDocReferenceStatus,
      @ObjectModel.foreignKey.association: '_ChmlCmplncStatus'
      cast(vbap.pcsta as mon_tdd_pcsta preserving type )                                as ChmlCmplncStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_DangerousGoodsStatus'
      cast(vbap.dgsta as mon_tdd_dgsta preserving type )                                as DangerousGoodsStatus,
      @ObjectModel.foreignKey.association: '_SafetyDataSheetStatus'
      cast(vbap.sdssta as mon_tdd_sdssta preserving type )                              as SafetyDataSheetStatus,
      @ObjectModel.foreignKey.association: '_TrdCmplncEmbargoSts'
      cast(vbap.emcst as embargochksts preserving type )                                as TrdCmplncEmbargoSts,
      @ObjectModel.foreignKey.association: '_TrdCmplncSnctndListChkSts'
      cast(vbap.slcst as watchlistscrngchksts preserving type )                         as TrdCmplncSnctndListChkSts,
      @ObjectModel.foreignKey.association: '_OvrlTrdCmplncLegalCtrlChkSts'
      cast(vbap.total_lccst as lglctrlchksts preserving type )                          as OvrlTrdCmplncLegalCtrlChkSts,

      @ObjectModel.foreignKey.association: '_AltvBsdConfSubstitutionSts'
      vbap.atp_abc_substitution_status                                                  as AltvBsdConfSubstitutionStatus,
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_ContractItemDownPaymentStatus'
      vbap.dp_clear_sta_itm                                                             as ContractItemDownPaymentStatus,
      
      // Value Chain Management
      @Analytics.internalName: #LOCAL
      @ObjectModel.foreignKey.association: '_SalesValueChainCategory'
      vbap.vcm_chain_category                                                           as ValueChainCategory,

      //PBS
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.capped_net_amount                                                            as CappedNetAmount,
      vbap.capped_net_amount_alert_thld                                                 as CappedNetAmtAlertThldInPct,
      //this field is relevant only for PBS scenario
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      vbap.ifrs15_total_ssp                                                             as TotalStandAloneSellingPrice,
      vbap.abgrs                                                                        as ResultAnalysisInternalID,

      // CRM
      @ObjectModel.foreignKey.association: '_ServiceDocumentType'
      vbap.service_doc_type                                                             as ServiceDocumentType,
      vbap.service_doc_id                                                               as ServiceDocument,
      vbap.service_doc_item_id                                                          as ServiceDocumentItem,

      // Analytics relevant fields
      @ObjectModel.foreignKey.association: '_SalesDocumentType'
      vbap.auart_ana                                                                    as SalesDocumentType,
      @ObjectModel.foreignKey.association: '_SalesOrganization'
      vbap.vkorg_ana                                                                    as SalesOrganization,
      @ObjectModel.foreignKey.association: '_DistributionChannel'
      vbap.vtweg_ana                                                                    as DistributionChannel,
      @ObjectModel.foreignKey.association: '_OrganizationDivision'
      vbap.spart_ana                                                                    as OrganizationDivision,
      @ObjectModel.foreignKey.association: '_SalesOffice'
      vbap.vkbur_ana                                                                    as SalesOffice,
      @ObjectModel.foreignKey.association: '_SalesGroup'
      vbap.vkgrp_ana                                                                    as SalesGroup,
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Customer_VH',
                     element: 'Customer' }
        }]
      @ObjectModel.foreignKey.association: '_SoldToParty'
      vbap.kunnr_ana                                                                    as SoldToParty,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup1'
      vbap.kvgr1_ana                                                                    as AdditionalCustomerGroup1,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup2'
      vbap.kvgr2_ana                                                                    as AdditionalCustomerGroup2,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup3'
      vbap.kvgr3_ana                                                                    as AdditionalCustomerGroup3,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup4'
      vbap.kvgr4_ana                                                                    as AdditionalCustomerGroup4,
      @ObjectModel.foreignKey.association: '_AdditionalCustomerGroup5'
      vbap.kvgr5_ana                                                                    as AdditionalCustomerGroup5,
      vbap.audat_ana                                                                    as SalesDocumentDate,
      @ObjectModel.foreignKey.association: '_SDDocumentReason'
      vbap.augru_ana                                                                    as SDDocumentReason,
      cast(vbap.vdatu_ana as reqd_delivery_date preserving type)                        as RequestedDeliveryDate,
      @ObjectModel.foreignKey.association: '_ShippingCondition'
      vbap.vsbed_ana                                                                    as ShippingCondition,
      // Analytics partner fields
      @ObjectModel.foreignKey.association: '_ShipToParty'
      vbap.kunwe_ana                                                                    as ShipToParty,
      @ObjectModel.foreignKey.association: '_PayerParty'
      vbap.kunrg_ana                                                                    as PayerParty,
      @ObjectModel.foreignKey.association: '_BillToParty'
      vbap.kunre_ana                                                                    as BillToParty,
      @ObjectModel.foreignKey.association: '_SalesEmployee'
      vbap.perve_ana                                                                    as SalesEmployee,
      @ObjectModel.foreignKey.association: '_ResponsibleEmployee'
      vbap.perzm_ana                                                                    as ResponsibleEmployee,
      cast(vbap.perve_ana as sales_empl preserving type)                                as SalesEmployeeWorkAgreement,
      cast(vbap.perzm_ana as resp_empl  preserving type)                                as ResponsibleEmployeeWorkAgrmt,

      vbap.bob_promotion_id                                                             as OmniChannelSalesPromotion,
      vbap.bob_fg_id                                                                    as OmniChannelSalesPromotionRule,

      @ObjectModel.foreignKey.association: '_ConsumptionPosting'
      vbap.kzvbr                                                                        as ConsumptionPosting,

      // Production planning related fields
      @ObjectModel.foreignKey.association: '_PlanningProduct'
      @Analytics.internalName: #LOCAL
      vbap.vpmat                                                                        as PlanningMaterial,
      @ObjectModel.foreignKey.association: '_PlanningPlant'
      @Analytics.internalName: #LOCAL
      vbap.vpwrk                                                                        as PlanningPlant,
      @ObjectModel.foreignKey.association: '_ProductUnit'
      @Analytics.internalName: #LOCAL
      vbap.prbme                                                                        as ProductBaseUnit,

      vbap.umref                                                                        as ProdPlntPlngMatlConversionFctr,

      _SlsDocItemEnhancedFields,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _SalesDocument,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _ScheduleLine,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Partner,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _PricingElement,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _ItemBillingPlan,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: '_SubsequentProcFlowDocItem'
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_SubsequentProcFlowDocItem'
      _SubsequentDocument,

      _SubsequentProcFlowDocItem,

      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: '_PrecedingProcFlowDocItem'
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_PrecedingProcFlowDocItem'
      _PrecedingDocument,

      _PrecedingProcFlowDocItem,

      _SDDocumentCategory,
      _ItemCategory,
      _HigherLevelItem,
      _CreatedByUser,
      _Division,
      _Material,
      _Product,
      _OriginallyRequestedMaterial,
      _MaterialPlant,
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
      _MatlAccountAssignmentGroup,
      _OrderQuantityUnit,
      _TargetQuantityUnit,
      _BaseUnit,
      _RequestedQuantityUnit,
      _ItemWeightUnit,
      _ItemVolumeUnit,
      _SalesDistrict,
      _SalesDeal,
      _CustomerGroup,
      _CustomerPriceGroup,
      _SalesDocumentRjcnReason,
      _ReturnReason,
      _ReturnsRefundExtent,
      _SalesContractValidityPerdUnit,
      _SalesContractCanclnParty,
      _SalesContractCanclnReason,
      _ContractItemDownPaymentStatus,
      _SalesDocumentItemProcgCode,
      _NetPriceQuantityUnit,
      _StatisticalValueControl,
      _TransactionCurrency,
      _ShippingPoint,
      _ShippingType,
      _DeliveryPriority,
      _PartialDeliveryItem,
      _Plant,
      _OriginalPlant,
      _TransitPlant,
      _StorageLocation,
      _Route,
      _ItemIsBillingRelevant,
      _ItemBillingBlockReason,

      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: '_ItemBillingPlan'
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_ItemBillingPlan'
      _BillingPlan,

      _CustomerPaymentTerms,
      _IncotermsVersion,
      _IncotermsClassification,
      _CustomerAccountAssgmtGroup,
      _BusinessArea,
      @Consumption.filter.businessDate.at: true
      _ProfitCenter,
      _ControllingArea,

      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: '_WBSElementBasicData_2'
      @API.element.releaseState: #DEPRECATED
      @API.element.successor: '_WBSElementBasicData_2'
      _WBSElementBasicData,
      _WBSElementBasicData_2,
      _ReferenceSDDocument,
      _ReferenceSDDocumentItem,
      _ReferenceSDDocumentCategory,
      _PlngDelivSchedInstrn,

      _SolutionOrder,
      _SolutionOrderItem,
      
      _SalesValueChainCategory,

      _SDProcessStatus,
      _PurchaseConfirmationStatus,
      _TotalDeliveryStatus,
      _DeliveryStatus,
      _DeliveryBlockStatus,
      _DeliveryConfirmationStatus,
      _DeliveryDateTypeRule,
      _OrderRelatedBillingStatus,
      _BillingBlockStatus,
      _SDDocumentRejectionStatus,
      _ItemGeneralIncompletionStatus,
      _ItemBillingIncompletionStatus,
      _PricingIncompletionStatus,
      _ItemDelivIncompletionSts,
      _TotalSDDocReferenceStatus,
      _SDDocReferenceStatus,
      _AltvBsdConfSubstitutionSts,
      _ChmlCmplncStatus,
      _DangerousGoodsStatus,
      _SafetyDataSheetStatus,
      _TrdCmplncEmbargoSts,
      _TrdCmplncSnctndListChkSts,
      _OvrlTrdCmplncLegalCtrlChkSts,
      _ConsumptionPosting,
      _PlanningPlant,
      _PlanningProduct,
      _MainItemPricingRefProduct,
      _ProductUnit,

      // Analytics relevant associations
      _SalesDocumentType,
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
      _SDDocumentReason,
      _ShippingCondition,
      _ShipToParty,
      _BillToParty,
      _PayerParty,
      _SalesEmployee,
      _ResponsibleEmployee,


      _ServiceDocumentType,
      //--[ GENERATED:012:GFBfhyK17kY4ofNN1pz{RG
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
