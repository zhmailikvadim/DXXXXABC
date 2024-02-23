@EndUserText.label: 'Time Series of Product'
@VDM.usage.type:[ #ACTION_RESULT_STRUCTURE ]
define root abstract entity D_AvailyDetmAvailyTmeSersR
{
  @Semantics.timeZoneReference: 'ProdAvailyPerdStrtTmznIANACode'
  key ProdAvailyPerdStrtUTCDteTme    : periodstartutcdatetime;
      ProdAvailyPerdStrtTimeZone     : periodstarttimezone;
      @Semantics.timeZone: true
      ProdAvailyPerdStrtTmznIANACode : tznianacode;
      @Semantics.timeZoneReference: 'ProdAvailyPerdEndTmznIANACode'
      ProdAvailyPerdEndUTCDteTme     : periodendutcdatetime;
      ProdAvailyPerdEndTimeZone      : periodendtimezone;
      @Semantics.timeZone: true
      ProdAvailyPerdEndTmznIANACode  : tznianacode;
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      AvailableQuantityInBaseUnit    : abap.quan(15,3);
      BaseUnit                       : unit;
      BaseUnitISOCode                : isocd_unit;
}
