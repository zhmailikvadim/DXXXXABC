@AbapCatalog.sqlViewName: 'IPRDPLANT'
@VDM:{
    viewType: #BASIC,
    lifecycle: {
      status: #DEPRECATED,
      successor: 'I_ProductPlantBasic'
 }}
@EndUserText.label: 'Product Plant'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl: {
    authorizationCheck: #CHECK,
    privilegedAssociations: [ '_MRPController' ]
}
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations:true
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET
]

define view I_ProductPlant
  as select from nsdm_e_marc as Plant

  association [1..1] to I_Product                      as _Product                      on  $projection.Product = _Product.Product
  association [0..1] to I_MRPController                as _MRPController                on  $projection.Plant          = _MRPController.Plant
                                                                                        and $projection.MRPResponsible = _MRPController.MRPController

  association [0..1] to I_ProductStatus                as _ProductStatus                on  $projection.ProfileCode = _ProductStatus.Status
  association [0..*] to I_ProductStatusText            as _ProductStatusText            on  $projection.ProfileCode = _ProductStatusText.Status
  association [0..1] to I_UnitOfMeasure                as _GoodsIssueUnit               on  $projection.GoodsIssueUnit = _GoodsIssueUnit.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _UnitOfMeasureText            on  $projection.GoodsIssueUnit = _UnitOfMeasureText.UnitOfMeasure
  association [0..1] to I_FiscalYearVariant            as _FiscalYearVariant            on  $projection.FiscalYearVariant = _FiscalYearVariant.FiscalYearVariant
  association [0..*] to I_FiscalYearVariantText        as _FiscalYearVariantDescription on  $projection.FiscalYearVariant = _FiscalYearVariantDescription.FiscalYearVariant

  association [0..1] to I_Product                      as _ConfigurableProduct          on  $projection.ConfigurableProduct = _ConfigurableProduct.Product
  association [0..*] to I_ProductDescription           as _ConfigurableProductName      on  $projection.ConfigurableProduct = _ConfigurableProductName.Product

  association [0..*] to I_ProductDescription           as _Text                         on  $projection.Product = _Text.Product
  association [0..1] to I_Prodabclassfctn              as _ABCIndicator                 on  $projection.ABCIndicator = _ABCIndicator.MaterialABCClassification
  association [0..*] to I_Prodabclassfctntxt           as _ABCIndicatorDesc             on  $projection.ABCIndicator = _ABCIndicatorDesc.MaterialABCClassification

  association [0..1] to I_ProductDistributionProfile   as _DistributionProfile          on  $projection.DistrCntrDistributionProfile = _DistributionProfile.ProductDistributionProfile
  association [0..*] to I_ProductDistributionProfileT  as _DistributionProfileText      on  $projection.DistrCntrDistributionProfile = _DistributionProfileText.ProductDistributionProfile

  association [1..1] to I_Plant                        as _Plant                        on  $projection.Plant = _Plant.Plant
  association [0..1] to I_Site                         as _Site                         on  $projection.Plant = _Site.Site
  association [0..1] to I_MRPType                      as _MRPType                      on  $projection.MRPType = _MRPType.MRPType
  association [0..1] to I_SourceOfSupplyCategory       as _SourceOfSupplyCategory       on  $projection.SourceOfSupplyCategory = _SourceOfSupplyCategory.SourceOfSupplyCategory
  association [0..1] to I_PurchasingGroup              as _PurchasingGroup              on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup


  association [0..1] to I_ProductWorkScheduling        as _GoodsMovementQuantity        on  $projection.Product = _GoodsMovementQuantity.Product
                                                                                        and $projection.Plant   = _GoodsMovementQuantity.Plant

  association [0..1] to I_Productplantprocurement      as _PlantProcurement             on  $projection.Product = _PlantProcurement.Product
                                                                                        and $projection.Plant   = _PlantProcurement.Plant

  association [0..1] to I_ProductPlantIntlTrd          as _ProdPlantInternationalTrade  on  $projection.Product = _ProdPlantInternationalTrade.Product
                                                                                        and $projection.Plant   = _ProdPlantInternationalTrade.Plant

  association [0..1] to I_ProductPlantCosting          as _ProductPlantCosting          on  $projection.Product = _ProductPlantCosting.Product
                                                                                        and $projection.Plant   = _ProductPlantCosting.Plant

  association [0..1] to I_ProductPlantForecast         as _ProductPlantForecast         on  $projection.Product = _ProductPlantForecast.Product
                                                                                        and $projection.Plant   = _ProductPlantForecast.Plant

  association [0..1] to I_Productplantqtmanagement     as _PlantQualityMgmt             on  $projection.Product = _PlantQualityMgmt.Product
                                                                                        and $projection.Plant   = _PlantQualityMgmt.Plant

  association [0..1] to I_Productplantsales            as _PlantSales                   on  $projection.Product = _PlantSales.Product
                                                                                        and $projection.Plant   = _PlantSales.Plant

  association [1..1] to I_ProductSupplyPlanning        as _MaterialLotSizingProcedure   on  $projection.Product = _MaterialLotSizingProcedure.Product
                                                                                        and $projection.Plant   = _MaterialLotSizingProcedure.Plant



  association [0..1] to E_Productplant                 as _ProductPlantExt              on  $projection.Product = _ProductPlantExt.Product
                                                                                        and $projection.Plant   = _ProductPlantExt.Plant

  association [0..*] to I_MaterialStock                as _Stock                        on  $projection.Product = _Stock.Material
                                                                                        and $projection.Plant   = _Stock.Plant

  //Start: enterprise search help (ESH) related associations------------------------------------------------------------------------------------
  //These associations are required in I_ProductPlant as N_ProductPlant has these associations
  //There can be no associations in N_ProductPlant which are not present in I_ProductPlant
  association [0..*] to I_CountryText                  as _CountryOfOriginText          on  $projection.CountryOfOrigin = _CountryOfOriginText.Country
  association [0..*] to I_RegionText                   as _RegionText                   on  $projection.CountryOfOrigin = _RegionText.Country
  association [0..*] to I_ProductStorageLocation       as _ProductStorageLocation       on  $projection.Product = _ProductStorageLocation.Product
                                                                                        and $projection.Plant   = _ProductStorageLocation.Plant

  //End of ESH related associations-------------------------------------------------------------------------------------------------------------

  association [0..1] to I_StockDeterminationGroup      as _StockDeterminationGroup      on  $projection.Plant                   = _StockDeterminationGroup.Plant
                                                                                        and $projection.StockDeterminationGroup = _StockDeterminationGroup.StockDeterminationGroup

  association [0..*] to I_StockDeterminationGroupText  as _StockDeterminationGroupT     on  $projection.Plant                   = _StockDeterminationGroupT.Plant
                                                                                        and $projection.StockDeterminationGroup = _StockDeterminationGroupT.StockDeterminationGroup

  association [0..1] to I_BR_CFOPCategory              as _ProductCFOPCategory          on  $projection.ProductCFOPCategory = _ProductCFOPCategory.BR_CFOPCategory
  association [0..*] to I_BR_CFOPCategoryText          as _CFOPDesc                     on  $projection.ProductCFOPCategory = _CFOPDesc.BR_CFOPCategory

  association [0..1] to I_ProductConsumptionPeriod     as _PeriodType                   on  $projection.PeriodType = _PeriodType.PeriodType
  association [0..*] to I_ProductConsumptionPeriodText as _PeriodTypeText               on  $projection.PeriodType = _PeriodTypeText.PeriodType


  association [0..1] to I_ProductPlantESPP             as _PlantESPP                    on  $projection.Product = _PlantESPP.Product
                                                                                        and $projection.Plant   = _PlantESPP.Plant


