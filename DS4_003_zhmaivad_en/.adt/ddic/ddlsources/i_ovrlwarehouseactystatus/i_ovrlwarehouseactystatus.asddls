@ClientHandling.algorithm: #SESSION_VARIABLE 
@ObjectModel.representativeKey: 'OverallWarehouseActivityStatus'
@ObjectModel.usageType.dataClass: #META 
@ObjectModel.usageType.serviceQuality: #A 
@ObjectModel.usageType.sizeCategory: #S 
@EndUserText.label: 'Overall Warehouse Activity Status'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: false }
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ISDOLWHACTSTS'
@Metadata.ignorePropagatedAnnotations:true 
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #ANALYTICAL_DIMENSION ]
@ObjectModel.modelingPattern: [ #ANALYTICAL_DIMENSION ]

define view I_OvrlWarehouseActyStatus
as select from dd07l

association [0..*] to I_OvrlWarehouseActyStatusT as _Text on $projection.OverallWarehouseActivityStatus = _Text.OverallWarehouseActivityStatus

{
    @ObjectModel.text.association: '_Text'
    key cast(SUBSTRING(dd07l.domvalue_l, 1, 1) as lvsta ) as OverallWarehouseActivityStatus,
    _Text  
}
where (dd07l.domname = 'STATV') and (dd07l.as4local = 'A');  
