@ClientHandling.algorithm: #SESSION_VARIABLE 
@ObjectModel.representativeKey: 'OverallPickingStatus'
@ObjectModel.usageType.dataClass: #META 
@ObjectModel.usageType.serviceQuality: #A 
@ObjectModel.usageType.sizeCategory: #S 
@EndUserText.label: 'Overall Picking Status'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: false }
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ISDOVRLPICKSTS'
@Metadata.ignorePropagatedAnnotations:true 
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #ANALYTICAL_DIMENSION ]
@ObjectModel.modelingPattern: [ #ANALYTICAL_DIMENSION ]

define view I_OverallPickingStatus
as select from dd07l

association [0..*] to I_OverallPickingStatusText as _Text on $projection.OverallPickingStatus = _Text.OverallPickingStatus
{   
    @ObjectModel.text.association: '_Text'
    key SUBSTRING(dd07l.domvalue_l, 1, 1) as OverallPickingStatus,
    
    _Text
}
where (dd07l.domname = 'STATV') and (dd07l.as4local = 'A');  
