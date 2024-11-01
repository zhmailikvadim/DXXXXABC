// active core entity
@AbapCatalog.sqlViewName: 'IPRODUCT'
//@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }   //addedforVH
@VDM.viewType: #BASIC

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product active core entity'
@ObjectModel.representativeKey: 'Product'


@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER

//@Search.searchable: true    //added for VH
//@ObjectModel:{
//lifecycle : {
//     enqueue : {
//        expiryBehavior :
//           #RELATIVE_TO_LAST_CHANGE,
//        expiryInterval : 'PT15M',
//       notificationBeforeExpiryInterval : 'PT2M'},
//     processing : {
//        expiryBehavior :
//            #RELATIVE_TO_LAST_CHANGE,
//        expiryInterval : 'PT30M',
//        notificationBeforeExpiryInterval :  'PT4M' }
//         }
//
//}

define view I_Product
  as select from    mara
    left outer join maw1 on mara.matnr = maw1.matnr
  //association [0..*] to I_MaterialText   as _Text           on $projection.Product      = _Text.Material //added for VH
{ // root node fields

  key cast (mara.matnr as productnumber)                 as Product,
      cast (mara.mtart as producttype)                   as ProductType,
      mara.ersda                                         as CreationDate,
      mara.ernam                                         as CreatedByUser,
      mara.laeda                                         as LastChangeDate,
      mara.aenam                                         as LastChangedByUser,
      mara.lvorm                                         as IsMarkedForDeletion,
      cast (mara.mstae as crossplantstatus)              as CrossPlantStatus,
      mara.mstde                                         as CrossPlantStatusValidityDate,
      // common node fields -> no common node
      cast (mara.bismt as productoldid)                  as ProductOldID,
      mara.brgew                                         as GrossWeight,
      mara.bstme                                         as PurchaseOrderQuantityUnit,
      mara.bwscl                                         as SourceOfSupply,
      mara.gewei                                         as WeightUnit,
      //      mara.herkl                                         as CountryOfOrigin,
      mara.kunnr                                         as CompetitorID,
      cast (mara.matkl as productgroup)                  as ProductGroup,
      mara.meins                                         as BaseUnit,
      mara.mtpos_mara                                    as ItemCategoryGroup,
      mara.ntgew                                         as NetWeight,
      mara.prdha                                         as ProductHierarchy,
      mara.spart                                         as Division,
      mara.vabme                                         as VarblPurOrdUnitIsActive,
      mara.voleh                                         as VolumeUnit,
      cast (mara.volum as materialvolume)                as MaterialVolume,
      mara.mstav                                         as SalesStatus, -- added on 12.08.2015
      mara.tragr                                         as TransportationGroup,
      mara.mstdv                                         as SalesStatusValidityDate,
      // NEW FIELDS

      mara.anp                                           as ANPCode,
      cast (mara.attyp as prodcategory)                  as ProductCategory,
      mara.brand_id                                      as Brand,
      mara.bwvor                                         as ProcurementRule,
      mara.datab                                         as ValidityStartDate,
      mara.disst                                         as LowLevelCode,
      mara.gennr                                         as ProdNoInGenProdInPrepackProd,
      mara.serial                                        as SerialIdentifierAssgmtProfile,
      mara.groes                                         as SizeOrDimensionText,
      mara.normt                                         as IndustryStandardName,
      cast( mara.ean11 as globaltradeitemnumber)         as ProductStandardID,
      mara.numtp                                         as InternationalArticleNumberCat,
      mara.kzkfg                                         as ProductIsConfigurable,
      mara.xchpf                                         as IsBatchManagementRequired,
      cast (mara.extwg as externalproductgroup)          as ExternalProductGroup,
      cast (mara.satnr as crossplantconfigurableproduct) as CrossPlantConfigurableProduct,
      mara.serlv                                         as SerialNoExplicitnessLevel,
      mara.mfrpn                                         as ProductManufacturerNumber,
      mara.mfrnr                                         as ManufacturerNumber,
      mara.mprof                                         as ManufacturerPartProfile,
      mara.qmpur                                         as QltyMgmtInProcmtIsActive,
      // _Text  //added for VH

      -- Added on 21.4.16 not releven for Product Master

      mara.xgchp                                         as IsApprovedBatchRecordReqd,


      //      Retail Fields


      mara.laeng                                         as BaseUnitSpecificProductLength,
      mara.breit                                         as BaseUnitSpecificProductWidth,
      mara.hoehe                                         as BaseUnitSpecificProductHeight,
      mara.meabm                                         as ProductMeasurementUnit,
      mara.datab                                         as ProductValidStartDate,
      cast (mara.attyp as articlecategory)               as ArticleCategory,
      mara.inhme                                         as ContentUnit,
      mara.inhal                                         as NetContent,
      mara.vpreh                                         as ComparisonPriceQuantity,
      mara.inhbr                                         as GrossContent,
      mara.liqdt                                         as ProductValidEndDate,
      mara.bbtyp                                         as AssortmentListType,
      mara.animal_origin                                 as HasTextilePartsWthAnimalOrigin,
      mara.fsh_sealv                                     as ProductSeasonUsageCategory,
      maw1.servv                                         as ServiceAgreement,
      maw1.wmaab                                         as ConsumptionValueCategory, // ref. handling for MARC
      maw1.wausm                                         as GoodsIssueUnit, // ref. handling for MARC
      maw1.wherl                                         as CountryOfOrigin, // ref. handling for MARC
      maw1.wherr                                         as RegionOfOrigin, // ref. handling for MARC
      maw1.sstuf                                         as AssortmentGrade,
      maw1.lstfl                                         as StoreListingProcedure,
      maw1.lstvz                                         as DistrCntrListingProcedure,
      maw1.ldvfl                                         as StoreListingStartDate,
      maw1.ldbfl                                         as StoreListingEndDate,
      maw1.ldvzl                                         as DistrCntrListingStartDate,
      maw1.ldbzl                                         as DistrCntrListingEndDate,
      maw1.vdvfl                                         as StoreSaleStartDate,
      maw1.vdbfl                                         as StoreSaleEndDate,
      maw1.vdvzl                                         as DistrCntrSaleStartDate,
      maw1.vdbzl                                         as DistrCntrSaleEndDate,
      maw1.wbkla                                         as ValuationClass, // ref. handling for MBEW
      maw1.wstaw                                         as CommodityCode,
      maw1.wbwsp                                         as ValuationMargin, // ref. handling for MBEW
      maw1.wexpm                                         as CommoditiyCodeNumberUnit,

      //
      mara.mbrsh                                         as IndustrySector, //added for external VH request
      
      //EWM fields------------------------------
      //for EWM............
      mara.hndlcode                                      as HandlingIndicator,
      mara.whmatgr                                       as WarehouseProductGroup,
      mara.whstc                                         as WarehouseStorageCondition,
      mara.hutyp_dflt                                    as StandardHandlingUnitType,
      mara.serial                                        as SerialNumberProfile,
      mara.adprof                                        as AdjustmentProfile,
      mara.scm_puom                                      as PreferredUnitOfMeasure,
      mara.pilferable                                    as IsPilferable,
      mara.hazmat                                        as IsRelevantForHzdsSubstances,
      mara.qqtime                                        as QuarantinePeriod,
      mara.qqtimeuom                                     as TimeUnitForQuarantinePeriod,
      mara.qgrp                                          as QualityInspectionGroup,
      //WM packaging fields
      mara.hutyp                                         as HandlingUnitType,
      //    mara.hutyp_dflt,
      mara.tare_var                                      as HasVariableTareWeight,
      mara.maxl                                          as MaximumPackagingLength,
      mara.maxb                                          as MaximumPackagingWidth,
      mara.maxh                                          as MaximumPackagingHeight,
      mara.maxc                                          as OvercapacityTolerance,
      mara.maxc_tol                                      as MaximumCapacity,
      mara.maxdim_uom                                    as UnitForMaxPackagingDimensions
      










}        
  
  
  
  
  
 