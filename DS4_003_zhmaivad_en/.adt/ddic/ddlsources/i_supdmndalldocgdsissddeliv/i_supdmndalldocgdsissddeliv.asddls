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
  sqlViewName: 'ISUPDMNDADGIDLV',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Goods Issued Deliveries'
define view I_SupDmndAllDocGdsIssdDeliv
  as select from lips                   as lips
    inner join   likp                   as likp on lips.vbeln = likp.vbeln
    inner join   kna1                   as kna1 on likp.kunnr = kna1.kunnr
    inner join   I_SupDmndMaterialPlant as marc on  lips.matnr = marc.Material
                                                and lips.werks = marc.Plant
{
  lips.vbeln                                      as RequirementDocumentNumber,
  lips.posnr                                      as RequirementDocumentItem,
  lips.uecha                                      as HigherLvlItmOfBatSpltItm,
  'VJ'                                            as RequirementType,
  lips.mbdat                                      as RequestedDate,
  lips.mbdat                                      as ProductAvailabilityDate,
  lips.mbdat                                      as RequestedDeliveryDate,
  lips.ormng                                      as DeliveredQuantity,
  lips.meins                                      as BaseUnit,
  likp.wadat                                      as PlannedGoodsIssueDate,
  likp.wadat_ist                                  as ActualGoodsMovementDate,
  // Planned GI Date - Actual GI Date
  dats_days_between( likp.wadat, likp.wadat_ist ) as GIToPlndGIDelayInDays,
  likp.vsart                                      as ShippingType,
  lips.matnr                                      as Material,
  lips.werks                                      as Plant,
  lips.matkl                                      as MaterialGroup,
  marc.MaterialType,
  marc.CrossPlantConfigurableProduct,
  lips.sgt_rcat                                   as RequirementSegment,
  likp.vbtyp                                      as SDDocumentCategory,
  likp.lfart                                      as DeliveryDocumentType,
  likp.vkorg                                      as SalesOrganization,
  lips.vtweg                                      as DistributionChannel,
  lips.spart                                      as Division,
  likp.bzirk                                      as SalesDistrict,
  likp.kunag                                      as SoldToParty,
  lips.lgort                                      as StorageLocation,
  kna1.cvp_xblck                                  as IsBusinessPurposeCompleted,
  lips.netpr                                      as NetPriceAmount,
  likp.waerk                                      as DocumentCurrency
}
where
      lips.wbsta = 'C' --> Good Movement completed ( PGI Done )
  and lips.lfimg > 0
  and likp.vbtyp = 'J'
