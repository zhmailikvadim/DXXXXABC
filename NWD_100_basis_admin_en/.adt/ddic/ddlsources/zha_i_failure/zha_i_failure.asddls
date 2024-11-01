@AbapCatalog.sqlViewName: 'ZHA_I_Q_FLR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_FAILURE DB table'
define view ZHA_I_FAILURE
  as select from zha_d_failures
{

  key failure_id,
      malfunc_id,
      message_id,
      failure_message,
      measures, 
      matnr,
      park_id,
      malfunc_number,
      description
}
