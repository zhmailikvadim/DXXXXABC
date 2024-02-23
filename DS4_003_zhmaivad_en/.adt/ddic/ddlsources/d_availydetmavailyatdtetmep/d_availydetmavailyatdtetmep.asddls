
@EndUserText.label: 'DetermineAvailabilityAtDateTme Params'
@Metadata.allowExtensions: true
@VDM.usage.type:[ #ACTION_PARAMETER_STRUCTURE ]
define root abstract entity D_AvailyDetmAvailyAtDteTmeP
{
  key ATPCheckingRule                : prreg;
      ProductAvailabilityUTCDateTime : tzntstmps;
      _DocumentAttributes            : association [0..1] to D_DetmAvailyDocAttributeP on 1 = 1;
}
