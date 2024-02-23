@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Routes'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_zhm_routes
  as select from tvro
  association to trolz as _RoutesDeterminateInDeliveries on $projection.Route = _RoutesDeterminateInDeliveries.route
{
  key route                                as Route,
      trazt                                as Trazt,
      traztd                               as Traztd,
      _RoutesDeterminateInDeliveries.vsbed as ShippingCondition,
      _RoutesDeterminateInDeliveries.azone,
      _RoutesDeterminateInDeliveries.lzone,
      tdvzt                                as Tdvzt,
      tdvztd                               as Tdvztd,
      tdvznd                               as Tdvznd,
      spfbk                                as Spfbk,
      expvz                                as Expvz,
      tdiix                                as Tdiix,
      spzst                                as Spzst,
      fahztd                               as Fahztd,
      distz                                as Distz,
      medst                                as Medst,
      vsart                                as Vsart,
      vsavl                                as Vsavl,
      vsanl                                as Vsanl,
      tdlnr                                as Tdlnr,
      routid                               as Routid,
      tctab                                as Tctab,
      allowed_twgt                         as AllowedTwgt,
      allowed_uom                          as AllowedUom
}
