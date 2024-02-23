@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Active Supply Protections'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_supplyprotect_active
  as select distinct from I_SupplyProtectionTP
{
  key    Material,
  key    Plant,
         SupProtLifecycleStatus
}
where
  SupProtLifecycleStatus = '02'
