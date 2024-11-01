@AbapCatalog.sqlViewName: 'ZHA_ITQ_FLR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_FAILURE'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHA_D_FAILURES',
    semanticKey: ['failure_id'],
    representativeKey: 'failure_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true 
}


define view ZHA_I_T_FAILURE 
  as select from ZHA_I_FAILURE
  association [1..1] to ZHA_I_T_MALFUNC as _malfuncData on $projection.malfunc_id = _malfuncData.malfunc_id
{

  key failure_id,
      malfunc_id,
      message_id,
      failure_message,
      measures,
      matnr,
      park_id,
      malfunc_number,
      description,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
     _malfuncData
}
