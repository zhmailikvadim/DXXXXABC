@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'SalesDocumentRjcnReason'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [ #LANGUAGE_DEPENDENT_TEXT, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, 
                                      #CDS_MODELING_DATA_SOURCE, #EXTRACTION_DATA_SOURCE]
@ObjectModel.modelingPattern: [ #LANGUAGE_DEPENDENT_TEXT ]
@EndUserText.label: 'Rejection Reason of Sales Document - Text'
@VDM.viewType: #BASIC
@Analytics.dataExtraction.enabled: true
@AccessControl.authorizationCheck:#NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ISDSLSDOCRJNRSNT'
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@Metadata.ignorePropagatedAnnotations:true
@Search.searchable: true

define view I_SalesDocumentRjcnReasonText
as select from tvagt

association[0..1] to I_SalesDocumentRjcnReason as _SalesDocumentRjcnReason on $projection.SalesDocumentRjcnReason = _SalesDocumentRjcnReason.SalesDocumentRjcnReason
association[0..1] to I_Language as _Language on $projection.Language = _Language.Language
{  
    @ObjectModel.foreignKey.association: '_SalesDocumentRjcnReason'
    key abgru as SalesDocumentRjcnReason,
    
    @Semantics.language: true
    @ObjectModel.foreignKey.association: '_Language'
    key spras as Language,
    
    @Semantics.text: true
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    bezei as SalesDocumentRjcnReasonName,
    
    _SalesDocumentRjcnReason,
    _Language
    
};     
 