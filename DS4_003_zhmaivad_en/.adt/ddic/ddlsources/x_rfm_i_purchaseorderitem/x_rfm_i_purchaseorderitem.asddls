@AbapCatalog.sqlViewAppendName: 'XRFMIPURCHORDIT'
@EndUserText.label: 'Exte. view for I_PurchaseOrderItem'
@VDM.viewExtension: true
extend view I_PurchaseOrderItem with X_RFM_I_PurchaseOrderItem
  association [0..1] to I_SeasonBasic as _SeasonBasic
    on $projection.productseasonyear = _SeasonBasic.ProductSeasonYear and
       $projection.productseason     = _SeasonBasic.ProductSeason     and
       $projection.productcollection = _SeasonBasic.ProductCollection and
       $projection.producttheme      = _SeasonBasic.ProductTheme
{

// Seasons
  @Feature:'SW:RFM_SEASON_UI'
  ProductSeasonYear,
  @Feature:'SW:RFM_SEASON_UI'
  ProductSeason,
  @Feature:'SW:RFM_SEASON_UI'
  ProductCollection,
  @Feature:'SW:RFM_SEASON_UI'
  ProductTheme,
  @Feature:'SW:RFM_SEASON_UI'
  SeasonCompletenessStatus,
   
// CommittedQuantity,
  
// PSST  
  @Feature:'SW:RFM_PSST_UI'
  ShippingGroupRule,
  @Feature:'SW:RFM_PSST_UI'
  ShippingGroupNumber,
  
// Characteristics  
  @Feature:'SW:RFM_CHARC_VALS_UI'
  ProductCharacteristic1,
  @Feature:'SW:RFM_CHARC_VALS_UI'
  ProductCharacteristic2,
  @Feature:'SW:RFM_CHARC_VALS_UI'
  ProductCharacteristic3,

// Sub Items
  @Feature:'SW:RFM_FSH_RTL_UI'
  SubItemCategory,
  
// PODiversion  
  @Feature:'SW:RFM_FSH_WHSL_UI'
  DiversionStatus,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  ReferenceDocumentNumber,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  ReferenceDocumentItem,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  PurchaseOrderReferenceType,
  @Feature:'SW:RFM_FSH_WHSL_UI'
  ReferenceDocumentScheduleLine,
  @Feature:'SW:RFM_VAS_UI'
  ItemHasValueAddedService,
  @Feature:'SW:RFM_VAS_UI'
  ValAddedSrvcParentItmNumber,

// Supply Assignment
  @Feature:'SW:RFM_ARUN_UI'
  ARunPriorityValue,
  @Feature:'SW:RFM_ARUN_UI'
  ARunDemandGroupPriority,
  
// Associations
  _SeasonBasic

}
