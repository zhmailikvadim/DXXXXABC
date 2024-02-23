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
      MovingAveragePrice                           as MovingPrice,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      StandardPrice                                as StandardPrice,
      cast ('EUR' as abap.cuky)                    as CurrencyCode,
      Currency,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(
      client=>$session.client,
      amount => case when MovingAveragePrice = 0
                  then StandardPrice
                  else MovingAveragePrice end,
      source_currency => Currency,
      target_currency => cast ('EUR' as abap.cuky),
      round=>'X',
      exchange_rate_date => $session.system_date ) as Price


      //      case when MovingAveragePrice = 0 then StandardPrice
      //      else MovingAveragePrice end                  as Price
}
