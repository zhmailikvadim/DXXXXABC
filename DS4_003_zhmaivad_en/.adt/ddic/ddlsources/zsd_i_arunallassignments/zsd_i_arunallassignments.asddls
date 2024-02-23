/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SHNIPALI     | 28.12.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I_ARunAllAssignments Custom View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XXL
   }
}
define view entity ZSD_I_ARunAllAssignments
  as select from arun_bdbs
{
  plant                                          as Plant,
  material                                       as Material,
  req_ind                                        as RequirementType,
  arun_status                                    as SupplyAssignmentStatus,
  case req_ind
    when 'VC' then salesdoc_num
    when 'VI' then salesdoc_num
    when 'VG' then salesdoc_num
    when 'VJ' then salesdoc_num
    when 'U1' then purchdoc_num
    when 'BB' then cast(reserv_num as abap.char(10))
    when 'AR' then cast(reserv_num as abap.char(10))
    else cast('0000000000' as abap.char(10))
  end                                            as RequirementDocumentNumber,
  case req_ind
    when 'VC' then salesdoc_item
    when 'VI' then salesdoc_item
    when 'VG' then salesdoc_item
    when 'VJ' then salesdoc_item
    when 'U1' then LPAD(purchdoc_item,6,'0')
    when 'BB' then LPAD(reserv_item,6,'0')
    when 'AR' then LPAD(reserv_item,6,'0')
    else '000000'
  end                                            as RequirementDocumentItem,
  hextobin( '00000000000000000000000000000000' ) as SupProtTimeBucketUUID,
  stock_source                                   as AssignedSupplyType,
  stock_source                                   as SupAssgmtSource,
  case stock_source
    when 'B' then cast(purchord_num as abap.char(12))
    when 'L' then cast(purchord_num as abap.char(12))
    when 'F' then cast(prodord_num as abap.char(12))
    else cast('' as abap.char(12))
  end                                            as SupplyNumber,
  case stock_source
    when 'B' then cast(purchord_item as abap.char(6))
    when 'L' then cast(purchord_item as abap.char(6))
    when 'F' then cast(prodord_item as abap.char(6))
    else cast('000000' as abap.char(6))
  end                                            as SupplyItem,
  case stock_source
    when 'B' then cast(purchord_sch as abap.char(4))
    when 'L' then cast(confirmation_no as abap.char(4))
    else cast('0000' as abap.char(4))
  end                                            as SupplyScheduleLine,
  case
    when stock_source = 'C' or stock_source = 'S'
    then batch
    else ''
  end                                            as Batch,
  case
    when stock_source = 'C' or stock_source = 'S'
    then storage_location
    else ''
  end                                            as StorageLocation,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  alloc_qty                                      as AssignedQuantityInBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  alloc_qty                                      as NormalAssignedQuantityInBsUnt,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  cast( 0 as abap.dec( 12, 3 ) )                 as PreviewAssignedQuantityInBsUnt,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  cast( 0 as abap.dec( 12, 3 ) )                 as ARunTmpAssignedQuantityInBsUnt,
  material_baseunit                              as BaseUnit,
  requested_date                                 as RequestedDate,
  material_avail_date                            as ProductAvailabilityDate,
  case
    when stock_source = 'S' or stock_source = 'C'
    then cast( $session.system_date as abap.dats )
    else  delivery_date_po
  end                                            as SupplyDeliveryDate,
  case
    when stock_source = 'S' or stock_source = 'C'
    then 0
    else dats_days_between( material_avail_date, delivery_date_po )
  end                                            as NumberOfDays,
  creation_time                                  as DateNormalAssgmnt,
  cast( 0 as timestamp )                         as DateTempAssgmnt
}

