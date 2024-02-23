/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 09.10.2023 | 25663     : [Build] Outbound Delivery Stat *
*              |            | DS4K965942                              *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Handling Unit Status Object Wrapper'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_RP_HUSTOBJ
  as select from hustobj
{
  key objnr,
      obtyp,
      stsma,
      chgkz,
      chgnr
}
