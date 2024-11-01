@AbapCatalog.sqlViewName: 'ZHA_I_Q_TTRL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_TUTORIAL DB table'
define view ZHA_I_TUTORIAL
  as select from zha_d_tutorials
{

  key tutorial_id,
      tutorial_name,
      link,
      description,
      user_who_changed,
      date_changed,
      time_changed
}
