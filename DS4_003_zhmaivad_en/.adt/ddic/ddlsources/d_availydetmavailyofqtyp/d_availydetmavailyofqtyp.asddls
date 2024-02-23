@EndUserText.label: 'DetermineAvailabilityOfQty Params'
@Metadata.allowExtensions: true
@VDM.usage.type:[ #ACTION_PARAMETER_STRUCTURE ]
@ObjectModel.supportedCapabilities: [#DATA_STRUCTURE]
@ObjectModel.modelingPattern: #DATA_STRUCTURE
define root abstract entity D_AvailyDetmAvailyOfQtyP
{
  key ATPCheckingRule             : prreg;
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      AvailableQuantityInBaseUnit : omeng;
      BaseUnit                    : unit;
      _DocumentAttributes         : association [0..1] to D_DetmAvailyDocAttributeP on 1 = 1;
}
