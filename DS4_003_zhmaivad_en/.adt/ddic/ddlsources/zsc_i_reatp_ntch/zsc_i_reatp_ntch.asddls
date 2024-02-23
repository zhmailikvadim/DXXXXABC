/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 01.08.2023 | 20252     : Feature - [Build] Event-base *
*              |            | DS4K949975                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Event based Re-ATP Net change'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsc_i_reatp_ntch
  as select from zsc_t_reatp_ntch
{
  key netchange_uuid  as NetchangeUuid,
      artnr           as Artnr,
      werks           as Werks,
      change_category as ChangeCategory
}
