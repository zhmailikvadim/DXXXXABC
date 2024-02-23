/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Product for Rejected Orderbook'
@AccessControl.authorizationCheck: #CHECK
define view entity zsd_i_product_rj
  as select from I_Product
  association [0..*] to mean        as _EANs                   on  $projection.Product = _EANs.matnr
                                                               and _EANs.eantp         = 'UC'
  association        to mara        as _ProductDb              on  $projection.Product = _ProductDb.matnr
  association [0..*] to zpd_t_zmmsc as _SportsCodeDescriptions on  $projection.SportCategory = _SportsCodeDescriptions.zzmsc

{
  key I_Product.Product,
      _ProductDb.zzmsc as SportCategory,
      _EANs,
      _SportsCodeDescriptions
}
