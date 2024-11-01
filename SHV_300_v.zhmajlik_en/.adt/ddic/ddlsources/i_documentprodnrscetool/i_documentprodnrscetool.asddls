@AbapCatalog.sqlViewName: 'IPPDOCUMENTPRT'
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'DocumentPart'
@ObjectModel.semanticKey: ['DocumentType', 'DocumentInfoRecord', 'DocumentVersion', 'DocumentPart']
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Document Production Resource Tool'
//@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }

define view I_DocumentProdnRsceTool
  as select from I_DocumentPRTByInternalKey as PRT

{
      @ObjectModel.foreignKey.association: '_DocumentType'
  key PRT.DocumentType                                                                                                                                                                                                                            as     DocumentType,
      @ObjectModel.foreignKey.association: '_DocumentNumber'
//      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key PRT.DocumentInfoRecord                                                                                                                                                                                                                      as     DocumentInfoRecord,
      @ObjectModel.foreignKey.association: '_DocumentVersion'
  key PRT.DocumentVersion                                                                                                                                                                                                                         as     DocumentVersion,
      @ObjectModel.foreignKey.association: '_DocumentInfoRecord'
  key PRT.DocumentPart                                                                                                                                                                                                                            as     DocumentPart,

      AuthorizationGroup,
      InternalDocumentStatus,

      // **** The following fields cannot be maintained in CV01N ****
      // **** Therefore they are always empty                    ****
//      @ObjectModel.foreignKey.association: '_ProductionResourceType'
//      PRT.ProductionResourceType,
//      PRT.ProductionResourceInternalID,
//      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
//      PRT.ProductionResourceToolGroup1,
//      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
//      PRT.ProductionResourceToolGroup2,
//      PRT.ProductionResourceUsage,
//      ProdnRsceToolControlProfile,
//      EngineeringChangeOrder,
//      ProdnRsceToolStandardTextCode,
//      ProdnRsceToolTotQtyCalcFormula,
//      ProdnRsceToolUsageQtyCalcFmla,
//      StartDateOffsetReferenceCode,
//      EndDateOffsetReferenceCode,
//
//      @Semantics.quantity.unitOfMeasure: 'StartDateOffsetDurationUnit'
//      @DefaultAggregation: #SUM
//      StartDateOffsetDuration,
//      @Semantics.unitOfMeasure: true
//      StartDateOffsetDurationUnit,
//      @Semantics.quantity.unitOfMeasure: 'EndDateOffsetDurationUnit'
//      @DefaultAggregation: #SUM
//      EndDateOffsetDuration,
//      @Semantics.unitOfMeasure: true
//      EndDateOffsetDurationUnit,
//      // **** End of fields that cannot be maintained in CV01N ****

      // Admin
      @Semantics.businessDate.createdAt: true
      CreationDate,
      @Semantics.user.createdBy: true
      CreatedByUser,
      @Semantics.businessDate.lastChangedAt: true
      LastChangeDate,
      @Semantics.user.lastChangedBy: true
      LastChangedByUser,

//      _ProductionResourceType,
//      _ProdnRsceToolGroup1,
//      _ProdnRsceToolGroup2,
//      _ProductionResourceUsage,
//      _ProdnRsceToolControlProfile,
//      _ProdnRsceToolStandardText,
//      _ProdnRsceToolTotQtyCalcFmla,
//      _ProdnRsceToolUsageQtyCalcFmla,
//      _StartDateOffsetReferenceCode,
//      _EndDateOffsetReferenceCode,
//      _StartDateOffsetDurationUnit,
//      _EndDateOffsetDurationUnit,

      _DocumentType,
      _DocumentNumber,
      _DocumentVersion,
      _DocumentInfoRecord,

      _CreatedByUser,
      _LastChangedByUser

}                         
  
  
  
  
  
  
 