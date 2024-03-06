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
@AbapCatalog.sqlViewAppendName: 'ZSDEISLSPRRECTMP'
@EndUserText.label: 'Extention for I_SlsPrcgCndnRecdTemplate'
extend view I_SlsPrcgCndnRecdTemplate with ZSD_E_ISlsPrcgCndnRecdTemplate
{

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier : 'FSH_COLLECTION' }
  cast('' as fsh_collection)       as FSH_COLLECTION,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'FSH_SEASON' }
  cast('' as fsh_saiso)            as FSH_SEASON,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'FSH_SEASON_YEAR' }
  cast('' as fsh_saisj)            as FSH_SEASON_YEAR,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'KNUMA_AG' }
  cast('' as knuma_ag)             as KNUMA_AG,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'KUNRE' }
  cast('' as kunre)                as KUNRE,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'PROVG' }
  cast('' as provg)                as PROVG,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'VSTEL' }
  cast('' as vstel)                as VSTEL,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'AKTNR' }
  cast('' as waktion)              as AKTNR,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'BASEUNIT' }
  cast('' as meins)                as BASEUNIT,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                     qualifier: 'COUNTRY' }
  cast('' as land1)                as COUNTRY,


  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZBSG' }
  cast('' as zmm_bsg)              as ZZBSG,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZFSH_KVGR7' }
  cast('' as fsh_kvgr7)            as ZZFSH_KVGR7,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZFSH_KVGR8' }
  cast('' as fsh_kvgr8)            as ZZFSH_KVGR8,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZKATR1' }
  cast('' as katr1)                as ZZKATR1,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZKATR9' }
  cast('' as katr9)                as ZZKATR9,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZKVGR2' }
  cast('' as kvgr2)                as ZZKVGR2,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZKVGR4' }
  cast('' as kvgr4)                as ZZKVGR4,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                   qualifier: 'ZZLASTSEASON' }
  cast('' as zmm_last_sale_season) as ZZLASTSEASON,

  @UI.fieldGroup                   :{ groupLabel: 'Condition Key',
                                      qualifier: 'ZZVMSTA' }
  cast('' as vmsta)                as ZZVMSTA
}
