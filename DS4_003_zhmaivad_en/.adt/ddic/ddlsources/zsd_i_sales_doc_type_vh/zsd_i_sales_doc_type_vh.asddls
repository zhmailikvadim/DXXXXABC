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
@EndUserText.label: 'Value Help for Sales Document Type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity zsd_i_sales_doc_type_vh
  as select from  tvak
  left outer join tvakt on  tvakt.spras = $session.system_language
                        and tvakt.auart = tvak.auart
{
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @ObjectModel.text.element: ['Description']  
  key tvak.auart  as SalesDocType,
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      tvakt.bezei as Description
}
