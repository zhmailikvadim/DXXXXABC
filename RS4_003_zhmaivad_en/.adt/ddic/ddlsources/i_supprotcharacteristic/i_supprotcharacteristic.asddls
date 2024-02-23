@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK

@ObjectModel:   { usageType: { serviceQuality: #C,
                               sizeCategory:   #L,
                               dataClass:      #MIXED }
}

@EndUserText.label: 'Supply Protection Characteristic'
define view entity I_SupProtCharacteristic
  as select from sup_charc
{
  key uuid               as SupProtCharacteristicUUID,
      objectuuid         as SupplyProtectionUUID,
      ordinalnumber      as SupProtOrdinalNumberValue,
      tablecolumnname    as SupProtCharcColumnName,
      catalogpathuuid    as SupProtCharcCtlgPathUUID,
      catalogpathid      as SupProtCharcCtlgPathIntID,
      creationdatetime   as CreationDateTime,
      createdbyuser      as CreatedByUser,
      lastchangedatetime as LastChangeDateTime,
      lastchangedbyuser  as LastChangedByUser

}
