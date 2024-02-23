/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.11.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Theme'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   dataCategory: #TEXT,
   usageType: {
     dataClass:      #META,
     serviceQuality: #A,
     sizeCategory:   #S
   }
}
define view entity zsd_i_product_theme_text
  as select from I_ProductTheme
  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
  key I_ProductTheme.ProductSeasonYear      as SeasonYear,
  key I_ProductTheme.ProductSeason          as Season,
  key I_ProductTheme.ProductCollection      as ProductCollection,
  key I_ProductTheme.ProductTheme           as ProductTheme,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key I_ProductTheme._Text.Language         as Language,
      @EndUserText.label: 'Product Theme Description'
      @Semantics.text: true
      I_ProductTheme._Text.ProductThemeName as ProductThemeText,
      _Text,
      _Language
}
