/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BOBRULA      | 20.11.2023 | 26564 : Pricing Mass Upload Tool         *
*              |            | DS4K969470                               *
*----------------------------------------------------------------------*
* KHIZHAND     | 16.01.2024 | 28046 : Add 2 fields to pricing mass     *
*              |            |           update app                     *
*              |            | DS4K976004                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDECSLSPRCNDRTP'
@EndUserText.label: 'Extention for C_SlsPricingConditionRecordTP'
extend view C_SlsPricingConditionRecordTP with ZSD_E_CSlsPricingConditRecTP
{
  RecordTP.FSH_COLLECTION,
  RecordTP.FSH_SEASON,
  RecordTP.FSH_SEASON_YEAR,
  RecordTP.KNUMA_AG,
  RecordTP.KUNRE,
  RecordTP.PROVG,
  RecordTP.VSTEL,
  RecordTP.AKTNR,
  RecordTP.COUNTRY,

  RecordTP.ZZBSG,
  RecordTP.ZZFSH_KVGR7,
  RecordTP.ZZFSH_KVGR8,
  RecordTP.ZZKATR1,
  RecordTP.ZZKATR9,
  RecordTP.ZZKVGR2,
  RecordTP.ZZKVGR4,
  RecordTP.ZZLASTSEASON,
  RecordTP.ZZVMSTA
}
