/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Delivery Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_delivery_items
  as select from lips
{
  key vbeln                                     as Vbeln,
  key cast( posnr as posnr_vl preserving type ) as Posnr,
      vgbel                                     as Vgbel,
      vgpos                                     as Vgpos,
      @Semantics.quantity.unitOfMeasure: 'meins'
      lgmng as UnrestrictedStockQty,
      meins

}
