/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 03.01.2023 | 16554     : [Feature] [Platform] [Custom *
*              |            | DS4K939267                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Outbound Scheduling Lead Times'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
define view entity zsd_i_outboundschedulinglt
  as select from zsd_i_deliv_routes_ship_points
  association to kna1 as _Customer on $projection.DestinationZone = _Customer.lzone
  association to tvro as _Routes   on $projection.Route = _Routes.route


{
             //OutobundSchedulingLT
  key        DepartureSite,
  key        ShippingPoint,

             //TransportationLT
             cast(cast(_Customer.kunnr as abap.char( 4 ) ) as werks_d preserving type ) as DestinationSite,
             _Customer.werks                                                            as LocationPlant,

             //DestinationLT
             ShippingCondition,
             CEIL( _Routes.traztd  / 240000 )                                           as DestinationSiteLT,

             Route                                                                      as Route,
             DestinationZone
}
where
  _Customer.werks = _Customer.kunnr
