@AbapCatalog.sqlViewName: 'ZHA_I_Q_TCH_PRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_TECH_PROC DB table'
define view ZHA_I_TECH_PROC
  as select from zha_d_tech_proc
{

  key tech_proc_id,
      tech_proc_name,
      model,
      tech_proc_date,
      link,
      tech_proc_number,
      description,
      user_who_changed,
      date_changed,
      time_changed      
}
