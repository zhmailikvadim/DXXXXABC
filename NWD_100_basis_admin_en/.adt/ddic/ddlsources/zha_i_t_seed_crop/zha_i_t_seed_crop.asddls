@AbapCatalog.sqlViewName: 'ZHA_ITQ_SD_CRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_SEED_CROP'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHA_D_SEED_CROP',
    semanticKey: ['crop_id'],
    representativeKey: 'crop_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}


define view ZHA_I_T_SEED_CROP
  as select from zha_i_seed_crop
  association [1..1] to ZHA_I_T_FARMS as _farmsData on $projection.farm_id = _farmsData.farm_id
{
  key crop_id,
      crop_name,
      farm_id,
      farm_name,
      crop_square,
      description,
      user_who_changed,
      date_changed,
      time_changed,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
      _farmsData
}
