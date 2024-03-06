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
@AbapCatalog.sqlViewAppendName: 'ZSDEISLSPRCNDNVA'
@EndUserText.label: 'Extention for I_SlsPrcgCndnRecdValidity'
extend view I_SlsPrcgCndnRecdValidity with ZSD_E_ISlsPrcgCndnRecdValidity
{
  cast('' as fsh_collection)       as FSH_COLLECTION,
  cast('' as fsh_saiso)            as FSH_SEASON,
  cast('' as fsh_saisj)            as FSH_SEASON_YEAR,
  cast('' as knuma_ag)             as KNUMA_AG,
  cast('' as kunre)                as KUNRE,
  cast('' as provg)                as PROVG,
  cast('' as vstel)                as VSTEL,
  cast('' as waktion)              as AKTNR,
  cast('' as meins)                as BASEUNIT,
  cast('' as land1)                as COUNTRY,

  cast('' as zmm_bsg)              as ZZBSG,
  cast('' as fsh_kvgr7)            as ZZFSH_KVGR7,
  cast('' as fsh_kvgr8)            as ZZFSH_KVGR8,
  cast('' as katr1)                as ZZKATR1,
  cast('' as katr9)                as ZZKATR9,
  cast('' as kvgr2)                as ZZKVGR2,
  cast('' as kvgr4)                as ZZKVGR4,
  cast('' as zmm_last_sale_season) as ZZLASTSEASON,
  cast('' as vmsta)                as ZZVMSTA
}
