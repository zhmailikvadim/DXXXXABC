/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 07.11.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 20960     : [Feature] [Build] - Stock re *
*              |            | DS4K951475                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Idoc Errors - Aggregate by Art,Plnt,Stor'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zsd_i_errors_goods_issue_sum
  as select from zsd_i_errors_goods_issue_idoc
  association to I_Product as _Product on $projection.Article = _Product.Product
{
  key      Article,
  key      Plant,
  key      StorageLocation,
           _Product.BaseUnit as BaseUnit,
           @Semantics.quantity.unitOfMeasure: 'BaseUnit'
           sum(Quantity)     as StockQuantity
}
group by
  _Product.BaseUnit,
  Article,
  Plant,
  StorageLocation
