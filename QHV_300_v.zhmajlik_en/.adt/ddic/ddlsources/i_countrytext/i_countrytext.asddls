@EndUserText.label: 'Country Text'
@Analytics: { dataExtraction.enabled: true }
@VDM.viewType: #BASIC
@VDM.lifecycle.contract: #PUBLIC_LOCAL_API
@AbapCatalog.sqlViewName: 'IFICOUNTRYTEXT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'Country'
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass:  #MASTER
@ObjectModel.usageType.serviceQuality: #A
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #ACTIVE        
@AbapCatalog.buffering.type: #GENERIC
@AbapCatalog.buffering.numberOfKeyFields: 2
@Metadata.ignorePropagatedAnnotations: true 

define view I_CountryText as select from t005t
association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
association [0..1] to I_Country as _Country on $projection.Country = _Country.Country
{
    @ObjectModel.foreignKey.association: '_Country' 
    key land1 as Country,   
    @ObjectModel.foreignKey.association: '_Language' 
    @Semantics.language
    key spras as Language,  
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    @Semantics.text: true
    landx50 as CountryName,
    
    natio as NationalityName,
    natio50 as NationalityLongName,
    landx   as CountryShortName,
    
    @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
    _Country,
    _Language

}       
  
 