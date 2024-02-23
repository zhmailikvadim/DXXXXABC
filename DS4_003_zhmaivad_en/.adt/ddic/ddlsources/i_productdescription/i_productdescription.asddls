// Product description active table
@AbapCatalog:{
  sqlViewName: 'IPRDDESCR',
  preserveKey: true,
  compiler.compareFilter: true
}
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Descriptions'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'Product'
@ObjectModel: {
    usageType.serviceQuality: #C,
    usageType.sizeCategory : #L,
    usageType.dataClass: #MASTER
}
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions:true
@Analytics:{
    dataCategory: #DIMENSION,
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture:{
          mapping: [{
            viewElement: ['PRODUCT', 'LANGUAGE'],
            role: #MAIN,
            table: 'MAKT',
            tableElement: ['MATNR', 'SPRAS']
          },
          {
            viewElement: ['LANGUAGE'],
            role: #LEFT_OUTER_TO_ONE_JOIN,
            table: 'T002',
            tableElement: ['SPRAS']
          }]
        }
    }
}
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #EXTRACTION_DATA_SOURCE,
                                      #SEARCHABLE_ENTITY
]
define view I_ProductDescription
  as select from makt
  association [1..1] to I_Product  as _Product  on $projection.Product = _Product.Product

  association [1..1] to I_Language as _Language on $projection.Language = _Language.Language
{

  key cast(makt.matnr as productnumber preserving type )                  as Product,
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key makt.spras                                                          as Language,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      cast(makt.maktx as productdescription preserving type )             as ProductDescription,

      cast(_Language.LanguageISOCode as languageisocode preserving type ) as LanguageISOCode,
      _Product,
      _Language
}