union all select from arun_preview
{
  plant                                          as Plant,
  material                                       as Material,
  req_ind                                        as RequirementType,
  arun_status                                    as SupplyAssignmentStatus,
  case req_ind
    when 'VC' then salesdoc_num
    when 'VI' then salesdoc_num
    when 'VG' then salesdoc_num
    when 'U1' then purchdoc_num
    when 'BB' then cast(reserv_num as abap.char(10))
    when 'AR' then cast(reserv_num as abap.char(10))
    else ''
  end                                            as RequirementDocumentNumber,
  case req_ind
    when 'VC' then salesdoc_item
    when 'VI' then salesdoc_item
    when 'VG' then salesdoc_item
    when 'U1' then LPAD(purchdoc_item,6,'0')
    when 'BB' then LPAD(reserv_item,6,'0')
    when 'AR' then LPAD(reserv_item,6,'0')
    else '000000'
  end                                            as RequirementDocumentItem,
  hextobin( '00000000000000000000000000000000' ) as SupProtTimeBucketUUID,
  stock_source                                   as AssignedSupplyType,
  stock_source                                   as SupAssgmtSource,
  case stock_source
    when 'B' then cast(purchord_num as abap.char(12))
    when 'A' then cast(purchord_num as abap.char(12))
    when 'L' then cast(purchord_num as abap.char(12))
    when 'F' then cast(prodord_num as abap.char(12))
    when 'P' then cast(plnum as abap.char(12))
    else cast('' as abap.char(12))
  end                                            as SupplyNumber,
  case stock_source
    when 'B' then cast(purchord_item as abap.char(6))
    when 'A' then cast(purchord_item as abap.char(6))
    when 'L' then cast(purchord_item as abap.char(6))
    when 'F' then cast(prodord_item as abap.char(6))
    else cast('000000' as abap.char(6))
  end                                            as SupplyItem,
  case stock_source
    when 'B' then cast(purchord_sch as abap.char(4))
    when 'L' then cast(confirmation_no as abap.char(4))
    else cast('0000' as abap.char(4))
  end                                            as SupplyScheduleLine,
  case
    when stock_source = 'C' or stock_source = 'S'
    then batch
    else ''
  end                                            as Batch,
  case
    when stock_source = 'C' or stock_source = 'S'
    then storage_location
    else ''
  end                                            as StorageLocation,
  alloc_qty                                      as AssignedQuantityInBaseUnit,
  cast( 0 as abap.dec( 12, 3 ) )                 as NormalAssignedQuantityInBsUnt,
  alloc_qty                                      as PreviewAssignedQuantityInBsUnt,
  cast( 0 as abap.dec( 12, 3 ) )                 as ARunTmpAssignedQuantityInBsUnt,
  material_baseunit                              as BaseUnit,
  requested_date                                 as RequestedDate,
  material_avail_date                            as ProductAvailabilityDate,
  case
    when stock_source = 'S' or stock_source = 'C'
    then cast( $session.system_date as abap.dats )
    else  delivery_date_po
  end                                            as SupplyDeliveryDate,
  case
    when stock_source = 'S' or stock_source = 'C'
    then 0
    else dats_days_between( material_avail_date, delivery_date_po )
  end                                            as NumberOfDays,
  cast( 0 as timestamp )                         as DateNormalAssgmnt,
  cast( 0 as timestamp )                         as DateTempAssgmnt
}


