@AbapCatalog: {
                sqlViewName: 'ISTORAGELOCATION',
                preserveKey: true,
                compiler.compareFilter: true
              }
@EndUserText.label: 'Storage Location'
@ObjectModel: {
                usageType: {
                             sizeCategory: #S,
                             serviceQuality: #A,
                             dataClass:#CUSTOMIZING
                           },
                representativeKey: 'StorageLocation',
                modelingPattern: #ANALYTICAL_DIMENSION,
                supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #EXTRACTION_DATA_SOURCE]
              }
@VDM: {
        viewType: #BASIC,
        lifecycle.contract.type: #PUBLIC_LOCAL_API
      }
@AccessControl: {
                  authorizationCheck: #NOT_REQUIRED,
                  personalData.blocking: #NOT_REQUIRED
                }
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics: {
              dataCategory: #DIMENSION,
              dataExtraction.enabled: true
            }
@Search.searchable: true
@Metadata: {
             allowExtensions: true,
             ignorePropagatedAnnotations: true
           }

define view I_StorageLocation
  as select from t001l
  association [1..1] to I_Plant as _Plant on $projection.Plant = _Plant.Plant
{
      @ObjectModel.foreignKey.association: '_Plant'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key werks                     as Plant,
      @ObjectModel.text.element: 'StorageLocationName'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key lgort                     as StorageLocation,
      @Semantics.text: true
      cast(lgobe as lgort_name) as StorageLocationName,
      vkorg                     as SalesOrganization,
      vtweg                     as DistributionChannel,
      spart                     as Division,
      xblgo                     as IsStorLocAuthznCheckActive,
      configdeprecationcode     as ConfigDeprecationCode,
      _Plant
}     
  
 