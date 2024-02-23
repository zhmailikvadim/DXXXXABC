/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 31.08.2022 |    13574  :  FB_13574_SD_Build - [BE] - Supply Demand Overview (S*
*              |            |    DS4K929761                           *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 28.11.2022 |    13622  :  FB_13622_SD_Build - [BE] - Gap SDO Enhancements for*
*              |            |    DS4K931934                            *
*----------------------------------------------------------------------*/

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Time Segment Events'
define view entity zsd_i_tevents_for_inb_delivery
  as select from tsege     as Events
    inner join   ttsegtple as EventTemplate      on Events.even = EventTemplate.even
    inner join   ZPE_I_HM( iv_id: '0000000485' ) on EventTemplate.tepl = ZPE_I_HM.field2
  association to ttsegevty as _eventType on Events.even = _eventType.even 

{
  key Events.head_hdl        as HandlerTimeEventSegment,
  key Events.even_verty      as EventVersionType,
      _eventType.even_ali    as EventAlias,
      Events.even_sor        as EventSortField,
      Events.even_tstfr      as EventTimeStartFromUTC,
      Events.even_zonfr      as EventTimeStartFromTimeZone,
      Events.even_tstto      as EventTimeStartToUTC,
      Events.even_zonto      as EventTimeStartToTimeZone,
      EventTemplate.even_sor as TemplateEvenSortField
}

