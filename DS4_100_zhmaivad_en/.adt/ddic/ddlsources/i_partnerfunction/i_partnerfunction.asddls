@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'PartnerFunction'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@EndUserText.label: 'Partner Function'
@Analytics.dataCategory: #DIMENSION
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ISDPARTFUNC'
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.modelingPattern:           #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities:  [  #SQL_DATA_SOURCE,
                                        #CDS_MODELING_DATA_SOURCE,
                                        #CDS_MODELING_ASSOCIATION_TARGET,
                                        #ANALYTICAL_DIMENSION  ]
@ObjectModel.sapObjectNodeType.name:'PartnerFunction'                                        
define view I_PartnerFunction
as select from tpar

association [0..*] to I_PartnerFunctionText as _Text on $projection.PartnerFunction = _Text.PartnerFunction
association [0..*] to I_PartnerFunctionLangDepdnt as _PartnerFunctionLangDepdnt on $projection.PartnerFunction = _PartnerFunctionLangDepdnt.PartnerFunction
{
    @ObjectModel.text.association: '_Text'
    key cast(parvw as parvw_unv) as PartnerFunction,
    nrart as SDDocumentPartnerType,
    
    //Association
    _Text,
    _PartnerFunctionLangDepdnt
};
      
