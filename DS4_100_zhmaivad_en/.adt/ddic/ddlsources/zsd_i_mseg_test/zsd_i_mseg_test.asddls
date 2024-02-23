@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mseg'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_mseg_test
  as select from nsdm_e_mseg
{
  key mblnr                     as Mblnr,
  key mjahr                     as Mjahr,
  key zeile                     as Zeile,
      line_id                   as LineId,
      parent_id                 as ParentId,
      line_depth                as LineDepth,
      maa_urzei                 as MaaUrzei,
      bwart                     as Bwart,
      xauto                     as Xauto,
      matnr                     as Matnr,
      werks                     as Werks,
      lgort                     as Lgort,
      charg                     as Charg,
      insmk                     as Insmk,
      zusch                     as Zusch,
      zustd                     as Zustd,
      sobkz                     as Sobkz,
      lifnr                     as Lifnr,
      kunnr                     as Kunnr,
      kdauf                     as Kdauf,
      kdpos                     as Kdpos,
      kdein                     as Kdein,
      plpla                     as Plpla,
      shkzg                     as Shkzg,
      waers                     as Waers,
      dmbtr                     as Dmbtr,
      bnbtr                     as Bnbtr,
      bualt                     as Bualt,
      shkum                     as Shkum,
      dmbum                     as Dmbum,
      bwtar                     as Bwtar,
      menge                     as Menge,
      meins                     as Meins,
      erfmg                     as Erfmg,
      erfme                     as Erfme,
      ZZ1_WMSDate_MMI           as Zz1WmsdateMmi,
      ZZ1_WMSTime_MMI           as Zz1WmstimeMmi,
      ZZ1_zz1_zhmaivad_test_MMI as Zz1Zz1ZhmaivadTestMmi
}
