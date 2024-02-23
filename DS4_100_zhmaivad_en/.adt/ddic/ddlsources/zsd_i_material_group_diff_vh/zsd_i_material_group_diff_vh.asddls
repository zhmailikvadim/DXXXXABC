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
@EndUserText.label: 'Value Help for Difference Material Group'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_material_group_diff_vh
  as select distinct from zsd_i_stock_difference_report as DifferenceReport
    join                  t023t                         as MaterialGroupTexts on MaterialGroupTexts.matkl = DifferenceReport.ArticleGroup
{
       @EndUserText.label: 'Material Group'
  key  DifferenceReport.ArticleGroup,
       @EndUserText.label: 'Material Group Description'
       MaterialGroupTexts.wgbez,
       @EndUserText.label: 'Material Group Description Long'
       MaterialGroupTexts.wgbez60
}
