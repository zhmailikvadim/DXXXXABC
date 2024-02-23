/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 04.04.2023 | 19667     : SD_Feature - [Defect]-Feature - SDO  Enhance *
*              |            | DS4K949084                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Billing Documents Sum'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_billingdocumensum
  as select from I_BillingDocumentItemBasic
{
  key ReferenceSDDocument,
  key ReferenceSDDocumentItem,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      sum(BillingQuantity) as BillingQuantity,
      BillingQuantityUnit
}
group by
  ReferenceSDDocument,
  ReferenceSDDocumentItem,
  BillingQuantityUnit
