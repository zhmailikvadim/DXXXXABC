@AbapCatalog.sqlViewName: 'ZHA_I_Q_AGR_PRK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_AGR_PARK DB table'

define view zha_i_agr_park
  as select from zha_d_agr_park
{

  key park_id,
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
      time_changed
     
}
 