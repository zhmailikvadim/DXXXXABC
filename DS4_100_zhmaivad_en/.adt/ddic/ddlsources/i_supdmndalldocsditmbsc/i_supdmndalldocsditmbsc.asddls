@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Basic View for Sales Document'
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADSDITMB',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #C,
     sizeCategory:   #XL
   }
}
define view I_SupDmndAllDocSDItmBsc
  as select from I_SalesDocumentScheduleLine as Scheduleline
    inner join   tvep                        as tvep on Scheduleline.ScheduleLineCategory = tvep.ettyp
  association [1..1] to I_SupDmndMaterialPlant   as _MatPlant   on  $projection.Material = _MatPlant.Material
                                                                and $projection.Plant    = _MatPlant.Plant
  association [0..1] to I_RFMSalesDocumentType   as _SlsDocType on  $projection.OrderType = _SlsDocType.SalesDocumentType
  association [0..1] to I_SDDocumentCompletePartners as _SDItemPartner on Scheduleline.SalesDocument      = _SDItemPartner.SDDocument
                                                                       and Scheduleline.SalesDocumentItem = _SDItemPartner.SDDocumentItem
                                                                       and _SDItemPartner.PartnerFunction = 'SP'
  association [0..1] to P_SupDmndAllDocMatlDocSD as _MatDoc     on  Scheduleline.SalesDocument                 =  _MatDoc.SalesOrder
                                                                and Scheduleline.SalesDocumentItem             =  _MatDoc.SalesOrderItem
                                                                and Scheduleline.PurchaseRequisition           =  _MatDoc.PurchaseRequisition
                                                                and Scheduleline.PurchaseRequisitionItem       =  _MatDoc.PurchaseRequisitionItem
                                                                and Scheduleline.PurchaseRequisition           <> ''
                                                                and Scheduleline.PurchaseRequisitionItem       <> '00000'
                                                                and _MatDoc.QuantityInBaseUnit                 >  0
                                                                and Scheduleline.ConfdOrderQtyByMatlAvailCheck >  0
{
  Scheduleline.SalesDocument                          as RequirementDocumentNumber,
  Scheduleline.SalesDocumentItem                      as RequirementDocumentItem,
  case
    when tvep.pstyp = '5'
      then 'VS'   -- Third Party Order
    when Scheduleline._SalesDocumentItem.InventorySpecialStockType = 'E' and ( tvep.bstyp = 'B' or Scheduleline.PurchaseRequisition <> '' )
      then 'VE'   -- Purchase to Order
    when Scheduleline._SalesDocumentItem.InventorySpecialStockType = 'E' and tvep.bstyp = ''
      then 'VM'   -- Make To Order
    when Scheduleline._SalesDocument.SDDocumentCategory = 'C'
      then 'VC'   -- Sales Order
    when Scheduleline._SalesDocument.SDDocumentCategory = 'G'
      then 'VG'   -- Contract
    when Scheduleline._SalesDocument.SDDocumentCategory = 'I'
      then 'VI'   -- Order w/o Charge
    else ''
  end                                                 as RequirementType,
  Scheduleline.ConfdSchedLineReqdDelivDate            as RequestedDate,
  Scheduleline.ProductAvailabilityDate                as ProductAvailabilityDate,
  case
    when Scheduleline._SalesDocument.SDDocumentCategory = 'C' or Scheduleline._SalesDocument.SDDocumentCategory = 'I'
      then
         (
            case
              when Scheduleline.OrderToBaseQuantityDnmntr != 0 or Scheduleline.OrderToBaseQuantityNmrtr != 0
                then
                cast( Scheduleline.ScheduleLineOrderQuantity * division(Scheduleline.OrderToBaseQuantityNmrtr,Scheduleline.OrderToBaseQuantityDnmntr,3) as ovr_conf_so_sl_qty )
              else cast( Scheduleline.ScheduleLineOrderQuantity as ovr_conf_so_sl_qty )
            end
         )
    when Scheduleline._SalesDocument.SDDocumentCategory = 'G'
      then Scheduleline.RequestedRqmtQtyInBaseUnit
    else 0
  end                                                 as ScheduleLineOrderQuantity,
  case
    when Scheduleline._SalesDocument.SDDocumentCategory = 'C' or Scheduleline._SalesDocument.SDDocumentCategory = 'I'
      then
         (
            case
              when Scheduleline.OrderToBaseQuantityDnmntr != 0 or Scheduleline.OrderToBaseQuantityNmrtr != 0
                then cast( Scheduleline.ConfdOrderQtyByMatlAvailCheck * division(Scheduleline.OrderToBaseQuantityNmrtr,Scheduleline.OrderToBaseQuantityDnmntr,3) as ovr_conf_so_sl_qty )
              else cast( Scheduleline.ConfdOrderQtyByMatlAvailCheck as ovr_conf_so_sl_qty )
            end
         )
    when Scheduleline._SalesDocument.SDDocumentCategory = 'G'
      then Scheduleline.ConfirmedRqmtQtyInBaseUnit
    else 0
  end                                                 as ConfdOrderQtyByMatlAvailCheck,
  case tvep.pstyp
    when '5' then _MatDoc.QuantityInBaseUnit
    else  Scheduleline.DeliveredQuantityInBaseUnit
  end                                                 as DeliveredQuantityInBaseUnit,
  case Scheduleline._SalesDocument.SDDocumentCategory
    when 'G'
      then
        (
          case
            when Scheduleline.OrderToBaseQuantityDnmntr != 0 or Scheduleline.OrderToBaseQuantityNmrtr != 0
              then ( cast ( Scheduleline.ScheduleLineOrderQuantity * division(Scheduleline.OrderToBaseQuantityNmrtr, Scheduleline.OrderToBaseQuantityDnmntr,3) as ovr_conf_so_sl_qty ) - Scheduleline.RequestedRqmtQtyInBaseUnit )
            else Scheduleline.ScheduleLineOrderQuantity - Scheduleline.RequestedRqmtQtyInBaseUnit
          end
        )
    else 0
  end                                                 as SalesContractReleasedQuantity,
  Scheduleline._SalesDocumentItem.BaseUnit            as BaseUnit,
  Scheduleline._SalesDocumentItem.Material            as Material,
  Scheduleline._SalesDocumentItem.MaterialGroup       as MaterialGroup,
  Scheduleline._SalesDocumentItem.Plant               as Plant,
  case tvep.pstyp
    when '5' then 'S'     //Third Party Order
    else
    ( case Scheduleline._SalesDocumentItem.InventorySpecialStockType
        when 'E' then 'E' //Order on Hand (Purhcase To Order/Make To Order)
        when 'W' then 'W' //Customer Consignment
        else Scheduleline._SalesDocument.SDDocumentCategory
      end )
  end                                                 as SDDocumentCategory,
  Scheduleline._SalesDocumentItem.RequirementSegment  as RequirementSegment,
  Scheduleline._SalesDocument.SalesDocumentType       as OrderType,
  Scheduleline._SalesDocument.SalesOrganization       as SalesOrganization,
  Scheduleline._SalesDocument.DistributionChannel     as DistributionChannel,
  Scheduleline._SalesDocument.OrganizationDivision    as Division,
  Scheduleline._SalesDocument.SalesDistrict           as SalesDistrict,
  coalesce(
  _SDItemPartner.Customer,
  Scheduleline._SalesDocument.SoldToParty )           as SoldToParty,
  Scheduleline._SalesDocument.BillingCompanyCode      as CompanyCode,
  Scheduleline._SalesDocumentItem.StorageLocation     as StorageLocation,
  Scheduleline._SalesDocumentItem.FashionCancelDate   as FashionCancelDate,
  Scheduleline._SalesDocumentItem.DeliveryBlockStatus as DeliveryBlockStatus,
  Scheduleline._SalesDocument.TotalBlockStatus        as TotalBlockStatus,
  tvep.pstyp                                          as ReferenceScheduleLineCategory,
  @Semantics.amount.currencyCode: 'DocumentCurrency'
  Scheduleline._SalesDocumentItem.NetPriceAmount      as NetPriceAmount,
  @Semantics.currencyCode: true
  Scheduleline._SalesDocumentItem.TransactionCurrency as DocumentCurrency,
  Scheduleline.ScheduleLineCategory                   as ScheduleLineCategory,
  _MatPlant,
  _SlsDocType
}
where ( Scheduleline.GoodsMovementType != '' or tvep.pstyp = '5' )
  and  Scheduleline._SalesDocumentItem.SDDocReferenceStatus != 'C' //Reference Status != Completely processed
  and  Scheduleline._SalesDocumentItem.SalesDocumentItemType != 'B' //Item Type != Text item
  and  Scheduleline._SalesDocumentItem.DeliveryStatus != 'C' //Delivery Status != Completely processed
  and  Scheduleline._SalesDocumentItem.SalesDocumentRjcnReason             = ' ' //RejectionReason = ' '
  and  Scheduleline._SalesDocumentItem.IsReturnsItem != 'X' //Returns != 'X'
  and(
       Scheduleline._SalesDocumentItem.InventorySpecialStockType           = ' '
    or Scheduleline._SalesDocumentItem.InventorySpecialStockType           = 'E'
  ) //Consider Orders on Hand
  and  Scheduleline._SalesDocument.OverallTotalSDDocRefStatus != 'C' //Total Reference Status != Completely processed
  and  Scheduleline._SalesDocument.OverallDeliveryStatus != 'C' //Total Delivery Status != Completely processed
  and(       Scheduleline._SalesDocument.SDDocumentCategory                      = 'C' //Document Category = Order
    or Scheduleline._SalesDocument.SDDocumentCategory                      = 'I' //Document Category = Order without Charge
    or Scheduleline._SalesDocument.SDDocumentCategory                      = 'G' //Document Category = Contract
  )
  and  Scheduleline._SalesDocument._SoldToParty.IsBusinessPurposeCompleted = ''

