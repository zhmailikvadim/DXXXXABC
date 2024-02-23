/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 16.01.2023 | 16869     : [Feature] 3/3 [Development]  *
*              |            | DS4K940377                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DN Cut-Off Times AIF Upload'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsd_i_os_dn_cut_aif_upload
  as select from zsd_t_os_dn_cut
{
  key zvstel,
  key zvtweg,
      zcut_off_time,
      time_zone,
      created_on,
      created_at,
      @Semantics.user.createdBy: true
      created_by,
      changed_on,
      changed_at,
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by
}
