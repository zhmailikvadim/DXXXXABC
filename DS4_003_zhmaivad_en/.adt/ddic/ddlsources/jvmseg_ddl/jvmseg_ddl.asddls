@AbapCatalog.sqlViewAppendName: 'J_JVMSEG_V'
@EndUserText.label: 'Extension for Append JVMSEG on MSEG'

@ObjectModel.usageType.sizeCategory: 'XXL'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #AUTOMATED
@AbapCatalog.viewEnhancementCategory: #PROJECTION_LIST

extend view nsdm_e_mseg with JVMSEG_E {
    oinavnw,
    oicondcod,
    condi    
}      
  
 