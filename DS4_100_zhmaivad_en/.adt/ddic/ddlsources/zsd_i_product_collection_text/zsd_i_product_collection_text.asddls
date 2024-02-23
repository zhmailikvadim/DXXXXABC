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
@EndUserText.label: 'Product Collection'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   dataCategory: #TEXT,
   usageType: {
     dataClass:      #META,
     serviceQuality: #A,
     sizeCategory:   #S
   }
}
define view entity zsd_i_product_collection_text
  as select from I_ProductCollection
  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
  key I_ProductCollection.ProductSeasonYear           as SeasonYear,
  key I_ProductCollection.ProductSeason               as Season,
  key I_ProductCollection.ProductCollection           as ProductCollection,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key I_ProductCollection._Text.Language              as Language,
      @EndUserText.label: 'Product Collection Description'
      @Semantics.text: true
      I_ProductCollection._Text.ProductCollectionName as ProductCollectionText,
      _Language
}
