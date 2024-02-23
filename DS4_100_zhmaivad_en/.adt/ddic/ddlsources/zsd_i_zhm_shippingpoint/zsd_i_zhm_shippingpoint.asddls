@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Shipping Points'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity zsd_i_zhm_shippingpoint
  as select from tvst
  association to tvswz as _ShippingPointsPerPlant on $projection.ShippingPoint = _ShippingPointsPerPlant.vstel
{
  key tvst.vstel                    as ShippingPoint,
      _ShippingPointsPerPlant.werks as Plant,
      tvst.azone                    as DepartureZone
}
