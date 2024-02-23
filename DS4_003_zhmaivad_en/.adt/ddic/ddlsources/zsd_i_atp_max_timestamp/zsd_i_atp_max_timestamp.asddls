/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 11.05.2023 | 20690     : Feature - ATP push from S/4  *
*              |            | DS4K950897                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Max Net Change Timestamp'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_atp_max_timestamp
  as select from atpncftstamp
    join         atpnetchgfilter on atpncftstamp.netchguuid = atpnetchgfilter.netchguuid
{
  atpnetchgfilter.matnr          as Material,
  atpnetchgfilter.werks          as Plant,
  atpnetchgfilter.berid          as MrpArea,
  atpnetchgfilter.netchgcategory as NetchgCategory,
  max(atpncftstamp.netchgtstamp) as NetChgMaxTimestamp
}
group by
  atpnetchgfilter.matnr,
  atpnetchgfilter.werks,
  atpnetchgfilter.berid,
  atpnetchgfilter.netchgcategory
