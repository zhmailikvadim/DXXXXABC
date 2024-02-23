@AbapCatalog: {
                sqlViewName:      'NSDM_V_MSEG',
                compiler.compareFilter: true,
                preserveKey: true,
                viewEnhancementCategory: #PROJECTION_LIST
              }
@EndUserText.label:            'MSEG Compatibility View'
@DataAging.noAgingRestriction: 'false'

@ObjectModel: {
                usageType:
                  {
                    sizeCategory: #XL,
                    serviceQuality: #B,
                    dataClass: #TRANSACTIONAL
                  }
              }
@ClientHandling.algorithm: #AUTOMATED
@AccessControl.authorizationCheck: #NOT_ALLOWED
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/

define view nsdm_e_mseg
  as select from matdoc 
  association [1..1] to E_MaterialDocumentItem  as _ProcessExtension  on  $projection.mblnr                            = _ProcessExtension.MaterialDocument
                                                                      and $projection.mjahr                            = _ProcessExtension.MaterialDocumentYear
                                                                      and $projection.zeile                            = _ProcessExtension.MaterialDocumentItem
                                                                      and _ProcessExtension.MaterialDocumentRecordType = 'MDOC'
  association [1..1] to E_MaterialDocumentItem_2 as _ProcessExtension2 on  $projection.mblnr                             = _ProcessExtension2.MaterialDocument
                                                                       and $projection.mjahr                             = _ProcessExtension2.MaterialDocumentYear
                                                                       and $projection.zeile                             = _ProcessExtension2.MaterialDocumentItem
                                                                       and _ProcessExtension2.MaterialDocumentRecordType = 'MDOC'
{
  key mandt,
  key mblnr,
  key mjahr,
  key zeile,
      line_id,
      parent_id,
      line_depth,
      maa_urzei,
      bwart,
      xauto,
      matnr,
      werks,
      lgort,
      charg,
      insmk,
      zusch,
      zustd,
      sobkz,
      lifnr,
      kunnr,
      kdauf,
      kdpos,
      kdein,
      plpla,
      shkzg,
      waers,
      dmbtr,
      bnbtr,
      bualt,
      shkum,
      dmbum,
      bwtar,
      menge,
      meins,
      erfmg,
      erfme,
      bpmng,
      bprme,
      ebeln,
      ebelp,
      lfbja,
      lfbnr,
      lfpos,
      sjahr,
      smbln,
      smblp,
      elikz,
      sgtxt,
      equnr,
      wempf,
      ablad,
      gsber,
      kokrs,
      pargb,
      parbu,
      kostl,
      projn,
      aufnr,
      anln1,
      anln2,
      xskst,
      xsauf,
      xspro,
      xserg,
      gjahr,
      xruem,
      xruej,
      bukrs,
      belnr,
      buzei,
      belum,
      buzum,
      rsnum,
      rspos,
      kzear,
      pbamg,
      kzstr,
      ummat,
      umwrk,
      umlgo,
      umcha,
      umzst,
      umzus,
      umbar,
      umsok,
      kzbew,
      kzvbr,
      kzzug,
      weunb,
      palan,
      lgnum,
      lgtyp,
      lgpla,
      bestq,
      bwlvs,
      tbnum,
      tbpos,
      xblvs,
      vschn,
      nschn,
      dypla,
      ubnum,
      tbpri,
      tanum,
      weanz,
      grund,
      evers,
      evere,
      imkey,
      kstrg,
      paobjnr,
      prctr,
      ps_psp_pnr,
      nplnr,
      aufpl,
      aplzl,
      aufps,
      vptnr,
      fipos,
      sakto,
      bstmg,
      bstme,
      xwsbr,
      emlif,
      dummy_incl_eew_cobl,
      exbwr,
      vkwrt,
      aktnr,
      zekkn,
      vfdat,
      cuobj_ch,
      exvkw,
      pprctr,
      rsart,
      geber,
      fistl,
      matbf,
      ummab,
      bustm,
      bustw,
      mengu,
      wertu,
      lbkum,
      salk3,
      vprsv,
      fkber,
      dabrbz,
      vkwra,
      dabrz,
      xbeau,
      lsmng,
      lsmeh,
      kzbws,
      qinspst,
      urzei,
      j_1bexbase,
      mwskz,
      txjcd,
      ematn,
      j_1agirupd,
      vkmws,
      hsdat,
      berkz,
      mat_kdauf,
      mat_kdpos,
      mat_pspnr,
      xwoff,
      bemot,
      prznr,
      llief,
      lstar,
      xobew,
      grant_nbr,
      zustd_t156m,
      spe_gts_stock_ty,
      kblnr,
      kblpos,
      xmacc,
      vgart  as vgart_mkpf,
      budat  as budat_mkpf,
      cpudt  as cpudt_mkpf,
      cputm  as cputm_mkpf,
      usnam  as usnam_mkpf,
      xblnr  as xblnr_mkpf,
      tcode2 as tcode2_mkpf,
      vbeln_im,
      vbelp_im,
      sgt_scat,
      sgt_umscat,
      sgt_rcat,
      serviceperformer,
      pernr,
      knttp_gr,
      work_item_id,
      fbuda,
      xprint,
      /cwm/menge,
      /cwm/meins,
      /cwm/erfmg,
      /cwm/erfme,
      service_doc_type,
      service_doc_id,
      service_doc_item_id,
      ewm_lgnum,
      ewm_gmdoc,
      resourcename_sid,
      resourcename_cid,
      dummy_matdoc_incl_eew_ps,

      /*
      Fields which do belong to APPENDs on MSEG will be provided via EXTEND VIEW to this view.
      Hence, Industries having also APPENDs can use the same technique
      and just because the alphabetical sequence of APPENDs is also valid for EXTEND VIEW the compability will be ensured.
      The name of the IS EXTEND VIEW has to be the same as the APPEND. Rules are:
      ABAP Catalog Objekt: <Append>_V
      DDL Source <Append>_DDL
      CDS View = <Append>_E
      The alphabetical order of the EXTEND VIEW in the final proxy view is according to the name of sqlViewAppendName
      and not accroding to DDL source name or the EXTEND VIEW name! Hence there is still a restriction on 16 chars!
      */
      /*
      DDL sources of known extensions so far:
      DISUB_MSEG_DATA__DDL
      FSH_MSEGDATA_APPEND_DDL
      ISAUTO_COMPL_MSEG_DDL
      ISAUTO_ESCR_QTY_DIFFMSEG_DDL
      JVMSEG_DDL
      WRF_MSEG_APPEND_DDL
      */
      _ProcessExtension,
      _ProcessExtension2

}
where
  record_type = 'MDOC'
