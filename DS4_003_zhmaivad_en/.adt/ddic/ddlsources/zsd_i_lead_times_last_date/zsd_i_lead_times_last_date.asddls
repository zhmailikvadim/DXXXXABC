/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 03.01.2023 | 16554     : [Feature] [Platform] [Custom *
*              |            | DS4K939267                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Lead Times Max Valid-From Date'
@AccessControl.authorizationCheck: #CHECK
define view entity zsd_i_lead_times_last_date
  as select from zsd_t_os_lt
{
  key zlt_type     as ZltType,
  key zvstel       as Zvstel,
  key zvtweg       as Zvtweg,
  key zvsbed       as Zvsbed,
  key zauart       as Zauart,
  key zorderreason as Zorderreason,
      max(zdatab)  as Zdatab
}
group by
  zlt_type,
  zvstel,
  zvtweg,
  zvsbed,
  zauart,
  zorderreason
