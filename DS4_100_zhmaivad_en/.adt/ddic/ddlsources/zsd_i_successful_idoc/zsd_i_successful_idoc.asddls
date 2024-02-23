/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view for IDoc header'
define view entity zsd_i_successful_idoc
  as select from edidc
    inner join   stacust                       on edidc.status = stacust.status
    inner join   stalight                      on stacust.statva = stalight.statva
    inner join   teds2                         on  edidc.status = teds2.status
                                               and teds2.langua = $session.system_language
    inner join   zsd_i_status_txt_tf as status on  edidc.docnum = status.docnum
                                               and edidc.status = status.status
{
  key edidc.docnum,
      edidc.status                                  as IntStatus,
      stalight.stalight                             as ExtStatus,
      teds2.descrp                                  as ExtStatusName,
      replace_regexpr(pcre =>'(&4)',
      value => replace_regexpr(pcre =>'(&3)',
      value => replace_regexpr( pcre =>'(&2)',
      value => replace_regexpr(pcre => '(&1)',
      value => status.statxt, with => status.stapa1,
      result_length => 150 ), with => status.stapa2, result_length => 150 ), with => status.stapa3, result_length => 150 ),
      with => status.stapa4, result_length => 150 ) as ExtStatusDescription,
      status.credat                                 as IdocCreateDate,
      status.cretim                                 as IdocCreateTime
}
where
       edidc.mestyp       = 'WHSCON'
  and  edidc.idoctp       = 'FSHDLV04'
  and  edidc.cimtyp       = 'ZFSHDLV04'
  and  not(
     stalight.stalight    = '3'
     or stalight.stalight = '1'
   )
