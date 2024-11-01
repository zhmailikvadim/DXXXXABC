@EndUserText.label: 'Project Definition Details By Internal ID'
@VDM.viewType: #BASIC
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@AbapCatalog.sqlViewName: 'IPROJBYINTKEY'
@ObjectModel.representativeKey: 'ProjectInternalID'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #MIXED

define view I_ProjectByInternalKey
  as select from    I_Project
    left outer join cnldst_shorttx on  I_Project.ProjectObject = cnldst_shorttx.objnr
                                   and cnldst_shorttx.language = $session.system_language
  association [1..1] to I_ControllingArea        as _ControllingArea        on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association [1..1] to I_CompanyCode            as _CompanyCode            on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [1..*] to I_CostCenter             as _CostCenter             on  $projection.CostCenter      = _CostCenter.CostCenter
                                                                            and $projection.ControllingArea = _CostCenter.ControllingArea
  association [1..1] to I_BusinessArea           as _BusinessArea           on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [1..1] to I_Plant                  as _Plant                  on  $projection.Plant = _Plant.Plant
  association [1..1] to I_Projectprofilecode     as _ProjectProfileCode     on  $projection.ProjectProfileCode = _ProjectProfileCode.ProjectProfileCode
  association [1..1] to I_ControllingObjectClass as _ControllingObjectClass on  $projection.ControllingObjectClass = _ControllingObjectClass.ControllingObjectClass
  association [1..*] to I_StatusObjectStatus     as _Status                 on  $projection.ProjectObject = _Status.StatusObject

{

  key ProjectInternalID,
      @ObjectModel.text.element: 'ProjectDescription'
      Project,
      ProjectWithCodingMask,
      @Semantics.text: true
      ProjectDescription,
      ProjectObject,
      CreatedByUser,
      CreationDate,
      LastChangedByUser,
      LastChangeDate,
      @ObjectModel.text.element: 'ResponsiblePersonName'
      ResponsiblePerson,
      @Semantics.text: true
      ResponsiblePersonName,
      @ObjectModel.text.element: 'ApplicantCode'
      ApplicantCode,
      @Semantics.text: true
      ApplicantName,
      @ObjectModel.foreignKey.association: '_CompanyCode'
      CompanyCode,
      @ObjectModel.foreignKey.association: '_BusinessArea'
      BusinessArea,
      @ObjectModel.foreignKey.association: '_ControllingArea'
      ControllingArea,
      ProfitCenter,

      Currency,
      NetworkAssignmentType,
      WBSElmntDatesIsDetailed,
      @Semantics.calendar.dayOfMonth: true
      PlannedStartDate,
      @Semantics.calendar.dayOfMonth: true
      PlannedEndDate,
      @ObjectModel.foreignKey.association: '_Plant'
      Plant,
      FactoryCalendar,
      NetworkHdrIsVisibleToUser,
      NetworkProfile,
      ProjectProfileCode,
      BudgetProfile,
      @Semantics.language
      I_Project.Language               as Language,
      @ObjectModel.foreignKey.association: '_CostCenter'
      CostCenter,
      CostObject,
      @Semantics.calendar.dayOfMonth: true
      BasicDatesLastScheduledDate,
      @Semantics.calendar.dayOfMonth: true
      FcstdDatesLastScheduledDate,
      ProjectHasOwnStock,
      ControllingObjectClass,
      WBSIsStatisticalWBSElement,
      TaxJurisdiction,
      ProjInterestCalcProfile,
      InvestmentProfile,
      PaymentPlanProfile,
      ResultAnalysisInternalID,
      PlanningProfile,
      WBSIsMarkedForIntegratedPlng,
      IsMarkedForDeletion,
      InventorySpecialStockValnType,
      WBSIsMarkedForAutomReqmtGrpg,
      WorkCenterLocation,
      FunctionalArea,
      SalesOrganization,
      DistributionChannel,
      Division,
      DynItemProcessorPrfl,
      JointVenture,
      JointVentureCostRecoveryCode,
      JointVentureEquityType,
      JointVentureObjectType,
      JointVentureClass,
      JointVentureSubClass,
      @Semantics.calendar.dayOfMonth: true
      ForecastedStartDate,
      @Semantics.calendar.dayOfMonth: true
      ForecastedEndDate,
      cnldst_shorttx.shorttext         as ProjectLangBsdDescription,
      _ControllingArea,
      _CompanyCode,
      _BusinessArea,
      _CostCenter,
      _Plant,
      _ProjectProfileCode,
      _ControllingObjectClass,
      _Status

}         
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 