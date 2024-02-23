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
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Deliveries Routes and Shipping Points'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_deliv_routes_ship_points
  as select distinct from trolz
     join       tvst  on trolz.azone = tvst.azone
     join       tvswz on tvswz.vstel = tvst.vstel
{
  key    trolz.azone as DepartureZone,
  key    trolz.lzone as DestinationZone,
         tvst.vstel  as ShippingPoint,
         tvswz.werks as DepartureSite,
         trolz.vsbed as ShippingCondition,
         trolz.route as Route


}
