@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'Region'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@AbapCatalog.sqlViewName: 'IREGIONTEXT'
@AbapCatalog.preserveKey:true
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Region Text'
@Analytics.dataExtraction.enabled: true
@VDM.viewType: #BASIC
@AccessControl.personalData.blocking: #NOT_REQUIRED
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations:true

define view I_RegionText
  as select from t005u
  association [0..1] to I_Region   as _Region   on  $projection.Region  = _Region.Region
                                                and $projection.Country = _Region.Country
  association [0..1] to I_Language as _Language on  $projection.Language = _Language.Language
  association [0..1] to I_Country  as _Country  on  $projection.Country = _Country.Country
{
      @ObjectModel.foreignKey.association: '_Country'
  key t005u.land1 as Country,
      @ObjectModel.foreignKey.association: '_Region'
  key t005u.bland as Region,
      @Semantics.language
      @ObjectModel.foreignKey.association: '_Language'
  key t005u.spras as Language,
      @Semantics.text
      t005u.bezei as RegionName,
      _Region,
      _Language,
      _Country
}
