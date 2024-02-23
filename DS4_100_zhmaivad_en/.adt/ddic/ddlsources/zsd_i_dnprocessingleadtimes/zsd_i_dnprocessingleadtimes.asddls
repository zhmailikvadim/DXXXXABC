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
@EndUserText.label: 'DNProcessingLeadTimes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_dnprocessingleadtimes
  as select distinct from zsd_t_os_lt                as LeadTimes
    inner join            ZPE_I_HM( iv_id: '0000001039' )             on LeadTimes.zlt_type = ZPE_I_HM.field2
    join                  zsd_i_outboundschedulinglt as Scheduling    on LeadTimes.zvstel = Scheduling.ShippingPoint
    join                  zsd_i_lead_times_last_date as LastLeadTimes on  LastLeadTimes.ZltType      = ZPE_I_HM.field2
                                                                      and LastLeadTimes.Zvtweg       = LeadTimes.zvtweg
                                                                      and LastLeadTimes.Zvsbed       = LeadTimes.zvsbed
                                                                      and LastLeadTimes.Zauart       = LeadTimes.zauart
                                                                      and LastLeadTimes.Zvstel       = LeadTimes.zvstel
                                                                      and LastLeadTimes.Zorderreason = LeadTimes.zorderreason
                                                                      and LastLeadTimes.Zdatab       = LeadTimes.zdatab
{
  key Scheduling.DepartureSite,
  key Scheduling.ShippingPoint,
      Scheduling.DestinationSite,
      LeadTimes.zvtweg                                                  as DistributionChannel,
      cast(LeadTimes.zauart as auart preserving type )                  as OrderType,
      cast(LeadTimes.zorderreason as zz1_zorderreason preserving type ) as OrderReason,
      CEIL( LeadTimes.zlead_time / 240000 )                             as DNprocessingLT,
      LeadTimes.zlt_type
}
