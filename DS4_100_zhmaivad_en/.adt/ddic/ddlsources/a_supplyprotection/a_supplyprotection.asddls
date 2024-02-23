@VDM: {
  viewType: #CONSUMPTION,
  lifecycle.contract.type: #PUBLIC_REMOTE_API,
  usage.type: [#TRANSACTIONAL_PROCESSING_SERVICE]
}
@ObjectModel: {
   representativeKey: 'SupplyProtectionUUID',
   usageType: {
     serviceQuality: #C,
     sizeCategory:   #L,
     dataClass:      #MIXED
   }
}
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Supply Availability Protection Plan'
define root view entity A_SupplyProtection
  provider contract transactional_query
  as projection on I_SupplyProtectionTP

{
  key SupplyProtectionUUID,
      SupplyProtectionName,
      Material,
      _MaterialText.MaterialName                                : localized,
      Plant,
      _Plant.PlantName,
      SupProtLifecycleStatus,
      _SupProtLifecycleStatusText.SupProtLifecycleStatusText    : localized,
      SupProtPlanningPeriodType,
      _SupProtPlanningPeriodTypeT.SupProtPlanningPeriodTypeText : localized,
      SupProtPlanningPeriodStartDate,
      SupProtPlanningPeriodEndDate,
      SupProtIsPlanningContextSlsOrd,
      SupProtIsPlanningContextSTO,

//      @ObjectModel.virtualElement: true
//      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_ATP_SUP_SADL_EXIT_CHARNAME'
      SupProtCoreCharc01Name,
      CoreCharc01CtlgPathIntID,
      SupProtCoreCharc01Text,
      SupProtCoreCharc01ValueID,

//      @ObjectModel.virtualElement: true
//      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_ATP_SUP_SADL_EXIT_CHARNAME'
      SupProtCoreCharc02Name,
      CoreCharc02CtlgPathIntID,
      SupProtCoreCharc02Text,
      SupProtCoreCharc02ValueID,

      @Semantics.unitOfMeasure: true
      UnitOfMeasure,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_ATP_SUP_SADL_EXIT_QUANTITY'
      cast(SupProtProtectedQuantity as sup_protected_quantity preserving type)      as SupProtProtectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_ATP_SUP_SADL_EXIT_QUANTITY'
      cast(SupProtConsumedQuantity as sup_consumed_quantity preserving type)        as SupProtConsumedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_ATP_SUP_SADL_EXIT_QUANTITY'
      cast(SupProtRemainingProtectedQty as sup_remaining_quantity preserving type ) as SupProtRemainingProtectedQty,

      CreatedByUser,
      CreationDateTime,
      LastChangedByUser,
      LastChangeDateTime,
      CharcValAuthznGroup, // required for authorization check

      @Feature: 'ATP_SUP_SCHEDULED_ACTIVATION'
      SupProtAutomActivationIsActive,
      @Feature: 'ATP_SUP_SCHEDULED_ACTIVATION'
      SupProtAutomActivationDate,

      SupProtActivationDate,

      SupProtCnsmpnDateTimeType,
      _SupProtCnsmpnDateTimeTypeT.SupProtCnsmpnDateTimeTypeText : localized,
      
      SupProtSelfRestrictionType,      
      _SupProtSelfRestrictionTypeT.SupProtSelfRestrictionTypeText : localized,
       
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_ATP_SUP_SADL_EXIT_PLNG_CONS'
      SupProtPlngContextIsConsistent,

      /* Associations */
      _SupplyProtectionGroupTP     : redirected to composition child A_SupplyProtectionGroup,
      _SupProtCharacteristicTP     : redirected to composition child A_SupProtCharacteristic,
      _SupProtFlexibleTimeBucketTP : redirected to composition child A_SupProtFlexibleTimeBucket
}
where
  SupplyProtectionIsBlocked = ''
