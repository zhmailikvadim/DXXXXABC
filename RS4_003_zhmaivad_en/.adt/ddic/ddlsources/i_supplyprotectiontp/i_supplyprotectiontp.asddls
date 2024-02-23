@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK
@ObjectModel: { usageType: { serviceQuality: #C,
                             sizeCategory:   #L,
                             dataClass:      #MIXED } ,
                             sapObjectNodeType.name: 'SupAvailabilityProtectionPlan'}
@EndUserText.label: 'Supply Protection'
define root view entity I_SupplyProtectionTP
  as select from I_SupplyProtection

  composition [0..*] of I_SupProtCharacteristicTP     as _SupProtCharacteristicTP
  composition [0..*] of I_SupplyProtectionGroupTP     as _SupplyProtectionGroupTP
  composition [0..*] of I_SupProtFlexibleTimeBucketTP as _SupProtFlexibleTimeBucketTP

  association [1..*] to I_MaterialText                as _MaterialText                on  $projection.Material = _MaterialText.Material

  association [0..1] to I_Material                    as _Material                    on  $projection.Material = _Material.Material
  association [0..1] to I_UnitOfMeasure               as _BaseUnit                    on  $projection.UnitOfMeasure = _BaseUnit.UnitOfMeasure

  association [0..1] to I_Plant                       as _Plant                       on  $projection.Plant = _Plant.Plant

  association [0..1] to I_SupProtLifecycleStatus      as _SupProtLifecycleStatus      on  $projection.SupProtLifecycleStatus = _SupProtLifecycleStatus.SupProtLifecycleStatus
  association [0..*] to I_SupProtLifecycleStatusText  as _SupProtLifecycleStatusText  on  $projection.SupProtLifecycleStatus = _SupProtLifecycleStatusText.SupProtLifecycleStatus

  association [0..1] to I_SupProtPlanningPeriodType   as _SupProtPlanningPeriodType   on  $projection.SupProtPlanningPeriodType = _SupProtPlanningPeriodType.SupProtPlanningPeriodType
  association [0..*] to I_SupProtPlanningPeriodTypeT  as _SupProtPlanningPeriodTypeT  on  $projection.SupProtPlanningPeriodType = _SupProtPlanningPeriodTypeT.SupProtPlanningPeriodType

  association [0..1] to I_SupProtCnsmpnDateTimeType   as _SupProtCnsmpnDateTimeType   on  $projection.SupProtCnsmpnDateTimeType = _SupProtCnsmpnDateTimeType.SupProtCnsmpnDateTimeType
  association [0..*] to I_SupProtCnsmpnDateTimeTypeT  as _SupProtCnsmpnDateTimeTypeT  on  $projection.SupProtCnsmpnDateTimeType = _SupProtCnsmpnDateTimeTypeT.SupProtCnsmpnDateTimeType

  association [0..1] to I_SupProtSelfRestrictionType  as _SupProtSelfRestrictionType  on  $projection.SupProtSelfRestrictionType = _SupProtSelfRestrictionType.SupProtSelfRestrictionType
  association [0..*] to I_SupProtSelfRestrictionTypeT as _SupProtSelfRestrictionTypeT on  $projection.SupProtSelfRestrictionType = _SupProtSelfRestrictionTypeT.SupProtSelfRestrictionType

  association [0..*] to I_SupProtRelatedSupProtTP     as _SupProtRelatedSupProtTP     on  $projection.Material             =  _SupProtRelatedSupProtTP.Material
                                                                                      and $projection.Plant                =  _SupProtRelatedSupProtTP.Plant
                                                                                      and $projection.SupplyProtectionUUID <> _SupProtRelatedSupProtTP.SupplyProtectionUUID

  association [0..1] to I_ProdAllocCharcText          as _ProdAllocCharcText01        on  _ProdAllocCharcText01.ProdAllocCharcCtlgPathIntID = $projection.CoreCharc01CtlgPathIntID
                                                                                      and _ProdAllocCharcText01.Language                    = $session.system_language
  association [0..1] to I_ProdAllocCharcText          as _ProdAllocCharcText02        on  _ProdAllocCharcText02.ProdAllocCharcCtlgPathIntID = $projection.CoreCharc02CtlgPathIntID
                                                                                      and _ProdAllocCharcText02.Language                    = $session.system_language

  association [0..1] to I_User                        as _CreatedByUser               on  $projection.CreatedByUser = _CreatedByUser.UserID
  association [0..1] to I_User                        as _LastChangedByUser           on  $projection.LastChangedByUser = _LastChangedByUser.UserID

{
  key SupplyProtectionUUID,

      SupplyProtectionName,

      @Consumption.valueHelpDefinition: [{ entity.name:    'I_MaterialStdVH',
                                           entity.element: 'Material' }]
      @Consumption.semanticObject: 'Material'
      Material,
      _Material.MaterialBaseUnit                                                                                                                    as UnitOfMeasure,

      @Consumption.valueHelpDefinition: [{ entity.name:    'I_ProductByPlantVH',
                                           entity.element: 'Plant',
                                           additionalBinding: [{ element:  'Product',
                                                                 localElement: 'Material',
                                                                 usage: #FILTER }] }]
      @Consumption.semanticObject: 'Plant'
      Plant,

      SupProtIsPlanningContextSlsOrd,
      SupProtIsPlanningContextSTO,
      SupProtCharcCatalogType,

      @Consumption.valueHelpDefinition: [{ entity.name: 'I_SupProtPlanningPeriodType',
                                           entity.element: 'SupProtPlanningPeriodType' }]
      SupProtPlanningPeriodType                                                                                                                     as SupProtPlanningPeriodType,
      SupProtPlanningPeriodStartDate,
      SupProtPlanningPeriodEndDate,

      SupProtAutomActivationIsActive,
      SupProtAutomActivationDate,

      SupProtCoreCharc01CtlgPathUUID,
      CoreCharc01CtlgPathIntID,
      cast( '' as charccatalogcharacteristicname )                                                                                                  as SupProtCoreCharc01Name,

      @Consumption.valueHelpDefinition: [{ entity.name:     'I_SupProtCharacteristicVH',
                                           entity.element:  'Characteristic',
                                           additionalBinding: [{ element:       'ProdAllocCharcCtlgPathUUID',
                                                                 localElement:  'SupProtCoreCharc01CtlgPathUUID',
                                                                 usage:         #RESULT},
                                                               { element:       'ProdAllocCharcCtlgPathIntID',
                                                                 localElement:  'CoreCharc01CtlgPathIntID',
                                                                 usage:         #RESULT },
                                                               { element:       'ProdAllocCharcCatalogType',
                                                                 localElement:  'SupProtCharcCatalogType',
                                                                 usage:         #FILTER} ]
                                        }]
      cast( _ProdAllocCharcText01.ProdAllocCharcCtlgPathDesc as sup_charc_text  preserving type )                                                   as SupProtCoreCharc01Text,

      @Consumption.valueHelpDefinition: [{ entity.name:    'C_SupProtCharcValueVH',
                                           entity.element: 'CharcValue',
                                           additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                 localElement: 'SupProtCoreCharc01CtlgPathUUID',
                                                                 usage:        #FILTER },
                                                              { element:      'SupplyProtectionUUID',
                                                                localElement: 'SupplyProtectionUUID',
                                                                usage:        #FILTER } ] }]
      SupProtCoreCharc01ValueID,

      SupProtCoreCharc02CtlgPathUUID,
      CoreCharc02CtlgPathIntID,
      cast( '' as charccatalogcharacteristicname )                                                                                                  as SupProtCoreCharc02Name,

      @Consumption.valueHelpDefinition: [{ entity.name:     'I_SupProtCharacteristicVH',
                                           entity.element:  'Characteristic',
                                           additionalBinding: [{ element:       'ProdAllocCharcCtlgPathUUID',
                                                                 localElement:  'SupProtCoreCharc02CtlgPathUUID',
                                                                 usage:         #RESULT},
                                                               { element:       'ProdAllocCharcCtlgPathIntID',
                                                                 localElement:  'CoreCharc02CtlgPathIntID',
                                                                 usage:         #RESULT },
                                                               { element:       'ProdAllocCharcCatalogType',
                                                                 localElement:  'SupProtCharcCatalogType',
                                                                 usage:         #FILTER} ]
                                        }]
      cast( _ProdAllocCharcText02.ProdAllocCharcCtlgPathDesc as sup_charc_text preserving type )                                                    as SupProtCoreCharc02Text,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCoreCharc02CtlgPathUUID',
                                                                usage:        #FILTER },
                                                              { element:      'SupplyProtectionUUID',
                                                                localElement: 'SupplyProtectionUUID',
                                                                usage:        #FILTER } ] }]
      SupProtCoreCharc02ValueID,

      @Consumption.valueHelpDefinition: [{ entity.name: 'I_SupProtLifecycleStatus',
                                           entity.element: 'SupProtLifecycleStatus' }]
      SupProtLifecycleStatus,
      case SupProtLifecycleStatus
        when '01' then 2
        when '02' then 3
        else 0
      end                                                                                                                                           as Criticality,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtProtectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtConsumedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtRemainingProtectedQty,


      @Semantics.user.createdBy: true
      CreatedByUser,

      @Semantics.systemDateTime.createdAt: true
      CreationDateTime,
      cast(tstmp_to_dats( cast( CreationDateTime as abap.dec(15,0) ), 'UTC', $session.client, 'NULL' ) as sup_creation_date  preserving type )      as CreationDate,

      @Semantics.user.lastChangedBy: true
      LastChangedByUser,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LastChangeDateTime,
      cast(tstmp_to_dats( cast( LastChangeDateTime as abap.dec(15,0) ), 'UTC', $session.client, 'NULL' ) as sup_last_change_date  preserving type ) as LastChangeDate,

      CharcValAuthznGroup,

      SupplyProtectionIsBlocked,

      @Semantics.systemDateTime.lastChangedAt: true
      DraftLastChangedDateTime,

      SupProtActivationDate,

      @Consumption.valueHelpDefinition: [{ entity.name: 'I_SupProtCnsmpnDateTimeType',
                                           entity.element: 'SupProtCnsmpnDateTimeType' }]
      SupProtCnsmpnDateTimeType,

      @Consumption.valueHelpDefinition: [{ entity.name: 'I_SupProtSelfRestrictionType',
                                           entity.element: 'SupProtSelfRestrictionType' }]
      SupProtSelfRestrictionType,

      cast(' ' as sup_plngcontext_consistent preserving type )                                                                                      as SupProtPlngContextIsConsistent,

      @UI.hidden: true
      cast(0 as sup_plngcontext_criticality preserving type )                                                                                       as SupProtPlngContextCriticality,

      /* Compositions */
      _SupProtCharacteristicTP,
      _SupplyProtectionGroupTP,
      _SupProtFlexibleTimeBucketTP,

      /* Associations */
      _Material,
      _BaseUnit,
      _MaterialText,
      _Plant,
      _CreatedByUser,
      _LastChangedByUser,
      _SupProtLifecycleStatus,
      _SupProtLifecycleStatusText,
      _SupProtPlanningPeriodType,
      _SupProtPlanningPeriodTypeT,
      _SupProtCnsmpnDateTimeType,
      _SupProtCnsmpnDateTimeTypeT,
      _SupProtSelfRestrictionType,
      _SupProtSelfRestrictionTypeT,
      _SupProtRelatedSupProtTP
}
