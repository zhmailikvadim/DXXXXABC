@EndUserText.label: 'DetmAvailabilityTimeSeries Parameters'
@Metadata.allowExtensions: true
@VDM.usage.type:[ #ACTION_PARAMETER_STRUCTURE ]
define root abstract entity D_AvailyDetmAvailyTmeSersP
{
  key ATPCheckingRule     : prreg;
      _DocumentAttributes : association [0..1] to D_DetmAvailyDocAttributeP on 1 = 1;
}
