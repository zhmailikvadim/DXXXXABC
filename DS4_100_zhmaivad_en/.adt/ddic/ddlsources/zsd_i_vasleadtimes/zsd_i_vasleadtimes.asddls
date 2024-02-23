/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 03.01.2023 | 16554     : [Feature] [Platform] [Custom *
*              |            | DS4K939267                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'VASLeadTimes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_vasleadtimes
  as select distinct from zsd_t_vas_lt               as LeadTimes
    join                  zsd_i_outboundschedulinglt as Scheduling on LeadTimes.zvstel = Scheduling.ShippingPoint
{
  key Scheduling.DepartureSite,
  key Scheduling.ShippingPoint,
      Scheduling.DestinationSite,
      LeadTimes.zvas_code  as VASCode,
      LeadTimes.zlead_time as VASLT
}
