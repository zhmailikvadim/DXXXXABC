@AbapCatalog.sqlViewName: 'zcoikontconsump1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cosumptions for Kontur'
@Metadata.ignorePropagatedAnnotations: true
define view ZCO_I_KONTUR_CONSUMPTION
  as select from ZCO_I_KONTUR_CONSUMPTION_COEP
  association to I_Order as _Order on $projection.orderid = _Order.OrderID
{
  Aufnr,
  _Order.zzportalid,
  _Order.OrderType,
  _Order.OrderID
} 
where Aufnr > '' 
 