/************************************************************************
*  R E V I S I O N   H I S T O R Y                                        *
*************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION                 *
*              |            | TRANSPORT REQUESTS                          *
*************************************************************************
* KAUSHRIS     | 10.07.2023 | 22570  :       FB_22570_PD_PDM-C Fiori App  *
*                                        Development [ BE  ]              *
*              |            |  DS4K957249                                 *
*-------------------------------------------------------------------------*
* KAUSHRIS     | 08.07.2023 | 24552  :       FB_24552_PD_PDM-C Fiori      *
                                     App Development [ BE  ]              *
*              |            |  DS4K962029                                 *
*-------------------------------------------------------------------------*
* KAUSHRIS     | 25.09.2023 | 25234  :     FB_25234_PD_PDM-C Template 1.5 *
*                                        SIT Fiori Defect Fix - BE        *
*              |            |  DS4K965078                                 *
*-------------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZPD_E_BPSALE_EXT'
@EndUserText.label: 'Ext View for C_BUSINESSPARTNERSALESAREA'
extend view C_BusinessPartnerSalesArea with ZPD_E_BPSALESAREA_EXT
  association [1] to knvv               as _knvv          on $projection.businesspartner = _knvv.kunnr
  association [1] to ZPD_I_custgrp6_TV  as _CUSTGRP6TEXT  on $projection.businesspartner = _CUSTGRP6TEXT.bp
  association [1] to ZPD_I_CUSTGRP7_TV  as _CUSTGRP7TEXT  on $projection.businesspartner = _CUSTGRP7TEXT.bp
  association [1] to ZPD_I_CUSTGRP8_TV  as _CUSTGRP8TEXT  on $projection.businesspartner = _CUSTGRP8TEXT.bp
  association [1] to ZPD_I_CUSTGRP9_TV  as _CUSTGRP9TEXT  on $projection.businesspartner = _CUSTGRP9TEXT.bp
  association [1] to ZPD_I_CUSTGRP10_TV as _CUSTGRP10TEXT on $projection.businesspartner = _CUSTGRP10TEXT.bp
  association [1] to ZPD_I_zsmorg_TV    as _ZSMORG_t      on $projection.businesspartner = _ZSMORG_t.bp
  association [1] to ZPD_I_ZZSMSEG_TV   as _ZZSMSEG_t     on $projection.businesspartner = _ZZSMSEG_t.bp
  association [1] to ZPD_I_ZZFRAIND_TV  as _ZZFRAIND_t    on $projection.businesspartner = _ZZFRAIND_t.bp
  association [1] to ZPD_I_ZPORTAS_TV   as _ZZPORTAS_t    on $projection.businesspartner = _ZZPORTAS_t.bp
    association [1] to ZPD_I_ZCUSFOC_TV   as _ZCUSFOC_t     on $projection.businesspartner = _ZCUSFOC_t.bp
association [1] to ZPD_I_ZZRULE_TV as _ZZRULE_t          on $projection.businesspartner = _ZZRULE_t.bp
association [1] to ZPD_I_ACLVL_TV as _ACLVL_t               on $projection.businesspartner = _ACLVL_t.bp
association [1] to ZPD_I_abcopt_TV as _abcopt_t on $projection.businesspartner = _abcopt_t.bp
association [1] to ZPD_I_abcspl_TV as _abcspl_t on $projection.businesspartner = _abcspl_t.bp
association [1] to ZPD_I_VasDemMode_TV as _VasDemMode_t on $projection.businesspartner = _VasDemMode_t.bp 
{

  @UI.lineItem: [ { position: 10, label: 'Switch off rounding?'} ]
  @ObjectModel.readOnly: true
  _knvv.rdoff               as SwitchOfRounding,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 20, label:'Customer Statistics Group' } ]
  _knvv.versg               as CustomerStatGrp,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 30, label:'Deletion flag for customer (sales level)' } ]
  _knvv.loevm               as DeliInd,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 40, label:'Customer/Supplier Identifier' } ]
  _knvv.fsh_sc_cid          as CustSupInd,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 50, label:'VAS Determination Mode' } ]
  _knvv.fsh_vas_detc        as VasDemMode,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 60, label:'Order Scheduling Strategy' } ]
  _knvv.fsh_ss              as OrderSchStrgy,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 70, label:'Fill Rate %' } ]
  _knvv.fsh_frate           as FillRatePer,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 80, label:'Fill Rate Aggregation Level' } ]
  _knvv.fsh_frate_agg_level as FillAggLevel,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 90, label:'Customer Group 6' } ]
  _CUSTGRP6TEXT.CustGrpSix  as CustGrpSix,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 100, label:'Customer Group 7' } ]
  _CUSTGRP7TEXT.CustGrp7    as CustGrpSeven,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 110, label:'Customer Group 8' } ]
  _CUSTGRP8TEXT.CustGrp8    as CustGrpEight,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 120, label:'Customer Group 9' } ]
  _CUSTGRP9TEXT.CustGrp9    as CustGrpNine,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 130, label:'Customer Group 10' } ]
  _CUSTGRP10TEXT.CustGrp10  as CustGrpTen,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 140, label:'Sales Block for Customer(Sales Area)' } ]
  _knvv.cassd               as SalesIsBlockedForCustomer,

  @ObjectModel.readOnly: true
  @UI.lineItem: [ { position: 150, label:'POD Timeframe' } ]
  _knvv.podtg               as PODtimeFrame,

  //Hidden, Used to get text by UI team
  @UI.hidden: true
  @ObjectModel.readOnly: true
  _ZSMORG_t.zzsmorgtext     as zzsmorgText,

  @UI.hidden: true
  @ObjectModel.readOnly: true
  _ZZSMSEG_t.zzsmsegtext    as zzsmsegText,

  @UI.hidden: true
  @ObjectModel.readOnly: true
  _ZZFRAIND_t.zzfraindtext  as zzfraindText,
  
  @UI.hidden: true
  @ObjectModel.readOnly: true
  _ZZPORTAS_t.zzportasText  as zzportasText,

  @UI.hidden: true
  @ObjectModel.readOnly: true
  _ZCUSFOC_t.zzcusfoctext   as zzcusfocText,
  
    @UI.hidden: true
  @ObjectModel.readOnly: true
 _ZZRULE_t.ZZRULEText as ZZRULEText,
 
     @UI.hidden: true
  @ObjectModel.readOnly: true
 _ACLVL_t.aclvlText as aclvlText,
 
      @UI.hidden: true
  @ObjectModel.readOnly: true
 _abcopt_t.description as abcoptText,
 
       @UI.hidden: true
  @ObjectModel.readOnly: true
 _abcspl_t.description as abcsplText,
 
         @UI.hidden: true
  @ObjectModel.readOnly: true
 _VasDemMode_t.Ddtext as VasDemModeText
 
}
