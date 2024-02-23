@AbapCatalog: {
                sqlViewName: 'IPLANTCATEGORYT',
                preserveKey: true,
                compiler.compareFilter: true
              }
@EndUserText.label: 'Plant Category - Text'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
                usageType: {
                             sizeCategory: #S,
                             serviceQuality: #A,
                             dataClass:#CUSTOMIZING
                           },
                dataCategory: #TEXT,
                representativeKey: 'PlantCategory',
                sapObjectNodeType: {
                                     name: 'PlantCategory'
                                   },
                modelingPattern: #LANGUAGE_DEPENDENT_TEXT,
                supportedCapabilities: [#LANGUAGE_DEPENDENT_TEXT, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET]
              }
@VDM: {
        viewType: #BASIC,
        lifecycle.contract.type: #PUBLIC_LOCAL_API
      }
@Analytics: {
              internalName: #LOCAL,
              dataExtraction.enabled: true
            }
@Metadata: {
             ignorePropagatedAnnotations: true
           }
@Consumption.ranked: true

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/

define view I_PlantCategoryT
  as select from dd07t
  association [0..1] to I_Language                 as _Language on $projection.Language = _Language.Language
{
  key cast(substring( domvalue_l, 1, 1 ) as vlfkz) as PlantCategory, //casting to have the right label for consumers
      @Semantics.language: true
  key ddlanguage                                   as Language,
      @Semantics.text: true
      ddtext                                       as PlantCategoryName,
      _Language
}
where domname  = 'VLFKZ' and as4local = 'A'

