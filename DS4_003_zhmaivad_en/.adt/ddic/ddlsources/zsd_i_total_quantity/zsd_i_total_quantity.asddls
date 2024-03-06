/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SRIKAVEN     | 06.06.2023 | 20611     : BE: Case Lot -Enhancement *
*              |            | DS4K950721                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Get Total Quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_TOTAL_QUANTITY as select from I_SalesDocumentItem as vbap
inner join   I_SalesDocumentScheduleLine as vbep              on  vbap.SalesDocument = vbep.SalesDocument
                                   and vbap.SalesDocumentItem = vbep.SalesDocumentItem
                                   and vbep.ItemIsDeliveryRelevant is not initial
                                   and vbep.ConfdOrderQtyByMatlAvailCheck       is not initial
                                   and vbep.IsConfirmedDelivSchedLine = 'X'
                                   and vbep.ItemIsDeliveryRelevant = 'X'
{
    key vbap.SalesDocument             as SalesOrder,
  key vbap.SalesDocumentItem             as SalesOrderItem,
   vbep.OrderQuantityUnit as OrderQuantityUnit,
   @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    sum ( vbep.ConfdOrderQtyByMatlAvailCheck ) as sum_gross_amount
} group by vbap.SalesDocument , vbap.SalesDocumentItem,vbep.OrderQuantityUnit
