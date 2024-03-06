/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SUFIYKON     | 13.04.2023 | 20028 Stock Reconciliation Summary       *
*              |            | DS4K949671                               *
************************************************************************/

@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #VALUE_HELP
@Search.searchable: true
@EndUserText.label: 'Stock Reconciliation Summary storLocVH'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_stock_recon_summ_slocvh
  as select distinct from I_StorageLocation
{
  key StorageLocation,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      StorageLocationName
}
