@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.sqlViewName:      'NSDM_V_MARD'
@EndUserText.label:            'MARD Compatibility View'
@DataAging.noAgingRestriction: 'false'

@ObjectModel.usageType.sizeCategory: 'L'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #AUTOMATED
@AccessControl.authorizationCheck: #NOT_ALLOWED
@AbapCatalog.viewEnhancementCategory: #PROJECTION_LIST

define view nsdm_e_mard
  as select from    mard             as t
    left outer to one join nsdm_e_mard_diff as m on  t.mandt = m.mandt
                                                and t.matnr = m.matnr
                                                and t.werks = m.werks
                                                and t.lgort = m.lgort
  association [0..1] to E_Productstoragelocation as _ActiveExtension on  $projection.matnr = _ActiveExtension.Product
                                                                     and $projection.werks = _ActiveExtension.Plant
                                                                     and $projection.lgort = _ActiveExtension.StorageLocation
{
  key t.mandt,
  key t.matnr,
  key t.werks,
  key t.lgort,

      t.pstat,
      t.lvorm,

      case
      when m.gjper = '0000000'
      or m.gjper is null then
      t.lfgja
      else
      cast(substring(m.gjper, 1, 4) as abap.numc(4))
      end                                                         as lfgja,

      case
      when m.gjper = '0000000'
      or m.gjper is null then
      t.lfmon
      else
      cast(substring(m.gjper, 6, 2) as abap.numc(2))
      end                                                         as lfmon,

      t.sperr,
      case when m.labst is null then 0 else m.labst end           as labst,      // vvv note 2249780
      case when m.umlme is null then 0 else m.umlme end           as umlme,
      case when m.insme is null then 0 else m.insme end           as insme,
      case when m.einme is null then 0 else m.einme end           as einme,
      case when m.speme is null then 0 else m.speme end           as speme,
      case when m.retme is null then 0 else m.retme end           as retme,
      case when m.vmlab is null then 0 else m.vmlab end           as vmlab,
      case when m.vmuml is null then 0 else m.vmuml end           as vmuml,
      case when m.vmins is null then 0 else m.vmins end           as vmins,
      case when m.vmein is null then 0 else m.vmein end           as vmein,
      case when m.vmspe is null then 0 else m.vmspe end           as vmspe,
      case when m.vmret is null then 0 else m.vmret end           as vmret,      // ^^^ note 2249780
      t.kzill,
      t.kzilq,
      t.kzile,
      t.kzils,
      t.kzvll,
      t.kzvlq,
      t.kzvle,
      t.kzvls,
      t.diskz,
      t.lsobs,
      t.lminb,
      t.lbstf,
      t.herkl,
      t.exppg,
      t.exver,
      t.lgpbe,
      case when m.klabs is null then 0 else m.klabs end           as klabs,      // vvv note 2249780
      case when m.kinsm is null then 0 else m.kinsm end           as kinsm,
      case when m.keinm is null then 0 else m.keinm end           as keinm,
      case when m.kspem is null then 0 else m.kspem end           as kspem,      // ^^^ note 2249780
      t.dlinl,
      t.prctl,
      t.ersda,
      case when m.vklab is null then 0 else m.vklab end           as vklab,      // note 2249780
      case when m.vkuml is null then 0 else m.vkuml end           as vkuml,      // note 2249780
      t.lwmkb,
      t.bskrf,
      'X'                                                         as mdrue,
      t.mdjin,
      --field added for extensibility
      t.dummy_stl_incl_eew_ps,
      --Fields added for EA-RETAIL(FASHION)
      t.fsh_salloc_qty_s,
      case when m./cwm/labst is null then 0 else m./cwm/labst end as /cwm/labst, // note 2413597
      case when m./cwm/insme is null then 0 else m./cwm/insme end as /cwm/insme, // note 2413597
      case when m./cwm/einme is null then 0 else m./cwm/einme end as /cwm/einme, // note 2413597
      case when m./cwm/speme is null then 0 else m./cwm/speme end as /cwm/speme, // note 2413597
      case when m./cwm/retme is null then 0 else m./cwm/retme end as /cwm/retme, // note 2413597
      case when m./cwm/umlme is null then 0 else m./cwm/umlme end as /cwm/umlme, // note 2413597
      case when m./cwm/klabs is null then 0 else m./cwm/klabs end as /cwm/klabs, // note 2413597
      case when m./cwm/kinsm is null then 0 else m./cwm/kinsm end as /cwm/kinsm, // note 2413597
      case when m./cwm/keinm is null then 0 else m./cwm/keinm end as /cwm/keinm, // note 2413597
      case when m./cwm/kspem is null then 0 else m./cwm/kspem end as /cwm/kspem, // note 2413597
      case when m./cwm/vmlab is null then 0 else m./cwm/vmlab end as /cwm/vmlab, // note 2413597
      case when m./cwm/vmins is null then 0 else m./cwm/vmins end as /cwm/vmins, // note 2413597
      case when m./cwm/vmein is null then 0 else m./cwm/vmein end as /cwm/vmein, // note 2413597
      case when m./cwm/vmspe is null then 0 else m./cwm/vmspe end as /cwm/vmspe, // note 2413597
      case when m./cwm/vmret is null then 0 else m./cwm/vmret end as /cwm/vmret, // note 2413597
      case when m./cwm/vmuml is null then 0 else m./cwm/vmuml end as /cwm/vmuml // note 2413597

}
