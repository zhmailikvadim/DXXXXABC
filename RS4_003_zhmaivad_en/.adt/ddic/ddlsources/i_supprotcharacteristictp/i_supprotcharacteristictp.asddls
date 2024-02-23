@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK
@ObjectModel: { usageType: { serviceQuality: #C,
                             sizeCategory:   #L,
                             dataClass:      #MIXED } }
@EndUserText.label: 'Supply Protection Characteristic'
define view entity I_SupProtCharacteristicTP
  as select from I_SupProtCharacteristic
  association        to parent I_SupplyProtectionTP as _SupplyProtectionTP on  $projection.SupplyProtectionUUID = _SupplyProtectionTP.SupplyProtectionUUID
  association [0..1] to I_ProdAllocCharcText        as _ProdAllocCharcText on  _ProdAllocCharcText.ProdAllocCharcCtlgPathIntID = $projection.SupProtCharcCtlgPathIntID
                                                                           and _ProdAllocCharcText.Language                    = $session.system_language
{
  key SupProtCharacteristicUUID,
      SupplyProtectionUUID,
      SupProtOrdinalNumberValue,
      SupProtCharcColumnName,
      SupProtCharcCtlgPathUUID,
      SupProtCharcCtlgPathIntID,
      cast( '' as charccatalogcharacteristicname )                                             as SupProtCharcName,

      @Semantics.user.createdBy: true
      CreatedByUser,

      @Semantics.systemDateTime.createdAt: true
      CreationDateTime,

      @Semantics.user.lastChangedBy: true
      LastChangedByUser,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangeDateTime,

      @Consumption.valueHelpDefinition: [{ entity.name:         'I_SupProtCharacteristicVH',
                                           entity.element:      'Characteristic',
                                           additionalBinding:   [{ element:      'ProdAllocCharcCtlgPathUUID',
                                                                   localElement: 'SupProtCharcCtlgPathUUID',
                                                                   usage:        #RESULT},
                                                                 { element:      'ProdAllocCharcCtlgPathIntID',
                                                                   localElement: 'SupProtCharcCtlgPathIntID',
                                                                   usage:        #RESULT},
                                                                 { element:      'ProdAllocCharcCatalogType',
                                                                   localElement: 'SupProtCharcCatalogType',
                                                                   usage:        #FILTER}]
                                        }]
      cast( _ProdAllocCharcText.ProdAllocCharcCtlgPathDesc as sup_charc_text preserving type ) as Characteristic,
      _SupplyProtectionTP.SupProtCharcCatalogType,

      /* Associations */
      _SupplyProtectionTP
}
