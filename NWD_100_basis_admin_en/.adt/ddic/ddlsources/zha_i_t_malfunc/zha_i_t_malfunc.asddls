@AbapCatalog.sqlViewName: 'ZHA_ITQ_MLFNC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_MALFUNC'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_MALFUNC',
    semanticKey: ['malfunc_id'],
    representativeKey: 'malfunc_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_MALFUNC
  as select from ZHA_I_MALFUNC
  association [0..*] to ZHA_I_T_FAILURE as _failureData on $projection.malfunc_id = _failureData.malfunc_id
{
  key malfunc_id,
      malfunc_number,
      malfunc_paper_number,
      model,
      batch,
      code_condition,
      worktime,
      meins,
      mseht,
      repair_date,
      message_date,
      farm_id,
      farm_name,
      message_definition,
      failure_photo,
      photo_link,
      failure_video,
      video_link,
      ZHA_I_MALFUNC.description,
      user_who_changed,
      date_changed,
      time_changed,

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _failureData

}
