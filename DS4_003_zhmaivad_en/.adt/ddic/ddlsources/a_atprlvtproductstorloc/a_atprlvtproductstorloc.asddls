@VDM: {
  viewType: #CONSUMPTION,
  lifecycle.contract.type: #PUBLIC_REMOTE_API,
  usage.type: [#TRANSACTIONAL_PROCESSING_SERVICE]
}
@ObjectModel: {
   usageType: {
     serviceQuality: #C,
     sizeCategory:   #XL,
     dataClass:      #MASTER
   }
}
@OData.entityType.name: 'ATPRlvtProductStorLoc_Type'
@Feature: 'OLY_PAC_INFO_API'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Product Availability per StorLoc'
define root view entity A_ATPRlvtProductStorLoc
  as select from I_ATPRlvtProdMRPAreaStorLoc as _ProdMRPAreaStorLoc
    inner join   I_ProductMRPArea            as _ProductMRPArea   on  _ProductMRPArea.Product = _ProdMRPAreaStorLoc.Product
                                                                  and _ProductMRPArea.MRPArea = _ProdMRPAreaStorLoc.MRPArea
    inner join   I_ProductPlant              as _ProductPlant     on  _ProductPlant.Product = _ProductMRPArea.Product
                                                                  and _ProductPlant.Plant   = _ProductMRPArea.MRPPlant
    inner join   I_ATPCheckingGroup          as _ATPCheckingGroup on _ATPCheckingGroup.ATPCheckingGroup = _ProductPlant.AvailabilityCheckType

{
  key _ProdMRPAreaStorLoc.Product         as Product,
  key _ProdMRPAreaStorLoc.StorageLocation as StorageLocation,
  key _ProdMRPAreaStorLoc.MRPArea         as MRPArea
}
where
  _ATPCheckingGroup.AdvancedATPIsActive = 'X'

union select from         I_ProductStorageLocation    as _ProdStorLoc
  inner join              I_ProductPlant              as _ProductPlant       on  _ProductPlant.Product = _ProdStorLoc.Product
                                                                             and _ProductPlant.Plant   = _ProdStorLoc.Plant
  inner join              I_ATPCheckingGroup          as _ATPCheckingGroup   on _ATPCheckingGroup.ATPCheckingGroup = _ProductPlant.AvailabilityCheckType
  left outer to many join I_ATPRlvtProdMRPAreaStorLoc as _ProdMRPAreaStorLoc on  _ProdMRPAreaStorLoc.Product         = _ProdStorLoc.Product
                                                                             and _ProdMRPAreaStorLoc.StorageLocation = _ProdStorLoc.StorageLocation
{
  key _ProdStorLoc.Product         as Product,
  key _ProdStorLoc.StorageLocation as StorageLocation,
  key _ProdStorLoc.Plant           as MRPArea
}
where
      _ProdMRPAreaStorLoc.MRPArea           is null
  and _ATPCheckingGroup.AdvancedATPIsActive = 'X'
