@ObjectModel.query.implementedBy: 'ABAP:CL_ATP_SUP_CHARC_VALUE_VH'
@VDM.viewType: #CONSUMPTION
@EndUserText.label: 'Characteristic Values'
define custom entity C_SupProtCharcValueVH
{
      @ObjectModel.text.element: [ 'CharcValueDescription' ]
  key CharcValue               : sup_charc_value;
      @Semantics.text
  key CharcValueDescription    : sup_charc_value_desc;
      @UI.hidden               : true
      SupProtCharcCtlgPathUUID : sup_charc_catalog_path_uuid;
      @UI.hidden               : true
      SupplyProtectionUUID     : sup_object_uuid;
}
