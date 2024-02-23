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
@EndUserText.label: 'Fullfillment Scenario Texts'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   dataCategory: #TEXT,
   usageType: {
     dataClass:      #META,
     serviceQuality: #A,
     sizeCategory:   #S
   }
}
define view entity zsd_i_fullfillment_scenario_t
  as select from zz1_ab4bfd9156b9
  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
  key code        as FullfillmentScenario,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key language    as Language,
      @EndUserText.label: 'Fullfillment Scenario'
      @Semantics.text: true
      description as FullfillmentScenarioText,

      _Language
}
