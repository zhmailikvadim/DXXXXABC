@AbapCatalog.sqlViewName: 'IPPDOCUMENTPRTIK'
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'ProductionResourceInternalID'
@ObjectModel.semanticKey: ['DocumentType', 'DocumentInfoRecord', 'DocumentVersion', 'DocumentPart']
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Document PRT by internal key'
//@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }

define view I_DocumentPRTByInternalKey
  as select from I_ProdnRsceToolMasterData as PRT
    inner join   crvd_a on  crvd_a.objty = PRT.ProductionResourceType
                        and crvd_a.objid = PRT.ProductionResourceInternalID
    inner join   draw   on  draw.dokar = crvd_a.dokar
                        and draw.doknr = crvd_a.doknr
                        and draw.dokvr = crvd_a.dokvr
                        and draw.doktl = crvd_a.doktl

  association [1..1] to I_DocInfoRecdDocumentType    as _DocumentType          on  $projection.DocumentType = _DocumentType.DocumentType
  association [1..1] to I_DocInfoRecdNumber          as _DocumentNumber        on  $projection.DocumentType       = _DocumentNumber.DocumentType
                                                                               and $projection.DocumentInfoRecord = _DocumentNumber.DocumentInfoRecord
  association [1..1] to I_DocInfoRecdDocumentVersion as _DocumentVersion       on  $projection.DocumentType       = _DocumentVersion.DocumentType
                                                                               and $projection.DocumentInfoRecord = _DocumentVersion.DocumentInfoRecord
                                                                               and $projection.DocumentVersion    = _DocumentVersion.DocumentVersion
  association [1..1] to I_DocInfoRecd                as _DocumentInfoRecord    on  $projection.DocumentType       = _DocumentInfoRecord.DocumentType
                                                                               and $projection.DocumentInfoRecord = _DocumentInfoRecord.DocumentInfoRecord
                                                                               and $projection.DocumentVersion    = _DocumentInfoRecord.DocumentVersion
                                                                               and $projection.DocumentPart       = _DocumentInfoRecord.DocumentPart

  association [1..1] to I_DocumentProdnRsceTool      as _DocumentProdnRsceTool on  $projection.DocumentType       = _DocumentProdnRsceTool.DocumentType
                                                                               and $projection.DocumentInfoRecord = _DocumentProdnRsceTool.DocumentInfoRecord
                                                                               and $projection.DocumentVersion    = _DocumentProdnRsceTool.DocumentVersion
                                                                               and $projection.DocumentPart       = _DocumentProdnRsceTool.DocumentPart

{
      @ObjectModel.foreignKey.association: '_ProductionResourceType'
  key PRT.ProductionResourceType,
  key PRT.ProductionResourceInternalID,
      @ObjectModel.foreignKey.association: '_DocumentType'
      crvd_a.dokar as DocumentType,
      @ObjectModel.foreignKey.association: '_DocumentNumber'
      crvd_a.doknr as DocumentInfoRecord,
      @ObjectModel.foreignKey.association: '_DocumentVersion'
      crvd_a.dokvr as DocumentVersion,
      @ObjectModel.foreignKey.association: '_DocumentInfoRecord'
      crvd_a.doktl as DocumentPart,

      draw.begru   as AuthorizationGroup,
      draw.dokst   as InternalDocumentStatus,

      // **** The following fields cannot be maintained in CV01N ****
      // **** Therefore they are always empty                    ****
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
      // **** End of fields that cannot be maintained in CV01N ****

      // Admin
      @Semantics.businessDate.createdAt: true
      CreationDate,
      @Semantics.user.createdBy: true
      PRT.CreatedByUser,
      @Semantics.businessDate.lastChangedAt: true
      LastChangeDate,
      @Semantics.user.lastChangedBy: true
      PRT.LastChangedByUser,

      _ProductionResourceType,

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

      _DocumentProdnRsceTool,

      _CreatedByUser,
      _LastChangedByUser

}

where
  PRT.ProdnRsceToolCategory = 'D' // Document                         
  
  
  
  
  
  
  
  
  
  
  
 