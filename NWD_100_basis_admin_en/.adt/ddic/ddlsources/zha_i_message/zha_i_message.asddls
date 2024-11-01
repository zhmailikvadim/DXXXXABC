@AbapCatalog.sqlViewName: 'ZHA_I_Q_MSSG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Message''s value help'

define view ZHA_I_MESSAGE
  as select distinct from ZHA_I_FAIL_MESSAGE
{
        
  key  message_number,
       message_paper_number,
       message_date,
       model,
       batch,
       farm_name,
       farm_country,
       farm_region,
       failure_message,
       measures,
       description
}
