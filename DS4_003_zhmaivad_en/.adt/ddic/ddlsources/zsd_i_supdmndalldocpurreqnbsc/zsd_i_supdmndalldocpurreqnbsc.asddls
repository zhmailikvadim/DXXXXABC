/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZUJSKAS      | 18.01.2023 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'Basic View for Purchase Requisition'
define view entity ZSD_I_SUPDMNDALLDOCPURREQNBSC
  as select from    eban                   as eban
    inner join      ZSD_I_SUPDMNDMATERIALPLANT as marc    on  eban.matnr = marc.Material
                                                      and eban.werks = marc.Plant
    left outer join ebkn                   as ebkn    on  eban.banfn = ebkn.banfn
                                                      and eban.bnfpo = ebkn.bnfpo
    left outer join lfa1                   as lfa1_dv on  eban.lifnr        = lfa1_dv.lifnr
                                                      and lfa1_dv.cvp_xblck = ''
    left outer join lfa1                   as lfa1_fv on  eban.flief        = lfa1_fv.lifnr
                                                      and lfa1_fv.cvp_xblck = ''
{
  cast(eban.banfn as abap.char(12)) as SupplyNumber,
  cast(eban.bnfpo as abap.char(5))  as SupplyItem,
  cast('0000' as abap.char(4))      as SupplyScheduleLine,
  case
    when eban.pstyp = '5' -- Third Party Order
    then 'T'
    when eban.sobkz = 'E' -- Purchase To Order
    then 'E'
    else 'A'
  end                               as AssignedSupplyType,
  'A'                               as SupAssgmtSource,
  eban.lfdat                        as SupplyDeliveryDate,
  eban.lfdat                        as ProductAvailabilityDate,
  eban.lfdat                        as RequestedDeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  eban.menge - eban.bsmng           as TotalQuantity,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  eban.menge - eban.bsmng           as OpenSupplyQuantity,
  eban.meins                        as BaseUnit,
  eban.matnr                        as Material,
  eban.matkl                        as MaterialGroup,
  eban.werks                        as Plant,
  marc.MaterialType,
  eban.sgt_scat                     as StockSegment,
  marc.CrossPlantConfigurableProduct,
  eban.bsart                        as OrderType,
  eban.ekorg                        as PurchasingOrganization,
  eban.ekgrp                        as PurchasingGroup,
  cast('' as charg_d )              as Batch,
  cast('' as lgort_d )              as StorageLocation,
  eban.kunnr                        as Customer,
  eban.bstyp                        as PurchaseOrderCategory,
  case
    when eban.flief <> ''
    then eban.flief
    else eban.lifnr
  end                               as Supplier,
  eban.extcompanycodeforpurg        as CompanyCode,
  case
    when eban.pstyp = '5' or eban.sobkz = 'E'
    then coalesce(ebkn.vbeln,'')
    else ''
   end                              as SalesOrder,
  case
    when eban.pstyp = '5' or eban.sobkz = 'E'
    then coalesce(ebkn.vbelp,'000000')
    else '000000'
   end                              as SalesOrderItem,
  eban.frgzu                        as PurgReleaseSequenceStatus,
  eban.preis                        as NetPriceAmount,
  eban.waers                        as DocumentCurrency,
  eban.plifz                        as PlannedDeliveryTime,
  eban.erdat                        as CreationDate
}
where
           eban.bstyp    =  'B' -- Purchasing Document Category
  and      eban.loekz    =  ''  --  Deletion Indicator in Purchasing Document
  and      eban.menge    >  eban.bsmng
  and(
           eban.knttp    =  ''
    or(
           eban.knttp    <> ''
      and(
           eban.pstyp    =  '5' -- Third Party
        or eban.sobkz    =  'E' -- Order in Hand
      )
    )
  )                            -- Account Assignment Category
  and      eban.ebakz    =  '' -- Purchase Requisition Closed
  and      eban.blckd    =  '' -- Purchase Requisition Blocked
  and      eban.bsakz    =  '' -- Control indicator for purchasing document type
  and(
           eban.arsnr         =  '0000000000' -- Settlement reservation number
    or     eban.vorab         =  'X' -- Advance procurement: project stock
  )
  and(
           eban.sobkz    =  ''
    or     eban.sobkz    =  'K'
    or     eban.sobkz    =  'E'
    //    or eban.sobkz =       'W'
    or     eban.pstyp    =  '5'
  )
  and(
           eban.lifnr    =  ''
    or(
           eban.lifnr    <> ''
      and  lfa1_dv.lifnr <> ''
    )
  )
  and(
           eban.flief    =  ''
    or(
           eban.flief    <> ''
      and  lfa1_fv.lifnr <> ''
    )
  )
