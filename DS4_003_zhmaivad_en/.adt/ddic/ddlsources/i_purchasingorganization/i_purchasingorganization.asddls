@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'PurchasingOrganization'
@ObjectModel.usageType.dataClass:#ORGANIZATIONAL
@ObjectModel.usageType.serviceQuality:#A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.sapObjectNodeType.name:'PurchasingOrganization'
@ObjectModel.supportedCapabilities: [ #SEARCHABLE_ENTITY,
                                      #ANALYTICAL_DIMENSION,
                                      #EXTRACTION_DATA_SOURCE,
                                      #SQL_DATA_SOURCE, 
                                      #CDS_MODELING_DATA_SOURCE, 
                                      #CDS_MODELING_ASSOCIATION_TARGET ]
@AbapCatalog.sqlViewName: 'IMMPURGORG'
@EndUserText.label: 'Purchasing Organization'
@Analytics.dataCategory: #DIMENSION
@Analytics.dataExtraction.enabled: true
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
define view I_PurchasingOrganization
  as select from t024e

  association [0..*] to I_PlantPurchasingOrganization as _Plant on $projection.PurchasingOrganization = _Plant.PurchasingOrganization

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.75
      @ObjectModel.text.element : 'PurchasingOrganizationName'
  key cast( ekorg as ekorg_ll preserving type )           as PurchasingOrganization,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.75
      @Semantics.text: true
      cast( ekotx as mm_a_purg_org_name preserving type ) as PurchasingOrganizationName,

      t024e.bukrs                                         as CompanyCode,

      _Plant
};
