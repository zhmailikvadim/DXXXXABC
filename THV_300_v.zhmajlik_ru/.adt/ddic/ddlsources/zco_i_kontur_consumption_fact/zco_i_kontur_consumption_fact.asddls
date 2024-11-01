@AbapCatalog.sqlViewName: 'zcoikontconsump '
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cosumptions for Kontur'
@Metadata.ignorePropagatedAnnotations: true
define view zco_i_kontur_consumption_fact
  as select from zco_i_kontur_consump_fact_coep
  association to I_Order as _Order on $projection.orderid = _Order.OrderID
{
  Aufnr,
  _Order.zzportalid,
  _Order.OrderType,
  _Order.OrderID
} 
where Aufnr > '' 
 