union all select from arun_sdo_alldoc
{
  case
    when stock_source = 'K' and fpc_material is not initial
    then fpc_plant
    else plant
  end                            as Plant,
  case
    when stock_source = 'K' and fpc_material is not initial
    then fpc_material
    else material
  end                            as Material,
  req_ind                        as RequirementType,
  arun_status                    as SupplyAssignmentStatus,
  case req_ind
    when 'VC' then salesdoc_num
    when 'VI' then salesdoc_num
    when 'VG' then salesdoc_num
    when 'VS' then salesdoc_num
    when 'VE' then salesdoc_num
    when 'VM' then salesdoc_num
    when 'U1' then purchdoc_num
    when 'U2' then purchdoc_num
    when 'RP' then purchdoc_num
    when 'BB' then reserv_num
    when 'RB' then reserv_num
    when 'AR' then reserv_num
    when 'SB' then reserv_num
    when 'PP' then pir
    else ''
  end                            as RequirementDocumentNumber,
  case req_ind
    when 'VC' then salesdoc_item
    when 'VI' then salesdoc_item
    when 'VG' then salesdoc_item
    when 'VS' then salesdoc_item
    when 'VE' then salesdoc_item
    when 'VM' then salesdoc_item
    when 'U1' then LPAD(purchdoc_item,6,'0')
    when 'U2' then LPAD(purchdoc_item,6,'0')
    when 'RP' then LPAD(purchdoc_item,6,'0')
    when 'BB' then LPAD(reserv_item,6,'0')
    when 'RB' then LPAD(reserv_item,6,'0')
    when 'AR' then LPAD(reserv_item,6,'0')
    when 'SB' then LPAD(reserv_item,6,'0')
    else '000000'
  end                            as RequirementDocumentItem,
  sup_uuid                       as SupProtTimeBucketUUID,
  stock_ind                      as AssignedSupplyType,
  stock_source                   as SupAssgmtSource,
  case stock_source
    when 'B' then cast(purchord_num as abap.char(12))
    when 'A' then cast(purchord_num as abap.char(12))
    when 'L' then cast(purchord_num as abap.char(12))
    when 'K' then cast(purchord_num as abap.char(12))
    when 'F' then cast(prodord_num as abap.char(12))
    when 'P' then cast(plnum as abap.char(12))
    when 'R' then cast(retsd_num as abap.char(12))
    when 'D' then cast(retsd_num as abap.char(12))
    else cast('' as abap.char(12))
  end                            as SupplyNumber,
  case stock_source
    when 'B' then cast(purchord_item as abap.char(6))
    when 'A' then cast(purchord_item as abap.char(6))
    when 'K' then cast(purchord_item as abap.char(6))
    when 'L' then cast(purchord_item as abap.char(6))
    when 'F' then cast(prodord_item as abap.char(6))
    when 'R' then cast(retsd_item as abap.char(6))
    when 'D' then cast(retsd_item as abap.char(6))
    else cast('000000' as abap.char(6))
  end                            as SupplyItem,
  case stock_source
    when 'B' then cast(purchord_sch as abap.char(4))
    when 'L' then cast(confirmation_no as abap.char(4))
    when 'R' then cast(retsd_sch as abap.char(4))
    else cast('0000' as abap.char(4))
  end                            as SupplyScheduleLine,
  case
    when stock_source = 'C' or stock_source = 'S'
    then batch
    else ''
  end                            as Batch,
  case
    when stock_source = 'C' or stock_source = 'S'
    then storage_location
    else ''
  end                            as StorageLocation,
  alloc_qty                      as AssignedQuantityInBaseUnit,
  cast( 0 as abap.dec( 12, 3 ) ) as NormalAssignedQuantityInBsUnt,
  cast( 0 as abap.dec( 12, 3 ) ) as PreviewAssignedQuantityInBsUnt,
  alloc_qty                      as ARunTmpAssignedQuantityInBsUnt,
  material_baseunit              as BaseUnit,
  requested_date                 as RequestedDate,
  material_avail_date            as ProductAvailabilityDate,
  case
    when stock_source = 'S' or stock_source = 'C'
    then cast( $session.system_date as abap.dats )
    else  delivery_date_po
  end                            as SupplyDeliveryDate,
  case
    when stock_source = 'S' or stock_source = 'C'
    then 0
    else dats_days_between( material_avail_date, delivery_date_po )
  end                            as NumberOfDays,
  cast( 0 as timestamp )         as DateNormalAssgmnt,
  creation_time                  as DateTempAssgmnt
}
where
  arun_status = 'T'
