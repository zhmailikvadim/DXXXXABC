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
  sqlViewName: 'ISUPDMNDADCONS',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #C,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Document Consumption'
define view I_SupDmndAllDocCnsmpn
  as select from arun_sdo_alldoc
{
  plant               as Plant,
  material            as Material,
  pir                 as PlndIndepRqmtPlan,
  pir_date            as ProductAvailabilityDate,
  pir_date            as RequestedDeliveryDate,
  'PP'                as RequirementType,
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
    else ''
  end                 as RequirementDocumentNumber,
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
  end                 as RequirementDocumentItem,
  req_ind             as ProdAvailabilityCheckRqmtType,
  requested_date      as RequestedDate,
  material_avail_date as RequirementDate,
  sum( consumed_qty ) as ARunConsumedQuantityInBsUnt,
  material_baseunit   as BaseUnit
}
where
  arun_status = '3'
group by
  plant,
  material,
  pir,
  pir_date,
  req_ind,
  salesdoc_num,
  purchdoc_num,
  reserv_num,
  salesdoc_item,
  purchdoc_item,
  reserv_item,
  requested_date,
  material_avail_date,
  material_baseunit
