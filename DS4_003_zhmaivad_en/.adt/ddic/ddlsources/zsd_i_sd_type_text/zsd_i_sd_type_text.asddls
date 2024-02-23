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
@EndUserText.label: 'Sales Document Type Text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   dataCategory: #TEXT,
   usageType: {
     dataClass:      #META,
     serviceQuality: #A,
     sizeCategory:   #S
   }
}
define view entity zsd_i_sd_type_text
  as select from tvakt
  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
  key auart as SalesDocumentType,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key spras as Language,
      @EndUserText.label: 'Sales Document Type'
      @Semantics.text: true
      bezei as SalesDocumenTypeText,

      _Language
}
