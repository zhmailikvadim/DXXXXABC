@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Справочник область'

@Search.searchable: true

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZHR_I_REGION_VH_RAP
  as select from I_RegionText as _Region

{
      @EndUserText.label: 'Область'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key RegionName,

      @UI.hidden: true
      max(Region)  as Region,
      _Country._Text.CountryName,
      max(Country) as Country
}

where
  _Region.Language = 'R'

group by
  RegionName,
  _Country._Text.CountryName
