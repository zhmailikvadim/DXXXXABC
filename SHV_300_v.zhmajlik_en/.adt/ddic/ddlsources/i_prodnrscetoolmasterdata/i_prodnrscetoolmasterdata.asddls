@AbapCatalog.sqlViewName: 'IPPPRTMD'
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'ProductionResourceInternalID'
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Resource Tool Master Data'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }

define view I_ProdnRsceToolMasterData 
  as select from crfh

  association [1..1] to I_ProductionResourceType      as _ProductionResourceType        on $projection.ProductionResourceType = _ProductionResourceType.ProductionResourceType
  association [1..1] to I_ProdnRsceToolCategory       as _ProdnRsceToolCategory         on $projection.ProdnRsceToolCategory = _ProdnRsceToolCategory.ProdnRsceToolCategory

  association [1..1] to I_ProdnRsceToolGroup          as _ProdnRsceToolGroup1           on $projection.ProductionResourceToolGroup1 = _ProdnRsceToolGroup1.ProductionResourceToolGroup
  association [1..1] to I_ProdnRsceToolGroup          as _ProdnRsceToolGroup2           on $projection.ProductionResourceToolGroup2 = _ProdnRsceToolGroup2.ProductionResourceToolGroup

  association [1..1] to I_ProductionResourceUsage     as _ProductionResourceUsage       on $projection.ProductionResourceUsage = _ProductionResourceUsage.ProductionResourceUsage

  association [0..1] to I_ProdnRsceToolControlProfile as _ProdnRsceToolControlProfile   on $projection.ProdnRsceToolControlProfile = _ProdnRsceToolControlProfile.ProdnRsceToolControlProfile

  association [1..1] to I_ProdnRsceToolStandardText   as _ProdnRsceToolStandardText     on $projection.ProdnRsceToolStandardTextCode = _ProdnRsceToolStandardText.ProdnRsceToolStandardTextCode

  association [1..1] to I_ProdnRsceToolQtyCalcFormula as _ProdnRsceToolTotQtyCalcFmla   on $projection.ProdnRsceToolTotQtyCalcFormula = _ProdnRsceToolTotQtyCalcFmla.ProdnRsceToolQtyCalcFormula
  association [1..1] to I_ProdnRsceToolQtyCalcFormula as _ProdnRsceToolUsageQtyCalcFmla on $projection.ProdnRsceToolUsageQtyCalcFmla = _ProdnRsceToolUsageQtyCalcFmla.ProdnRsceToolQtyCalcFormula

  association [1..1] to I_OperationDateOffsetRefCode  as _StartDateOffsetReferenceCode  on $projection.StartDateOffsetReferenceCode = _StartDateOffsetReferenceCode.OperationDateOffsetRefCode
  association [1..1] to I_OperationDateOffsetRefCode  as _EndDateOffsetReferenceCode    on $projection.EndDateOffsetReferenceCode = _EndDateOffsetReferenceCode.OperationDateOffsetRefCode

  association [0..1] to I_UnitOfMeasure               as _StartDateOffsetDurationUnit   on $projection.StartDateOffsetDurationUnit = _StartDateOffsetDurationUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure               as _EndDateOffsetDurationUnit     on $projection.EndDateOffsetDurationUnit = _EndDateOffsetDurationUnit.UnitOfMeasure

  association [1..1] to I_User                        as _CreatedByUser                 on $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_User                        as _LastChangedByUser             on $projection.LastChangedByUser = _LastChangedByUser.UserID

{
      @ObjectModel.foreignKey.association: '_ProductionResourceType'
  key cast(crfh.objty as productionresourcetype preserving type)         as   ProductionResourceType,
  key crfh.objid                                                         as   ProductionResourceInternalID,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolCategory'
      fhmar                                                              as   ProdnRsceToolCategory,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolGroup1'
      fgru1                                                              as   ProductionResourceToolGroup1,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolGroup2'
      fgru2                                                              as   ProductionResourceToolGroup2,
      @ObjectModel.foreignKey.association: '_ProductionResourceUsage'
      planv                                                              as   ProductionResourceUsage,
      // Technical field, so foreign key relation probably not needed
      // Used for Miscellaneous Production Resource Tool only !
      brgru                                                              as   MiscPRTAuthorizationGroup,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolControlProfile'
      steuf                                                              as   ProdnRsceToolControlProfile,
      cast(aennr as engineeringchangeorder preserving type)              as   EngineeringChangeOrder,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolStandardText'
      ktsch                                                              as   ProdnRsceToolStandardTextCode,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolTotQtyCalcFmla'
      mgform                                                             as   ProdnRsceToolTotQtyCalcFormula,
      @ObjectModel.foreignKey.association: '_ProdnRsceToolUsageQtyCalcFmla'
      ewform                                                             as   ProdnRsceToolUsageQtyCalcFmla,
      @ObjectModel.foreignKey.association: '_StartDateOffsetReferenceCode'
      cast(bzoffb as startdateoffsetreferencecode preserving type)       as   StartDateOffsetReferenceCode,
      @ObjectModel.foreignKey.association: '_EndDateOffsetReferenceCode'
      cast(bzoffe as enddateoffsetreferencecode preserving type)         as   EndDateOffsetReferenceCode,

      @Semantics.quantity.unitOfMeasure: 'StartDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      cast(offstb as startdateoffsetduration preserving type)            as   StartDateOffsetDuration,
      @Semantics.unitOfMeasure: true
      ehoffb                                                             as   StartDateOffsetDurationUnit,
      @Semantics.quantity.unitOfMeasure: 'EndDateOffsetDurationUnit'
      @DefaultAggregation: #SUM
      cast(offste as enddateoffsetduration preserving type)              as   EndDateOffsetDuration,
      @Semantics.unitOfMeasure: true
      ehoffe                                                             as   EndDateOffsetDurationUnit,

      // Admin
      @Semantics.businessDate.createdAt: true
      andat                                                              as   CreationDate,
      //      @ObjectModel.foreignKey.association: '_CreatedByUser'
      @Semantics.user.createdBy: true
      annam                                                              as   CreatedByUser,
      @Semantics.businessDate.lastChangedAt: true
      aedat                                                              as   LastChangeDate,
      //      @ObjectModel.foreignKey.association: '_LastChangedByUser'
      @Semantics.user.lastChangedBy: true
      aenam                                                              as   LastChangedByUser,

      _ProductionResourceType,
      _ProdnRsceToolCategory,
      _ProdnRsceToolGroup1,
      _ProdnRsceToolGroup2,
      _ProductionResourceUsage,
      _ProdnRsceToolControlProfile,
      _ProdnRsceToolStandardText,
      _ProdnRsceToolTotQtyCalcFmla,
      _ProdnRsceToolUsageQtyCalcFmla,
      _StartDateOffsetReferenceCode,
      _EndDateOffsetReferenceCode,
      _StartDateOffsetDurationUnit,
      _EndDateOffsetDurationUnit,
      _CreatedByUser,
      _LastChangedByUser
}
where
      crfh.objty = 'FH' // Production Resource Tool
  and crfh.loekz = ' '  // not deleted                              
  
  
  
  
  
 