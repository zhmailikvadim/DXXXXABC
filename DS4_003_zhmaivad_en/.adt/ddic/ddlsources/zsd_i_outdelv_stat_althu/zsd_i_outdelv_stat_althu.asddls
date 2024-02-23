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
@EndUserText.label: 'Basic view for Outb delivery AlternateHU'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_OUTDELV_STAT_ALTHU
  as select distinct from ZSD_I_HANDLINGUNIT_HEADER as _HU
    inner join            I_HandlingUnitHeader      as _HUheader on _HUheader.HandlingUnitInternalID = _HU.venum
{
  key _HU.spe_ident_01            as AlternativeHUIdentification,
      @UI.hidden: true
      _HU.venum                   as HandlingUnit,
      @UI.hidden: true
      _HUheader.SalesOrganization as SalesOrganization
}
where
  _HU.spe_ident_01 <> ''
