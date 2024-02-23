@AbapCatalog:{
  sqlViewName: 'IPRODTYPTXT',
  preserveKey: true,
  compiler.compareFilter: true,
  buffering:{
    status: #ACTIVE,
    type: #GENERIC,
    numberOfKeyFields: 1
  }
 }
//@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@VDM.viewType: #BASIC
@VDM.lifecycle.status: #DEPRECATED
@VDM.lifecycle.successor: 'I_ProductTypeText_2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Type - Text'
@ObjectModel:{
  dataCategory: #TEXT,
  representativeKey: 'ProductType',
  supportedCapabilities: [ #SQL_DATA_SOURCE,
                           #CDS_MODELING_DATA_SOURCE,
                           #CDS_MODELING_ASSOCIATION_TARGET,
                           #SEARCHABLE_ENTITY,
                           #LANGUAGE_DEPENDENT_TEXT,
                           #EXTRACTION_DATA_SOURCE
  ],
  usageType:{
    serviceQuality: #A,
    sizeCategory : #L,
    dataClass: #CUSTOMIZING
  }
}
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@Analytics:{
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture.automatic: true
    }
}
define view I_ProductTypeText
  as select from t134t

  association [0..1] to I_Producttype as _ProductType on $projection.ProductType = _ProductType.ProductType
  association [0..1] to I_Language    as _Language    on $projection.Language = _Language.Language

{
      @ObjectModel.foreignKey.association: '_ProductType'
  key cast(t134t.mtart as producttype preserving type )     as ProductType,
      @Semantics.language: true
  key t134t.spras                                           as Language,
      @Semantics.text: true
      @Search:{
        defaultSearchElement: true,
        fuzzinessThreshold: 0.8,
        ranking: #LOW
      }
      @EndUserText.label: 'Product Type Description'
      cast(t134t.mtbez as producttypename preserving type ) as MaterialTypeName,

      _Language,
      _ProductType
}
