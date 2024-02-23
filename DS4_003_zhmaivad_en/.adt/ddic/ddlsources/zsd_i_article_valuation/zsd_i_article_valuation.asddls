/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Valuation  - Base'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_article_valuation
  as select from I_ProductValuationBasic
{
  key Product                                      as Article,
  key ValuationArea                                as ValuationArea,
  key ValuationType                                as ValuationType,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      StandardPrice                                as Price,
      Currency                                     as CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(
      client=>$session.client,
      amount => StandardPrice,
      source_currency => Currency,
      target_currency => cast ('EUR' as abap.cuky),
      round=>'X',
      exchange_rate_date => $session.system_date ) as PriceEuro

}
