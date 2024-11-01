@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Справочник Страна'

@Search.searchable: true

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZHR_I_COUNTRY_VH_RAP
  as select from I_CountryText

{
      @EndUserText.label: 'Страна'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key CountryName,

      @UI.hidden
      Country
}

where
  Language = 'R'
