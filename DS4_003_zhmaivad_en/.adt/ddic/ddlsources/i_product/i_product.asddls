// active core entity
@AbapCatalog: {
  sqlViewName: 'IPRODUCT',
  preserveKey: true
}
@VDM.viewType: #BASIC

@AccessControl: {
  authorizationCheck: #CHECK,
//As I_TextObjectPlainLongText has a DCL0,
//the following annotation is required for enterprise search "Products"
  privilegedAssociations: ['_ESHTextObjectPlainLongText']
}
@EndUserText.label: 'Product'
@ObjectModel.representativeKey: 'Product'
@Analytics.dataCategory: #DIMENSION
//@ObjectModel.entityChangeStateId: 'LastChangeDateTime'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.allowExtensions:true
@Metadata.ignorePropagatedAnnotations: true
@Analytics:{
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture.automatic: true
    }
}
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #EXTRACTION_DATA_SOURCE,
                                      #SEARCHABLE_ENTITY,
                                      #ANALYTICAL_DIMENSION
]

define view I_Product
  as select from mara
  //    left outer join maw1 on mara.matnr = maw1.matnr //moved to _ProductRetail
  association [0..*] to I_ProductText                  as _Text                          on  $projection.Product = _Text.Product
  association [0..1] to I_ProductGroup                 as _ProductGroup                  on  $projection.ProductGroup = _ProductGroup.MaterialGroup
  association [0..*] to I_ProductGroupText             as _ProductGroupText              on  $projection.ProductGroup = _ProductGroupText.MaterialGroup
  association [0..1] to I_ProductGroup_2               as _ProductGroup_2                on  $projection.ProductGroup = _ProductGroup_2.ProductGroup
  association [0..*] to I_ProductGroupText_2           as _ProductGroupText_2            on  $projection.ProductGroup = _ProductGroupText_2.ProductGroup
  association [0..1] to I_ProductRetail                as _ProductRetail                 on  $projection.Product = _ProductRetail.Product //added for VH
  association [0..1] to I_Division                     as _Division                      on  $projection.Division = _Division.Division
  association [0..*] to I_DivisionText                 as _DivisionText                  on  $projection.Division = _DivisionText.Division
  association [0..1] to I_ExtProdGrp                   as _ExternalProductGroup          on  $projection.ExternalProductGroup = _ExternalProductGroup.ExternalProductGroup
  association [0..*] to I_ExtProdGrpText               as _ExtProdGrpText                on  $projection.ExternalProductGroup = _ExtProdGrpText.ExternalProductGroup
  association [0..1] to I_ProductHierarchy             as _ProductHierarchy              on  $projection.ProductHierarchy = _ProductHierarchy.ProductHierarchy
  association [0..*] to I_ProductHierarchyText         as _ProductHierarchyText          on  $projection.ProductHierarchy = _ProductHierarchyText.ProductHierarchy
  association [1..1] to I_Producttype                  as _ProductType                   on  $projection.ProductType = _ProductType.ProductType
  association [0..*] to I_ProductTypeText              as _ProductTypeName               on  $projection.ProductType = _ProductTypeName.ProductType
  association [0..1] to I_Intntnlartnmbcat             as _InternationalArticleNumberCat on  $projection.InternationalArticleNumberCat = _InternationalArticleNumberCat.InternationalArticleNumberCat
  association [0..*] to I_Intntnlartnmbcattext         as _IntArticleNumberText          on  $projection.InternationalArticleNumberCat = _IntArticleNumberText.InternationalArticleNumberCat
  association [1..1] to I_ProductCategory              as _ProductCategory               on  $projection.ProductCategory = _ProductCategory.ProductCategory
  association [0..*] to I_ProductCategoryText          as _ProductCategoryText           on  $projection.ProductCategory = _ProductCategoryText.ProductCategory
  association [1..1] to I_UnitOfMeasure                as _BaseUnitOfMeasure             on  $projection.BaseUnit = _BaseUnitOfMeasure.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _BaseUnitOfMeasureText         on  $projection.BaseUnit = _BaseUnitOfMeasureText.UnitOfMeasure
  association [0..1] to I_Product                      as _CrossPlantConfigurableProduct on  $projection.CrossPlantConfigurableProduct = _CrossPlantConfigurableProduct.Product
  association [0..1] to I_Brand                        as _Brand                         on  $projection.Brand = _Brand.Brand
  association [0..1] to I_User                         as _CreatedByUser                 on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_User                         as _LastChangedByUser             on  $projection.LastChangedByUser = _LastChangedByUser.UserID
  association [1..1] to I_UserContactCard              as _CreatedByUserContactCard      on  $projection.CreatedByUser = _CreatedByUserContactCard.ContactCardID
  association [0..1] to I_UserContactCard              as _LastChangedByUserContactCard  on  $projection.LastChangedByUser = _LastChangedByUserContactCard.ContactCardID

  association [0..1] to E_Product                      as _ProductExt                    on  mara.matnr = _ProductExt.Product
  association [0..1] to I_UnitOfMeasure                as _ContentUnit                   on  $projection.ContentUnit = _ContentUnit.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _ContentUnitText               on  $projection.ContentUnit = _ContentUnitText.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _ProductMeasurementUnit        on  $projection.ProductMeasurementUnit = _ProductMeasurementUnit.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _ProductMeasurementUnitText    on  $projection.ProductMeasurementUnit = _ProductMeasurementUnitText.UnitOfMeasure
  association [0..1] to I_Productprocurement           as _ProductProcurement            on  $projection.Product = _ProductProcurement.Product
  association [0..1] to I_ProductSales                 as _ProductSales                  on  $projection.Product = _ProductSales.Product
  association [0..1] to I_ProductStatus                as _ProductStatus                 on  $projection.CrossPlantStatus = _ProductStatus.Status
  association [0..*] to I_ProductStatusText            as _ProductStatusText             on  $projection.CrossPlantStatus = _ProductStatusText.Status
  association [0..1] to I_UnitOfMeasure                as _WeightUnitValueHelp           on  $projection.WeightUnit = _WeightUnitValueHelp.UnitOfMeasure

  association [0..*] to I_UnitOfMeasureText            as _WeightUnitText                on  $projection.WeightUnit = _WeightUnitText.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _QuantityUnitValueHelp         on  $projection.VolumeUnit = _QuantityUnitValueHelp.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _QuantityUnitText              on  $projection.VolumeUnit = _QuantityUnitText.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure                as _UnitForMaxPackaging           on  $projection.UnitForMaxPackagingDimensions = _UnitForMaxPackaging.UnitOfMeasure
  association [0..*] to I_UnitOfMeasureText            as _UnitForMaxPackagingText       on  $projection.UnitForMaxPackagingDimensions = _UnitForMaxPackagingText.UnitOfMeasure

  association [0..1] to I_UnitOfMeasure                as _TimeUnitForQuarantinePeriod   on  $projection.TimeUnitForQuarantinePeriod             = _TimeUnitForQuarantinePeriod.UnitOfMeasure
                                                                                         and _TimeUnitForQuarantinePeriod.UnitOfMeasureDimension = 'TIME'
  association [0..*] to I_UnitOfMeasureText            as _TimeUnitQuarantinePeriodText  on  $projection.TimeUnitForQuarantinePeriod = _TimeUnitQuarantinePeriodText.UnitOfMeasure
  //  association [0..1] to I_Productvh            as _CrossPlantConfigurableProduct on  $projection.CrossPlantConfigurableProduct = _CrossPlantConfigurableProduct.Product
  association [0..*] to I_ProductDescription           as _MaterialText                  on  $projection.CrossPlantConfigurableProduct = _MaterialText.Product

  association [0..*] to I_MDProductHierarchyNode       as _MDProductHierarchyNode -- Not part of 1705 [Pushing down from I_ProductWD to I_Product Applegreen ticket]
                                                                                         on  $projection.Product = _MDProductHierarchyNode.Product

  association [0..1] to I_ChangeMstrObjTypeRevisionLvl as _MaterialRevisionLevel         on  $projection.MaterialRevisionLevel             = _MaterialRevisionLevel.RevisionLevel
                                                                                         and _MaterialRevisionLevel.ChangeNumberObjectType = '41'

  association [0..1] to I_ChemicalComplianceRelevant   as _ChemicalComplianceRelevant    on  $projection.IsChemicalComplianceRelevant = _ChemicalComplianceRelevant.IsChemicalComplianceRelevant
  association [0..*] to I_ChemicalComplianceRlvtText   as _ChemicalComplianceRlvtText    on  $projection.IsChemicalComplianceRelevant = _ChemicalComplianceRlvtText.IsChemicalComplianceRelevant

  association [0..1] to I_ItemCategoryGroup            as _ItemCategoryGroup             on  $projection.ItemCategoryGroup = _ItemCategoryGroup.ItemCategoryGroup
  association [0..*] to I_ItemCategoryGroupText        as _ItemCategoryGroupText         on  $projection.ItemCategoryGroup = _ItemCategoryGroupText.ItemCategoryGroup

  association [0..*] to I_BrandText                    as _BrandText                     on  $projection.Brand = _BrandText.Brand

  //Start: enterprise search help (ESH) related associations----------------------------------------------------------------------------------------------------------------------
  association [0..*] to I_ProductSalesDelivery         as _ESHProductSalesDelivery       on  $projection.Product = _ESHProductSalesDelivery.Product
  association [0..*] to I_SourceOfSupplyCategoryT      as _ESHSourceOfSupply             on  $projection.SourceOfSupply = _ESHSourceOfSupply.SourceOfSupplyCategory
  association [0..1] to I_Supplier                     as _ESHSupplier                   on  $projection.ManufacturerNumber = _ESHSupplier.Supplier
  association [0..*] to I_TextObjectPlainLongText      as _ESHTextObjectPlainLongText    on  $projection.Product                            = _ESHTextObjectPlainLongText.TextObjectKey
                                                                                         and _ESHTextObjectPlainLongText.TextObjectCategory = 'MATERIAL'
  association [0..*] to I_DocumentInfoRecordObjectLink as _ESHDocInfoRecordObjectLink    on  $projection.Product                         = _ESHDocInfoRecordObjectLink.LinkedSAPObjectKey
                                                                                         and _ESHDocInfoRecordObjectLink.LinkedSAPObject = 'MARA'
  association [0..*] to I_UnitOfMeasureText            as _ESHPurOrderQuantityUnitText   on  $projection.PurchaseOrderQuantityUnit = _ESHPurOrderQuantityUnitText.UnitOfMeasure
  association [0..*] to I_ProductPlant                 as _ESHProductPlant               on  $projection.Product = _ESHProductPlant.Product

  //In 1905 Classification related associations are added to get classification related fields into the
  //search model
  association [0..*] to I_ClfnObjectCharcValForKeyDate as _ESHCharValueAssignment        on  $projection.Product                     = _ESHCharValueAssignment.ClfnObjectID
                                                                                         and _ESHCharValueAssignment.ClfnObjectTable = 'MARA'
  association [0..*] to I_ClfnObjectClassForKeyDate    as _ESHClassAssignment            on  $projection.Product                 = _ESHClassAssignment.ClfnObjectID
                                                                                         and _ESHClassAssignment.ClfnObjectTable = 'MARA'
  //End of ESH related associations-----------------------------------------------------------------------------------------------------------------------------------------------
  association [0..*] to I_ProdUnivHierarchyNode        as _ProdUnivHierarchyNode         on  $projection.Product = _ProdUnivHierarchyNode.Product

  association [0..1] to I_AssortmentListType           as _AssortmentListType            on  $projection.AssortmentListType = _AssortmentListType.AssortmentListType
  association [0..*] to I_AssortmentListTypeT          as _AssortmentListTypeText        on  $projection.AssortmentListType = _AssortmentListTypeText.AssortmentListType

  association [0..1] to I_BR_ANPCode                   as _BR_ANPCode                    on  $projection.ANPCode = _BR_ANPCode.BR_ANPCode
  association [0..*] to I_BR_ANPCodeText               as _BR_ANPCodeText                on  $projection.ANPCode = _BR_ANPCodeText.BR_ANPCode

  association [0..1] to I_EWM_MaterialHandling         as _HandlingIndicator             on  $projection.HandlingIndicator = _HandlingIndicator.MaterialHandling
  association [0..*] to I_EWM_MaterialHandlingT        as _HandlingIndicatorText         on  $projection.HandlingIndicator = _HandlingIndicatorText.MaterialHandling

  association [0..1] to I_EWM_WarehouseMaterialGroup   as _WarehouseProductGroup         on  $projection.WarehouseProductGroup = _WarehouseProductGroup.WarehouseProductGroup
  association [0..*] to I_EWM_WarehouseMaterialGroupT  as _WarehouseProductGroupText     on  $projection.WarehouseProductGroup = _WarehouseProductGroupText.WarehouseProductGroup

  association [0..1] to I_EWM_WhseStorageCondition     as _WarehouseStorageCondition     on  $projection.WarehouseStorageCondition = _WarehouseStorageCondition.WarehouseStorageCondition
  association [0..*] to I_EWM_WhseStorageConditionT    as _WarehouseStorageConditionText on  $projection.WarehouseStorageCondition = _WarehouseStorageConditionText.WarehouseStorageCondition

  association [0..1] to I_EWM_HandlingUnitType         as _StandardHandlingUnitType      on  $projection.StandardHandlingUnitType = _StandardHandlingUnitType.HandlingUnitType
  association [0..*] to I_EWM_HandlingUnitTypeT        as _StandardHandlingUnitTypeText  on  $projection.StandardHandlingUnitType = _StandardHandlingUnitTypeText.HandlingUnitType

  association [0..1] to I_EWM_SerialNumberProfile      as _SerialNumberProfile           on  $projection.SerialNumberProfile = _SerialNumberProfile.SerialNumberProfile
  association [0..*] to I_EWM_SerialNumberProfileT     as _SerialNumberProfileText       on  $projection.SerialNumberProfile = _SerialNumberProfileText.SerialNumberProfile

  association [0..1] to I_EWM_QtyAdjustmentProfile     as _AdjustmentProfile             on  $projection.AdjustmentProfile = _AdjustmentProfile.AdjustmentProfile
  association [0..*] to I_EWM_QtyAdjustmentProfileT    as _AdjustmentProfileText         on  $projection.AdjustmentProfile = _AdjustmentProfileText.AdjustmentProfile

  association [0..1] to I_ProdEWMAdjmtProfile          as _AdjustmentProfile_2           on  $projection.AdjustmentProfile = _AdjustmentProfile_2.AdjustmentProfile
  association [0..*] to I_ProdEWMAdjmtProfileText      as _AdjustmentProfileText_2       on  $projection.AdjustmentProfile = _AdjustmentProfileText_2.AdjustmentProfile

  association [0..1] to I_EWM_QualityInspectionGroup   as _QualityInspectionGroup        on  $projection.QualityInspectionGroup = _QualityInspectionGroup.QualityInspectionGroup
  association [0..*] to I_EWM_QualityInspectionGroupT  as _QualityInspectionGroupText    on  $projection.QualityInspectionGroup = _QualityInspectionGroupText.QualityInspectionGroup

  association [0..1] to I_EWM_HandlingUnitType         as _HandlingUnitType              on  $projection.HandlingUnitType = _HandlingUnitType.HandlingUnitType
  association [0..*] to I_EWM_HandlingUnitTypeT        as _HandlingUnitTypeText          on  $projection.HandlingUnitType = _HandlingUnitTypeText.HandlingUnitType

  association [0..1] to I_ProductESPP                  as _ProductESPP                   on  $projection.Product = _ProductESPP.Product
  association [1..1] to I_Productscm                   as _ProductSCM                    on  $projection.Product = _ProductSCM.Product
{ // root node fields

      @ObjectModel: {
        text.association: '_Text',
        hierarchy.association: '_ProdUnivHierarchyNode'
      }
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH

  key cast (mara.matnr as productnumber preserving type )                  as Product,
      _Text,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      mara.matnr_external                                                  as ProductExternalID,
      mara.productoid                                                      as ProductOID,
      @ObjectModel.foreignKey.association: '_ProductType'
      @ObjectModel.text.association: '_ProductTypeName'
      @ObjectModel.sapObjectNodeTypeReference:'ProductType'
      cast (mara.mtart as producttype preserving type )                    as ProductType,
      _ProductType,
      @Semantics.systemDate.createdAt: true
      mara.ersda                                                           as CreationDate,
      @Semantics.systemTime.createdAt: true
      mara.created_at_time                                                 as CreationTime,

      @Semantics.systemDateTime.createdAt: true
      cast ( dats_tims_to_tstmp( mara.ersda,
                                 mara.created_at_time,
                                 abap_system_timezone( $session.client,'NULL' ),
                                 $session.client,
                                 'NULL' ) as cmd_prd_creation_date_time  ) as CreationDateTime,
      @ObjectModel.foreignKey.association: '_CreatedByUserContactCard'
      mara.ernam                                                           as CreatedByUser,
      _CreatedByUser,
      _CreatedByUserContactCard,
      @Semantics.systemDate.lastChangedAt: true
      mara.laeda                                                           as LastChangeDate,
      @ObjectModel.foreignKey.association: '_LastChangedByUserContactCard'
      case when mara.aenam <> '' then mara.aenam
                                 else cast( mara.ernam as aenam preserving type )
      end                                                                  as LastChangedByUser,
      //mara.aenam                                                           as LastChangedByUser,
      _LastChangedByUser,
      _LastChangedByUserContactCard,
      cast (mara.lvorm as ismarkedfordeletion)                             as IsMarkedForDeletion,
      @ObjectModel.foreignKey.association: '_ProductStatus'
      @ObjectModel.text.association: '_ProductStatusText'
      @ObjectModel.sapObjectNodeTypeReference:'ProductProfileCode'
      cast (mara.mstae as crossplantstatus)                                as CrossPlantStatus,
      _ProductStatus,
      _ProductStatusText,
      mara.mstde                                                           as CrossPlantStatusValidityDate,
      // common node fields -> no common node
      cast (mara.bismt as productoldid)                                    as ProductOldID,
      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      mara.brgew                                                           as GrossWeight,
      mara.bstme                                                           as PurchaseOrderQuantityUnit,
      mara.bwscl                                                           as SourceOfSupply,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association:'_WeightUnitValueHelp'
      @ObjectModel.text.association: '_WeightUnitText'
      mara.gewei                                                           as WeightUnit,
      _WeightUnitValueHelp,
      _WeightUnitText,
      mara.herkl                                                           as CountryOfOrigin,
      mara.kunnr                                                           as CompetitorID,
      @ObjectModel.foreignKey.association: '_ProductGroup_2'
      @ObjectModel.text.association: '_ProductGroupText_2'
      @ObjectModel.sapObjectNodeTypeReference:'ProductGroup'
      cast (mara.matkl as productgroup preserving type )                   as ProductGroup,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: '_ProductGroup_2'
      _ProductGroup,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: '_ProductGroupText_2'
      _ProductGroupText,
      _ProductGroup_2,
      _ProductGroupText_2,
      @ObjectModel.foreignKey.association: '_BaseUnitOfMeasure'
      @ObjectModel.text.association: '_BaseUnitOfMeasureText'
      mara.meins                                                           as BaseUnit,
      _BaseUnitOfMeasure,
      _BaseUnitOfMeasureText,
      @ObjectModel.foreignKey.association: '_ItemCategoryGroup'
      @ObjectModel.text.association: '_ItemCategoryGroupText'
      mara.mtpos_mara                                                      as ItemCategoryGroup,
      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      mara.ntgew                                                           as NetWeight,
      @ObjectModel.foreignKey.association: '_ProductHierarchy'
      @ObjectModel.text.association: '_ProductHierarchyText'
      mara.prdha                                                           as ProductHierarchy,
      _ProductHierarchy,
      _ProductHierarchyText,
      @ObjectModel.foreignKey.association: '_Division'
      @ObjectModel.text.association: '_DivisionText'
      mara.spart                                                           as Division,
      _Division,
      _DivisionText,
      mara.vabme                                                           as VarblPurOrdUnitIsActive,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association:'_QuantityUnitValueHelp'
      @ObjectModel.text.association: '_QuantityUnitText'
      mara.voleh                                                           as VolumeUnit,
      _QuantityUnitValueHelp,
      _QuantityUnitText,
      @Semantics.quantity.unitOfMeasure: 'VolumeUnit'
      cast (mara.volum as materialvolume)                                  as MaterialVolume,
      mara.mstav                                                           as SalesStatus, -- added on 12.08.2015
      mara.tragr                                                           as TransportationGroup,
      mara.mstdv                                                           as SalesStatusValidityDate,
      mara.begru                                                           as AuthorizationGroup,
      // NEW FIELDS
      @ObjectModel:{
        foreignKey.association: '_BR_ANPCode',
        text.association: '_BR_ANPCodeText'
      }
      mara.anp                                                             as ANPCode,
      @ObjectModel.foreignKey.association: '_ProductCategory'
      @ObjectModel.text.association: '_ProductCategoryText'
      cast (mara.attyp as prodcategory preserving type )                   as ProductCategory,
      _ProductCategory,
      _ProductCategoryText,
      @ObjectModel.foreignKey.association: '_Brand'
      @ObjectModel.text.association: '_BrandText'
      mara.brand_id                                                        as Brand,
      _Brand,
      mara.bwvor                                                           as ProcurementRule,
      mara.datab                                                           as ValidityStartDate,
      mara.disst                                                           as LowLevelCode,
      mara.gennr                                                           as ProdNoInGenProdInPrepackProd,
      mara.serial                                                          as SerialIdentifierAssgmtProfile,
      mara.groes                                                           as SizeOrDimensionText,
      mara.normt                                                           as IndustryStandardName,
      cast( mara.ean11 as globaltradeitemnumber)                           as ProductStandardID,
      @ObjectModel.foreignKey.association: '_InternationalArticleNumberCat'
      @ObjectModel.text.association:'_IntArticleNumberText'
      @ObjectModel.sapObjectNodeTypeReference:'GlobalTradeItemNumberCategory'
      mara.numtp                                                           as InternationalArticleNumberCat,
      _InternationalArticleNumberCat,
      _IntArticleNumberText,
      cast( mara.kzkfg as productisconfigurable preserving type )          as ProductIsConfigurable,
      mara.xchpf                                                           as IsBatchManagementRequired,
      mara.mlgut                                                           as HasEmptiesBOM,
      @ObjectModel.foreignKey.association: '_ExternalProductGroup'
      @ObjectModel.text.association: '_ExtProdGrpText'
      cast (mara.extwg as externalproductgroup preserving type )           as ExternalProductGroup,
      _ExternalProductGroup,
      _ExtProdGrpText,
      //--[ GENERATED:012:GFBfhxvv7jY4jTYbPy8kum
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ProductStdVH',
                     element: 'Product' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CrossPlantConfigurableProduct'
      @ObjectModel.text.association: '_MaterialText'
      cast (mara.satnr as crossplantconfigurableproduct preserving type )  as CrossPlantConfigurableProduct,
      _CrossPlantConfigurableProduct,
      _MaterialText,
      mara.serlv                                                           as SerialNoExplicitnessLevel,
      mara.mfrpn                                                           as ProductManufacturerNumber,
      mara.mfrnr                                                           as ManufacturerNumber,
      mara.mprof                                                           as ManufacturerPartProfile,
      mara.qmpur                                                           as QltyMgmtInProcmtIsActive,
      // _Text  //added for VH

      -- Added on 21.4.16 not releven for Product Master

      mara.xgchp                                                           as IsApprovedBatchRecordReqd,

      //EWM fields------------------------------
      //for EWM............
      @ObjectModel.foreignKey.association: '_HandlingIndicator'
      @ObjectModel.text.association: '_HandlingIndicatorText'
      mara.hndlcode                                                        as HandlingIndicator,
      @ObjectModel.foreignKey.association: '_WarehouseProductGroup'
      @ObjectModel.text.association: '_WarehouseProductGroupText'
      mara.whmatgr                                                         as WarehouseProductGroup,
      @ObjectModel.foreignKey.association: '_WarehouseStorageCondition'
      @ObjectModel.text.association: '_WarehouseStorageConditionText'
      mara.whstc                                                           as WarehouseStorageCondition,
      @ObjectModel.foreignKey.association: '_StandardHandlingUnitType'
      @ObjectModel.text.association: '_StandardHandlingUnitTypeText'
      mara.hutyp_dflt                                                      as StandardHandlingUnitType,
      @ObjectModel.foreignKey.association: '_SerialNumberProfile'
      @ObjectModel.text.association: '_SerialNumberProfileText'
      mara.serial                                                          as SerialNumberProfile,
      @ObjectModel.foreignKey.association: '_AdjustmentProfile_2'
      @ObjectModel.text.association: '_AdjustmentProfileText_2'
      mara.adprof                                                          as AdjustmentProfile,
      mara.scm_puom                                                        as PreferredUnitOfMeasure,
      mara.pilferable                                                      as IsPilferable,
      mara.hazmat                                                          as IsRelevantForHzdsSubstances,
      @Semantics.quantity.unitOfMeasure : 'TimeUnitForQuarantinePeriod'
      mara.qqtime                                                          as QuarantinePeriod,
      @ObjectModel.foreignKey.association:'_TimeUnitForQuarantinePeriod'
      @Semantics.unitOfMeasure : true
      @ObjectModel.text.association: '_TimeUnitQuarantinePeriodText'
      mara.qqtimeuom                                                       as TimeUnitForQuarantinePeriod,
      _TimeUnitForQuarantinePeriod,
      _TimeUnitQuarantinePeriodText,
      @ObjectModel.foreignKey.association: '_QualityInspectionGroup'
      @ObjectModel.text.association: '_QualityInspectionGroupText'
      mara.qgrp                                                            as QualityInspectionGroup,
      //WM packaging fields
      @ObjectModel.foreignKey.association: '_HandlingUnitType'
      @ObjectModel.text.association: '_HandlingUnitTypeText'
      mara.hutyp                                                           as HandlingUnitType,
      //    mara.hutyp_dflt,
      mara.tare_var                                                        as HasVariableTareWeight,
      @Semantics.quantity.unitOfMeasure: 'UnitForMaxPackagingDimensions'
      mara.maxl                                                            as MaximumPackagingLength,
      @Semantics.quantity.unitOfMeasure: 'UnitForMaxPackagingDimensions'
      mara.maxb                                                            as MaximumPackagingWidth,
      @Semantics.quantity.unitOfMeasure: 'UnitForMaxPackagingDimensions'
      mara.maxh                                                            as MaximumPackagingHeight,
      mara.maxc                                                            as MaximumCapacity,
      mara.maxc_tol                                                        as OvercapacityTolerance,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_UnitForMaxPackaging'
      @ObjectModel.text.association: '_UnitForMaxPackagingText'
      mara.maxdim_uom                                                      as UnitForMaxPackagingDimensions,
      _UnitForMaxPackaging,
      _UnitForMaxPackagingText,

      //      Retail Fields

      @Semantics.quantity.unitOfMeasure: 'ProductMeasurementUnit'
      mara.laeng                                                           as BaseUnitSpecificProductLength,
      @Semantics.quantity.unitOfMeasure: 'ProductMeasurementUnit'
      mara.breit                                                           as BaseUnitSpecificProductWidth,
      @Semantics.quantity.unitOfMeasure: 'ProductMeasurementUnit'
      mara.hoehe                                                           as BaseUnitSpecificProductHeight,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_ProductMeasurementUnit'
      @ObjectModel.text.association: '_ProductMeasurementUnitText'
      mara.meabm                                                           as ProductMeasurementUnit,
      _ProductMeasurementUnit,
      _ProductMeasurementUnitText,
      mara.datab                                                           as ProductValidStartDate,
      @ObjectModel.sapObjectNodeTypeReference:'ProductCategory'
      cast (mara.attyp as prodcategory preserving type )                   as ArticleCategory,
      @ObjectModel.foreignKey.association: '_ContentUnit'
      @ObjectModel.text.association: '_ContentUnitText'
      @Semantics.unitOfMeasure: true
      mara.inhme                                                           as ContentUnit,
      _ContentUnit,
      _ContentUnitText,
      @Semantics.quantity.unitOfMeasure: 'ContentUnit'
      mara.inhal                                                           as NetContent,
      @Semantics.quantity.unitOfMeasure: 'ContentUnit'
      @EndUserText.label: 'Comparison Price Unit'
      mara.vpreh                                                           as ComparisonPriceQuantity,
      @Semantics.quantity.unitOfMeasure: 'ContentUnit'
      mara.inhbr                                                           as GrossContent,
      mara.liqdt                                                           as ProductValidEndDate,
      @ObjectModel.foreignKey.association: '_AssortmentListType'
      @ObjectModel.text.association: '_AssortmentListTypeText'
      mara.bbtyp                                                           as AssortmentListType,
      mara.animal_origin                                                   as HasTextilePartsWthAnimalOrigin,
      mara.fsh_sealv                                                       as ProductSeasonUsageCategory,

      // moved to _ProductRetail
      //      maw1.servv                                         as ServiceAgreement,
      //      maw1.wmaab                                         as ConsumptionValueCategory, // ref. handling for MARC
      //      maw1.wausm                                         as GoodsIssueUnit, // ref. handling for MARC
      //      maw1.wherl                                         as CountryOfOrigin, // ref. handling for MARC
      //      maw1.wherr                                         as RegionOfOrigin, // ref. handling for MARC
      //      maw1.sstuf                                         as AssortmentGrade,
      //      maw1.lstfl                                         as StoreListingProcedure,
      //      maw1.lstvz                                         as DistrCntrListingProcedure,
      //      maw1.ldvfl                                         as StoreListingStartDate,
      //      maw1.ldbfl                                         as StoreListingEndDate,
      //      maw1.ldvzl                                         as DistrCntrListingStartDate,
      //      maw1.ldbzl                                         as DistrCntrListingEndDate,
      //      maw1.vdvfl                                         as StoreSaleStartDate,
      //      maw1.vdbfl                                         as StoreSaleEndDate,
      //      maw1.vdvzl                                         as DistrCntrSaleStartDate,
      //      maw1.vdbzl                                         as DistrCntrSaleEndDate,
      //      maw1.wbkla                                         as ValuationClass, // ref. handling for MBEW
      //      maw1.wstaw                                         as CommodityCode,
      //      maw1.wbwsp                                         as ValuationMargin, // ref. handling for MBEW
      //      maw1.wexpm                                         as CommoditiyCodeNumberUnit,

      //
      mara.mbrsh                                                           as IndustrySector, //added for external VH request'
      cast('' as changenumber )                                            as ChangeNumber,
      //      @ObjectModel.foreignKey.association: '_MaterialRevisionLevel'
      cast('' as productrevisionlevel)                                     as MaterialRevisionLevel,
      cast( 'X' as sdraft_is_active preserving type )                      as IsActiveEntity,

      @Semantics.systemDateTime.lastChangedAt: true
      case when mara.aenam <> ''
        then cast(dats_tims_to_tstmp(mara.laeda, mara.last_changed_time, abap_system_timezone( $session.client,'NULL' ), $session.client, 'NULL') as changedatetime )
        else cast(dats_tims_to_tstmp(mara.ersda, mara.last_changed_time, abap_system_timezone( $session.client,'NULL' ), $session.client, 'NULL') as changedatetime )
      end                                                                  as LastChangeDateTime,


      //new fields
      @Semantics.systemTime.lastChangedAt: true
      mara.last_changed_time                                               as LastChangeTime,
      mara.profl                                                           as DangerousGoodsIndProfile,
      mara.scm_matid_guid16                                                as ProductUUID,
      mara.scm_matid_guid22                                                as ProdSupChnMgmtUUID22,
      //new fields- Unified API
      mara.aeszn                                                           as ProductDocumentChangeNumber,
      mara.blanz                                                           as ProductDocumentPageCount,
      mara.blatt                                                           as ProductDocumentPageNumber,
      mara.bmatn                                                           as OwnInventoryManagedProduct,
      mara.cadkz                                                           as DocumentIsCreatedByCAD,
      mara.ferth                                                           as ProductionOrInspectionMemoTxt,
      mara.formt                                                           as ProductionMemoPageFormat,
      mara.gtin_variant                                                    as GlobalTradeItemNumberVariant,
      mara.ihivi                                                           as ProductIsHighlyViscous,
      mara.iloos                                                           as TransportIsInBulk,
      mara.kosch                                                           as ProdAllocDetnProcedure,
      mara.kzeff                                                           as ProdEffctyParamValsAreAssigned,
      mara.kzumw                                                           as ProdIsEnvironmentallyRelevant,
      mara.labor                                                           as LaboratoryOrDesignOffice,
      mara.magrv                                                           as PackagingMaterialGroup,
      mara.matfi                                                           as ProductIsLocked,
      mara.nrfhg                                                           as DiscountInKindEligibility,
      mara.ps_smartform                                                    as SmartFormName,
      mara.rmatp                                                           as PackingReferenceProduct,
      mara.wrkst                                                           as BasicMaterial,
      mara.zeinr                                                           as ProductDocumentNumber,
      mara.zeivr                                                           as ProductDocumentVersion,
      mara.zeiar                                                           as ProductDocumentType,
      mara.zeifo                                                           as ProductDocumentPageFormat,
      mara.cuobf                                                           as ProductConfiguration,
      mara.sgt_covsa                                                       as SegmentationStrategy,
      mara.sgt_rel                                                         as SegmentationIsRelevant,
      @ObjectModel.foreignKey.association: '_ChemicalComplianceRelevant'
      @ObjectModel.text.association: '_ChemicalComplianceRlvtText'
      cast( mara.chml_cmplnc_rlvnce_ind as chml_cmplnc_rlvnce_ind_pm )     as IsChemicalComplianceRelevant,
      mara.msbookpartno                                                    as ManufacturerBookPartNumber,
      //      The below fields are requested by Retail Colleagues.
      mara.logistical_mat_category                                         as LogisticalProductCategory,
      mara.sales_material                                                  as SalesProduct,

      //      The below fields are requested by Retail Fashion Colleagues.
      mara.color_atinn                                                     as ProdCharc1InternalNumber,
      mara.size1_atinn                                                     as ProdCharc2InternalNumber,
      mara.size2_atinn                                                     as ProdCharc3InternalNumber,
      mara.color                                                           as ProductCharacteristic1,
      mara.size1                                                           as ProductCharacteristic2,
      mara.size2                                                           as ProductCharacteristic3,

      _ProductTypeName,
      _ProductRetail,
      _ProductProcurement,
      _ProductSales,
      _MDProductHierarchyNode,
      _ChemicalComplianceRlvtText,
      _ChemicalComplianceRelevant,
      _ItemCategoryGroupText,
      _ItemCategoryGroup,
      _BrandText,
      _ProdUnivHierarchyNode,
      //Start of ESH related associations---------------------------
      _ESHProductSalesDelivery,
      _ESHSourceOfSupply,
      _ESHSupplier,
      _ESHTextObjectPlainLongText,
      _ESHDocInfoRecordObjectLink,
      _ESHPurOrderQuantityUnitText,
      _ESHProductPlant,
      _ESHCharValueAssignment,
      _ESHClassAssignment,
      //End of ESH related associations------------------------------
      _MaterialRevisionLevel,
      _AssortmentListType,
      _AssortmentListTypeText,
      _BR_ANPCode,
      _BR_ANPCodeText,
      _HandlingIndicator,
      _HandlingIndicatorText,
      _WarehouseProductGroup,
      _WarehouseProductGroupText,
      _WarehouseStorageCondition,
      _WarehouseStorageConditionText,
      _StandardHandlingUnitType,
      _StandardHandlingUnitTypeText,
      _SerialNumberProfile,
      _SerialNumberProfileText,
      @VDM.lifecycle: {
        status: #DEPRECATED,
        successor: '_AdjustmentProfile_2'
      }
      _AdjustmentProfile,
      @VDM.lifecycle: {
        status: #DEPRECATED,
        successor: '_AdjustmentProfileText_2'
      }
      _AdjustmentProfileText,
      _AdjustmentProfile_2,
      _AdjustmentProfileText_2,
      _QualityInspectionGroup,
      _QualityInspectionGroupText,
      _HandlingUnitType,
      _HandlingUnitTypeText,
      _ProductESPP,
      _ProductSCM

}
