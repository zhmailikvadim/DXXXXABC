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
@AbapCatalog.sqlViewAppendName: 'ZSDEASLSPRCNDNVA'
@EndUserText.label: 'Extention for A_SlsPrcgCndnRecdValidity'
extend view A_SlsPrcgCndnRecdValidity with ZZA_SlsPrcgCndnRecdValidity
{
  FSH_COLLECTION,
  FSH_SEASON,
  FSH_SEASON_YEAR,
  KNUMA_AG,
  KUNRE,
  PROVG,
  VSTEL,
  AKTNR,
  COUNTRY,
  BASEUNIT,

  ZZBSG,
  ZZFSH_KVGR7,
  ZZFSH_KVGR8,
  ZZKATR1,
  ZZKATR9,
  ZZKVGR2,
  ZZKVGR4,
  ZZLASTSEASON,
  ZZVMSTA
}
