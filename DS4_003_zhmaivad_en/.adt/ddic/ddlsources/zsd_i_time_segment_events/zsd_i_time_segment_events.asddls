/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* MUKHAMAK     | 13.12.2022 | 27533     : 27533_SD_Billing Process -   *
*              |            | Date Determination DS4K973427            *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Time Segment Events'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_Time_Segment_Events
  as select from tsege
{
  key head_hdl   as HeadHdl,
  key even       as Even,
  key even_cnt   as EvenCnt,
  key even_verty as EvenVerty,
  key even_vernu as EvenVernu,
      even_sor   as EvenSor,
      even_tstfr as EvenTstfr,
      even_zonfr as EvenZonfr,
      even_tstto as EvenTstto,
      even_zonto as EvenZonto,
      even_flgff as EvenFlgff,
      even_flgft as EvenFlgft,
      _dataaging as Dataaging
}
