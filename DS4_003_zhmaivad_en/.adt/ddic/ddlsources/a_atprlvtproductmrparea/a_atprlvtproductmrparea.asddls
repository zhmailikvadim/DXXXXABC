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
@OData.entityType.name: 'ATPRlvtProductMRPArea_Type'
@Feature: 'OLY_PAC_INFO_API'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Product Availability per MRP Area'
define root view entity A_ATPRlvtProductMRPArea
  as select from I_ProductMRPArea   as _ProductMRPArea
    inner join   I_ProductPlant     as _ProductPlant     on  _ProductPlant.Product = _ProductMRPArea.Product
                                                         and _ProductPlant.Plant   = _ProductMRPArea.MRPPlant
    inner join   I_ATPCheckingGroup as _ATPCheckingGroup on _ATPCheckingGroup.ATPCheckingGroup = _ProductPlant.AvailabilityCheckType
{
  key _ProductMRPArea.Product as Product,
  key _ProductMRPArea.MRPArea as MRPArea
}
where
  _ATPCheckingGroup.AdvancedATPIsActive = 'X' and
  _ProductMRPArea.MRPArea <> _ProductMRPArea.MRPPlant

union all select from I_ProductPlant     as _ProductPlant
  inner join      I_ATPCheckingGroup as _ATPCheckingGroup on _ATPCheckingGroup.ATPCheckingGroup = _ProductPlant.AvailabilityCheckType
{
  key _ProductPlant.Product as Product,
  key _ProductPlant.Plant   as MRPArea
}
where
  _ATPCheckingGroup.AdvancedATPIsActive = 'X'
