@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADSTR',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Stock Transport Requisition'
define view I_SupDmndAllDocStkTransptReqn
  as select from    eban                   as eban
    inner join      I_SupDmndMaterialPlant as marc on  eban.matnr = marc.Material
                                                   and eban.reswk = marc.Plant
    left outer join ebkn                   as ebkn on  eban.banfn = ebkn.banfn
                                                   and eban.bnfpo = ebkn.bnfpo
{
  eban.banfn                 as RequirementDocumentNumber,
  lpad(eban.bnfpo,6,'0')     as RequirementDocumentItem,
  'U2'                       as RequirementType,
  eban.lfdat                 as RequestedDate,
  eban.lfdat                 as ProductAvailabilityDate,
  eban.lfdat                 as RequestedDeliveryDate,
  (eban.menge - eban.bsmng)  as RequestedRqmtQtyInBaseUnit,
  (eban.menge - eban.bsmng)  as ConfirmedRqmtQtyInBaseUnit,
  0                          as DeliveredQuantityInBaseUnit,
  (eban.menge - eban.bsmng)  as OpenDemandQuantity,
  0                          as AssignedQuantityInBaseUnit,
  0                          as NormalAssignedQuantityInBsUnt,
  0                          as PreviewAssignedQuantityInBsUnt,
  eban.bsmng                 as OrderedQuantity,
  eban.meins                 as BaseUnit,
  eban.matnr                 as Material,
  eban.matkl                 as MaterialGroup,
  eban.reswk                 as Plant,
  eban.bsart                 as OrderType,
  marc.CrossPlantConfigurableProduct,
  marc.MaterialType,
  eban.sgt_rcat              as RequirementSegment,
  eban.ekorg                 as PurchasingOrganization,
  eban.ekgrp                 as PurchasingGroup,
  eban.kunnr                 as SoldToParty,
  eban.extcompanycodeforpurg as CompanyCode,
  eban.lgort                 as StorageLocation,
  eban.frgzu                 as PurgReleaseSequenceStatus,
  eban.preis                 as NetPriceAmount,
  eban.waers                 as DocumentCurrency,
  marc.SegmentationStrategy,
  marc.SegmentationStrategyScope
}
where
       eban.bstyp =  'B' -- Purchasing Document Category
  and  eban.reswk <> ' ' -- Supplying Plant
  and  eban.loekz <> 'X' -- Deletion Indicator in Purchasing Document
  and  eban.menge >  eban.bsmng
  and  eban.knttp =  ''  -- Account Assignment Category
  and  eban.ebakz =  ''  -- Purchase Requisition Closed
  and  eban.blckd =  ''  -- Purchase Requisition Blocked
  and  eban.bsakz =  ''  -- Control indicator for purchasing document type
  and(
       arsnr      =  '0000000000' -- Settlement reservation number
    or vorab      =  'X' -- Advance procurement: project stock
  )
  and(
       eban.sobkz =  ''
    or eban.sobkz =  'K'
  )
