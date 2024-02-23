/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.08.2022 | FB_12903_SD_Build -[BE]- Supply Demand Overview (SDO    *
*              |            | DS4K926920                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Overview- Out DN EventTime(Delivery)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_out_dn_eventime_handler
  as select from tsege     as HeadHandler

    inner join   ttsegtple as EventTemplate on  EventTemplate.even = HeadHandler.even

    inner join   ZPE_I_HM( iv_id: '0000000405') as TemplateName on TemplateName.field1 = EventTemplate.tepl
       
    association [0..*] to tsege as _EventTime on _EventTime.head_hdl   = $projection.HeadHandler and
                                                 _EventTime.even_cnt   =  0   and
                                                 (
                                                 _EventTime.even_verty = '0'  or
                                                 _EventTime.even_verty = '1' )
{
  HeadHandler.head_hdl as HeadHandler,
  _EventTime
}
where
  ( HeadHandler.even_verty = '0' or
    HeadHandler.even_verty = '1' )
  and
  HeadHandler.even_cnt   = 0
group by
  HeadHandler.head_hdl
