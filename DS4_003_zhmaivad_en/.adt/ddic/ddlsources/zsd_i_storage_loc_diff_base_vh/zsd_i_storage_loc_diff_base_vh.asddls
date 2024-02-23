/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Plant'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_storage_loc_diff_base_vh
  as select distinct from I_StorageLocation             as StorageLocation
    join                  zsd_i_stock_difference_report as DiffReport on DiffReport.StorageLocation = StorageLocation.StorageLocation
{
  key          cast(StorageLocation.StorageLocation as lgort_d preserving type ) as StorageLocation,
  key          StorageLocation.Plant                                             as Plant,
               StorageLocation.StorageLocationName                               as Name1
}
