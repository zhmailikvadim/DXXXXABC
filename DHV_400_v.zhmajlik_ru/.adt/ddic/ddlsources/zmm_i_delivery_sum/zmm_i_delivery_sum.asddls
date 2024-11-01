@AbapCatalog.sqlViewName: 'zmmidelivsum'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery Graph For Kontur'
@Search.searchable: true
define view ZMM_I_DELIVERY_SUM
  as select from ZMM_I_delivery_schedule as shed
    left outer join ZHR_I_LOGIN as _Login on _Login.usrid = upper( shed.PurchasingGroupName )
{
  key Material,
  key DeliveryDate,
      //ScheduleLineDeliveryDate,
      BaseUnit,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking : #HIGH
      Fullname,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum( volume ) as volume,
      coalesce(_Login.FIO,  PurchasingGroupName ) as responsible,
      request_status
      //sum( ScheduleLineOpenQuantity ) as ScheduleLineOpenQuantity
}
group by
  DeliveryDate,
  Material,
  BaseUnit,
  Fullname,
  FIO,
  PurchasingGroupName,
  request_status
  //ScheduleLineDeliveryDate
 