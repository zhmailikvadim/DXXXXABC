@AbapCatalog.sqlViewName: 'ZHA_I_Q_CNTCT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_CONTACT DB table'

define view ZHA_I_CONTACT
  as select from zha_d_contact
{

  key contact_id,
      contact_name,
      contact_position,
      cont_gr_name,
      struct_division,
      telephon,
      e_mail,
      user_who_changed,
      date_changed,
      time_changed
}
  