{
  key    Plant.matnr                                      as Product,
         @ObjectModel.foreignKey.association: '_Plant'
  key    Plant.werks                                      as Plant,
         @ObjectModel.foreignKey.association: '_PurchasingGroup'
         Plant.ekgrp                                      as PurchasingGroup,
         Plant.herkl                                      as CountryOfOrigin,
         Plant.herkr                                      as RegionOfOrigin,

         Plant.lgpro                                      as ProductionInvtryManagedLoc,


         @ObjectModel : {
            foreignKey.association: '_ProductStatus',
            text.association: '_ProductStatusText'
         }
         Plant.mmsta                                      as ProfileCode,
         Plant.mmstd                                      as ProfileValidityStartDate,
         Plant.mtvfp                                      as AvailabilityCheckType,

         @ObjectModel:{
          foreignKey.association: '_FiscalYearVariant',
          text.association: '_FiscalYearVariantDescription'
         }
         Plant.periv                                      as FiscalYearVariant,
         @ObjectModel.foreignKey.association: '_PeriodType'
         @ObjectModel.text.association: '_PeriodTypeText'
         Plant.perkz                                      as PeriodType,

         Plant.prctr                                      as ProfitCenter,

         cast (Plant.stawn as stawn)                      as Commodity,
         Plant.webaz                                      as GoodsReceiptDuration,
         Plant.pstat                                      as MaintenanceStatusName,
         Plant.lvorm                                      as IsMarkedForDeletion,


         @ObjectModel.foreignKey.association: '_MRPType'
         Plant.dismm                                      as MRPType,
         @ObjectModel.foreignKey.association: '_MRPController'
         Plant.dispo                                      as MRPResponsible,
         Plant.maabc                                      as ABCIndicator,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         Plant.bstmi                                      as MinimumLotSizeQuantity,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         Plant.bstma                                      as MaximumLotSizeQuantity,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         Plant.bstfe                                      as FixedLotSizeQuantity,


         Plant.steuc                                      as ConsumptionTaxCtrlCode,
         Plant.kzkup                                      as IsCoProduct,

         cast (Plant.stdpd as configurableproduct )       as ProductIsConfigurable,
         //--[ GENERATED:012:29JlHNUf7jY4nhtQM3fYJ0
         @Consumption.valueHelpDefinition: [
           { entity:  { name:    'I_ProductStdVH',
                        element: 'Product' }
           }]
         // ]--GENERATED
         @ObjectModel:{
           foreignKey.association: '_ConfigurableProduct',
           text.association: '_ConfigurableProductName'
         }
         Plant.stdpd                                      as ConfigurableProduct,
         @ObjectModel.foreignKey.association: '_StockDeterminationGroup'
         @ObjectModel.text.association: '_StockDeterminationGroupT'
         Plant.eprio                                      as StockDeterminationGroup,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         Plant.umlmc                                      as StockInTransferQuantity,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         Plant.trame                                      as StockInTransitQuantity,

         cast (Plant.insmk  as hasposttoinspectionstock ) as HasPostToInspectionStock,
         Plant.xchpf                                      as IsBatchManagementRequired,

         Plant.sernp                                      as SerialNumberProfile,
         Plant.xmcng                                      as IsNegativeStockAllowed,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         Plant.bwesb                                      as GoodsReceiptBlockedStockQty,

         Plant.cons_procg                                 as HasConsignmentCtrl,
         //Plant.glgmg                    as TiedEmptiesStockQuantity,

         Plant.lfgja                                      as FiscalYearCurrentPeriod,
         Plant.lfmon                                      as FiscalMonthCurrentPeriod,
         Plant.multiple_ekgrp                             as IsPurgAcrossPurgGroup,
         Plant.xchar                                      as IsInternalBatchManaged,
         @ObjectModel.foreignKey.association: '_ProductCFOPCategory'
         @ObjectModel.text.association: '_CFOPDesc'
         Plant.indus                                      as ProductCFOPCategory,

         //Excise Tax Relevance Indicator "15.4.2019
         Plant.excise_tax_rlvnce                          as ProductIsExciseTaxRelevant,

         -- Added on 21.4.16 not relevent for Product master

         Plant.uneto                                      as UnderDelivToleranceLimit,
         Plant.ueeto                                      as OverDelivToleranceLimit,
         Plant.beskz                                      as ProcurementType,
         Plant.sobsl                                      as SpecialProcurementType,
         Plant.sfcpf                                      as ProductionSchedulingProfile,
         Plant.fevor                                      as ProductionSupervisor,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         Plant.eisbe                                      as SafetyStockQuantity,
         //
         //         --Retail fields Addd on 21.4.16

         @Semantics.unitOfMeasure: true
         @ObjectModel.foreignKey.association: '_GoodsIssueUnit'
         @ObjectModel.text.association: '_UnitOfMeasureText'
         Plant.ausme                                      as GoodsIssueUnit,
         @ObjectModel.foreignKey.association: '_SourceOfSupplyCategory'
         Plant.bwscl                                      as SourceOfSupplyCategory,
         Plant.vrbmt                                      as ConsumptionReferenceProduct,
         Plant.vrbwk                                      as ConsumptionReferencePlant,
         Plant.vrbdt                                      as ConsumptionRefUsageEndDate,
         Plant.vrbfk                                      as ConsumptionQtyMultiplier,
         Plant.megru                                      as ProductUnitGroup,
         @ObjectModel.foreignKey.association: '_DistributionProfile'
         @ObjectModel.text.association: '_DistributionProfileText'
         Plant.fprfm                                      as DistrCntrDistributionProfile,
         Plant.cons_procg                                 as ConsignmentControl,
         Plant.gi_pr_time                                 as GoodIssueProcessingDays,
         Plant.plifz                                      as PlannedDeliveryDurationInDays,
         cast( 'X' as sdraft_is_active preserving type )  as IsActiveEntity, // to enbale extensibility in Draft 2.0

         // New fields from MDG model, as part of unified API development
         Plant.kzkri                                      as ProductIsCriticalPrt,
         Plant.loggr                                      as ProductLogisticsHandlingGroup,
         Plant.mfrgr                                      as MaterialFreightGroup,
         Plant.ucmat                                      as OriginalBatchReferenceMaterial,
         Plant.uchkz                                      as OriglBatchManagementIsRequired,
         // added on CRM request
         Plant.cuobj                                      as ProductConfiguration,

         @Semantics.unitOfMeasure: true
         _Product.BaseUnit                                as BaseUnit,
         /*,_PlantText,
          _MRPTypeText,
          _SrlNmbPrfText*/
         _Product,
         _Plant,
         _Site,
         _MRPController,
         _MRPType,
         _SourceOfSupplyCategory,
         _PurchasingGroup,
         _Text,
         _ABCIndicator,
         _ABCIndicatorDesc,
         _GoodsMovementQuantity,
         _PlantProcurement,
         _ProdPlantInternationalTrade,
         _ProductPlantCosting,
         _ProductPlantForecast,
         _PlantQualityMgmt,
         _PlantSales,
         _MaterialLotSizingProcedure,
         _GoodsIssueUnit,
         _UnitOfMeasureText,
         _ProductStatus,
         _ProductStatusText,
         _FiscalYearVariant,
         _FiscalYearVariantDescription,
         _ConfigurableProduct,
         _ConfigurableProductName,
         _Stock,
         _DistributionProfile,
         _DistributionProfileText,

         //Start of ESH related associations---------------------------
         _CountryOfOriginText,
         _RegionText,
         _ProductStorageLocation,
         //End of ESH related associations------------------------------
         _StockDeterminationGroup,
         _StockDeterminationGroupT,
         _ProductCFOPCategory,
         _CFOPDesc,
         _PeriodType,
         _PeriodTypeText,
         _PlantESPP
}
