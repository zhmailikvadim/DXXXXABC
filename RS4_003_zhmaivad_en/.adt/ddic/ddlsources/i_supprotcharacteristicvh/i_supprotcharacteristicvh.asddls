@ObjectModel:{
               dataCategory: #VALUE_HELP,
               usageType:{
                           serviceQuality: #C,
                           sizeCategory: #S,
                           dataClass: #MIXED
                         },
               representativeKey: 'ProdAllocCharcCtlgPathUUID'
             }
@AccessControl.authorizationCheck: #CHECK
@VDM: { lifecycle.contract.type: #SAP_INTERNAL_API,
        viewType: #COMPOSITE }

@EndUserText.label: 'Supply Protection Characteristics'
define view entity I_SupProtCharacteristicVH
  as select from I_ProdAllocCharcCatalogPath
  association to I_ProdAllocCharcText as _ProdAllocCharcText on  $projection.ProdAllocCharcCtlgPathIntID = _ProdAllocCharcText.ProdAllocCharcCtlgPathIntID
                                                             and _ProdAllocCharcText.Language            = $session.system_language

{
      @ObjectModel.text.element: ['Characteristic']
      @Consumption.filter.hidden: true
  key ProdAllocCharcCtlgPathUUID,
      @Consumption.filter.hidden: true
      ProdAllocCharcCtlgPathIntID,
      @Consumption.filter.hidden: true
      ProdAllocCharcCatalogType,

      @Semantics.text: true
      cast(_ProdAllocCharcText.ProdAllocCharcCtlgPathDesc as sup_charc_text) as Characteristic,

      /* Associations */
      _ProdAllocCharcText
}
where
      ProdAllocCharcCatalogUseType   =  '05'
  and ProdAllocCharcCatalogPathType  =  '02'
  and ProdAllocCharcCtlgPathIsHidden <> 'X'
