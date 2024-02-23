@ClientHandling.algorithm: #SESSION_VARIABLE //Inserted by VDM CDS Suite Plugin
@ObjectModel.representativeKey: 'ShippingType'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
//Commented by VDM CDS Suite Plugin:@ObjectModel.representativeKey: 'ShippingType'
@EndUserText.label: 'Shipping Type'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: false }
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ILESHIPPINGTYPE'
@Metadata.ignorePropagatedAnnotations:true 
@Search.searchable: true
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #ANALYTICAL_DIMENSION, #SEARCHABLE_ENTITY ]
@ObjectModel.modelingPattern: [ #ANALYTICAL_DIMENSION ]

define view I_ShippingType
as select from
t173
association [0..*] to I_ShippingTypeText as _Text on $projection.ShippingType = _Text.ShippingType
{
    @ObjectModel.text.association: '_Text'
    @Search.defaultSearchElement: true
    key vsart as ShippingType,

    _Text
};  
