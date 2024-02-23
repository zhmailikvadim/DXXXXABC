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
  sqlViewName: 'IASSGNDMNDQTY',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'Assignment Qty at Demand level'
define view I_ARunAllDmndAssgmt
  as select from arun_bdbs
{
  plant                                          as Plant,
  material                                       as Material,
  req_ind                                        as RequirementType,
  case req_ind
    when 'VC' then salesdoc_num
    when 'VI' then salesdoc_num
    when 'VG' then salesdoc_num
    when 'VJ' then salesdoc_num
    when 'U1' then purchdoc_num
    when 'BB' then reserv_num
    when 'AR' then reserv_num
    else ''
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
  alloc_qty                                      as AssignedQuantityInBaseUnit,
  alloc_qty                                      as NormalAssignedQuantityInBsUnt,
  cast( 0 as abap.dec( 12, 3 ) )                 as PreviewAssignedQuantityInBsUnt,
  cast( 0 as abap.dec( 12, 3 ) )                 as ARunTmpAssignedQuantityInBsUnt,
  case 
    when arun_status = 'F' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as FixedQuantityInBaseUnit,
  case 
    when arun_status = 'R' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) )  
  end                                            as SupAssgmtReservedQtyInBaseUnit,
  case 
    when arun_status = 'O' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) )  
  end                                            as ReadyForReleaseQtyInBaseUnit,
  case 
    when arun_status = 'C' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as InboundAssignedQuantityInBsUnt,
  case 
    when stock_source = 'S' or stock_source = 'C'
    then alloc_qty
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as ARunPhysSupAssgdQtyInBsUnt,
  material_baseunit                              as BaseUnit,
  requested_date                                 as RequestedDate,
  material_avail_date                            as ProductAvailabilityDate

}
union all select from arun_preview
{
  plant                                          as Plant,
  material                                       as Material,
  req_ind                                        as RequirementType,
  case req_ind
    when 'VC' then salesdoc_num
    when 'VI' then salesdoc_num
    when 'VG' then salesdoc_num
    when 'U1' then purchdoc_num
    when 'BB' then reserv_num
    when 'AR' then reserv_num
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
  alloc_qty                                      as AssignedQuantityInBaseUnit,
  cast( 0 as abap.dec( 12, 3 ) )                 as NormalAssignedQuantityInBsUnt,
  alloc_qty                                      as PreviewAssignedQuantityInBsUnt,
  cast( 0 as abap.dec( 12, 3 ) )                 as ARunTmpAssignedQuantityInBsUnt,
  case 
    when arun_status = 'F' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as FixedQuantityInBaseUnit,
  case 
    when arun_status = 'R' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) )  
  end                                            as SupAssgmtReservedQtyInBaseUnit,
  case 
    when arun_status = 'O' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) )  
  end                                            as ReadyForReleaseQtyInBaseUnit,
  case 
    when arun_status = 'C' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as InboundAssignedQuantityInBsUnt,
  case 
    when stock_source = 'S' or stock_source = 'C'
    then alloc_qty
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as ARunPhysSupAssgdQtyInBsUnt,
  material_baseunit                              as BaseUnit,
  requested_date                                 as RequestedDate,
  material_avail_date                            as ProductAvailabilityDate
}
union all select from arun_sdo_alldoc
{
  plant                          as Plant,
  material                       as Material,
  req_ind                        as RequirementType,
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
  alloc_qty                      as AssignedQuantityInBaseUnit,
  cast( 0 as abap.dec( 12, 3 ) ) as NormalAssignedQuantityInBsUnt,
  cast( 0 as abap.dec( 12, 3 ) ) as PreviewAssignedQuantityInBsUnt,
  alloc_qty                      as ARunTmpAssignedQuantityInBsUnt,
  case 
    when arun_status = 'F' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as FixedQuantityInBaseUnit,
  case 
    when arun_status = 'R' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) )  
  end                                            as SupAssgmtReservedQtyInBaseUnit,
  case 
    when arun_status = 'O' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) )  
  end                                            as ReadyForReleaseQtyInBaseUnit,
  case 
    when arun_status = 'C' 
    then alloc_qty          
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as InboundAssignedQuantityInBsUnt,
  case 
    when stock_source = 'S' or stock_source = 'C'
    then alloc_qty
    else cast( 0 as abap.dec( 12, 3 ) ) 
  end                                            as ARunPhysSupAssgdQtyInBsUnt,  
  material_baseunit              as BaseUnit,
  requested_date                 as RequestedDate,
  material_avail_date            as ProductAvailabilityDate
}
where
  arun_status = 'T'
