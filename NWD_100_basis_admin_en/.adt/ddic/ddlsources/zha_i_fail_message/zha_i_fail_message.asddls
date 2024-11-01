@AbapCatalog.sqlViewName: 'ZHA_I_FL_MSS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_FAIL DB table'
define view ZHA_I_FAIL_MESSAGE
  as select from zha_d_fail_mess
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
