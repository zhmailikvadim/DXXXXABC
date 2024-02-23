@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Difference Article'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_article_diff_vh
  as select distinct from zsd_i_stock_difference_report as DifferenceReport
    join                  makt                          as ArticleTexts on  DifferenceReport.Article = ArticleTexts.matnr
                                                                        //and ArticleTexts.spras       = $session.system_language
{
  key  DifferenceReport.Article as Article,
       ArticleTexts.maktx       as Description
}
