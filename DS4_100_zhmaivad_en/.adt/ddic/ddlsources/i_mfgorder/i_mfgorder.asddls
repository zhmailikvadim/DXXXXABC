@AbapCatalog.sqlViewName: 'IPPMFGORDER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #NOT_REQUIRED
@AccessControl.privilegedAssociations: ['_MRPController', '_ProductionSupervisor', '_CreatedByUser', '_LastChangedByUser']
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ManufacturingOrder'
@ObjectModel.semanticKey: 'ManufacturingOrder'
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@VDM.viewType: #BASIC
@VDM.lifecycle.status: #DEPRECATED
@VDM.lifecycle.successor: 'I_ManufacturingOrder'
@Search.searchable: true
@EndUserText.label: 'Manufacturing Order'

/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
define view I_MfgOrder
  // Corresponds to calculation view 'sap.hba.ecc.MfgOrder'
  as select from I_LogisticsOrder as aufv
    inner join   I_OrderItem      as afpo on  afpo.OrderID   = aufv.OrderID
                                          and afpo.OrderItem = '0001'

  association [1..1] to I_MfgOrderCategory            as _MfgOrderCategory            on  $projection.ManufacturingOrderCategory = _MfgOrderCategory.ManufacturingOrderCategory
  association [1..1] to I_MfgOrderType                as _MfgOrderType                on  $projection.ManufacturingOrderType = _MfgOrderType.ManufacturingOrderType
  association [1..1] to I_OrdInternalBillOfOperations as _OrdInternalBillOfOperations on  $projection.OrderInternalBillOfOperations = _OrdInternalBillOfOperations.OrderInternalBillOfOperations
  association [0..1] to I_Language                    as _LongTextLanguage            on  $projection.LongTextLanguageCode = _LongTextLanguage.Language
  association [1..1] to I_UnitOfMeasure               as _ProductionUnit              on  $projection.ProductionUnit = _ProductionUnit.UnitOfMeasure
  association [1..1] to I_Plant                       as _Plant                       on  $projection.ProductionPlant = _Plant.Plant
  association [0..1] to I_Plant                       as _MRPPlant                    on  $projection.MRPPlant = _MRPPlant.Plant
  association [0..1] to I_MRPArea                     as _MRPArea                     on  $projection.MRPArea = _MRPArea.MRPArea
  association [0..1] to I_Material                    as _Material                    on  $projection.Material = _Material.Material
  association [0..1] to I_MaterialPlant               as _MaterialPlant               on  $projection.ProductionPlant = _MaterialPlant.Plant
                                                                                      and $projection.Material        = _MaterialPlant.Material
  association [0..1] to I_Product                     as _Product                     on  $projection.Material = _Product.Product
  association [0..1] to I_Material                    as _BillOfOperationsMaterial    on  $projection.BillOfOperationsMaterial = _BillOfOperationsMaterial.Material
  association [0..1] to I_SalesOrder                  as _SalesOrder                  on  $projection.SalesOrder = _SalesOrder.SalesOrder
  association [0..1] to I_SalesOrderItem              as _SalesOrderItem              on  $projection.SalesOrder     = _SalesOrderItem.SalesOrder
                                                                                      and $projection.SalesOrderItem = _SalesOrderItem.SalesOrderItem
  association [0..1] to I_SalesDocument               as _SalesDocument               on  $projection.SalesDocument = _SalesDocument.SalesDocument
  association [0..1] to I_SalesDocumentItem           as _SalesDocumentItem           on  $projection.SalesDocument     = _SalesDocumentItem.SalesDocument
                                                                                      and $projection.SalesDocumentItem = _SalesDocumentItem.SalesDocumentItem
  association [0..1] to I_WBSElementByInternalKey     as _WBSElement                  on  $projection.WBSElementInternalID = _WBSElement.WBSElementInternalID
  association [0..1] to I_ChangeMaster                as _ChangeNumber                on  $projection.ChangeNumber = _ChangeNumber.ChangeNumber
  association [0..1] to I_GLAccount                   as _GLAccount                   on  $projection.GLAccount   = _GLAccount.GLAccount
                                                                                      and $projection.CompanyCode = _GLAccount.CompanyCode
  association [0..1] to I_PlannedOrder                as _PlannedOrder                on  $projection.PlannedOrder = _PlannedOrder.PlannedOrder
  association [0..1] to I_MRPController               as _MRPController               on  $projection.MRPPlant      = _MRPController.Plant
                                                                                      and $projection.MRPController = _MRPController.MRPController
  association [0..1] to I_ProductionSupervisor        as _ProductionSupervisor        on  $projection.ProductionPlant      = _ProductionSupervisor.Plant
                                                                                      and $projection.ProductionSupervisor = _ProductionSupervisor.ProductionSupervisor
  association [0..1] to I_ProductionSchedulingProfile as _ProductionSchedulingProfile on  $projection.ProductionPlant             = _ProductionSchedulingProfile.Plant
                                                                                      and $projection.ProductionSchedulingProfile = _ProductionSchedulingProfile.ProductionSchedulingProfile
  association [0..1] to I_ResponsiblePlannerGroup     as _ResponsiblePlannerGroup     on  $projection.ProductionPlant         = _ResponsiblePlannerGroup.Plant
                                                                                      and $projection.ResponsiblePlannerGroup = _ResponsiblePlannerGroup.ResponsiblePlannerGroup
  association [0..1] to I_ProductionVersion           as _ProductionVersion           on  $projection.Material          = _ProductionVersion.Material
                                                                                      and $projection.ProductionPlant   = _ProductionVersion.Plant
                                                                                      and $projection.ProductionVersion = _ProductionVersion.ProductionVersion
  association [0..*] to I_MaterialBOM                 as _BillOfMaterial              on  $projection.BillOfMaterialVariantUsage = _BillOfMaterial.BillOfMaterialVariantUsage
                                                                                      and $projection.BillOfMaterial             = _BillOfMaterial.BillOfMaterial
                                                                                      and $projection.BillOfMaterialVariant      = _BillOfMaterial.BillOfMaterialVariant
                                                                                      and $projection.BillOfMaterialCategory     = _BillOfMaterial.BillOfMaterialCategory
                                                                                      and $projection.BillOfMaterialVersion      = _BillOfMaterial.BillOfMaterialVersion
  association [0..*] to I_ProdnProcgFlexibilityIndTxt as _ProdnProcgFlexibilityIndTxt on  $projection.ProdnProcgIsFlexible = _ProdnProcgFlexibilityIndTxt.ProdnProcgIsFlexible
{
      // Key
      @ObjectModel.text.element: 'ManufacturingOrderText'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key cast(aufv.OrderID as manufacturingorder preserving type)                         as ManufacturingOrder,

      // Category and Type
      @ObjectModel.foreignKey.association: '_MfgOrderCategory'
      cast(aufv.OrderCategory as manufacturingordercategory preserving type)           as ManufacturingOrderCategory,
      @ObjectModel.foreignKey.association: '_MfgOrderType'
      cast(aufv.OrderType     as manufacturingordertype     preserving type)           as ManufacturingOrderType,

      // Text
      @Semantics.text: true
      cast(aufv.OrderDescription as manufacturingordertext  preserving type)           as ManufacturingOrderText,
      // new logic: Since long text indicator does not contain X but the language code, this one is moved to
      // language field and longtext indicator is determined separately
      cast(case aufv.OrderHasLongText
            when '' then ''
            else 'X'
      end as aufltext preserving type)                                                 as ManufacturingOrderHasLongText,
      @ObjectModel.foreignKey.association: '_LongTextLanguage'
      cast(aufv.OrderHasLongText as pph_longtextlang)                                  as LongTextLanguageCode,

      // Attributes
      cast(aufv.PriorityCode as orderimportancecode preserving type)                   as ManufacturingOrderImportance,
      aufv.ProdnProcgIsFlexible                                                        as ProdnProcgIsFlexible,
      aufv.IsMarkedForDeletion                                                         as MfgOrderIsToBeDeleted,
      aufv.MfgOrderHasMultipleItems,
      aufv.MfgOrderIsPartOfCollvOrder,
      aufv.MfgOrderHierarchyLevel,
      afpo.IsCompletelyDelivered,
      aufv.OrderIsNotCostedAutomatically,
      aufv.OrdIsNotSchedldAutomatically,

      // Admin
      @Semantics.systemDate.createdAt: true
      cast(aufv.CreationDate as ordercreationdate preserving type)                     as MfgOrderCreationDate,
      @Semantics.systemTime.createdAt: true
      cast(aufv.CreationTime as ordercreationtime preserving type)                     as MfgOrderCreationTime,
      @Semantics.user.createdBy: true
      aufv.CreatedByUser,
      @Semantics.systemDate.lastChangedAt: true
      aufv.LastChangeDate,
      @Semantics.systemTime.lastChangedAt: true
      aufv.LastChangeTime,
      @Semantics.user.lastChangedBy: true
      aufv.LastChangedByUser,

      // Assignments
      @ObjectModel.foreignKey.association: '_OrdInternalBillOfOperations'
      cast(aufv.OrderInternalBillOfOperations as pph_aufpl preserving type)            as OrderInternalBillOfOperations,
--    @ObjectModel.foreignKey.association: '_ReferenceOrder'
      aufv.ReferenceOrder,
--    @ObjectModel.foreignKey.association: '_LeadingOrder'
      aufv.LeadingOrder,
--    @ObjectModel.foreignKey.association: '_SuperiorOrder'
      aufv.MfgOrderSuperiorMfgOrder,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_Currency'
      aufv.Currency,
      @ObjectModel.foreignKey.association: '_Plant'
      cast(aufv.Plant as pwwrk preserving type)                                        as ProductionPlant,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialStdVH', element: 'Material' } } ]
      @ObjectModel.foreignKey.association: '_Material'
      afpo.Material,
      @ObjectModel.foreignKey.association: '_MRPPlant'
      afpo.MRPPlant,
      @ObjectModel.foreignKey.association: '_MRPArea'
      afpo.MRPArea,
      @ObjectModel.foreignKey.association: '_MRPController'
      cast(aufv.MRPController               as pph_dispo   preserving type)            as MRPController,
      @ObjectModel.foreignKey.association: '_ProductionSupervisor'
      cast(aufv.ProductionSupervisor        as pph_fevor   preserving type)            as ProductionSupervisor,
      @ObjectModel.foreignKey.association: '_ProductionSchedulingProfile'
      cast(aufv.ProductionSchedulingProfile as pph_prodprf preserving type)            as ProductionSchedulingProfile,
      @ObjectModel.foreignKey.association: '_ResponsiblePlannerGroup'
      aufv.ResponsiblePlannerGroup,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductionVersionStdVH', element: 'ProductionVersion' } } ]
      @ObjectModel.foreignKey.association: '_ProductionVersion'
      afpo.ProductionVersion,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PlannedOrderStdVH', element: 'PlannedOrder' } } ]
      @ObjectModel.foreignKey.association: '_PlannedOrder'
      afpo.PlannedOrder,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesOrderStdVH', element: 'SalesOrder' } } ]
      @ObjectModel.foreignKey.association: '_SalesOrder'
      afpo.SalesOrder,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesOrderItemStdVH', element: 'SalesOrderItem' } } ]
      @ObjectModel.foreignKey.association: '_SalesOrderItem'
      afpo.SalesOrderItem,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesDocumentStdVH', element: 'SalesDocument' } } ]
      @ObjectModel.foreignKey.association: '_SalesDocument'
      cast(afpo.SalesOrder    as vdm_vbeln preserving type)                             as SalesDocument,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesDocumentItemStdVH', element: 'SalesDocumentItem' } } ]
      @ObjectModel.foreignKey.association: '_SalesDocumentItem'
      cast(afpo.SalesOrderItem  as vdm_posnr preserving type)                           as SalesDocumentItem,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_WBSElmntByIntKeyStdVH', element: 'WBSElementInternalID' } } ]
      @ObjectModel.foreignKey.association: '_WBSElement'
      afpo.WBSElementInternalID,
      @ObjectModel.foreignKey.association: '_Reservation'
      aufv.Reservation,
      @ObjectModel.foreignKey.association: '_SettlementReservation'
      cast(aufv.SettlementReservation  as settlmntres preserving type)                 as SettlementReservation,
      @ObjectModel.foreignKey.association: '_ConfirmationGroup'
      aufv.MfgOrderConfirmation,
      aufv.MfgOrderConfirmationCount,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CapacityRequirementStdVH', element: 'CapacityRequirement' } } ]
      @ObjectModel.foreignKey.association: '_CapacityRequirement'
      aufv.CapacityRequirement,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_InspectionLotStdVH', element: 'InspectionLot' } } ]
      @ObjectModel.foreignKey.association: '_InspectionLot'
      aufv.InspectionLot,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ChangeMasterStdVH', element: 'ChangeNumber' } } ]
      @ObjectModel.foreignKey.association: '_ChangeNumber'
      aufv.ChangeNumber,
      @ObjectModel.foreignKey.association: '_BasicSchedulingType'
      cast(aufv.BasicSchedulingType    as basicschedtype preserving type)              as BasicSchedulingType,
      @ObjectModel.foreignKey.association: '_ForecastSchedulingType'
      cast(aufv.ForecastSchedulingType as forecastschedtype preserving type)           as ForecastSchedulingType,
      cast(aufv.ObjectInternalID       as pph_objnr preserving type)                   as ManufacturingObject,
      cast(afpo.ProductConfiguration   as product_configuration preserving type)       as ProductConfiguration,
      afpo.EffectivityParameterVariant,
      afpo.SerialNumberAssgmtProfile,
      aufv.ConditionApplication,
      aufv.CapacityActiveVersion,
      aufv.CapacityRqmtHasNotToBeCreated,
      aufv.OrderSequenceNumber,
      afpo.Batch,
      afpo.StorageLocation,

      // Assignments BOO
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialStdVH', element: 'Material' } } ]
      @ObjectModel.foreignKey.association: '_BillOfOperationsMaterial'
      aufv.Material                                                                    as BillOfOperationsMaterial,
      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
      aufv.BillOfOperationsType,
      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
      @VDM.lifecycle.status: #DEPRECATED           // default data element change -> deprecated to avoid RTT2 error in ATC
      @VDM.lifecycle.successor: 'BillOfOperationsGroup'
      aufv.BillOfOperations,
      @ObjectModel.foreignKey.association: '_BillOfOperationsGroup2'
      aufv.BillOfOperationsGroup,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillOfOperationsStdVH', element: 'BillOfOperationsVariant' } } ]
      @ObjectModel.foreignKey.association: '_BillOfOperations'
      aufv.BillOfOperationsVariant,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BOOChgStateStdVH', element: 'BOOInternalVersionCounter' } } ]
      @ObjectModel.foreignKey.association: '_BillOfOperationsChangeState'
      aufv.BOOInternalVersionCounter,
      @ObjectModel.foreignKey.association: '_BillOfOperationsUsage'
      aufv.BillOfOperationsUsage,
      aufv.BillOfOperationsVersion,
      aufv.BOOExplosionDate,
      aufv.BOOValidityStartDate,

      // Assignments BOM
      aufv.BillOfMaterialCategory,
      aufv.BillOfMaterial,
      aufv.BillOfMaterialVariant,
      aufv.BillOfMaterialVariantUsage,
      aufv.BillOfMaterialVersion,
      aufv.BOMExplosionDate,
      aufv.BOMValidityStartDate,

      // Assignments FI/CO
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BusinessAreaStdVH', element: 'BusinessArea' } } ]
      @ObjectModel.foreignKey.association: '_BusinessArea'
      aufv.BusinessArea,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CompanyCodeStdVH', element: 'CompanyCode' } } ]
      @ObjectModel.foreignKey.association: '_CompanyCode'
      aufv.CompanyCode,
      @ObjectModel.foreignKey.association: '_ControllingArea'
      aufv.ControllingArea,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProfitCenterStdVH', element: 'ProfitCenter' } } ]
      aufv.ProfitCenter,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CostCenterStdVH', element: 'CostCenter' } } ]
      aufv.CostCenter,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CostCenterStdVH', element: 'CostCenter' } } ]
      aufv.ResponsibleCostCenter,
      aufv.CostElement,
      aufv.CostingSheet,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_GLAccountStdVH', element: 'GLAccount' } } ]
      @ObjectModel.foreignKey.association: '_GLAccount'
      aufv.GLAccount,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductCostCtrlgOrderStdVH', element: 'OrderID' } } ]
      @ObjectModel.foreignKey.association: '_ProductCostCollector'
      aufv.ProductCostCollector,
      aufv.ActualCostsCostingVariant,
      aufv.PlannedCostsCostingVariant,
      @ObjectModel.foreignKey.association: '_ControllingObjectClass'
      aufv.ControllingObjectClass,
      @ObjectModel.foreignKey.association: '_FunctionalArea'
      aufv.FunctionalArea,

      // Dates and Times
      cast(aufv.PlannedStartDate as mfgorderplannedstartdate preserving type)          as MfgOrderPlannedStartDate,
      cast(aufv.PlannedStartTime as mfgorderplannedstarttime preserving type)          as MfgOrderPlannedStartTime,
      cast(aufv.PlannedEndDate as mfgorderplannedenddate preserving type)              as MfgOrderPlannedEndDate,
      cast(aufv.PlannedEndTime as mfgorderplannedendtime preserving type)              as MfgOrderPlannedEndTime,
      cast(aufv.PlannedReleaseDate as mfgorderplannedreleasedate preserving type)      as MfgOrderPlannedReleaseDate,
      cast(aufv.ScheduledBasicStartDate as mfgorderscheduledstartdate preserving type) as MfgOrderScheduledStartDate,
      cast(aufv.ScheduledBasicStartTime as mfgorderscheduledstarttime preserving type) as MfgOrderScheduledStartTime,
      cast(aufv.ScheduledBasicEndDate as mfgorderscheduledenddate preserving type)     as MfgOrderScheduledEndDate,
      cast(aufv.ScheduledBasicEndTime as mfgorderscheduledendtime preserving type)     as MfgOrderScheduledEndTime,
      cast(aufv.ScheduledReleaseDate as mfgorderscheduledreleasedate preserving type)  as MfgOrderScheduledReleaseDate,
      cast(aufv.ActualStartDate as mfgorderactualstartdate preserving type)            as MfgOrderActualStartDate,
      cast(aufv.ActualStartTime as mfgorderactualstarttime preserving type)            as MfgOrderActualStartTime,
      cast(aufv.ActualEndDate as mfgorderactualenddate preserving type)                as MfgOrderActualEndDate,
      cast(aufv.ActualReleasedDate as mfgorderactualreleasedate preserving type)       as MfgOrderActualReleaseDate,
      cast(aufv.ConfirmedEndDate as mfgorderconfirmedenddate preserving type)          as MfgOrderConfirmedEndDate,
      cast(aufv.ConfirmedEndTime as mfgorderconfirmedendtime preserving type)          as MfgOrderConfirmedEndTime,
      aufv.TotalCommitmentDate                                                         as MfgOrderTotalCommitmentDate,
      afpo.ActualDeliveryDate                                                          as MfgOrderItemActualDeliveryDate,

      // Quantities and UoM
      @Semantics.unitOfMeasure: true
      cast(aufv.BaseUnit as productionunit preserving type)                            as ProductionUnit,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @DefaultAggregation: #NONE
      cast(aufv.OrderPlannedTotalQty as mfgorderplannedtotalqty preserving type)       as MfgOrderPlannedTotalQty,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @DefaultAggregation: #NONE
      cast(aufv.OrderPlannedScrapQty as mfgorderplannedscrapqty preserving type)       as MfgOrderPlannedScrapQty,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @DefaultAggregation: #NONE
      cast(aufv.OrderConfirmedYieldQty as co_igmng preserving type)                    as MfgOrderConfirmedYieldQty,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @DefaultAggregation: #NONE
      cast(aufv.OrderConfirmedScrapQty as co_iasmg preserving type)                    as MfgOrderConfirmedScrapQty,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @DefaultAggregation: #NONE
      aufv.MfgOrderConfirmedReworkQty,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @DefaultAggregation: #NONE
      cast(afpo.MfgOrderItemActualDeviationQty as co_mimez preserving type)            as ExpectedDeviationQuantity,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      @DefaultAggregation: #NONE
      afpo.MfgOrderItemGoodsReceiptQty                                                 as ActualDeliveredQuantity,

      // Fashion Manufacturing Fields      
      aufv.MasterProductionOrder,
      afpo.ProductSeasonYear,
      afpo.ProductSeason,
      afpo.ProductCollection,
      afpo.ProductTheme,
      // Segmentation
      afpo.StockSegment,
      
      // Associations
      _MfgOrderCategory,
      _MfgOrderType,
      _OrderTypeDetails,
      _CreatedByUser,
      _LastChangedByUser,
      _LongTextLanguage,
      _ProductionUnit,
      _Currency,
      _OrdInternalBillOfOperations,
      _BillOfMaterial,
      _BillOfOperationsMaterial,
      _BillOfOperationsType,
      _BillOfOperationsGroup,
      _BillOfOperationsGroup2,
      _BillOfOperations,
      _BillOfOperationsChangeState,
      _BillOfOperationsUsage,
      _ConfirmationGroup,
      _Reservation,
      aufv._SettlementReservation,
      _Plant,
      _Material,
      _MaterialPlant,
      _Product,
      _MRPArea,
      _MRPPlant,
      _MRPController,
      _ProductionSupervisor,
      _ProductionSchedulingProfile,
      _ResponsiblePlannerGroup,
      _ProductionVersion,
      _CapacityRequirement,
      _ChangeNumber,
      _InspectionLot,
      _PlannedOrder,
      _SalesOrder,
      _SalesOrderItem,
      _SalesDocument,
      _SalesDocumentItem,
      _WBSElement,
      aufv._BusinessArea,
      _ProfitCenter,
      _CostCenter,
      _ResponsibleCostCenter,
      _CompanyCode,
      _ControllingArea,
      _ControllingObjectClass,
      _FunctionalArea,
      _GLAccount,
      _ProductCostCollector,
      _BasicSchedulingType,
      _ForecastSchedulingType,
      _ProdnProcgFlexibilityIndTxt
}
where ( aufv.OrderCategory = '10' or
        aufv.OrderCategory = '40' ); //Manufacturing orders only
