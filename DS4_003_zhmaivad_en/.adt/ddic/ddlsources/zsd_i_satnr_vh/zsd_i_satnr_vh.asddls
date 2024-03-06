/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHRYSAND     | 20.09.2022 | 13764     : BE: Case Lot - Sales order List Report A *
*              |            | DS4K930674                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Generic Article'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] }*/
define view entity zsd_i_satnr_vh
  as select distinct from mara

  association [1..1] to makt on  makt.matnr = $projection.GenericArticle
                             and makt.spras = $session.system_language
{
      @EndUserText.label: 'Generic Article'
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @ObjectModel.text.element: ['GenericArticleDescription']           
  key mara.satnr as GenericArticle,
      @EndUserText.label: 'Description'
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      makt.maktx as GenericArticleDescription
      
      
}
