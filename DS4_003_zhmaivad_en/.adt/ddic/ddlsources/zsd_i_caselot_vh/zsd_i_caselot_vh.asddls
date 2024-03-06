/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SRIKAVEN     | 24.01.2023 |15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value help for Case Lot'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZSD_I_CASELOT_VH as select from zsd_t_case_lot_h {
@UI.hidden: true
key caseloth_uuid,
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @ObjectModel.text.element: ['CaseLotText']  
key caselot_no as CaseLotNumber,
     @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
    caselot_text as CaseLotText
}
