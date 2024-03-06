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
@AbapCatalog.sqlViewAppendName: 'ZSDEISLSPRCNDRTP'
@EndUserText.label: 'Extention for I_SlsPricingConditionRecordTP'
extend view I_SlsPricingConditionRecordTP with ZSD_E_ISlsPricingConditRecTP
{
  Validity.FSH_COLLECTION,
  Validity.FSH_SEASON,
  Validity.FSH_SEASON_YEAR,
  Validity.KNUMA_AG,
  Validity.KUNRE,
  Validity.PROVG,
  Validity.VSTEL,
  Validity.AKTNR,
  Validity.COUNTRY,

  Validity.ZZBSG,
  Validity.ZZFSH_KVGR7,
  Validity.ZZFSH_KVGR8,
  Validity.ZZKATR1,
  Validity.ZZKATR9,
  Validity.ZZKVGR2,
  Validity.ZZKVGR4,
  Validity.ZZLASTSEASON,
  Validity.ZZVMSTA

}
