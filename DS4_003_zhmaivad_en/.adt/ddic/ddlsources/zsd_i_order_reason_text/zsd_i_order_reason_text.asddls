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
@EndUserText.label: 'Order Reason Text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   dataCategory: #TEXT,
   usageType: {
     dataClass:      #META,
     serviceQuality: #A,
     sizeCategory:   #S
   }
}
define view entity zsd_i_order_reason_text
  as select from tvaut
  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
  key augru as OrderReason,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key spras as Language,
      @EndUserText.label: 'Product Collection Description'
      @Semantics.text: true
      bezei as OrderReasonText,

      _Language
}
