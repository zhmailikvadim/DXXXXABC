@AbapCatalog.sqlViewName: 'ZFIIWBSTLOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WBS Transfer Log'
@Metadata.ignorePropagatedAnnotations: true
define view ZFI_I_WBS_TRANSFER_LOG
  as select from zfi_work_tsf_log
{
  mandt                 as Mandt,
  companycode           as Companycode,
  assetclass_parent     as AssetclassParent,
  asset_parent          as AssetParent,
  fixedasset_parent     as FixedassetParent,
  wbselement_parent     as WbselementParent,
  assetclass_child      as AssetclassChild,
  asset_child           as AssetChild,
  fixedasset_child      as FixedassetChild,
  wbselement_child      as WbselementChild,
  assetdeactivationdate as Assetdeactivationdate
} 
 