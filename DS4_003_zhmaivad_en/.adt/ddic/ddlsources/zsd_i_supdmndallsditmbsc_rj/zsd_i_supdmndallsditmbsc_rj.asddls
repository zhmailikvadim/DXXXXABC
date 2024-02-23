/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 04.04.2023 | 19667     : SD_Feature - [Defect]-Feature - SDO  Enhance *
*              |            | DS4K949084                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'I_SUPDMNDALLDOCSDITMBSC custom view'
@AccessControl: {
  authorizationCheck: #CHECK
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
define view entity zsd_i_supdmndallsditmbsc_rj
  as select from    I_SalesDocumentScheduleLine    as Scheduleline
    left outer join ZPE_I_HM( iv_id: '0000000789') as Language   on Language.sequence = '001'
    left outer join ZPE_I_HM( iv_id: '0000000838') as Hardcode   on Hardcode.sequence = '001'
    left outer join ZPE_I_HM( iv_id: '0000000999') as Hardcode_2 on Hardcode_2.sequence = '001'
    inner join      tvep                           as tvep       on Scheduleline.ScheduleLineCategory = tvep.ettyp
  association [0..1] to zsd_i_calloffqty_rj          as _CallOffQty                  on  Scheduleline.SalesDocument     = _CallOffQty.SalesDocument
                                                                                     and Scheduleline.SalesDocumentItem = _CallOffQty.SalesDocumentItem
  association [1..1] to ZSD_I_SUPDMNDMATERIALPLANT   as _MatPlant                    on  $projection.Material = _MatPlant.Material
                                                                                     and $projection.Plant    = _MatPlant.Plant
  association [0..1] to I_RFMSalesDocumentType       as _SlsDocType                  on  $projection.OrderType = _SlsDocType.SalesDocumentType
  association [0..1] to I_SDDocumentCompletePartners as _SDItemPartner               on  Scheduleline.SalesDocument     = _SDItemPartner.SDDocument
                                                                                     and Scheduleline.SalesDocumentItem = _SDItemPartner.SDDocumentItem
                                                                                     and _SDItemPartner.PartnerFunction = Hardcode.field1
  association [0..1] to P_SupDmndAllDocMatlDocSD     as _MatDoc                      on  Scheduleline.SalesDocument                 =  _MatDoc.SalesOrder
                                                                                     and Scheduleline.SalesDocumentItem             =  _MatDoc.SalesOrderItem
                                                                                     and Scheduleline.PurchaseRequisition           =  _MatDoc.PurchaseRequisition
                                                                                     and Scheduleline.PurchaseRequisitionItem       =  _MatDoc.PurchaseRequisitionItem
                                                                                     and Scheduleline.PurchaseRequisition           <> ''
                                                                                     and Scheduleline.PurchaseRequisitionItem       <> '00000'
                                                                                     and _MatDoc.QuantityInBaseUnit                 >  0
                                                                                     and Scheduleline.ConfdOrderQtyByMatlAvailCheck >  0
  association [0..1] to ZSD_I_SALESDOCUMENTITEM_EXT  as _SalesDocumentItemBasic      on  $projection.RequirementDocumentNumber = _SalesDocumentItemBasic.SalesDocument
                                                                                     and $projection.RequirementDocumentItem   = _SalesDocumentItemBasic.SalesDocumentItem
  association [0..1] to I_SalesDocItemPricingElement as _SalesDocItemPricingElement1 on  $projection.RequirementDocumentNumber      = _SalesDocItemPricingElement1.SalesDocument
                                                                                     and $projection.RequirementDocumentItem        = _SalesDocItemPricingElement1.SalesDocumentItem
                                                                                     and _SalesDocItemPricingElement1.ConditionType = Hardcode_2.field1
  association [0..1] to I_SalesDocItemPricingElement as _SalesDocItemPricingElement2 on  $projection.RequirementDocumentNumber      = _SalesDocItemPricingElement2.SalesDocument
                                                                                     and $projection.RequirementDocumentItem        = _SalesDocItemPricingElement2.SalesDocumentItem
                                                                                     and _SalesDocItemPricingElement2.ConditionType = Hardcode_2.field2
  association        to I_SalesDocument              as _SalesDocument               on  $projection.RequirementDocumentNumber = _SalesDocument.SalesDocument


{
  Scheduleline.SalesDocument                                as RequirementDocumentNumber,
  Scheduleline.SalesDocumentItem                            as RequirementDocumentItem,
  _SalesDocument.CustomerPurchaseOrderType                  as SoldToPartyPoType,
  Language.field1                                           as Language,
  case
    when tvep.pstyp = Hardcode.field2
      then 'VS'   -- Third Party Order
    when Scheduleline._SalesDocumentItem.InventorySpecialStockType = Hardcode.field3 and ( tvep.bstyp = 'B' or Scheduleline.PurchaseRequisition <> '' )
      then 'VE'   -- Purchase to Order
    when Scheduleline._SalesDocumentItem.InventorySpecialStockType = Hardcode.field3 and tvep.bstyp = ''
      then 'VM'   -- Make To Order
    when Scheduleline._SalesDocument.SDDocumentCategory = 'C'
      then 'VC'   -- Sales Order
    when Scheduleline._SalesDocument.SDDocumentCategory = 'G'
      then 'VG'   -- Contract
    when Scheduleline._SalesDocument.SDDocumentCategory = 'I'
      then 'VI'   -- Order w/o Charge
    else ''
  end                                                       as RequirementType,
  Scheduleline.ConfdSchedLineReqdDelivDate                  as RequestedDate,
  Scheduleline.ProductAvailabilityDate                      as ProductAvailabilityDate,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
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
      then
        (
          case
            when Scheduleline.OrderToBaseQuantityDnmntr != 0 or Scheduleline.OrderToBaseQuantityNmrtr != 0
              then ( cast ( Scheduleline.ScheduleLineOrderQuantity * division(Scheduleline.OrderToBaseQuantityNmrtr, Scheduleline.OrderToBaseQuantityDnmntr,3) as ovr_conf_so_sl_qty ) - Scheduleline.RequestedRqmtQtyInBaseUnit )
            else Scheduleline.ScheduleLineOrderQuantity - Scheduleline.RequestedRqmtQtyInBaseUnit
          end
        )
    else cast(0 as abap.quan(15,3))
  end                                                       as ScheduleLineOrderQuantity,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
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
    else cast(0 as abap.quan(15,3))
  end                                                       as ConfdOrderQtyByMatlAvailCheck,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  Scheduleline.DeliveredQuantityInBaseUnit                  as DeliveredQuantityInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
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
    else cast(0 as abap.quan(15,3))
  end                                                       as SalesContractReleasedQuantity,
  Scheduleline._SalesDocumentItem.BaseUnit                  as BaseUnit,
  Scheduleline._SalesDocumentItem.Material                  as Material,
  Scheduleline._SalesDocumentItem.MaterialGroup             as MaterialGroup,
  Scheduleline._SalesDocumentItem.Plant                     as Plant,
  Scheduleline._SalesDocumentItem.MaterialByCustomer        as MaterialByCustomer,
  case tvep.pstyp
    when Hardcode.field2 then Hardcode.field5     //Third Party Order
    else
    ( case Scheduleline._SalesDocumentItem.InventorySpecialStockType
        when Hardcode.field3 then Hardcode.field3 //Order on Hand (Purhcase To Order/Make To Order)
        when Hardcode.field4 then Hardcode.field4 //Customer Consignment
        else Scheduleline._SalesDocument.SDDocumentCategory
      end )
  end                                                       as SDDocumentCategory,
  Scheduleline._SalesDocumentItem.RequirementSegment        as RequirementSegment,
  Scheduleline._SalesDocument.SalesDocumentType             as OrderType,
  Scheduleline._SalesDocument.SalesOrganization             as SalesOrganization,
  Scheduleline._SalesDocument.DistributionChannel           as DistributionChannel,
  Scheduleline._SalesDocument.OrganizationDivision          as Division,
  Scheduleline._SalesDocument.SalesDistrict                 as SalesDistrict,
  coalesce(
  _SDItemPartner.Customer,
  Scheduleline._SalesDocument.SoldToParty )                 as SoldToParty,
  Scheduleline._SalesDocument.BillingCompanyCode            as CompanyCode,
  Scheduleline._SalesDocumentItem.StorageLocation           as StorageLocation,
  Scheduleline._SalesDocumentItem.FashionCancelDate         as FashionCancelDate,
  Scheduleline._SalesDocumentItem.DeliveryBlockStatus       as DeliveryBlockStatus,
  Scheduleline._SalesDocument.TotalBlockStatus              as TotalBlockStatus,
  tvep.pstyp                                                as ReferenceScheduleLineCategory,
  @Semantics.amount.currencyCode: 'DocumentCurrency'
  Scheduleline._SalesDocumentItem.NetPriceAmount            as NetPriceAmount,
  Scheduleline._SalesDocumentItem.TransactionCurrency       as DocumentCurrency,
  Scheduleline.ScheduleLineCategory                         as ScheduleLineCategory,
  Scheduleline._SalesDocumentItem.ProductSeasonYear,
  Scheduleline._SalesDocumentItem.ProductSeason,
  Scheduleline._SalesDocumentItem.ProductCollection,
  Scheduleline._SalesDocumentItem.CreatedByUser,
  Scheduleline._SalesDocumentItem.CustomerGroup,
  Scheduleline._SalesDocumentItem.AdditionalCustomerGroup1,
  Scheduleline._SalesDocumentItem.AdditionalCustomerGroup5,
  Scheduleline._SalesDocument.AgrmtValdtyEndDate,
  Scheduleline._SalesDocumentItem.DeliveryPriority,
  Scheduleline._SalesDocumentItem.ZZ1_OTCDLDATE_SDI         as FulfillmentDate,
  Scheduleline._SalesDocumentItem.ZZ1_DELSCEN_SDI           as FulfillmentScenario,
  Scheduleline._SalesDocumentItem.ZZ1_WWPRI_SDI             as PREIndicator,
  Scheduleline._SalesDocumentItem.ZZ1_DELSCEN_SDI           as PrepackHoldIndicator,
  Scheduleline._SalesDocumentItem.ZZ1_RSD_ITEM              as RequestedShelfDate,
  Scheduleline._SalesDocumentItem.ProductCharacteristic2,
  Scheduleline._SalesDocumentItem.UnderlyingPurchaseOrderItem,
  Scheduleline._SalesDocumentItem.SalesDocumentItemText,
  Scheduleline._SalesDocumentItem.AdditionalMaterialGroup1,
  Scheduleline._SalesDocumentItem.SDDocumentReason,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  Scheduleline._SalesDocumentItem.OrderQuantity             as OrderQuantity,
  Scheduleline._SalesDocumentItem.OrderQuantityUnit,
  Scheduleline._SalesDocumentItem.SalesDocumentItemCategory,
  Scheduleline._SalesDocumentItem.ProductTheme,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  Scheduleline._SalesDocumentItem.NetAmount,
  Scheduleline._SalesDocumentItem.TransactionCurrency,
  Scheduleline._SalesDocumentItem.PayerParty,
  Scheduleline._SalesDocumentItem.ShippingType,
  Scheduleline._SalesDocumentItem.ShippingPoint,
  Scheduleline._SalesDocumentItem.ShipToParty,
  Scheduleline._SalesDocumentItem.SalesOffice,
  Scheduleline._SalesDocumentItem.LastChangeDate,
  Scheduleline._SalesDocumentItem.CreationDate,
  Scheduleline._SalesDocumentItem.Payer,
  Scheduleline._SalesDocumentItem.PRE_RE_Indicator,
  Scheduleline._SalesDocumentItem.OrderReason,
  Scheduleline._SalesDocumentItem.SalesDocumentRjcnReason,
  Scheduleline._SalesDocumentItem.SalesDocumentType,
  Scheduleline._SalesDocumentItem._ShipToParty.CustomerName as ShipToPartyName,
  Scheduleline._SalesDocument.PurchaseOrderByCustomer,
  Scheduleline._SalesDocument.CustomerPurchaseOrderType,
  Scheduleline.ConfirmedShelfDate,
  Scheduleline._SalesDocument.DeliveryBlockReason,
  Scheduleline._SalesDocument._SoldToParty.CustomerName     as SoldToPartyName,
  Scheduleline.ScheduleLine,
  Scheduleline.ConfirmedShelvedDate,
  Scheduleline.GoodsIssueDate,
  Scheduleline.DeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'CallOffQuantityUnit'
  _CallOffQty.CallOffQuantity,
  _CallOffQty.CallOffQuantityUnit,
  _SalesDocumentItemBasic.EAN,
  _SalesDocumentItemBasic.MaterialGroup1Text,
  @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnitRRP'
  case
  when _SalesDocItemPricingElement1.ConditionQuantity <> 0
    then cast(_SalesDocItemPricingElement1.ConditionRateValue / _SalesDocItemPricingElement1.ConditionQuantity as vfprc_element_amount)
  else cast(0 as vfprc_element_amount)
  end                                                       as RecommendedRetailPrice,

  _SalesDocItemPricingElement1.ConditionQuantityUnit        as ConditionQuantityUnitRRP,
  @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnitWP'
  case
  when _SalesDocItemPricingElement2.ConditionQuantity <> 0
    then cast(_SalesDocItemPricingElement2.ConditionRateValue / _SalesDocItemPricingElement2.ConditionQuantity as vfprc_element_amount)
  else cast(0 as vfprc_element_amount)
  end                                                       as WholesalePrice,
  _SalesDocItemPricingElement2.ConditionQuantityUnit        as ConditionQuantityUnitWP,

  _MatPlant,
  _SlsDocType
}
where
  (
       Scheduleline.GoodsMovementType != ''
    or tvep.pstyp                                                          =  '5'
  )
  and  Scheduleline._SalesDocumentItem.SDDocReferenceStatus != 'C' //Reference Status != Completely processed
  and  Scheduleline._SalesDocumentItem.SalesDocumentItemType != 'B' //Item Type != Text item
  and  Scheduleline._SalesDocumentItem.DeliveryStatus != 'C' //Delivery Status != Completely processed
  and(
       Scheduleline._SalesDocumentItem.SalesDocumentRjcnReason             <> ' '
  )
  and  Scheduleline._SalesDocumentItem.IsReturnsItem != 'X' //Returns != 'X'
  and(
       Scheduleline._SalesDocumentItem.InventorySpecialStockType           =  ' '
    or Scheduleline._SalesDocumentItem.InventorySpecialStockType           =  'E'
  )
  and  Scheduleline._SalesDocument.OverallTotalSDDocRefStatus != 'C' //Total Reference Status != Completely processed
  and  Scheduleline._SalesDocument.OverallDeliveryStatus != 'C' //Total Delivery Status != Completely processed
  and(
       Scheduleline._SalesDocument.SDDocumentCategory                      =  'C' //Document Category = Order
    or Scheduleline._SalesDocument.SDDocumentCategory                      =  'I' //Document Category = Order without Charge
    or Scheduleline._SalesDocument.SDDocumentCategory                      =  'G' //Document Category = Contract
  )
  and  Scheduleline._SalesDocument._SoldToParty.IsBusinessPurposeCompleted =  ''
  and(
       Scheduleline.ScheduleLineOrderQuantity                              >  0
    or Scheduleline.DeliveredQuantityInBaseUnit                            >  0
  )
