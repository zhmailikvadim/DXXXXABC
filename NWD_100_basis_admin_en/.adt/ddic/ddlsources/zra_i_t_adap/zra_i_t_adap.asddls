@AbapCatalog.sqlViewName: 'ZRA_Q_T_ADAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck:#NOT_REQUIRED
@EndUserText.label: 'Ttransaction CDS for ZRA_I_B_ADAP'

@ObjectModel:{

    transactionalProcessingEnabled: true,
    writeActivePersistence: 'zra_d_adap',
    semanticKey: ['cmat_item_uuid'],
    representativeKey: 'cmat_item_uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZRA_I_T_ADAP
  as select from ZRA_I_B_ADAP
  association [1..1] to ZHA_I_T_ARG_PARK as _parkData on $projection.park_id = _parkData.park_id
  association [1..1] to ZHA_I_T_FARMS    as _farmData on $projection.farm_id = _farmData.farm_id

{

  key cmat_item_uuid,
      park_id,
      farm_id,
      model_adapter,
      batch_adapter,
      year_of_issue,
      data_of_issue,
      description,
      user_who_changed,
      date_changed,
      time_changed,

      @ObjectModel.association.type: [#TO_COMPOSITION_ROOT]
      _farmData,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT]
      _parkData
}
