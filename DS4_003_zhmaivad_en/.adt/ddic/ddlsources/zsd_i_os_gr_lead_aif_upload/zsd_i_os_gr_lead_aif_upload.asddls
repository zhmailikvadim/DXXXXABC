/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* HURTSALE     | 05.06.2023 | 21930     : GR leadtime table Fiori app  *
*              |            | DS4K954488                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ПК Lead Times AIF Upload'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsd_i_os_gr_lead_aif_upload
  as select from zsd_t_os_gr
{
  key ekorg,
  key zz1_zsales_channel_pdh,
  key bsart,
  key zz1_zorderreason_pdh,
  key werks,
  key zdatab,
      zlead_time,
      zdeletion_indi,
      created_on,
      created_at,
      @Semantics.user.createdBy: true
      created_by,
      changed_on,
      changed_at,
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by
}
