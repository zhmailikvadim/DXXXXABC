@AbapCatalog.sqlViewName: 'ICOUNTYCODE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics : {dataCategory: #DIMENSION, dataExtraction.enabled : true}
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'County Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'County'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API

define view I_CountyCode as select from adrcounty
    association [0..*] to I_CountyCodeText as _Text on $projection.Country = _Text.Country
                                                   and $projection.Region = _Text.Region
                                                   and $projection.County = _Text.County
                                                   
    association [1..1] to I_Region as _Region on $projection.Region = _Region.Region
                                             and $projection.Country = _Region.Country
                                             
    association [1..1] to I_Country as _Country on $projection.Country = _Country.Country
{   
    @ObjectModel.foreignKey.association: '_Country'
    key country as Country,
    @ObjectModel.foreignKey.association: '_Region'
    key region as Region,
    @ObjectModel.text.association: '_Text'
    key county_code as County,
    _Text,
    _Region,
    _Country
}       
  
  
  
 