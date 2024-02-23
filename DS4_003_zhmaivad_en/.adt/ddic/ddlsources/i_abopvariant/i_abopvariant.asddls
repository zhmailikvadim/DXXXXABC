@EndUserText.label: 'ABOP Variant'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IABOPVARIANT'
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED //#CHECK
@Search.searchable: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@ObjectModel: {

    compositionRoot: true,

    semanticKey: 'ABOPVariantName',
    representativeKey: 'ABOPVariantUUID',

    modelCategory: #BUSINESS_OBJECT,

    usageType: {
      serviceQuality: #A,
      sizeCategory: #M,
      dataClass: #MASTER
    }
}
define view I_ABOPVariant
  as select from atp_bop_variant

  association [0..*] to I_ABOPVariantSegment        as _VariantSegment        on $projection.ABOPVariantUUID = _VariantSegment.ABOPVariantUUID
  association [0..*] to I_ABOPVariantSimulation     as _Simulation            on $projection.ABOPVariantUUID = _Simulation.ABOPVariantUUID
  association [0..*] to I_ABOPVariantText           as _Text                  on $projection.ABOPVariantUUID = _Text.ABOPVariantUUID

  association [0..1] to I_User                      as _CreatedByUser         on $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_User                      as _LastChangedByUser     on $projection.LastChangedByUser = _LastChangedByUser.UserID

  association [0..1] to I_ABOPVariant               as _Fallback              on $projection.ABOPFallbackVariantUUID = _Fallback.ABOPVariantUUID

  association [0..*] to I_ABOPExceptionBehaviorText as _ExceptionBehaviorText on $projection.ABOPExceptionBehavior = _ExceptionBehaviorText.ABOPExceptionBehavior

  association [0..*] to I_ABOPFallbackBehaviorText  as _FallbackBehaviorText  on $projection.ABOPFallbackRqmtRstrcnBehvr = _FallbackBehaviorText.ABOPFallbackRqmtRstrcnBehvr

  association [0..1] to I_ARunRule                  as _ARunRule              on $projection.ARunRuleUUID = _ARunRule.ARunRuleUUID
{

      // key
      @ObjectModel.text.association: '_Text'
      @ObjectModel.readOnly: true
  key abopvariantuuid                as ABOPVariantUUID,

      // data
      @Search.defaultSearchElement: true
      @ObjectModel.mandatory: true
      abopvariantname                as ABOPVariantName,

      abopvarianthrfprocedure        as ABOPVariantHRFProcedure,

      abopvariantprocedure           as ABOPVariantProcedure,

      abopvariantseloptntoolproced   as ABOPVariantSelOptnToolProced,

      // administrative data
      @Semantics.systemDateTime.createdAt: true
      @ObjectModel.readOnly: true
      creationdatetime               as CreationDateTime,
      @Semantics.user.createdBy: true
      @ObjectModel.readOnly: true
      createdbyuser                  as CreatedByUser,
      @Semantics.systemDateTime.lastChangedAt: true
      @ObjectModel.readOnly: true
      lastchangedatetime             as LastChangeDateTime,
      @Semantics.user.lastChangedBy: true
      @ObjectModel.readOnly: true
      lastchangedbyuser              as LastChangedByUser,

      @ObjectModel.foreignKey.association: '_Fallback'
      abopfallbackvariantuuid        as ABOPFallbackVariantUUID,

      abopdeliverygrouphandling      as ABOPDeliveryGroupHandling,

      salesdocumentsareincluded      as SalesDocumentsAreIncluded,

      stocktransportordsareincluded  as StockTransportOrdsAreIncluded,

      nondeliveryrlvtdocsareincluded as NonDeliveryRlvtDocsAreIncluded,

      abopcheckingrule               as ABOPCheckingRule,

      abopexecutionmethod            as ABOPExecutionMethod,


      @ObjectModel.foreignKey.association: '_ARunRule'
      arunruleuuid                   as ARunRuleUUID,

      abopstocksortrule              as ABOPStockSortRule,

      abopallocreleaseisrequired     as ABOPAllocReleaseIsRequired,

      abopsupplyselhorizonindays     as ABOPSupplySelHorizonInDays,

      abopassignmentpreviewisactive  as ABOPAssignmentPreviewIsActive,

      abopsupplyreassignmentisreqd   as ABOPSupplyReassignmentIsReqd,


      @ObjectModel.text.association: '_ExceptionBehaviorText'
      abopexceptionbehavior          as ABOPExceptionBehavior,

      @ObjectModel.text.association: '_FallbackBehaviorText'
      abopfallbackrqmtrstrcnbehvr    as ABOPFallbackRqmtRstrcnBehvr,

      @ObjectModel.readOnly: true
      lastusageutcdatetime           as LastUsageUTCDateTime,

      // associations
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _VariantSegment,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Simulation,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Text,

      _ARunRule,

      _ExceptionBehaviorText,
      _FallbackBehaviorText,
      _CreatedByUser,
      _LastChangedByUser,
      _Fallback

}
