/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.08.2022 | FB_12903_SD_Build -[BE]- Supply Demand Overview (SDO          *
*              |            | DS4K926920                               *
* ZAICHART     | 30.06.2022 | FB_21361_SD_Build - Supply and Demand Overview - Consolidation*
*              |            | DS4K952788                               *
* ZAICHART     | 05.07.2022 | FB_21973_SD_Build - SDO - New fields on analysis steps V2     *
*              |            | DS4K954563                               *
* ZAICHART     | 15.07.2022 | FB_22642_SD_Feature - Build - SDO - Outbound  DN Events V3    *
*              |            | DS4K956434                               *
* NAGARSOW     | 12.10.2023 | FB_21361_SD_Build - Supply and Demand Overview - Consolidation*
*              |            | DS4K952788
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Overview - Outbound DN Events Time'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_out_dn_event_time_seg
  as select from zsd_i_out_dn_eventime_handler as EventTimeHandler
{
  HeadHandler,

  _EventTime[ 1: even = 'ZS4PLNPICK' and even_verty = '0' ].even_tstfr as zs4plnpick_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNPICK' and even_verty = '0' ].even_zonfr as zs4plnpick_even_zonfr,

  _EventTime[ 1: even = 'ZS4PLNLOAD' and even_verty = '0' ].even_tstfr as zs4plnload_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNLOAD' and even_verty = '0' ].even_zonfr as zs4plnload_even_zonfr,

  _EventTime[ 1: even = 'ZS4PLNGDIS' and even_verty = '0' ].even_tstfr as zs4plngdis_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNGDIS' and even_verty = '0' ].even_zonfr as zs4plngdis_even_zonfr,

  _EventTime[ 1: even = 'ZWSPLNGISS' and even_verty = '0' ].even_tstfr as zs4plndgis_even_tstfr,
  _EventTime[ 1: even = 'ZWSPLNGISS' and even_verty = '0' ].even_zonfr as zs4plndgis_even_zonfr,

  _EventTime[ 1: even = 'ZTSACTROUT' and even_verty = '0' ].even_tstfr as ztsactrout_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTROUT' and even_verty = '0' ].even_zonfr as ztsactrout_even_zonfr,

  _EventTime[ 1: even = 'ZTSACTRORE' and even_verty = '0' ].even_tstfr as ztsactrrou_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTRORE' and even_verty = '0' ].even_zonfr as ztsactrrou_even_zonfr,

  _EventTime[ 1: even = 'ZS4PLNDELI' and even_verty = '0' ].even_tstfr as zs4plndeli_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNDELI' and even_verty = '0' ].even_zonfr as zs4plndeli_even_zonfr,

  _EventTime[ 1: even = 'ZS4PLNCONS' and even_verty = '0' ].even_tstfr as zs4plncons_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNCONS' and even_verty = '0' ].even_zonfr as zs4plncons_even_zonfr,

  _EventTime[ 1: even = 'ZS4PLNGDIW' and even_verty = '0' ].even_tstfr as zs4plngdiw_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNGDIW' and even_verty = '0' ].even_zonfr as zs4plngdiw_even_zonfr,
  _EventTime[ 1: even = 'ZS4PLNGDIW' and even_verty = '0' ].even_tstto as zs4plngdiw_even_tstto,
  _EventTime[ 1: even = 'ZS4PLNGDIW' and even_verty = '0' ].even_zonto as zs4plngdiw_even_zonto,

  _EventTime[ 1: even = 'ZS4PLNDELW' and even_verty = '0' ].even_tstfr as zs4plndelw_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNDELW' and even_verty = '0' ].even_zonfr as zs4plndelw_even_zonfr,
  _EventTime[ 1: even = 'ZS4PLNDELW' and even_verty = '0' ].even_tstto as zs4plndelw_even_tstto,
  _EventTime[ 1: even = 'ZS4PLNDELW' and even_verty = '0' ].even_zonto as zs4plndelw_even_zonto,

  _EventTime[ 1: even = 'ZS4PLNROUT' and even_verty = '0' ].even_tstfr as zs4plnrout_even_tstfr,
  _EventTime[ 1: even = 'ZS4PLNROUT' and even_verty = '0' ].even_zonfr as zs4plnrout_even_zonfr,

  _EventTime[ 1: even = 'ZWSPLNLOAD' and even_verty = '0' ].even_tstfr as zwsplnload_even_tstfr,
  _EventTime[ 1: even = 'ZWSPLNLOAD' and even_verty = '0' ].even_zonfr as zwsplnload_even_zonfr,
  _EventTime[ 1: even = 'ZWSPLNLOAD' and even_verty = '0' ].even_tstto as zwsplnload_even_tstto,
  _EventTime[ 1: even = 'ZWSPLNLOAD' and even_verty = '0' ].even_zonto as zwsplnload_even_zonto,

  _EventTime[ 1: even = 'ZWSPLNGDIS' and even_verty = '0' ].even_tstfr as zwsplngdis_even_tstfr,
  _EventTime[ 1: even = 'ZWSPLNGDIS' and even_verty = '0' ].even_tstto as zwsplngdis_even_tstto,
  _EventTime[ 1: even = 'ZWSPLNGDIS' and even_verty = '0' ].even_zonfr as zwsplngdis_even_zonfr,
  _EventTime[ 1: even = 'ZWSPLNGDIS' and even_verty = '0' ].even_zonto as zwsplngdis_even_zonto,

  _EventTime[ 1: even = 'ZWSACTRECE' and even_verty = '1' ].even_tstfr as zwsactrece_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTRECE' and even_verty = '1' ].even_zonfr as zwsactrece_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTPICK' and even_verty = '1' ].even_tstfr as zwsactpick_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTPICK' and even_verty = '1' ].even_zonfr as zwsactpick_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTPACK' and even_verty = '1' ].even_tstfr as zwsactpack_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTPACK' and even_verty = '1' ].even_zonfr as zwsactpack_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTLOAD' and even_verty = '1' ].even_tstfr as zwsactload_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTLOAD' and even_verty = '1' ].even_zonfr as zwsactload_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTGDIS' and even_verty = '1' ].even_tstfr as zwsactgdis_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTGDIS' and even_verty = '1' ].even_zonfr as zwsactgdis_even_zonfr,

  _EventTime[ 1: even = 'ZWSPLNRORQ' and even_verty = '1' ].even_tstfr as zwsplnrorq_even_tstfr,
  _EventTime[ 1: even = 'ZWSPLNRORQ' and even_verty = '1' ].even_zonfr as zwsplnrorq_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTROIS' and even_verty = '1' ].even_tstfr as zwsactrois_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTROIS' and even_verty = '1' ].even_zonfr as zwsactrois_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTROUT' and even_verty = '1' ].even_tstfr as zwsactrout_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTROUT' and even_verty = '1' ].even_zonfr as zwsactrout_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTRORE' and even_verty = '1' ].even_tstfr as zwsactrore_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTROUT' and even_verty = '1' ].even_zonfr as zwsactrore_even_zonfr,

  _EventTime[ 1: even = 'ZTSPLNGDIS' and even_verty = '0' ].even_tstfr as ztsplngdis_even_tstfr,
  _EventTime[ 1: even = 'ZTSPLNGDIS' and even_verty = '0' ].even_zonfr as ztsplngdis_even_zonfr,
  _EventTime[ 1: even = 'ZTSPLNGDIS' and even_verty = '0' ].even_tstto as ztsplngdis_even_tstto,
  _EventTime[ 1: even = 'ZTSPLNGDIS' and even_verty = '0' ].even_zonto as ztsplngdis_even_zonto,

  _EventTime[ 1: even = 'ZTSPLNDELI' and even_verty = '0' ].even_tstfr as ztsplndeli_even_tstfr,
  _EventTime[ 1: even = 'ZTSPLNDELI' and even_verty = '0' ].even_zonfr as ztsplndeli_even_zonfr,
  _EventTime[ 1: even = 'ZTSPLNGDIS' and even_verty = '0' ].even_tstto as ztsplndeli_even_tstto,
  _EventTime[ 1: even = 'ZTSPLNDELI' and even_verty = '0' ].even_zonto as ztsplndeli_even_zonto,

  _EventTime[ 1: even = 'ZTSACTCOLL' and even_verty = '1' ].even_tstfr as ztsactcoll_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTCOLL' and even_verty = '1' ].even_zonfr as ztsactcoll_even_zonfr,

  _EventTime[ 1: even = 'ZTSACTARRI' and even_verty = '1' ].even_tstfr as ztsactarri_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTARRI' and even_verty = '1' ].even_zonfr as ztsactarri_even_zonfr,

  _EventTime[ 1: even = 'ZTSACTDEPT' and even_verty = '1' ].even_tstfr as ztsactdept_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTDEPT' and even_verty = '1' ].even_zonfr as ztsactdept_even_zonfr,

  _EventTime[ 1: even = 'ZTSACTATMP' and even_verty = '1' ].even_tstfr as ztsactatmp_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTATMP' and even_verty = '1' ].even_zonfr as ztsactatmp_even_zonfr,
  _EventTime[ 1: even = 'ZTSACTATMP' and even_verty = '1' ].even_tstto as ztsactatmp_even_tstto,
  _EventTime[ 1: even = 'ZTSACTATMP' and even_verty = '1' ].even_zonto as ztsactatmp_even_zonto,

  _EventTime[ 1: even = 'ZTSACTDELI' and even_verty = '1' ].even_tstfr as ztsactdeli_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTDELI' and even_verty = '1' ].even_zonfr as ztsactdeli_even_zonfr,

  _EventTime[ 1: even = 'ZTSACTDELI' and even_verty = '1' ].even_tstto as ztsactdeli_even_tstto,
  _EventTime[ 1: even = 'ZTSACTDELI' and even_verty = '1' ].even_zonto as ztsactdeli_even_zonto,

  _EventTime[ 1: even = 'ZTSACTREFU' and even_verty = '1' ].even_tstfr as ztsactrefu_even_tstfr,
  _EventTime[ 1: even = 'ZTSACTREFU' and even_verty = '1' ].even_zonfr as ztsactrefu_even_zonfr,
  _EventTime[ 1: even = 'ZTSACTREFU' and even_verty = '1' ].even_tstto as ztsactrefu_even_tstto,
  _EventTime[ 1: even = 'ZTSACTREFU' and even_verty = '1' ].even_zonfr as ztsactrefu_even_zonto,

  _EventTime[ 1: even = 'ZWSPLNPICK' and even_verty = '0' ].even_tstfr as zwsplnpick_even_tstfr,
  _EventTime[ 1: even = 'ZWSPLNPICK' and even_verty = '0' ].even_zonfr as zwsplnpick_even_zonfr,

  _EventTime[ 1: even = 'ZWSPLANDEL' and even_verty = '0' ].even_tstfr as zwsplandel_even_tstfr,
  _EventTime[ 1: even = 'ZWSPLANDEL' and even_verty = '0' ].even_zonfr as zwsplandel_even_zonfr,

  _EventTime[ 1: even = 'ZWSPRJGDIS' and even_verty = '1' ].even_tstfr as zwsprjgdis_even_tstfr,
  _EventTime[ 1: even = 'ZWSPRJGDIS' and even_verty = '1' ].even_zonfr as zwsprjgdis_even_zonfr,

  _EventTime[ 1: even = 'ZWSREQROUT' and even_verty = '1' ].even_tstfr as zwsreqrout_even_tstfr,
  _EventTime[ 1: even = 'ZWSREQROUT' and even_verty = '1' ].even_zonfr as zwsreqrout_even_zonfr,

  _EventTime[ 1: even = 'ZWSACTDELI' and even_verty = '1' ].even_tstfr as zwsactdeli_even_tstfr,
  _EventTime[ 1: even = 'ZWSACTDELI' and even_verty = '1' ].even_zonfr as zwsactdeli_even_zonfr,
  _EventTime[ 1: even = 'ZWSACTDELI' and even_verty = '1' ].even_tstto as zwsactdeli_even_tstto,
  _EventTime[ 1: even = 'ZWSACTDELI' and even_verty = '1' ].even_zonto as zwsactdeli_even_zonto,

  _EventTime[ 1: even = 'ZSTCONSHEL' and even_verty = '0' ].even_tstfr as zstconshel_even_tstfr,
  _EventTime[ 1: even = 'ZSTCONSHEL' and even_verty = '0' ].even_zonfr as zstconshel_even_zonfr,


  case
   when _EventTime[ 1: even = 'ZTSACTDELI' and even_verty = '1' ].even_zonto  != ''
        then _EventTime[ 1: even = 'ZTSACTDELI' and even_verty = '1' ].even_zonto
   else _EventTime[ 1:  even_verty = '1' ].even_zonfr
  end                                                                  as zs4_tz_zone

}
