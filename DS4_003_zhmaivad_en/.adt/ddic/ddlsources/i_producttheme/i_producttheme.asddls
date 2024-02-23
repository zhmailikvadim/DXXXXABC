@AbapCatalog.sqlViewName: 'IPRODUCTTHEME'
@EndUserText.label: 'Product Theme'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM.viewType: #BASIC
@ObjectModel: {
    compositionRoot: true,
    representativeKey: 'ProductTheme',
    usageType: {
        serviceQuality: #A,
        sizeCategory: #L,
        dataClass: #MASTER
   }
}

define view I_ProductTheme
  as select from rfm_v_theme
  association [0..*] to I_ProductThemeT as _Text on  $projection.ProductSeason     = _Text.ProductSeason
                                                 and $projection.ProductSeasonYear = _Text.ProductSeasonYear
                                                 and $projection.ProductCollection = _Text.ProductCollection
                                                 and $projection.ProductTheme      = _Text.ProductTheme
{
  key fsh_season      as ProductSeason,
  key fsh_season_year as ProductSeasonYear,
  key fsh_collection  as ProductCollection,
      @ObjectModel.text.association: '_Text'
  key fsh_theme       as ProductTheme,

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Text
}
