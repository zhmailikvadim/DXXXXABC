@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #COMPOSITE
}
@VDM.private: true
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'PSUPDMNDADCONS',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XXL
   }
}
//@EndUserText.label: 'View for Consumption from Demand Perspective'
define view P_SupDmndAllDocCnsmpn
  as select from I_SupDmndAllDocCnsmpn as Cnsmpn
{
  Cnsmpn.PlndIndepRqmtPlan,
  Cnsmpn.ProductAvailabilityDate,
  Cnsmpn.RequirementType,
  Cnsmpn.Material,
  Cnsmpn.Plant,
  sum(Cnsmpn.ARunConsumedQuantityInBsUnt)   as ARunConsumedQuantityInBsUnt,
  Cnsmpn.BaseUnit
}
group by
  Cnsmpn.PlndIndepRqmtPlan,
  Cnsmpn.ProductAvailabilityDate,
  Cnsmpn.RequirementType,
  Cnsmpn.Material,
  Cnsmpn.Plant,
  Cnsmpn.BaseUnit
