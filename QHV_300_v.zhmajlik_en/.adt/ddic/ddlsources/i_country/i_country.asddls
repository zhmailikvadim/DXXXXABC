@EndUserText.label: 'Country'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AccessControl.authorizationCheck: #NOT_REQUIRED   // #CHECK 
@AbapCatalog.sqlViewName: 'IFICOUNTRY'
@ObjectModel.representativeKey: 'Country'
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass:  #MASTER
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.compositionRoot:true
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.buffering.status: #ACTIVE          
@AbapCatalog.buffering.type: #FULL
@AbapCatalog.buffering.numberOfKeyFields: 1
@Metadata.ignorePropagatedAnnotations: true 

define view I_Country as select from t005
association [0..*] to I_CountryText as _Text on $projection.Country = _Text.Country
{
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @ObjectModel.text.association: '_Text'
    key land1 as Country,
    intca3 as CountryThreeLetterISOCode,
    intcn3 as CountryThreeDigitISOCode,
    intca  as CountryISOCode,
    
    @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
    _Text   
       
}            
  
  
  
  
  
 