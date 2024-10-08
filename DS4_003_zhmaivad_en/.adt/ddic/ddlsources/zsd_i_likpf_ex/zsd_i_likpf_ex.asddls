/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KASKODAR     |14.02.2023  | FB_17046_SD_[BUILD] Deliveries on Hold   *
*              |            | DS4K940860                               *
*----------------------------------------------------------------------*                                                                      *
* MOKHNVAD     |23.11.2023  | FB_27052_SD_Delivery Note related table  *
*              |            | LIKP & LIPS*                             *       
*              |            | DS4K971565                               *
*----------------------------------------------------------------------*/
@VDM.viewType: #BASIC
@Analytics.dataCategory:#FACT
@Metadata.allowExtensions: true
@Analytics: {
   internalName: #LOCAL,
    dataExtraction: {
       enabled: true,
       delta.changeDataCapture: {
            automatic : true
            }
      }
}
@ObjectModel: {
   representativeKey: 'vbeln',
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XL
   }
}
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SD Document: Delivery Header Data'
define view entity ZSD_I_LIKPF_EX as select from likp {
        key vbeln,
        ernam,
        erzet,
        erdat,
        bzirk,
        vstel,
        vkorg,
        lfart,
        autlf,
        kzazu,
        wadat,
        lddat,
        tddat,
        lfdat,
        kodat,
        ablad,
        inco1,
        inco2,
        expkz,
        route,
        faksk,
        lifsk,
        vbtyp,
        knfak,
        tpqua,
        tpgrp,
        lprio,
        vsbed,
        kunnr,
        kunag,
        kdgrp,
        stzkl,
        stzzu,
        @DefaultAggregation: #SUM
        @Semantics.quantity.unitOfMeasure: 'GEWEI'
        btgew,
        @DefaultAggregation: #SUM
        @Semantics.quantity.unitOfMeasure: 'GEWEI'
        ntgew,
        gewei,
        @DefaultAggregation: #SUM
        @Semantics.quantity.unitOfMeasure: 'VOLEH'
        volum,
        voleh,
        anzpk,
        berot,
        lfuhr,
        grulg,
        lstel,
        tragr,
        fkarv,
        fkdat,
        perfk,
        routa,
        stafo,
        kalsm,
        knumv,
        waerk,
        vkbur,
        vbeak,
        zukrl,
        verur,
        commn,
        stwae,
        stcur,
        exnum,
        aenam,
        aedat,
        lgnum,
        lispl,
        vkoiv,
        vtwiv,
        spaiv,
        fkaiv,
        pioiv,
        fkdiv,
        kuniv,
        kkber,
        knkli,
        grupp,
        sbgrp,
        ctlpc,
        cmwae,
        @DefaultAggregation: #SUM
        @Semantics.amount.currencyCode: 'CMWAE'
        amtbl,
        bolnr,
        lifnr,
        traty,
        traid,
        cmfre,
        cmngv,
        xabln,
        bldat,
        wadat_ist,
        trspg,
        tpsid,
        lifex,
        ternr,
        kalsm_ch,
        klief,
        kalsp,
        knump,
        @DefaultAggregation: #SUM
        @Semantics.amount.currencyCode: 'WAERK'
        netwr,
        aulwe,
        werks,
        lcnum,
        abssc,
        kouhr,
        tduhr,
        lduhr,
        wauhr,
        lgtor,
        lgbzo,
        akwae,
        akkur,
        akprz,
        proli,
        xblnr,
        handle,
        tsegfl,
        tsegtp,
        tzonis,
        tzonrc,
        cont_dg,
        verursys,
        kzwab,
        tcode,
        vsart,
        trmtyp,
        sdabw,
        vbund,
        xwoff,
        dirta,
        prvbe,
        folar,
        podat,
        potim,
        vganz,
        imwrk,
        spe_loekz,
        spe_loc_seq,
        spe_acc_app_sts,
        spe_shp_inf_sts,
        spe_ret_canc,
        spe_wauhr_ist,
        spe_wazone_ist,
        spe_rev_vlstk,
        spe_le_scenario,
        spe_orig_sys,
        spe_chng_sys,
        spe_georoute,
        spe_georouteind,
        spe_carrier_ind,
        spe_gts_rel,
        spe_gts_rt_cde,
        spe_rel_tmstmp,
        spe_unit_system,
        spe_inv_bfr_gi,
        spe_qi_status,
        spe_red_ind,
        sakes,
        spe_lifex_type,
        spe_ttype,
        spe_pro_number,
        loc_guid,
        spe_billing_ind,
        printer_profile,
        msr_active,
        prtnr,
        stge_loc_change,
        tm_ctrl_key,
        dlv_split_initia,
        dlv_version,
        _dataaging,
        gts_vorpa,
        gts_vornu,
        gts_expvz,
        gts_porti,
        itm_expvz,
        itm_stgbe,
        itm_kzgbe,
        itm_vygid,
        itm_iever,
        itm_stabe,
        itm_kzabe,
-- Mokhnatkin Vadim T4MTEMP-72974 - https://jira.tools.3stripes.net/browse/T4MTEMP-72974
        handoverloc,
        handoverdate,
        handovertime,
        handovertzone,
        bestk,
        cmpsc,
        cmpsd,
        cmpsi,
        cmpsj,
        cmpsk,
        cmps_cm,
        cmps_te,
        cmgst,
        fkivk,
        fkstk,
        gbstk,
        hdall,
        hdals,
        koquk,
        kostk,
        kostk_wh,
        lvstk,
        pdstk,
        pkstk,
        spe_tmpid,
        spstg,
        trsta,
        uvall,
        uvals,
        uvfak,
        uvfas,
        uvpak,
        uvpas,
        uvpik,
        uvpis,
        uvvlk,
        uvvls,
        uvwak,
        uvwas,
        vestk,
        vlstk,
        wbstk,
        uvk01,
        uvk02,
        uvk03,
        uvk04,
        uvk05,
        uvs01,
        uvs02,
        uvs03,
        uvs04,
        uvs05,
        total_pcsta,
        total_dgsta,
        total_sdssta,
        total_arc_status,
        ico_fkivk,
        total_emcst,
        total_slcst,
        total_lccst,
        /sapmp/lbask,
        incov,
        inco2_l,
        inco3_l,
        inco2_key,
        inco3_key,
        inco4_key,
        oid_extbol,
        oid_miscdl,
        ext_bus_syst_id,
        sitkz_db,
        tm_adv_ship_recv,
        tm_whse_exec,
        tm_whse_block,
        lglc_lic_ind,
        creation_ts,
        changed_ts,
        corr_ind,
        dummy_delivery_incl_eew_ps,
        zz1_seq_no_dlh,
        zz1_wms_palqty_dlh,
        zz1_otcdldate_dlh,
--        zz1_parentdeliverynote_dlh,
        zz1_wms_carqty_dlh,
        zz1_wms_carrierstr_dlh,
        zz1_wms_loadid_dlh,
        zz1_delscen_sdi_dlh,
        zz1_tms_carrierstr_dlh,
        zz1_tms_loadid_dlh,
        zz1_otcdldate_sdi_dlh,
        zz1_zotcbook_dlh,
        zz1_route_st_dlh,
        zz1_delscen_dlh,
        /bev1/luleinh,
        /bev1/rpfaess,
        /bev1/rpkist,
        /bev1/rpcont,
        /bev1/rpsonst,
        /bev1/rpflgnr,
        idt_cur_evtloc,
        idt_cur_evtqua,
        idt_cur_evttst,
        idt_cur_estloc,
        idt_cur_estqua,
        idt_cur_esttst,
        idt_cur_wrkqua,
        idt_pre_evtloc,
        idt_pre_evtqua,
        idt_pre_evttst,
        idt_pre_estloc,
        idt_pre_estqua,
        idt_pre_esttst,
        idt_pre_wrkqua,
        idt_ref_estloc,
        idt_ref_estqua,
        idt_ref_esttst,
        idt_firm_lfdat,
        idt_docnum,
        borgr_grp,
        kbnkz,
        fsh_transaction,
        fsh_vas_last_item,
        fsh_vas_cg,
        rfm_psst_group,
        ext_act_date_tocd,
        ext_plan_date_tocd,
        ext_tzone_tocd,
        int_act_date_tocd,
        int_plan_date_tocd,
        int_tzone_tocd,
        jit_rlvnt        
    
}
