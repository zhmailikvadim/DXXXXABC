@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK

@ObjectModel:   { usageType: { serviceQuality: #C,
                               sizeCategory:   #L,
                               dataClass:      #MIXED }
}
@ObjectModel.compositionRoot: true

@EndUserText.label: 'Supply Protection'
define root view entity I_SupplyProtection
  as select from sup_object
{
  key uuid                        as SupplyProtectionUUID,
      material                    as Material,
      plant                       as Plant,
      name                        as SupplyProtectionName,
      status                      as SupProtLifecycleStatus,
      planningperiodtype          as SupProtPlanningPeriodType,
      planningperiodstart         as SupProtPlanningPeriodStartDate,
      planningperiodend           as SupProtPlanningPeriodEndDate,
      corecharc01catalogpathuuid  as SupProtCoreCharc01CtlgPathUUID,
      corecharc01catalogpathid    as CoreCharc01CtlgPathIntID,
      corecharc01value            as SupProtCoreCharc01ValueID,
      corecharc02catalogpathuuid  as SupProtCoreCharc02CtlgPathUUID,
      corecharc02catalogpathid    as CoreCharc02CtlgPathIntID,
      corecharc02value            as SupProtCoreCharc02ValueID,
      planningcontextso           as SupProtIsPlanningContextSlsOrd,
      planningcontextsto          as SupProtIsPlanningContextSTO,
      catalogtype                 as SupProtCharcCatalogType,
      creationdatetime            as CreationDateTime,
      createdbyuser               as CreatedByUser,
      lastchangedatetime          as LastChangeDateTime,
      lastchangedbyuser           as LastChangedByUser,
      charcvalauthzngroup         as CharcValAuthznGroup,
      last_changed_at             as DraftLastChangedDateTime,
      blocked                     as SupplyProtectionIsBlocked,
      autoactivation              as SupProtAutomActivationIsActive,
      autoactivationdate          as SupProtAutomActivationDate,
      activationdate              as SupProtActivationDate,
      case consumptiondatetype
        when '' then '01'
        else consumptiondatetype
      end                         as SupProtCnsmpnDateTimeType,
      case selfrestriction
        when '' then '01'
        else selfrestriction
      end                         as SupProtSelfRestrictionType,

      cast('' as abap.unit(3) )   as UnitOfMeasure,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      cast(0 as abap.quan(15,3) ) as SupProtProtectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      cast(0 as abap.quan(15,3) ) as SupProtConsumedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      cast(0 as abap.quan(15,3) ) as SupProtRemainingProtectedQty
}
