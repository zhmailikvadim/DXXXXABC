/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 27.10.2023 | 26318     : DN OS compliance Report      *
*              |            | DS4K968461                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Wrapper view for MKPF Accounting doc'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #XL,
    dataClass: #MIXED
}
define view entity ZSD_I_MKPF_EX
  as select from mkpf
{
  key mblnr          as Mblnr,
  key mjahr          as Mjahr,
      vgart          as Vgart,
      blart          as Blart,
      blaum          as Blaum,
      bldat          as Bldat,
      budat          as Budat,
      cpudt          as Cpudt,
      cputm          as Cputm,
      aedat          as Aedat,
      usnam          as Usnam,
      tcode          as Tcode,
      xblnr          as Xblnr,
      bktxt          as Bktxt,
      frbnr          as Frbnr,
      wever          as Wever,
      xabln          as Xabln,
      awsys          as Awsys,
      bla2d          as Bla2d,
      tcode2         as Tcode2,
      bfwms          as Bfwms,
      exnum          as Exnum,
      spe_budat_uhr  as SpeBudatUhr,
      spe_budat_zone as SpeBudatZone,
      le_vbeln       as LeVbeln,
      spe_logsys     as SpeLogsys,
      spe_mdnum_ewm  as SpeMdnumEwm,
      gts_cusref_no  as GtsCusrefNo,
      fls_rsto       as FlsRsto,
      msr_active     as MsrActive,
      knumv          as Knumv,
      xcompl         as Xcompl
}
//group by
//  mblnr,
//  blart
