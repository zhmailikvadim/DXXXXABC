@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK

@ObjectModel:   { usageType: { serviceQuality: #C,
                               sizeCategory:   #XL,
                               dataClass:      #MIXED }
}

@EndUserText.label: 'Supply Protection Group'
define view entity I_SupplyProtectionGroup
  as select from sup_cvc
{
  key uuid                        as SupplyProtectionGroupUUID,
      supobjectuuid               as SupplyProtectionUUID,
      charc01catalogpathuuid      as SupProtCharc01CtlgPathUUID,
      charc01catalogpathid        as SupProtCharc01CtlgPathIntID,
      characteristic01            as SupProtCharc01ValueID,
      charc02catalogpathuuid      as SupProtCharc02CtlgPathUUID,
      charc02catalogpathid        as SupProtCharc02CtlgPathIntID,
      characteristic02            as SupProtCharc02ValueID,
      charc03catalogpathuuid      as SupProtCharc03CtlgPathUUID,
      charc03catalogpathid        as SupProtCharc03CtlgPathIntID,
      characteristic03            as SupProtCharc03ValueID,
      charc04catalogpathuuid      as SupProtCharc04CtlgPathUUID,
      charc04catalogpathid        as SupProtCharc04CtlgPathIntID,
      characteristic04            as SupProtCharc04ValueID,
      charc05catalogpathuuid      as SupProtCharc05CtlgPathUUID,
      charc05catalogpathid        as SupProtCharc05CtlgPathIntID,
      characteristic05            as SupProtCharc05ValueID,
      charc06catalogpathuuid      as SupProtCharc06CtlgPathUUID,
      charc06catalogpathid        as SupProtCharc06CtlgPathIntID,
      characteristic06            as SupProtCharc06ValueID,
      charc07catalogpathuuid      as SupProtCharc07CtlgPathUUID,
      charc07catalogpathid        as SupProtCharc07CtlgPathIntID,
      characteristic07            as SupProtCharc07ValueID,
      charc08catalogpathuuid      as SupProtCharc08CtlgPathUUID,
      charc08catalogpathid        as SupProtCharc08CtlgPathIntID,
      characteristic08            as SupProtCharc08ValueID,
      charc09catalogpathuuid      as SupProtCharc09CtlgPathUUID,
      charc09catalogpathid        as SupProtCharc09CtlgPathIntID,
      characteristic09            as SupProtCharc09ValueID,
      charc10catalogpathuuid      as SupProtCharc10CtlgPathUUID,
      charc10catalogpathid        as SupProtCharc10CtlgPathIntID,
      characteristic10            as SupProtCharc10ValueID,
      cvcpriority                 as SupProtGroupPriorityValue,
      creationdatetime            as CreationDateTime,
      createdbyuser               as CreatedByUser,
      lastchangedatetime          as LastChangeDateTime,
      lastchangedbyuser           as LastChangedByUser,
      charcvalauthzngroup         as CharcValAuthznGroup,
      blocked                     as SupplyProtectionGroupIsBlocked,

      cast('' as abap.unit(3) )   as UnitOfMeasure,
      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'

      cast(0 as abap.quan(15,3) ) as SupProtProtectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      cast(0 as abap.quan(15,3) ) as SupProtConsumedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      cast(0 as abap.quan(15,3) ) as SupProtRemainingProtectedQty
}
