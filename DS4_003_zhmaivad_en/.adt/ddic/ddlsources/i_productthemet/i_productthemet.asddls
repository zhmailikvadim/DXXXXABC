@AbapCatalog.sqlViewName: 'IPRODUCTTHEMET'
@EndUserText.label: 'Product Theme Text'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM.viewType: #BASIC
@ObjectModel: {
    dataCategory: #TEXT,
    representativeKey: 'ProductTheme',
    usageType: {
        serviceQuality: #A,
        sizeCategory: #L,
        dataClass: #MASTER
   }
}

define view I_ProductThemeT
  as select from rfm_v_themes_t
  association [1..1] to I_ProductTheme as _ProductTheme on  $projection.ProductSeason     = _ProductTheme.ProductSeason
                                                        and $projection.ProductSeasonYear = _ProductTheme.ProductSeasonYear
                                                        and $projection.ProductCollection = _ProductTheme.ProductCollection
                                                        and $projection.ProductTheme      = _ProductTheme.ProductTheme
  association [0..1] to I_Language     as _Language     on  $projection.Language = _Language.Language
{
  key fsh_season      as ProductSeason,
  key fsh_season_year as ProductSeasonYear,
  key fsh_collection  as ProductCollection,
      @ObjectModel.foreignKey.association: '_ProductTheme'
  key fsh_theme       as ProductTheme,

      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key spras           as Language,
      @Semantics.text: true
      text            as ProductThemeName,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _ProductTheme,
      _Language
}
