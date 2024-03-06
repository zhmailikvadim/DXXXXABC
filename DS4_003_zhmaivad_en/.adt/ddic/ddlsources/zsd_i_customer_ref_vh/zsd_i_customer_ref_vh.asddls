/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHRYSAND     | 18.11.2022 | 13764     : BE: Case Lot - Sales order List Report A *
*              |            | DS4K930674                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Customer reference'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_customer_ref_vh
  as select distinct from I_SalesDocument
{
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.80  }
  key PurchaseOrderByCustomer
}
