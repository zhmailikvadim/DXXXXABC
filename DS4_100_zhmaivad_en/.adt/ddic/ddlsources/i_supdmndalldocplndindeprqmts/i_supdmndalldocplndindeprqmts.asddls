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
  sqlViewName: 'ISUPDMNDADPIR',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Planned Independent Requirements'
define view I_SupDmndAllDocPlndIndepRqmts
  as select from pbed                   as pbed
    inner join   pbim                   as pbim on pbim.bdzei = pbed.bdzei
    inner join   I_SupDmndMaterialPlant as marc on  pbim.matnr = marc.Material
                                                and pbim.werks = marc.Plant
{
  pbim.pbdnr                  as RequirementDocumentNumber,
  cast( '000000' as posnr )   as RequirementDocumentItem,
  'PP'                        as RequirementType,
  pbed.pdatu                  as RequestedDate,
  pbed.pdatu                  as ProductAvailabilityDate,
  pbed.pdatu                  as RequestedDeliveryDate,
  pbed.plnmg                  as RequestedRqmtQtyInBaseUnit,
  pbed.plnmg                  as ConfirmedRqmtQtyInBaseUnit,
  cast( 0 as tdd_rrqqty_bu )  as DeliveredQuantityInBaseUnit,
  pbed.plnmg                  as OpenDemandQuantity,
  0                           as AssignedQuantityInBaseUnit,
  0                           as NormalAssignedQuantityInBsUnt,
  0                           as PreviewAssignedQuantityInBsUnt,
  pbed.meins                  as BaseUnit,
  pbim.matnr                  as Material,
  marc.MaterialGroup          as MaterialGroup,
  marc.MaterialType           as MaterialType,
  pbim.werks                  as Plant,
  marc.CrossPlantConfigurableProduct,
  pbim.bedae                  as OrderType,
  pbim.bdzei                  as PlndIndepRqmtInternalID,
  cast( pbim.werks as berid ) as MRPArea,
  pbim.sgt_rcat               as RequirementSegment,
  marc.SegmentationStrategy,
  marc.SegmentationStrategyScope
}
where
      pbim.vervs = 'X' //Version Active
  and pbed.plnmg > 0   //Planned quantity
union all select from pbid                   as pbid
  inner join          pbed                   as pbed on pbid.bdzei = pbed.bdzei
  inner join          I_SupDmndMaterialPlant as marc on  pbid.matnr = marc.Material
                                                     and pbid.werks = marc.Plant
{
  pbid.pbdnr                 as RequirementDocumentNumber,
  cast( '000000' as posnr )  as RequirementDocumentItem,
  'PP'                       as RequirementType,
  pbed.pdatu                 as RequestedDate,
  pbed.pdatu                 as ProductAvailabilityDate,
  pbed.pdatu                 as RequestedDeliveryDate,
  pbed.plnmg                 as RequestedRqmtQtyInBaseUnit,
  pbed.plnmg                 as ConfirmedRqmtQtyInBaseUnit,
  cast( 0 as tdd_rrqqty_bu ) as DeliveredQuantityInBaseUnit,
  pbed.plnmg                 as OpenDemandQuantity,
  0                          as AssignedQuantityInBaseUnit,
  0                          as NormalAssignedQuantityInBsUnt,
  0                          as PreviewAssignedQuantityInBsUnt,
  pbed.meins                 as BaseUnit,
  pbid.matnr                 as Material,
  marc.MaterialGroup         as MaterialGroup,
  marc.MaterialType          as MaterialType,
  pbid.werks                 as Plant,
  marc.CrossPlantConfigurableProduct,
  pbid.bedae                 as OrderType,
  pbid.bdzei                 as PlndIndepRqmtInternalID,
  pbid.berid                 as MRPArea,
  pbid.sgt_rcat              as RequirementSegment,
  marc.SegmentationStrategy,
  marc.SegmentationStrategyScope
}
where
      pbid.vervs = 'X' //Version Active
  and pbed.plnmg > 0   //Planned quantity
