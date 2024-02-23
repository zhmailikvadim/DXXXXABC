@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shipping Point Time Zone'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_shipping_point_time_zone
  as select from I_DeliveryDocument as Delivery
    inner join   I_ShippingPoint    as ShippingPoint on Delivery.ShippingPoint = ShippingPoint.ShippingPoint
  association to I_AddrOrgNamePostalAddress as _Address on ShippingPoint.AddressID = _Address.AddressID

{
  key Delivery.DeliveryDocument,
      Delivery.SDDocumentCategory,
      Delivery.DeliveryDocumentType,
      ShippingPoint.zzazone,
      ShippingPoint.AddressID,
      _Address.AddressTimeZone
}
