@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK
@ObjectModel:   { usageType: { serviceQuality: #C,
                               sizeCategory:   #XL,
                               dataClass:      #MIXED }
}

@EndUserText.label: 'Supply Protection Group'
define view entity I_SupplyProtectionGroupTP
  as select from I_SupplyProtectionGroup

  association        to parent I_SupplyProtectionTP    as _SupplyProtectionTP        on $projection.SupplyProtectionUUID = _SupplyProtectionTP.SupplyProtectionUUID
  association [0..*] to I_SupProtTimeBucketCnsmpnTP    as _SupProtTimeBucketCnsmpnTP on $projection.SupplyProtectionGroupUUID = _SupProtTimeBucketCnsmpnTP.SupplyProtectionGroupUUID
  association [0..*] to I_SupProtTimeBucketChart       as _SupProtTimeBucketChart    on $projection.SupplyProtectionGroupUUID = _SupProtTimeBucketChart.SupplyProtectionGroupUUID
  composition [0..*] of I_SupplyProtectionTimeBucketTP as _SupplyProtectionTimeBucketTP

{
  key SupplyProtectionGroupUUID,

      SupplyProtectionUUID,

      SupProtCharc01CtlgPathUUID,
      SupProtCharc01CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc01CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc01ValueID,

      SupProtCharc02CtlgPathUUID,
      SupProtCharc02CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc02CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc02ValueID,

      SupProtCharc03CtlgPathUUID,
      SupProtCharc03CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc03CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc03ValueID,

      SupProtCharc04CtlgPathUUID,
      SupProtCharc04CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc04CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc04ValueID,

      SupProtCharc05CtlgPathUUID,
      SupProtCharc05CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc05CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc05ValueID,

      SupProtCharc06CtlgPathUUID,
      SupProtCharc06CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc06CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc06ValueID,

      SupProtCharc07CtlgPathUUID,
      SupProtCharc07CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc07CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc07ValueID,

      SupProtCharc08CtlgPathUUID,
      SupProtCharc08CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc08CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc08ValueID,

      SupProtCharc09CtlgPathUUID,
      SupProtCharc09CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc09CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc09ValueID,

      SupProtCharc10CtlgPathUUID,
      SupProtCharc10CtlgPathIntID,

      @Consumption.valueHelpDefinition: [{entity.name:      'C_SupProtCharcValueVH',
                                          entity.element:   'CharcValue',
                                          additionalBinding: [{ element:      'SupProtCharcCtlgPathUUID',
                                                                localElement: 'SupProtCharc10CtlgPathUUID',
                                                                usage:        #FILTER } ] }]
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false }
      SupProtCharc10ValueID,

      SupProtGroupPriorityValue,

      _SupplyProtectionTP.UnitOfMeasure,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtProtectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtConsumedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtRemainingProtectedQty,

      CharcValAuthznGroup,

      @Semantics.user.createdBy: true
      CreatedByUser,

      @Semantics.systemDateTime.createdAt: true
      CreationDateTime,

      @Semantics.user.lastChangedBy: true
      LastChangedByUser,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangeDateTime,

      SupplyProtectionGroupIsBlocked,

      /* Compositions */
      _SupplyProtectionTimeBucketTP,

      /* Associations */
      _SupplyProtectionTP,
      _SupProtTimeBucketCnsmpnTP,
      _SupProtTimeBucketChart,
      _SupplyProtectionTP._BaseUnit
}
