@EndUserText.label: 'Available Quantity of Product'
@VDM.usage.type:[ #ACTION_RESULT_STRUCTURE ]
define root abstract entity D_AvailyDetmAvailyAtDteTmeR
{
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  key AvailableQuantityInBaseUnit : abap.quan(15,3);
      BaseUnit                    : unit;
      BaseUnitISOCode             : isocd_unit;
}
