/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 07.11.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
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

define view entity zsd_i_idoc_errors_aggregate
  as select from zsd_i_idoc_errors
{
  key      Article,
  key      Plant,
  key      StorageLocation,
           sum(cast(case when Quantity = '' then '00000000' else
           cast(Quantity as abap.numc( 8 )) end as abap.int4 )) as StockQuantity,
           count( * )                                           as ErrorQuantity
}
group by
  Article,
  Plant,
  StorageLocation
