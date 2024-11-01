@AbapCatalog.sqlViewName: 'ZHA_ITQ_FRMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_FARMS'

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_FARMS',
    semanticKey: ['farm_id'],
    representativeKey: 'farm_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_FARMS
  as select from ZHA_I_FARMS
  association [0..*] to ZHA_I_T_SEED_CROP as _cropData on $projection.farm_id = _cropData.farm_id
  association [0..*] to ZHA_I_T_ARG_PARK  as _parkData on $projection.farm_id = _parkData.farm_id
{
  key  farm_id,
       farm_name,
       farm_country,
       bland,
       farm_region,
       farm_city,
       farm_adress,
       telephon,
       e_mail,
       kunnr,
       name1,
       lower_farm_name,
       lower_farm_country,
       lower_farm_adress,
       user_who_changed,
       date_changed,
       time_changed,
       @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
       _cropData,
       @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
       _parkData

}
