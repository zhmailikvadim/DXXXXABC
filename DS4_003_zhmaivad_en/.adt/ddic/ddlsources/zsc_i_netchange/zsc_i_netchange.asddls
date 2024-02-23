/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KALSHZHA     | 02.05.2023 | 20252     : Feature - [Build] Event-base *
*              |            | DS4K949975                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Re-ATP Net change data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #M,
    dataClass: #MASTER
}
define view entity zsc_i_netchange as select from zsc_t_reatp_tims
  association [0..1] to zsc_t_reatp_ntch as _NetChange on $projection.netchange_uuid = _NetChange.netchange_uuid
{
  key tmstmp_uuid,
  key netchange_uuid,
  change_tmstmp,
  process_tmstmp,
  _NetChange.artnr as matnr,
  _NetChange.werks 
}
