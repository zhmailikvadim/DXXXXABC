@AbapCatalog.sqlViewName: 'PRDSCMMATLOC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.type: #INHERITED
@ClientHandling.algorithm: #AUTOMATED
@EndUserText.label: 'Redirect for /SAPAPO/MATLOC'

define view P_Prdscm_Matloc
  as select from           P_Prdscm_Locmap_Union as _union

    join                   mara                                       on _union.matnr = mara.matnr

    left outer to one join t438m                 as _t438m            on  _union.werks = _t438m.werks
                                                                      and _union.disgr = _t438m.mtart

    inner join             /sapapo/loc           as _loc              on  _union.locid   = _loc.locid
                                                                      and _union.loctype = _loc.loctype

    left outer to one join mara                  as ref_marc_stdpd    on ref_marc_stdpd.matnr = _union.stdpd

    left outer to one join /sapapo/resnet        as _resnet           on _union.scm_res_net_name = _resnet.res_net_name

    left outer to one join /sapapo/heurpack      as _heurpack         on _union.scm_package_id = _heurpack.package_id

    left outer to one join /sapapo/rrpcust1      as _rrpcust1         on _rrpcust1.mandt = _union.client

  association [1..1] to t399d                    as _t399d            on  _union.werks = _t399d.werks
  association [0..1] to t436a                    as _t436a            on  _union.werks = _t436a.werks
                                                                      and _union.fhori = _t436a.fhori
  // read with _union-strgr, otherwhise read with t438m-strgr
  association [0..1] to P_Prdscm_T459a           as _t459a_from_marc  on  _union.strgr = _t459a_from_marc.strgr
  association [0..1] to P_Prdscm_T459a           as _t459a_from_t438m on  _t438m.strgr = _t459a_from_t438m.strgr
  --association enbaling extensibility
  association [0..1] to E_Productplant           as _ActiveExtension  on  _union.matnr = _ActiveExtension.Product
                                                                      and _union.werks = _ActiveExtension.Plant

