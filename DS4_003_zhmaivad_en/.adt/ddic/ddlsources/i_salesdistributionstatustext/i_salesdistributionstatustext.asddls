@AbapCatalog.sqlViewName: 'ISLSDISTRBTNT'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for TVMST'
@VDM.viewType: #BASIC 
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'ProductSalesStatus'
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING 
define view I_SalesDistributionStatusText as select from tvmst _SalesDistributionStatusText
 {
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH
  key _SalesDistributionStatusText.vmsta as ProductSalesStatus,
  @Semantics.language: true
  key _SalesDistributionStatusText.spras as Language,
  @Semantics.text
  _SalesDistributionStatusText.vmstb as ProductSalesStatusDescription
  
}
