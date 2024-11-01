@AbapCatalog.viewEnhancementCategory: [#NONE]
@AbapCatalog.sqlViewName: 'zhriHRP1001'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HRP1001 basic'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZHR_I_HRP1001
  as select from hrp1001
{
  key  uname                       as Uname,
       @ObjectModel.readOnly: true
       cast('000001' as abap.int4) as check_mod,
       otype                       as Otype,
       objid                       as Objid,
       plvar                       as Plvar,
       rsign                       as Rsign,
       relat                       as Relat,
       istat                       as Istat,
       priox                       as Priox,
       begda                       as Begda,
       endda                       as Endda,
       varyf                       as Varyf,
       seqnr                       as Seqnr,
       infty                       as Infty,
       otjid                       as Otjid,
       subty                       as Subty,
       aedtm                       as Aedtm,
       reasn                       as Reasn,
       histo                       as Histo,
       itxnr                       as Itxnr,
       sclas                       as Sclas,
       sobid                       as Sobid,
       prozt                       as Prozt,
       adatanr                     as Adatanr
} 
 