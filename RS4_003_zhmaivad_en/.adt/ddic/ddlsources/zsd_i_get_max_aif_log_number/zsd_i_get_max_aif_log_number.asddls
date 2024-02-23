/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.12.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | FB_16311_SD_[Feature] [Build] - Stock reconciliation *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 29.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Max AIF Log Number'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_get_max_aif_log_number
  as select distinct from zsc_t_pgrpr_item as AifPersistentTable
    join                  sdsls_bussys_idx as _AifMessagesIndexTable on AifPersistentTable.msgguid = _AifMessagesIndexTable.msgguid
{
  key          AifPersistentTable.plant,
  key          AifPersistentTable.delivery,
  key          AifPersistentTable.deliveryitem,
  key          max(_AifMessagesIndexTable.lognumber) as MaxLogNumber
}
group by
  AifPersistentTable.plant,
  AifPersistentTable.delivery,
  AifPersistentTable.deliveryitem
