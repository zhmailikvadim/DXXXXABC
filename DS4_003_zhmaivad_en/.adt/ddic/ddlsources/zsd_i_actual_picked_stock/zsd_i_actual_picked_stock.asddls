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
@EndUserText.label: 'Actual Picked Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zsd_i_actual_picked_stock
  as select from zsd_i_deliveries_for_order as _Deliveries
    inner join   vbfa                       as _DoncumentFlow on  _DoncumentFlow.vbelv   = _Deliveries.DeliveryDoc
                                                              and _DoncumentFlow.posnv   = _Deliveries.DeliveryItem
                                                              and _DoncumentFlow.vbtyp_n = 'Q'
{
  key  _Deliveries.OrderNumber,
  key  _Deliveries.OrderItemNumber,
  key  _Deliveries.DeliveryDoc,
  key  _Deliveries.DeliveryItem,
       @Semantics.quantity.unitOfMeasure: 'Meins'
       sum( case when _DoncumentFlow.vbtyp_v = 'T' then  - _DoncumentFlow.rfmng
                 else _DoncumentFlow.rfmng end ) as StockQuantity,
       _DoncumentFlow.meins                      as Meins
}
group by
  _Deliveries.OrderNumber,
  _Deliveries.OrderItemNumber,
  _Deliveries.DeliveryDoc,
  _Deliveries.DeliveryItem,
  _DoncumentFlow.meins
