@AbapCatalog.sqlViewAppendName: 'XRFMIPURCHDOCIT'
@EndUserText.label: 'Exte. view for I_PurchasingDocumentItem'
@VDM.viewExtension: true
extend view I_PurchasingDocumentItem with X_RFM_I_PurchasingDocumentItem

association [0..1] to I_SeasonBasic as _SeasonBasic on $projection.ProductSeasonYear = _SeasonBasic.ProductSeasonYear and
                                                       $projection.ProductSeason     = _SeasonBasic.ProductSeason     and
                                                       $projection.ProductCollection = _SeasonBasic.ProductCollection and
                                                       $projection.ProductTheme      = _SeasonBasic.ProductTheme
                                                       
{
  @Feature:'SW:RFM_FSH_RTL_UI'
  uptyp                  as SubItemCategory,
  @Feature:'SW:RFM_SEASON_UI'
  fsh_season_year        as ProductSeasonYear,
  @Feature:'SW:RFM_SEASON_UI'
  fsh_season             as ProductSeason,
  @Feature:'SW:RFM_SEASON_UI'
  fsh_collection         as ProductCollection,
  @Feature:'SW:RFM_SEASON_UI'
  fsh_theme              as ProductTheme,
  @Feature:'SW:RFM_SEASON_UI'
  rfm_scc_indicator      as SeasonCompletenessStatus,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  @Feature:'SW:RFM_FSH_WHSL_UI'
  cnfm_qty               as CommittedQuantity,
  @Feature:'SW:RFM_PSST_UI'
  rfm_psst_rule          as ShippingGroupRule,
  @Feature:'SW:RFM_PSST_UI'
  rfm_psst_group         as ShippingGroupNumber,
  @Feature:'SW:RFM_CHARC_VALS_UI'
  wrf_charstc1           as ProductCharacteristic1,
  @Feature:'SW:RFM_CHARC_VALS_UI'
  wrf_charstc2           as ProductCharacteristic2,
  @Feature:'SW:RFM_CHARC_VALS_UI'
  wrf_charstc3           as ProductCharacteristic3,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  rfm_diversion          as DiversionStatus,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  rfm_ref_doc            as ReferenceDocumentNumber,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  rfm_ref_item           as ReferenceDocumentItem,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  rfm_ref_action         as PurchaseOrderReferenceType,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  rfm_ref_slitem         as ReferenceDocumentScheduleLine,
  @Feature:'SW:RFM_VAS_UI'
  fsh_vas_rel            as ItemHasValueAddedService,
  @Feature:'SW:RFM_VAS_UI'
  fsh_vas_prnt_id        as ValAddedSrvcParentItmNumber,
  @Feature:'SW:RFM_ARUN_UI'
  assignment_priority    as ARunPriorityValue,
  @Feature:'SW:RFM_ARUN_UI'
  arun_group_prio        as ARunDemandGroupPriority,
  
  _SeasonBasic 
}
