@AbapCatalog.sqlViewName: 'IPRDCOLLECTIONT'
@EndUserText.label: 'Product Collection Text'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM.viewType: #BASIC
@ObjectModel: {
    dataCategory: #TEXT,
    representativeKey: 'ProductCollection',
    usageType: {
        serviceQuality: #A,
        sizeCategory: #L,
        dataClass: #MASTER
   }
}

define view I_ProductCollectionT
  as select from rfm_v_col_t
  association [1..1] to I_ProductCollection as _ProductCollection on  $projection.ProductSeason     = _ProductCollection.ProductSeason
                                                                  and $projection.ProductSeasonYear = _ProductCollection.ProductSeasonYear
                                                                  and $projection.ProductCollection = _ProductCollection.ProductCollection
  association [0..1] to I_Language          as _Language          on  $projection.Language = _Language.Language
{
  key fsh_season      as ProductSeason,
  key fsh_season_year as ProductSeasonYear,
      @ObjectModel.foreignKey.association: '_ProductCollection'
  key fsh_collection  as ProductCollection,

      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key spras           as Language,
      @Semantics.text: true
      text            as ProductCollectionName,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _ProductCollection,
      _Language
}
