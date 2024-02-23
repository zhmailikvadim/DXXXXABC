@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Basic View for Material Plant'
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDMAT',
  compiler.compareFilter: true,
  preserveKey:true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL ,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
define view I_SupDmndMaterialPlant
  as select from mara as SupDmndMaterial
    inner join   marc as marc on SupDmndMaterial.matnr = marc.matnr

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
      matkl                      as MaterialGroup,
      marc.xchpf                 as MaterialIsBatchManaged,
      arun_fix_batch             as IsInternalBatchManaged,
      sgt_covs                   as SegmentationStrategy,
      marc.sgt_scope             as SegmentationStrategyScope,
      marc.mtvfp                 as ProdAvailabilityCheckGroup,
      marc.ladgr                 as LoadingGroup
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
