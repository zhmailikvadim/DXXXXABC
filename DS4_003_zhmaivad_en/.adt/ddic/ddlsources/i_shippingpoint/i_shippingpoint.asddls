@AbapCatalog.preserveKey:true
@ClientHandling.algorithm: #SESSION_VARIABLE 
@ObjectModel.representativeKey: 'ShippingPoint'
@ObjectModel.usageType.dataClass: #ORGANIZATIONAL
@ObjectModel.usageType.serviceQuality: #A 
@ObjectModel.usageType.sizeCategory: #S 
@EndUserText.label: 'Shipping Point'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: false }
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#CHECK
@AbapCatalog.sqlViewName: 'ISDSHIPPINGPNT'
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations:true 
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #ANALYTICAL_DIMENSION ]
@ObjectModel.modelingPattern: [ #ANALYTICAL_DIMENSION ]

@ObjectModel.sapObjectNodeType.name: 'ShippingPoint'
define view I_ShippingPoint
as select from
tvst  
association [0..*] to I_ShippingPointText as _Text on $projection.ShippingPoint = _Text.ShippingPoint
association [0..1] to I_Country as _ActiveDepartureCountry on $projection.ActiveDepartureCountry = _ActiveDepartureCountry.Country
{
    @ObjectModel.text.association: '_Text'
    key vstel as ShippingPoint,
    @ObjectModel.foreignKey.association: '_ActiveDepartureCountry'
    aland   as ActiveDepartureCountry,
    adrnr   as AddressID,
    koqui   as PickingConfirmation,
   
    _Text,
    _ActiveDepartureCountry
};
