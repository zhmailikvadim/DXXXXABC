@AbapCatalog.sqlViewName: 'ZHA_ITQ_AGR_PRK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_AGR_PARK'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHA_D_AGR_PARK',
    semanticKey: ['park_id'],
    representativeKey: 'park_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_ARG_PARK
  as select from zha_i_agr_park
  association [1..1] to ZHA_I_T_FARMS as _farmData on $projection.farm_id = _farmData.farm_id
  association [0..*] to ZRA_I_T_ADAP  as _itemtData on $projection.park_id = _itemtData.park_id
{
  key  park_id,
       park_producer,
       model,
       batch,
       amount,
       year_of_issue,
       data_of_issue,
       model_engine,
       batch_engine,
       model_adapter,
       batch_adapter,
       farm_id,
       farm_name,
       description,
       user_who_changed,
       date_changed,
       time_changed,
  
       @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
       _farmData,

        @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
       _itemtData 
}
