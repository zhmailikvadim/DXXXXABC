@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.sqlViewName: 'IMMORGPLANT'
@ClientHandling.algorithm: #SESSION_VARIABLE 
@Analytics.dataExtraction.enabled: true
@Analytics.dataCategory:#DIMENSION
@ObjectModel.usageType.dataClass: #CUSTOMIZING 
@ObjectModel.usageType.serviceQuality: #A 
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE,#EXTRACTION_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET ] 
@EndUserText.label: 'Responsible Purg Org for Plant' 
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

define view I_PlantPurchasingOrganization
  as select from t024w
  association [1..1] to I_PurchasingOrganization as _PurchasingOrganization on $projection.PurchasingOrganization = _PurchasingOrganization.PurchasingOrganization

  association [1..1] to I_Plant                  as _Plant                  on $projection.Plant = _Plant.Plant
{
      @ObjectModel.foreignKey.association: '_PurchasingOrganization'
  key ekorg as PurchasingOrganization,
  @ObjectModel.foreignKey.association: '_Plant'
  key werks as Plant,

      _PurchasingOrganization,
      _Plant

}      
  
  
  
  
  
 