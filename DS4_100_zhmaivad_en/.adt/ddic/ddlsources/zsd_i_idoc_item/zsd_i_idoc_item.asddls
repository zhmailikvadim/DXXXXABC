/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.11.2022 | 13444     : [Build] - Stock reconciliati *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 20960     : [Feature] [Build] - Stock re *
*              |            | DS4K951475                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.09.2023 | 22859     : [Feature] [Build] - Stock re *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view for IDoc Item'
define view entity zsd_i_idoc_item
  as select from zsd_i_edid4_details_tf
  association to I_Product as _Product on $projection.Article = _Product.Product
{
  key docnum,
      rtrim(Delivery,'' )                                                                          as Delivery,
      cast(
      case replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(posnr,
      '0', ''), '1', ''), '2', ''), '3', ''), '4', ''), '5', ''), '6', ''), '7', ''), '8', ''), '9', '')
      when '' then lpad(posnr, 6, '0') else posnr end as posnr )                                   as DeliveryItem,
      posnr,
      Article,
      replace_regexpr(pcre => '[^0-9.]',value => Quantity, with => '',result_length => 13 )        as Quantity,
      length(replace_regexpr(pcre => '[0-9.]',value => Quantity, with => '',result_length => 13 )) as IsNotNumberQuantityIfNotZero,
      Quantity                                                                                     as BaseQuantity,
      cast(Plant as werks_d preserving type )                                                      as Plant,
      Lgort,
      _Product.BaseUnit
}
