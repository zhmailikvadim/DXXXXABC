// Product Sales Delivery (active)
@AbapCatalog.sqlViewName: 'IPRDSALESDELIV'
@AbapCatalog.preserveKey: true
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Sales Delivery'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.representativeKey: 'Product'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.compiler.compareFilter:true
@Analytics.dataCategory: #DIMENSION
@Analytics.dataExtraction: {
        enabled: true,
        delta.changeDataCapture:{
        mapping: [{
                     table: 'MVKE',
                     role: #MAIN,
                     viewElement: ['Product','ProductSalesOrg','ProductDistributionChnl'],
                     tableElement: ['MATNR','VKORG','VTWEG']
                  },
                  {
                     table: 'MARA',
                     role: #LEFT_OUTER_TO_ONE_JOIN,
                     viewElement: ['Product'],
                     tableElement: ['MATNR']
                  }]
                }
              }
@Metadata.allowExtensions: true
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #ANALYTICAL_DIMENSION,
                                      #EXTRACTION_DATA_SOURCE
]

define view I_ProductSalesDelivery
  as select from mvke

  association [1..1] to I_Product                      as _Product                       on  $projection.Product = _Product.Product
  association [1..1] to I_SalesOrganization            as _SalesOrganization             on  $projection.ProductSalesOrg = _SalesOrganization.SalesOrganization
  association [1..1] to I_DistributionChannel          as _DistributionChannel           on  $projection.ProductDistributionChnl = _DistributionChannel.DistributionChannel

  association [0..1] to I_MaterialPricingGroup         as _MaterialPricingGroup          on  $projection.PriceSpecificationProductGroup = _MaterialPricingGroup.MaterialPricingGroup
  association [0..*] to I_MaterialPricingGroupText     as _MaterialPricingGroupText      on  $projection.PriceSpecificationProductGroup = _MaterialPricingGroupText.MaterialPricingGroup

  association [0..1] to E_Productsalesdelivery         as _ProdSalesDeliveryExt          on  mvke.matnr                          = _ProdSalesDeliveryExt.Product
                                                                                         and $projection.ProductSalesOrg         = _ProdSalesDeliveryExt.ProductSalesOrganization
                                                                                         and $projection.ProductDistributionChnl = _ProdSalesDeliveryExt.ProductDistributionChannel

  association [0..1] to I_ItemCategoryGroup            as _ItemCategoryGroup             on  $projection.ItemCategoryGroup = _ItemCategoryGroup.ItemCategoryGroup
  association [0..*] to I_ItemCategoryGroupText        as _ItemCategoryGroupText         on  $projection.ItemCategoryGroup = _ItemCategoryGroupText.ItemCategoryGroup

  association [0..1] to I_AssortmentGrade              as _AssortmentGrade               on  $projection.AssortmentGrade = _AssortmentGrade.AssortmentGrade
  association [0..*] to I_AssortmentGradeT             as _AssortmentGradeT              on  $projection.AssortmentGrade = _AssortmentGradeT.AssortmentGrade

  association [0..1] to I_ProdExtAsstmtPriority        as _ProdExtAssortmentPriority     on  $projection.ProdExtAssortmentPriority = _ProdExtAssortmentPriority.ProdExtAssortmentPriority
  association [0..*] to I_ProdExtAsstmtPriorityTxt     as _ProdExtAssortmentPriorityText on  $projection.ProdExtAssortmentPriority = _ProdExtAssortmentPriorityText.ProdExtAssortmentPriority

  association [0..1] to I_MaterialCommissionGroup      as _ProductCommissionGroup        on  $projection.ProductCommissionGroup = _ProductCommissionGroup.MaterialCommissionGroup
  association [0..*] to I_MaterialCommissionGroupText  as _ProductCommissionGroupText    on  $projection.ProductCommissionGroup = _ProductCommissionGroupText.MaterialCommissionGroup

  association [0..1] to I_SalesDistributionStatusVH    as _ProductSalesStatus            on  $projection.ProductSalesStatus = _ProductSalesStatus.ProductSalesStatus
  association [0..*] to I_SalesDistributionStatusText  as _ProductSalesStatusText        on  $projection.ProductSalesStatus = _ProductSalesStatusText.ProductSalesStatus

  association [0..1] to I_UnitOfMeasure                as _DeliveryQuantityUnit          on  $projection.DeliveryQuantityUnit = _DeliveryQuantityUnit.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _DeliveryQuantityUnitText      on  $projection.DeliveryQuantityUnit = _DeliveryQuantityUnitText.UnitOfMeasure

  association [0..1] to I_UnitOfMeasure                as _SalesUnit                     on  $projection.SalesMeasureUnit = _SalesUnit.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _SalesUnitText                 on  $projection.SalesMeasureUnit = _SalesUnitText.UnitOfMeasure
  association [0..*] to I_SalesOrganizationText        as _SalesOrganizationText         on  $projection.ProductSalesOrg = _SalesOrganizationText.SalesOrganization

  association [0..1] to I_ListingProcedure             as _StoreListingProcedure         on  $projection.StoreListingProcedure = _StoreListingProcedure.StoreListingProcedure
  association [0..*] to I_ListingProcedureT            as _StoreListingProcedureT        on  $projection.StoreListingProcedure = _StoreListingProcedureT.StoreListingProcedure

  association [0..1] to I_ListingProcedure             as _DistrCntrListingProcedure     on  $projection.DistrCntrListingProcedure = _DistrCntrListingProcedure.StoreListingProcedure
  association [0..*] to I_ListingProcedureT            as _DistrCntrListingProcedureT    on  $projection.DistrCntrListingProcedure = _DistrCntrListingProcedureT.StoreListingProcedure

  association [0..1] to I_MatlAccountAssignmentGroup   as _MatlAccountAssignmentGroup    on  $projection.AccountDetnProductGroup = _MatlAccountAssignmentGroup.MatlAccountAssignmentGroup
  association [0..*] to I_MatlAccountAssignmentGroupT  as _MatlAccountAssignmentGroupT   on  $projection.AccountDetnProductGroup = _MatlAccountAssignmentGroupT.MatlAccountAssignmentGroup

  association [0..1] to I_PriceFixingCategory          as _PriceFixingCategory           on  $projection.PriceFixingCategory = _PriceFixingCategory.PriceFixingCategory
  association [0..*] to I_PriceFixingCategoryText      as _PriceFixingCategoryText       on  $projection.PriceFixingCategory = _PriceFixingCategoryText.PriceFixingCategory

  association [0..1] to I_CompetitionPressureCategory  as _CompetitionPressureCategory   on  $projection.CompetitionPressureCategory = _CompetitionPressureCategory.CompetitionPressureCategory
  association [0..*] to I_CompetitionPressureCategoryT as _CompetitionPressureCategoryT  on  $projection.CompetitionPressureCategory = _CompetitionPressureCategoryT.CompetitionPressureCategory

  association [0..1] to I_MaterialStatisticsGroup      as _MaterialStatisticsGroup       on  $projection.LogisticsStatisticsGroup = _MaterialStatisticsGroup.MaterialStatisticsGroup
  association [0..*] to I_MaterialStatisticsGroupText  as _MaterialStatisticsGroupText   on  $projection.LogisticsStatisticsGroup = _MaterialStatisticsGroupText.MaterialStatisticsGroup

  //association [0..1] to I_LogisticalRoundingProfile    as _LogisticalRoundingProfile     on  $projection.SupplyingPlant  = _LogisticalRoundingProfile.Plant
  //                                                                                     and $projection.RoundingProfile = _LogisticalRoundingProfile.LogisticalRoundingProfile

  //association [0..*] to I_LogisticalRoundingProfileT   as _LogisticalRoundingProfileT    on  $projection.SupplyingPlant  = _LogisticalRoundingProfileT.Plant
  //                                                                                   and $projection.RoundingProfile = _LogisticalRoundingProfileT.LogisticalRoundingProfile
{
      @ObjectModel.foreignKey.association: '_Product'
  key cast (mvke.matnr  as productnumber preserving type )                      as Product,
      @ObjectModel.foreignKey.association: '_SalesOrganization'
      @ObjectModel.text.association: '_SalesOrganizationText'
  key mvke.vkorg                                                                as ProductSalesOrg,
      @ObjectModel.foreignKey.association: '_DistributionChannel'
  key mvke.vtweg                                                                as ProductDistributionChnl,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      mvke.aumng                                                                as MinimumOrderQuantity,
      mvke.dwerk                                                                as SupplyingPlant,

      @ObjectModel.foreignKey.association:'_MaterialPricingGroup'
      @ObjectModel.text.association: '_MaterialPricingGroupText'
      cast (mvke.kondm      as pricespecificationproductgroup preserving type ) as PriceSpecificationProductGroup,
      @ObjectModel.foreignKey.association:'_MatlAccountAssignmentGroup'
      @ObjectModel.text.association: '_MatlAccountAssignmentGroupT'
      mvke.ktgrm                                                                as AccountDetnProductGroup,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      mvke.lfmng                                                                as DeliveryNoteProcMinDelivQty,
      @ObjectModel.foreignKey.association: '_ItemCategoryGroup'
      @ObjectModel.text.association: '_ItemCategoryGroupText'
      mvke.mtpos                                                                as ItemCategoryGroup,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_DeliveryQuantityUnit'
      @ObjectModel.text.association: '_DeliveryQuantityUnitText'
      mvke.schme                                                                as DeliveryQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      mvke.scmng                                                                as DeliveryQuantity,
      @ObjectModel.foreignKey.association: '_ProductSalesStatus'
      @ObjectModel.text.association: '_ProductSalesStatusText'
      mvke.vmsta                                                                as ProductSalesStatus,
      mvke.vmstd                                                                as ProductSalesStatusValidityDate,
      @ObjectModel.foreignKey.association: '_SalesUnit'
      @ObjectModel.text.association: '_SalesUnitText'
      mvke.vrkme                                                                as SalesMeasureUnit,
      mvke.lvorm                                                                as IsMarkedForDeletion,
      -- New Fields
      mvke.prodh                                                                as ProductHierarchy,
      cast (mvke.mvgr1      as firstsalesspecproductgroup preserving type )     as FirstSalesSpecProductGroup,
      cast (mvke.mvgr2      as secondsalesspecproductgroup preserving type )    as SecondSalesSpecProductGroup,
      cast (mvke.mvgr3      as thirdsalesspecproductgroup preserving type )     as ThirdSalesSpecProductGroup,
      cast (mvke.mvgr4      as fourthsalesspecproductgroup preserving type )    as FourthSalesSpecProductGroup,
      cast (mvke.mvgr5      as fifthsalesspecproductgroup preserving type )     as FifthSalesSpecProductGroup,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      mvke.efmng                                                                as MinimumMakeToOrderOrderQty,

      //RETAIL FIELDS ADDED ON 25.4.16
      @ObjectModel.foreignKey.association: '_MaterialStatisticsGroup'
      @ObjectModel.text.association: '_MaterialStatisticsGroupText'
      mvke.versg                                                                as LogisticsStatisticsGroup,
      mvke.bonus                                                                as VolumeRebateGroup,
      @ObjectModel.foreignKey.association:'_ProductCommissionGroup'
      @ObjectModel.text.association: '_ProductCommissionGroupText'
      mvke.provg                                                                as ProductCommissionGroup,
      mvke.sktof                                                                as CashDiscountIsDeductible,
      mvke.pmatn                                                                as PricingReferenceProduct,
      @ObjectModel.foreignKey.association: '_AssortmentGrade'
      @ObjectModel.text.association: '_AssortmentGradeT'
      mvke.sstuf                                                                as AssortmentGrade,
      @ObjectModel.foreignKey.association: '_StoreListingProcedure'
      @ObjectModel.text.association: '_StoreListingProcedureT'
      mvke.lstfl                                                                as StoreListingProcedure,
      @ObjectModel.foreignKey.association: '_DistrCntrListingProcedure'
      @ObjectModel.text.association: '_DistrCntrListingProcedureT'
      mvke.lstvz                                                                as DistrCntrListingProcedure,
      cast(mvke.ldvfl  as storelistingstartdate )                               as StoreListingStartDate,
      cast(mvke.ldbfl as storelistingenddate )                                  as StoreListingEndDate,
      cast(mvke.ldvzl as distrcntrlistingstartdate  )                           as DistrCntrListingStartDate,
      cast(mvke.ldbzl as  distrcntrlistingenddate )                             as DistrCntrListingEndDate,
      cast (mvke.vdvfl as  storesalestartdate )                                 as StoreSaleStartDate,
      cast(mvke.vdbfl as  storesaleenddate  )                                   as StoreSaleEndDate,
      cast (mvke.vdvzl as  distrcntrsalestartdate )                             as DistrCntrSaleStartDate,
      cast(mvke.vdbzl as  distrcntrsaleenddate )                                as DistrCntrSaleEndDate,
      //@ObjectModel.foreignKey.association: '_LogisticalRoundingProfile'
      //@ObjectModel.text.association:'_LogisticalRoundingProfileT'
      mvke.rdprf                                                                as RoundingProfile,
      mvke.megru                                                                as ProductUnitGroup,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      mvke.lfmax                                                                as MaxDeliveryQtyStoreOrder,
      @ObjectModel.foreignKey.association: '_PriceFixingCategory'
      @ObjectModel.text.association: '_PriceFixingCategoryText'
      mvke.pbind                                                                as PriceFixingCategory,
      mvke.vavme                                                                as VariableSalesUnitIsNotAllowed,
      @ObjectModel.foreignKey.association: '_CompetitionPressureCategory'
      @ObjectModel.text.association: '_CompetitionPressureCategoryT'
      mvke.matkc                                                                as CompetitionPressureCategory,
      cast( mvke.prat1 as producthasattributeid01 preserving type )             as ProductHasAttributeID01,
      cast( mvke.prat2 as producthasattributeid02 preserving type )             as ProductHasAttributeID02,
      cast( mvke.prat3 as producthasattributeid03 preserving type )             as ProductHasAttributeID03,
      cast( mvke.prat4 as producthasattributeid04 preserving type )             as ProductHasAttributeID04,
      cast( mvke.prat5 as producthasattributeid05 preserving type )             as ProductHasAttributeID05,
      cast( mvke.prat6 as producthasattributeid06 preserving type )             as ProductHasAttributeID06,
      cast( mvke.prat7 as producthasattributeid07 preserving type )             as ProductHasAttributeID07,
      cast( mvke.prat8 as producthasattributeid08 preserving type )             as ProductHasAttributeID08,
      cast( mvke.prat9 as producthasattributeid09 preserving type )             as ProductHasAttributeID09,
      cast( mvke.prata as producthasattributeid10 preserving type )             as ProductHasAttributeID10,
      cast( 'X' as sdraft_is_active preserving type )                           as IsActiveEntity, // to enbale extensibility in Draft 2.0
      @ObjectModel.foreignKey.association: '_ProdExtAssortmentPriority'
      @ObjectModel.text.association: '_ProdExtAssortmentPriorityText'
      mvke.pflks                                                                as ProdExtAssortmentPriority,
      mvke.is_entlmnt_rlvt                                                      as ProdIsEntlmntRlvt,      
      @Semantics.unitOfMeasure: true
      _Product.BaseUnit,
      _Product,
      _SalesOrganization,
      _DistributionChannel,
      _ItemCategoryGroup,
      _ItemCategoryGroupText,
      _ProdExtAssortmentPriority,
      _ProdExtAssortmentPriorityText,
      _MaterialPricingGroup,
      _MaterialPricingGroupText,
      _ProductCommissionGroup,
      _ProductCommissionGroupText,
      _ProductSalesStatus,
      _ProductSalesStatusText,
      _DeliveryQuantityUnit,
      _DeliveryQuantityUnitText,
      _SalesUnit,
      _SalesUnitText,
      _SalesOrganizationText,
      _DistrCntrListingProcedure,
      _DistrCntrListingProcedureT,
      _StoreListingProcedure,
      _StoreListingProcedureT,
      _AssortmentGrade,
      _AssortmentGradeT,
      _MatlAccountAssignmentGroup,
      _MatlAccountAssignmentGroupT,
      _PriceFixingCategory,
      _PriceFixingCategoryText,
      _CompetitionPressureCategory,
      _CompetitionPressureCategoryT,
      _MaterialStatisticsGroup,
      _MaterialStatisticsGroupText
      //_LogisticalRoundingProfile,
      //_LogisticalRoundingProfileT

}
