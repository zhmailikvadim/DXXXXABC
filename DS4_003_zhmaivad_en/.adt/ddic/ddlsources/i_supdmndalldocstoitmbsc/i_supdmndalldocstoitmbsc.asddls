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
  sqlViewName: 'ISUPDMNDADSTOITB',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'Basic View for Stock Transport Order'
define view I_SupDmndAllDocSTOItmBsc
  as select from    ekko                         as ekko
    inner join      ekpo                         as ekpo      on  ekko.ebeln = ekpo.ebeln  
    inner join      eket                         as eket      on  ekpo.ebeln = eket.ebeln
                                                              and ekpo.ebelp = eket.ebelp
    inner join      I_PurchasingDocumentShipping as shipping  on  ekpo.ebeln = shipping.PurchasingDocument   
                                                              and ekpo.ebelp = shipping.PurchasingDocumentItem 
    inner join      I_SupDmndMaterialPlant       as marc      on  ekpo.matnr = marc.Material
                                                              and ekko.reswk = marc.Plant
    left outer join I_SupDmndSalesArea           as SalesArea on  SalesArea.Customer             = shipping.ShipToParty
                                                              and SalesArea.SalesOrganization    = shipping.SalesOrganization
                                                              and SalesArea.DistributionChannel  = shipping.DistributionChannel
                                                              and SalesArea.OrganizationDivision = shipping.OrganizationDivision

{
  ekpo.ebeln             as RequirementDocumentNumber,
  lpad(ekpo.ebelp,6,'0') as RequirementDocumentItem,
  'U1'                   as RequirementType,
  eket.arun_req_dlvdate  as RequestedDate,
  case
    when eket.mbdat = '00000000' or eket.mbdat = ''
    then eket.dat01
    else eket.mbdat
  end                    as ProductAvailabilityDate,
  eket.menge             as ScheduleLineOrderQuantity,
  eket.mng02             as ConfdOrderQtyByMatlAvailCheck,
  eket.glmng             as DeliveredQuantityInBaseUnit,
  ekpo.meins             as BaseUnit,
  ekpo.matnr             as Material,
  ekpo.matkl             as MaterialGroup,
  ekko.reswk             as Plant,
  ekko.bsart             as OrderType,
  marc.CrossPlantConfigurableProduct,
  marc.MaterialType,
  ekpo.sgt_rcat          as RequirementSegment,
  ekko.ekorg             as PurchasingOrganization,
  ekko.ekgrp             as PurchasingGroup,
  shipping.SalesOrganization             as SalesOrganization,
  shipping.DistributionChannel           as DistributionChannel,
  shipping.OrganizationDivision          as Division,
  SalesDistrict          as SalesDistrict,
  shipping.ShipToParty   as SoldToParty,
  ekpo.bukrs             as CompanyCode,
  ekpo.lgort             as StorageLocation,
  ekko.frgzu             as PurgReleaseSequenceStatus,
  ekpo.netpr             as NetPriceAmount,
  ekko.waers             as DocumentCurrency,
  marc.SegmentationStrategy,
  marc.SegmentationStrategyScope  
}
where
       ekko.reswk      <> '' -- Supplying Plant should be present
  and(
       ekpo.elikz != 'X'
  ) -- delivery completed indicator at ekpo level
  and(
       ekpo.retpo != 'X'
  ) -- return po
  and(
       ekpo.loekz      =  ' '
  ) -- deletion indicator
  and(
       ekpo.eglkz != 'X'
  ) -- final delivery indicator
  and(
       ekpo.pstyp      =  '0'
    or ekpo.pstyp      =  '7'
    or ekpo.pstyp      =  '2'
  ) -- ekpo category in purchasing doc
  and(
       ekko.bstyp      =  'F'
  ) -- purchasing doc category  , F is PO

  and(
       ekko.memorytype =  ''
  ) -- Category of Incompletess
  and(
       ekko.loekz != 'X'
  ) -- deletion indicator
  and 
  ekko.iseopblocked = ''