{
  key _union.matid                                                                        as MATID,
  key _union.locid                                                                        as LOCID,
      _union.lvorm                                                                        as LVORM,
      cast('' as /sapapo/diuom)                                                           as DIUOM,
      _union.mtvfp                                                                        as MTVFP,

      // read strategy group only, if _union or t438m provides strgr
      // read T461P & T461S -> return T461S-BEDKU
      // if _union-strgr is not initial: read T461P with _union-strgr
      // else if t438m-strgr is not initial: read T461P with _union-strgr
      // then read t461s with T461P-HPTST
      // then get requirement type in ATP_CHMOD
      case
      // use _union-strgr
        when (_union.strgr <> ''  or _union.strgr is not null) and (_t459a_from_marc.bedar <> '' or _t459a_from_marc.bedar is not null)
          then _t459a_from_marc.bedar
      // use t438m
        when (_t438m.strgr <> '' or _t438m.strgr is not null) and (_t459a_from_t438m.bedar <> '' or _t459a_from_t438m.bedar is not null)
          then _t459a_from_t438m.bedar
        else ''
      end                                                                                 as ATP_CHMOD,

      // see function module CALCULATE_APO_CHECK_HORIZON
      cast(lpad(cast(
        case
          when _union.beskz = 'F'
            then cast(_t399d.bztek as abap.dec(2)) + _union.plifz + _union.webaz

          when _union.beskz <> 'F' and _union.wzeit > 0
            then _union.wzeit

          when _union.beskz <> 'F' and _union.wzeit = 0 and _union.dzeit > 0
            then _union.dzeit + _union.webaz

          when _union.beskz <> 'F' and _union.wzeit = 0 and _union.dzeit <= 0
            then case division(_union.bearz+_union.ruezt+_union.tranz, 100, 0 ) * 100 - _union.bearz - _union.ruezt - _union.tranz // get rounded value (DIVISION rounds) and build difference
                   when 0
                     then division(_union.bearz+_union.ruezt+_union.tranz, 100, 0 ) //rounded value is equal
                   when abs(division(_union.bearz+_union.ruezt+_union.tranz, 100, 0 ) * 100 - _union.bearz-_union.ruezt-_union.tranz)
                     then division(_union.bearz+_union.ruezt+_union.tranz, 100, 0 )//difference of roundet value is greater 0
                   else division(_union.bearz+_union.ruezt+_union.tranz+100, 100, 0 ) //difference of roundet value is less  -> Add 100
                 end

          else 0

        end as abap.char(10)),3,'0') as /sapapo/chkhor)                                   as CHKHOR,
      case _union.beskz
        when 'F'
          then ' '
        else _loc.ppcal
      end                                                                                 as CHKHORCAL,
      '000'                                                                               as RCRRCPHOR,
      ''                                                                                  as PSSFLAG,
      cast('' as /sapapo/kosch)                                                           as KOSCH,
      cast('' as /sapapo/kosch_grp)                                                       as KOSCH_GRP,
      cast('' as /sapapo/vmikosch)                                                        as VMIKOSCH,
      cast('' as /sapapo/vmikosch_grp)                                                    as VMIKOSCH_GRP,
      _union.cuobj                                                                        as CUOBJ,
      case
        when _union.stdpd <> '' and _union.stdpd is not null
          then ref_marc_stdpd.scm_matid_guid22
        else ''
      end                                                                                 as SATID,

      case
        when mara.kzkfg <> ''
          then mara.kzkfg
        when _union.sgt_covs <> ''
          then 'X'
        else ''
      end                                                                                 as KZKFG,
      case
        when _union.loctype = '1050'
          then _union.scm_grprt //Do not use WEBAZ from plant for subcontractor
        when _union.scm_grprt = 0 or _union.scm_grprt is null and _union.webaz is not null
          then cast(_union.webaz*240000 as /sapapo/grprt)
        else _union.scm_grprt
      end                                                                                 as GRPRT,
      _union.scm_giprt                                                                    as GIPRT,
      _union.plifz                                                                        as PLIFZ,
      _union.lgrad                                                                        as LGRAD,
      _union.scm_scost                                                                    as SCOST,
      _union.beskz                                                                        as BESKZ,
      _union.scm_matlocid_guid22                                                          as LSZID,
      cast('' as /sapapo/snpdprid)                                                        as DPRID,
      cast('' as /sapapo/snpsprid)                                                        as SPRID,
      cast('' as /sapapo/snpdplid)                                                        as DPLID,
      cast('' as /sapapo/matstore)                                                        as MATSTORE,
      cast(_union.eisbe as /sapapo/safty)                                                 as SAFTY,
      cast('' as sysuuid_22)                                                              as STOCK_UID,
      ''                                                                                  as SW_SCZPRF,
      _union.scm_matlocid_guid22                                                          as RQMID,
      cast(0 as /sapapo/saftyc_max)                                                       as SAFTYC_MAX,
      cast(0 as /sapapo/saftyc_min)                                                       as SAFTYC_MIN,
      _union.scm_reldt                                                                    as RELDT,
      _union.scm_rrp_type                                                                 as RRP_TYPE,

      cast(case
        when _t436a.erhor is not null and _t436a.erhor <> ''
          then cast(_t436a.erhor as abap.int2) * 240000
        else 0
      end as /sapapo/erhor )                                                              as ERHOR,

      cast(case
        when _t436a.freiz is not null and _t436a.freiz <> ''
          then cast(_t436a.freiz as abap.int2) * 240000
        else 0
      end as /sapapo/freiz )                                                              as FREIZ,

      cast(case
        when _union.fxhor is not null and _union.fxhor <> '' and _union.fxhor <> '000'
          then cast(_union.fxhor as abap.int2) * 240000
        when _t438m.fixhz is not null and _t438m.fixhz <> ''
          then cast(_t438m.fixhz as abap.int2) * 240000
        else 0
      end as /sapapo/rrp_fixhz )                                                          as FIXHZ,

      _union.scm_heur_id                                                                  as HEUR_ID,
      _union.scm_package_id                                                               as PACKAGE_ID,

      case
        when _union.scm_package_id is not null and _union.scm_package_id <> ''
          then 'X'
        else  ''
      end                                                                                 as PART_OF_PACKAGE,
      case
        when _union.scm_whatbom  = ''
          then _rrpcust1.whatbom
        else _union.scm_whatbom
      end                                                                                 as WHATBOM,
      _t438m.besal                                                                        as EXPLDATE_FINDER,
      _union.convh                                                                        as CONVH,
      cast(0 as /sapapo/cthor)                                                            as CTHOR,
      cast( _t438m.resvp * 240000  as /sapapo/ajhoz )                                     as AJHOZ,
      _heurpack.package_type                                                              as PACKAGE_TYPE,
      cast('' as /sapapo/dplchrprf_id)                                                    as DPLCHRPRF_ID,
      cast(0 as /sapapo/scc_nd_stordu)                                                    as ND_STORDU,
      cast(0 as /sapapo/nd_mean_prod_per_week)                                            as ND_MEANPROD_WEEK,
      cast(_union.scm_ndcostwe as /sapapo/ndcostwe)                                       as NDCOSTWE,
      cast(_union.scm_ndcostwa as /sapapo/ndcostwa)                                       as NDCOSTWA,
      cast('' as /sapapo/dtqid)                                                           as DTQID,
      cast(0 as /sapapo/ctmdselhorz)                                                      as SELHORZ,
      '000'                                                                               as EARLYSHIP,
      ''                                                                                  as CRITICAL_COMP,
      ''                                                                                  as AGGR_CTM_PLNG,
      _union.scm_proc_cost                                                                as PROC_COST,
      cast(0 as /sapapo/prod_cost)                                                        as PROD_COST,
      _union.scm_sspen                                                                    as SSPEN,
      _union.saftystock_method                                                            as MSDP_SB_METHOD,
      _union.scm_get_alerts                                                               as GET_ALERTS,
      ''                                                                                  as SNPNOFIX,
      case
        when _union.scm_res_net_name <> ''
          then 1
        else 0
      end                                                                                 as RESNETSTRAT,
      _resnet.res_net_id                                                                  as RES_NET_ID,
      _union.scm_res_net_name                                                             as RES_NET_NAME,
      1                                                                                   as CONRESSTRAT,
      case
        when _union.scm_min_pass_amount > 0
          then 'X'
        else ''
      end                                                                                 as USE_MIN_PASS_AMT,
      _union.scm_tpop                                                                     as TPOP,
      ''                                                                                  as CCIND,
      _union.scm_scost_prcnt                                                              as SCOST_PRCNT,
      _union.scm_sft_lock                                                                 as SFT_OVERRIDE,
      _union.scm_thruput_time                                                             as THRUPUT_TIME,
      cast('0' as /sapapo/uns_prc_scost)                                                  as UNS_PRC_SCOST,
      cast(_union.scm_ppsaftystk as /sapapo/ppsaftystk)                                   as PPSAFTYSTK,
      cast(_union.scm_ppsaftystk_v as /sapapo/ppsaftystkv)                                as PPSAFTYSTK_V,
      cast(0 as /sapapo/addsftstk)                                                        as ADDSFTSTK,
      cast(0 as /sapapo/maxstorage_qty)                                                   as MAXSTOR_QTY,
      cast(_union.scm_safty_v as /sapapo/saftyv)                                          as SAFTY_V,
      cast(_union.scm_repsafty as /sapapo/repsafty)                                       as REPSAFTY,
      cast(_union.scm_repsafty_v as /sapapo/repsaftyv)                                    as REPSAFTY_V,
      cast(_union.scm_maxstock_v as /sapapo/maxstock_v)                                   as MAXSTOCK_V,
      cast(_union.scm_reord_v as /sapapo/reord_v)                                         as REORD_V,

      dats_tims_to_tstmp( _union.mfxdt,
                          _union.mfxti,
                          _loc.tzone,
                          _union.client,
                         'NULL' )                                                         as fixti,

      cast('' as /sapapo/snpcosid)                                                        as COSID,
      cast(0 as /sapapo/scost_per_day)                                                    as SCOST_PER_DAY,
      cast(_union.minbe as /sapapo/reord)                                                 as REORD,
      cast(_union.mabst as /sapapo/maxstock)                                              as MAXSTOCK,
      _union.dispo                                                                        as PLANNER_PPS,
      cast('' as /sapapo/planner_snp)                                                     as PLANNER_SNP,
      cast('' as /sapapo/planner_demand)                                                  as PLANNER_DEMAND,
      cast('' as /sapapo/planner_trans)                                                   as PLANNER_TRANS,
      cast('' as /sapapo/planner_pur)                                                     as PLANNER_PUR,
      _union.scm_conhap                                                                   as CONHAP,
      _union.scm_hunit                                                                    as HUNIT,
      _union.scm_coninp                                                                   as CONINP,
      _union.scm_iunit                                                                    as IUNIT,
      cast('' as /sapapo/kdmat)                                                           as KDMATID,
      _union.ekgrp                                                                        as EKGRP,
      cast('' as /sapapo/vegrp)                                                           as VEGRP,
      _union.scm_conhap_out                                                               as CONHAP_OUT,
      _union.scm_hunit_out                                                                as HUNIT_OUT,
      _union.ladgr                                                                        as LADGR,
      0                                                                                   as CONF_PROPAGATION,
      0                                                                                   as CONF_COMPONENTS,
      0                                                                                   as CONF_DURATION,
      ''                                                                                  as CONF_GMSYNC,
      _union.frtme                                                                        as FRTME,
      cast(0 as /sapapo/fedem)                                                            as FEDEM,
      cast(0 as /sapapo/ferld)                                                            as FERLD,
      cast(0 as /sapapo/piprt)                                                            as PIPRT,
      cast(0 as /sapapo/tlprt)                                                            as TLPRT,
      '000'                                                                               as SNPCHKHOR,
      _union.scm_rrp_sel_group                                                            as RRP_SEL_GROUP,
      _union.scm_intsrc_prof                                                              as INTSRC_PROF,
      _union.scm_prio                                                                     as PRIO,
      _union.scm_min_pass_amount                                                          as MIN_PASS_AMOUNT,
      _union.scm_profid                                                                   as PROFID,
      cast('' as /sapapo/mat_atdsp)                                                       as ATDSP,
      cast('' as /sapapo/mat_atddm)                                                       as ATDDM,
      cast('' as /sapapo/costprof_tlb)                                                    as COSTPROF,
      _union.maabc                                                                        as MAABC,
      ''                                                                                  as MAT_PRTMANAGE,
      ''                                                                                  as MANOT,
      _union.diber                                                                        as DIBER,
      cast('' as /sapapo/sublocid)                                                        as SUBLOCID,
      _union.scm_matlocid_guid22                                                          as MATLOCID,
      cast('' as /sapapo/mat_char40)                                                      as AT101,
      cast('' as /sapapo/mat_char30)                                                      as AT102,
      cast('' as /sapapo/mat_char20)                                                      as AT103,
      cast('' as /sapapo/mat_char10)                                                      as AT104,
      cast('' as /sapapo/mat_char10)                                                      as AT105,
      ''                                                                                  as MATVERS_ACTIVE,
      ''                                                                                  as MATVERS_HPLAN,
      ''                                                                                  as TDFIELDS,
      cast('' as /sapapo/planner_vmi)                                                     as PLANNER_VMI,
      cast('' as /sapapo/planner_smi)                                                     as PLANNER_SMI,
      ''                                                                                  as PRO_ORD,
      ''                                                                                  as PRO_LTP,
      cast(0 as /sapapo/os_limit)                                                         as OS_LIMIT,
      ''                                                                                  as DEADPILE,
      ''                                                                                  as SHIPPING,
      ''                                                                                  as ARRIVAL,
      ''                                                                                  as ACT_STATUS,
      cast('' as /sapapo/hugrp)                                                           as HUGRP,
      0                                                                                   as MAXCOVER,
      ''                                                                                  as MAXCOVERUP,
      ''                                                                                  as MIXTP,
      ''                                                                                  as USETP,
      ''                                                                                  as PROM_PREDL,
      _union.scm_shelf_life_loc                                                           as SHELF_LIFE_LOC,
      _union.scm_shelf_life_dur                                                           as SHELF_LIFE_DUR,
      _union.scm_maturity_dur                                                             as MATURITY_DUR,
      _union.scm_shlf_lfe_req_min                                                         as SHLF_LFE_REQ_MIN,
      _union.scm_shlf_lfe_req_max                                                         as SHLF_LFE_REQ_MAX,
      cast(0 as /sapapo/tsw_phys_min)                                                     as PHYSICAL_MIN,
      cast('' as /sapapo/rpstatus)                                                        as RPSTATUS,
      cast('' as /sapapo/measgrbuy)                                                       as MEASGRBUY,
      cast(0 as /sapapo/purtime)                                                          as PURTIME,
      cast(0 as /sapapo/minstock)                                                         as MINSTOCK,
      cast(0 as /sapapo/salesprice)                                                       as SALESPRICE,
      _union.bwscl                                                                        as BWSCL,
      '0'                                                                                 as SELLCLASS,
      cast('' as /sapapo/locid)                                                           as CONSREFLOCID,
      cast(0 as /sapapo/consreffac)                                                       as CONSREFFAC,
      cast(0 as /sapapo/consrefvalto)                                                     as CONSREFVALTO,
      cast(0 as /sapapo/targetstock)                                                      as TARGETSTOCK,
      cast(0 as /sapapo/stockmultiple)                                                    as STOCKMULTIPLE,
      cast(0 as /sapapo/reltime)                                                          as RELTIME,
      ''                                                                                  as SEASON,
      cast('0' as /sapapo/listingstatus)                                                  as LISTINGSTATUS,
      cast('' as /sapapo/profcst)                                                         as PROFCST,
      cast('' as /sapapo/prorepl)                                                         as PROREPL,
      cast('' as /sapapo/proexcp)                                                         as PROEXCP,
      cast('' as /sapapo/procl)                                                           as PROCL,
      '00'                                                                                as LEADTIMESHIFT,
      '000'                                                                               as FCHOROP,
      '000'                                                                               as FCOUTDAY,
      '000'                                                                               as FCOUTWEEK,
      cast('' as /sapapo/prosl)                                                           as PROSL,
      cast('' as /sapapo/profcfrq)                                                        as PROFCFRQ,
      cast('' as /sapapo/temprpblock)                                                     as TEMPRPBLOCK,
      ''                                                                                  as INITBUY,
      '000'                                                                               as MINTROC,
      '000'                                                                               as MAXTROC,
      cast('' as /sapapo/procalib)                                                        as PROCALIB,
      cast('' as /sapapo/balgr)                                                           as BALGR,
      cast('' as /sapapo/proprealloc)                                                     as PROPREALLOC,
      ''                                                                                  as SUBSTLOCK,
      '000'                                                                               as OFCHOR,
      cast('' as /sapapo/prooffrq)                                                        as PROOFFRQ,
      cast('' as /sapapo/matid)                                                           as CONSREFMATID,
      ''                                                                                  as DUMMY2_R,
      _union.dummy_plnt_incl_eew_ps,
      cast('' as ernam)                                                                   as CREATEUSER,
      cast(0 as /sapapo/tsucr)                                                            as CREATEUTC,
      cast('' as aenam)                                                                   as CHANGEUSER,
      cast(0 as /sapapo/tsuup)                                                            as CHANGEUTC,
      _union.maxdos_pen                                                                   as MAXDOS_PEN,
      _union.maxdos_flg                                                                   as MAXDOS_FLG,
      _union.sgt_covs                                                                     as sgt_covs
}

