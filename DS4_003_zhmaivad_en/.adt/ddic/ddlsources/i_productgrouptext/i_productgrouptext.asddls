@AbapCatalog.sqlViewName: 'IPRODUCTGRPTXT'
//@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@VDM.viewType: #BASIC
@VDM.lifecycle.status: #DEPRECATED
@VDM.lifecycle.successor: 'I_ProductGroupText_2'
@ObjectModel.dataCategory: #TEXT
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Group - Text'
@ObjectModel.representativeKey: 'MaterialGroup'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #S
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #SEARCHABLE_ENTITY,
                                      #LANGUAGE_DEPENDENT_TEXT
]
define view I_ProductGroupText
  as select from t023t
  association [0..1] to I_ProductGroup as _MaterialGroup on $projection.MaterialGroup = _MaterialGroup.MaterialGroup
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @ObjectModel.foreignKey.association: '_MaterialGroup'
  key cast(t023t.matkl as productgroup preserving type )     as MaterialGroup,
      @Semantics.language: true
  key t023t.spras                                            as Language,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      cast(t023t.wgbez as productgroupname preserving type ) as MaterialGroupName,
      @Semantics.text: true
      t023t.wgbez60                                          as MaterialGroupText,
      _MaterialGroup
}
