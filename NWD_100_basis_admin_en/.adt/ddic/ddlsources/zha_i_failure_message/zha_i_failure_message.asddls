@AbapCatalog.sqlViewName: 'ZHA_IQ_FLR_MSSG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Failure message''s value help'

define view ZHA_I_FAILURE_MESSAGE
  as select from ZHA_C_FAIL_MESS
{
      @UI.hidden: true
  key message_id,
      failure_message,
      ZHA_C_FAIL_MESS.farm_name,
      ZHA_C_FAIL_MESS.model,
      ZHA_C_FAIL_MESS.batch,
      measures,
      ZHA_C_FAIL_MESS.description
}
