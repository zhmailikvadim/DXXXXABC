/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.11.2022 | 13444     : [Build] - Stock reconciliati *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 20960     : [Feature] [Build] - Stock re *
*              |            | DS4K951475                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view for IDoc header'
define view entity zsd_i_idoc_header
  as select from edidc
    inner join   stacust                       on edidc.status = stacust.status
    inner join   stalight                      on stacust.statva = stalight.statva
    inner join   teds2                         on  edidc.status = teds2.status
                                               and teds2.langua = $session.system_language
    inner join   zsd_i_status_txt_tf as Status on  edidc.docnum = Status.docnum
                                               and edidc.status = Status.status
{
  key edidc.docnum,
      edidc.status                                  as IntStatus,
      stalight.stalight                             as ExtStatus,
      teds2.descrp                                  as ExtStatusName,
      replace_regexpr(pcre =>'(&4)',
      value => replace_regexpr(pcre =>'(&3)',
      value => replace_regexpr( pcre =>'(&2)',
      value => replace_regexpr(pcre => '(&1)',
      value => Status.statxt, with => Status.stapa1,
      result_length => 150 ), with => Status.stapa2, result_length => 150 ), with => Status.stapa3, result_length => 150 ),
      with => Status.stapa4, result_length => 150 ) as ExtStatusDescription,
      Status.credat                                 as IdocCreateDate,
      Status.cretim                                 as IdocCreateTime
}
where
         edidc.mestyp      = 'WHSCON'
  and    edidc.idoctp      = 'FSHDLV04'
  and    edidc.cimtyp      = 'ZFSHDLV04'
  and(
    (
         stalight.stalight = '3'
      or stalight.stalight = '1'
    )
  )