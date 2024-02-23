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
@EndUserText.label: 'Value Help for Difference Article'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_article_diff_vh
  as select distinct from zsd_i_stock_difference_report as DifferenceReport
    join                  I_ProductDescription          as ArticleTexts on  DifferenceReport.Article = ArticleTexts.Product
                                                                        and ArticleTexts.Language    = $session.system_language
{
       @EndUserText.label: 'Article'
  key  DifferenceReport.Article        as Article,
       @EndUserText.label: 'Article Description'
       ArticleTexts.ProductDescription as Description
}
