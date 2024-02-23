/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.10.2022 | 13456     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929251                               *
*----------------------------------------------------------------------*/@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Plant'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_plant_corr_vh
  as select distinct from t001w as Plant
    join         zsd_i_stock_difference_report as DiffReport on DiffReport.Plant = Plant.werks
{
  key Plant.werks as Plant,
      Plant.name1 as Name1
}
