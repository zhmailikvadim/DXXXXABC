/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
//@EndUserText.label: 'View for Earliest Requested Delivery Date for Sales Document'
define view entity ZSD_P_SUPDMNDOVWSDDATE_RJ
  as select from I_SalesDocumentScheduleLine as ScheduleLine
{
  key SalesDocument,
  key SalesDocumentItem,
      min(ConfdSchedLineReqdDelivDate)         as EarliestRequestedDeliveryDate,
      ScheduleLine._SalesDocumentItem.Material as Material,
      ScheduleLine._SalesDocumentItem.Plant    as Plant
}
where
       ScheduleLine._SalesDocumentItem.SDDocReferenceStatus != 'C' //Reference Status != Completely processed
  and  ScheduleLine._SalesDocumentItem.SalesDocumentItemType != 'B' //Item Type != Text item
  and  ScheduleLine._SalesDocumentItem.DeliveryStatus != 'C' //Delivery Status != Completely processed
  and  ScheduleLine._SalesDocumentItem.SalesDocumentRjcnReason   <> ' ' //RejectionReason = ' '
  and  ScheduleLine._SalesDocumentItem.IsReturnsItem != 'X' //Returns != 'X'
  and(
       ScheduleLine._SalesDocumentItem.InventorySpecialStockType = ' '
    or ScheduleLine._SalesDocumentItem.InventorySpecialStockType = 'E'
  ) //Consider Orders on Hand

  and  ScheduleLine._SalesDocument.OverallTotalSDDocRefStatus != 'C' //Total Reference Status != Completely processed
  and  ScheduleLine._SalesDocument.OverallDeliveryStatus != 'C' //Total Delivery Status != Completely processed
  and(
       ScheduleLine._SalesDocument.SDDocumentCategory            = 'C' //Document Category = Order
    or ScheduleLine._SalesDocument.SDDocumentCategory            = 'I' //Document Category = Order without Charge
    or ScheduleLine._SalesDocument.SDDocumentCategory            = 'G' //Document Category = Contract
  )
group by
  SalesDocument,
  SalesDocumentItem,
  ScheduleLine._SalesDocumentItem.Material,
  ScheduleLine._SalesDocumentItem.Plant
