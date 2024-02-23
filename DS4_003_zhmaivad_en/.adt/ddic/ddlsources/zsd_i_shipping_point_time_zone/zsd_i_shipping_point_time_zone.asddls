/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.01.2024 | 26115     : Feature - [Defect] - Deliver *
*              |            | DS4K967671                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Shipping Point Time Zone'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity zsd_i_shipping_point_time_zone
  as select from I_DeliveryDocument as Delivery
    inner join   I_ShippingPoint    as ShippingPoint on Delivery.ShippingPoint = ShippingPoint.ShippingPoint
  association to I_AddrOrgNamePostalAddress as _Address on ShippingPoint.AddressID = _Address.AddressID

{
  key Delivery.DeliveryDocument,
      ShippingPoint.ShippingPoint,
      Delivery.SDDocumentCategory,
      Delivery.DeliveryDocumentType,
      ShippingPoint.zzazone,
      ShippingPoint.AddressID,
      _Address.AddressTimeZone
}
