@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #BASIC,
  private: true
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'PSUPDMNDADSDDATE',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XXL
   }
}
define view P_SupDmndAllDocSDDate
  as select from I_SalesDocumentItem         as Item

    inner join   I_SalesDocumentScheduleLine as ScheduleLine1 on  Item.SalesDocument     = ScheduleLine1.SalesDocument
                                                              and Item.SalesDocumentItem = ScheduleLine1.SalesDocumentItem

    inner join   I_SalesDocumentScheduleLine as ScheduleLine2 on  ScheduleLine1.SalesDocument               = ScheduleLine2.SalesDocument
                                                              and ScheduleLine1.SalesDocumentItem           = ScheduleLine2.SalesDocumentItem
                                                              and ScheduleLine1.ConfdSchedLineReqdDelivDate = ScheduleLine2.ConfdSchedLineReqdDelivDate

    inner join   I_SupDmndMaterialPlant      as Marc          on  Item.Material = Marc.Material
                                                              and Item.Plant    = Marc.Plant
{
  ScheduleLine1.SalesDocument               as RequirementDocumentNumber,
  ScheduleLine1.SalesDocumentItem           as RequirementDocumentItem,
  ScheduleLine1.ConfdSchedLineReqdDelivDate as RequestedDate,
  ScheduleLine1.ProductAvailabilityDate     as ProductAvailabilityDate,
  Item.Material                             as Material,
  Item.Plant                                as Plant,
  case
    when Item._SalesDocument.SDDocumentCategory = 'C' or Item._SalesDocument.SDDocumentCategory = 'I'
      then
         (
            case
              when ScheduleLine2.OrderToBaseQuantityDnmntr != 0 or ScheduleLine2.OrderToBaseQuantityNmrtr != 0
                then cast( ScheduleLine2.ConfdOrderQtyByMatlAvailCheck * division(ScheduleLine2.OrderToBaseQuantityNmrtr,ScheduleLine2.OrderToBaseQuantityDnmntr,3) as ovr_conf_so_sl_qty )
              else cast( ScheduleLine2.ConfdOrderQtyByMatlAvailCheck as ovr_conf_so_sl_qty )
            end
         )
    when Item._SalesDocument.SDDocumentCategory = 'G'
      then ScheduleLine2.ConfirmedRqmtQtyInBaseUnit
    else 0
  end                                       as ConfdOrderQtyByMatlAvailCheck
}
where
       ScheduleLine1.ScheduleLineOrderQuantity > 0
  and  Item.SDDocReferenceStatus != 'C'  //Reference Status != Completely processed
  and  Item.SalesDocumentItemType != 'B' //Item Type != Text item
  and  Item.DeliveryStatus != 'C'        //Delivery Status != Completely processed
  and  Item.SalesDocumentRjcnReason            = ' ' //RejectionReason = ' '
  and  Item.IsReturnsItem != 'X' //Returns != 'X'
  and(
       Item.InventorySpecialStockType          = ' '
    or Item.InventorySpecialStockType          = 'E'
  ) //Consider Orders on Hand

  and  Item._SalesDocument.OverallTotalSDDocRefStatus != 'C' //Total Reference Status != Completely processed
  and  Item._SalesDocument.OverallDeliveryStatus != 'C' //Total Delivery Status != Completely processed
  and(
       Item._SalesDocument.SDDocumentCategory  = 'C' //Document Category = Order
    or Item._SalesDocument.SDDocumentCategory  = 'I' //Document Category = Order without Charge
    or Item._SalesDocument.SDDocumentCategory  = 'G' //Document Category = Contract
  )
