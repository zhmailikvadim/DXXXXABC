@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@Analytics.dataExtraction.enabled: true 
@ClientHandling.algorithm: #SESSION_VARIABLE 
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'ShippingPoint'
@ObjectModel.usageType.dataClass: #ORGANIZATIONAL
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@EndUserText.label: 'Shipping Point - Text'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#CHECK
@AbapCatalog.sqlViewName: 'ISDSHIPPINGPNTT'
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@Metadata.ignorePropagatedAnnotations:true 
@ObjectModel.supportedCapabilities: [ #LANGUAGE_DEPENDENT_TEXT ]
@ObjectModel.modelingPattern: [ #LANGUAGE_DEPENDENT_TEXT ]

define view I_ShippingPointText
as select from 
tvstt
association[0..1] to I_ShippingPoint as _ShippingPoint on $projection.ShippingPoint = _ShippingPoint.ShippingPoint
association[0..1] to I_Language as _Language on $projection.Language = _Language.Language
{   
    @ObjectModel.foreignKey.association: '_ShippingPoint'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ShippingPointStdVH', element: 'ShippingPoint' } } ]    
    key vstel as ShippingPoint,
    
    @Semantics.language: true
    @ObjectModel.foreignKey.association: '_Language'
    key spras as Language,
    
    @Semantics.text: true 
    vtext as ShippingPointName,
    
    //Associations
    _ShippingPoint,
    _Language
};       
 