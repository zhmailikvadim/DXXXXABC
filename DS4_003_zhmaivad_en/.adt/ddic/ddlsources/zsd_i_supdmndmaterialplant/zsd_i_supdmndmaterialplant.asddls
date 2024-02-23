/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZUJSKAS      | 27.02.2023 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Basic View for Material Plant'
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}

@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL ,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
define view entity ZSD_I_SUPDMNDMATERIALPLANT
  as select from mara as SupDmndMaterial
    inner join   marc as marc on SupDmndMaterial.matnr = marc.matnr
  association [0..*] to mean as _EANs on  marc.matnr  = _EANs.matnr
                                      and _EANs.eantp = 'UC'

{
  key marc.matnr                 as Material,
  key marc.werks                 as Plant,
      SupDmndMaterial.mtart      as MaterialType,
      SupDmndMaterial.fsh_mg_at1 as FreeDefinedProductAttribute01,
      SupDmndMaterial.fsh_mg_at1 as FreeDefinedProductAttribute02,
      SupDmndMaterial.fsh_mg_at1 as FreeDefinedProductAttribute03,
      SupDmndMaterial.color      as RetailArticleColor,
      SupDmndMaterial.size1      as RetailArticleMainSize,
      SupDmndMaterial.size2      as RetailArticleSecondSize,
      SupDmndMaterial.satnr      as CrossPlantConfigurableProduct,
      SupDmndMaterial.matkl      as MaterialGroup,
      marc.xchpf                 as MaterialIsBatchManaged,
      marc.arun_fix_batch        as IsInternalBatchManaged,
      marc.sgt_covs              as SegmentationStrategy,
      marc.sgt_scope             as SegmentationStrategyScope,
      marc.mtvfp                 as ProdAvailabilityCheckGroup,
      marc.ladgr                 as LoadingGroup,
      marc.plifz                 as PlannedDeliveryTime,
      SupDmndMaterial.eannr      as EAN,
      SupDmndMaterial.zzmsc      as SportCategory,
      _EANs
}
where
  (
       SupDmndMaterial.attyp = '00' -- item category
    or SupDmndMaterial.attyp = ' '
    or SupDmndMaterial.attyp = '02'
    or SupDmndMaterial.attyp = '10'
    or SupDmndMaterial.attyp = '11'
    or SupDmndMaterial.attyp = '12'
  )
  and  marc.fsh_mg_arun_req  = '1'
