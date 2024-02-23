@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'DistributionChannel'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@EndUserText.label: 'Distribution Channel'
@Analytics.dataCategory: #DIMENSION
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:  #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ISDDISTRCHANNEL'
@Search.searchable: true
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataExtraction.enabled: true

@ObjectModel.modelingPattern:           #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities:  [  #SQL_DATA_SOURCE,
                                        #CDS_MODELING_DATA_SOURCE,
                                        #CDS_MODELING_ASSOCIATION_TARGET,
                                        #ANALYTICAL_DIMENSION,
                                        #SEARCHABLE_ENTITY,
                                        #EXTRACTION_DATA_SOURCE  ]

@ObjectModel.alternativeKey: [{ id: 'OID', uniqueness: #UNIQUE, element: ['DistributionChannelOID'] }]
@ObjectModel.sapObjectNodeType.name:'DistributionChannel'
// @ObjectModel.oid: 'DistributionChannelOID'

define view I_DistributionChannel
  as select from tvtw
  left outer to one join mdi_oid_config
    on mdi_oid_config.object_type_code = '5640'
  association [0..*] to I_DistributionChannelText as _Text on $projection.DistributionChannel = _Text.DistributionChannel
{
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @ObjectModel.text.association: '_Text'
  key vtweg as DistributionChannel,
  
  @ObjectModel.filter.enabled: false
  @ObjectModel.sort.enabled: false
  case
    when mdi_oid_config.context is initial
      then cast( vtweg as distributionchannel_oid )
    when mdi_oid_config.context is not initial
      then cast( concat( concat( mdi_oid_config.context, ':' ), vtweg ) as distributionchannel_oid )
  end as DistributionChannelOID,
  
  _Text
};          
