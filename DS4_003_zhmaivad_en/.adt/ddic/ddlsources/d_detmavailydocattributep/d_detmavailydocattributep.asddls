@EndUserText.label: 'Available to Promise Document Attributes'
@Metadata.allowExtensions: true
@VDM.usage.type:[ #ACTION_PARAMETER_STRUCTURE ]
define root abstract entity D_DetmAvailyDocAttributeP
{
  key ATPRelevantDocumentPurpose : atp_relevant_document_purpose;
      _Characteristics           : association [0..*] to D_DetmAvailyCharcValueP on 1 = 1;
}
