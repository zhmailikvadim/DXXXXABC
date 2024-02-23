@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.sqlViewName:      'NSDM_V_MSKA'
@EndUserText.label:            'MSKA Compatibility View'
@DataAging.noAgingRestriction: 'false'

@ObjectModel.usageType.sizeCategory: 'L'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #AUTOMATED
@AccessControl.authorizationCheck: #NOT_ALLOWED
@AbapCatalog.viewEnhancementCategory: #PROJECTION_LIST

define view nsdm_e_mska
  as select from    mska             as t
    left outer to one join nsdm_e_mska_diff as m on  t.mandt = m.mandt
                                                and t.matnr = m.matnr
                                                and t.werks = m.werks
                                                and t.lgort = m.lgort
                                                and t.charg = m.charg
                                                and t.sobkz = m.sobkz
                                                and t.vbeln = m.vbeln
                                                and t.posnr = m.posnr
{
  key t.mandt,
  key t.matnr,
  key t.werks,
  key t.lgort,
  key t.charg,
  key t.sobkz,
  key t.vbeln,
  key t.posnr,

      case when m.gjper is null then '0000' else cast(substring(m.gjper, 1, 4) as abap.numc(4)) end as lfgja, // note 2249780
      case when m.gjper is null then  '00'  else cast(substring(m.gjper, 6, 2) as abap.numc(2)) end as lfmon, // note 2249780
      t.kaspr,
      case when m.kalab is null then 0 else m.kalab end                                             as kalab, // vvv note 2249780
      case when m.kains is null then 0 else m.kains end                                             as kains,
      case when m.kaspe is null then 0 else m.kaspe end                                             as kaspe,
      case when m.kavla is null then 0 else m.kavla end                                             as kavla,
      case when m.kavin is null then 0 else m.kavin end                                             as kavin,
      case when m.kavsp is null then 0 else m.kavsp end                                             as kavsp, // ^^^ note 2249780
      t.kaill,
      t.kailq,
      t.kails,
      t.kavll,
      t.kavlq,
      t.kavls,
      t.kafll,
      t.kaflq,
      t.kafls,
      t.kadll,
      case when m.kaein is null then 0 else m.kaein end                                             as kaein, // note 2249780
      case when m.kavei is null then 0 else m.kavei end                                             as kavei, // note 2249780
      t.ersda,
      t.kajin,
      case when m.karue is null then ' ' else m.karue end                                           as karue, // note 2249780
      t.sgt_scat,
      --Fields added for EA-RETAIL(Fashion)
      '    ' as fsh_season_year,
      '          ' as fsh_season,
      '          '   as fsh_collection,
      '          ' as fsh_theme,
      t.fsh_salloc_qty,
      case when m./cwm/kalab is null then 0 else m./cwm/kalab end                                   as /cwm/kalab, // note 2413597
      case when m./cwm/kains is null then 0 else m./cwm/kains end                                   as /cwm/kains, // note 2413597
      case when m./cwm/kaspe is null then 0 else m./cwm/kaspe end                                   as /cwm/kaspe, // note 2413597
      case when m./cwm/kaein is null then 0 else m./cwm/kaein end                                   as /cwm/kaein, // note 2413597
      case when m./cwm/kavla is null then 0 else m./cwm/kavla end                                   as /cwm/kavla, // note 2413597
      case when m./cwm/kavin is null then 0 else m./cwm/kavin end                                   as /cwm/kavin, // note 2413597
      case when m./cwm/kavsp is null then 0 else m./cwm/kavsp end                                   as /cwm/kavsp, // note 2413597
      case when m./cwm/kavei is null then 0 else m./cwm/kavei end                                   as /cwm/kavei // note 2413597

}
