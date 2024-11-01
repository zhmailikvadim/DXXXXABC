@AbapCatalog.sqlViewName: 'ZHA_ITQ_FL_MSSGS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_FAIL_MESS'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_FAIL_MESS',
    semanticKey: ['message_id'],
    representativeKey: 'message_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true 
}

define view ZHA_I_T_FAIL_MESSAGE
  as select from ZHA_I_FAIL_MESSAGE
{
  key message_id,
      malfunc_id,
      message_number,
      message_paper_number,
      date_failure,
      message_date,
      client_address,
      model,
      batch,
      farm_id,
      farm_name,
      farm_country,
      bland,
      farm_region,
      failure_message,
      measures,
      description,
      user_who_changed,
      date_changed,
      time_changed
}
