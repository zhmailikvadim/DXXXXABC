@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'SalesDocumentRjcnReason'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@ObjectModel.modelingPattern: [ #ANALYTICAL_DIMENSION ]
@EndUserText.label: 'Sales Document Rejection Reason'
@Analytics: { dataCategory: #DIMENSION}
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ISDSLSDOCRJNRSN'
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@Metadata.ignorePropagatedAnnotations:true
@Search.searchable: true

define view I_SalesDocumentRjcnReason
as select from tvag

association [0..*] to I_SalesDocumentRjcnReasonText as _Text on $projection.SalesDocumentRjcnReason = _Text.SalesDocumentRjcnReason
{
    @ObjectModel.text.association: '_Text'
    @Search.defaultSearchElement: true
    key abgru as SalesDocumentRjcnReason,

    _Text
};      
