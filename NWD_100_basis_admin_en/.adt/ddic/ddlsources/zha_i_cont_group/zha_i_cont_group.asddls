@AbapCatalog.sqlViewName: 'ZHA_I_Q_CNT_GR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_CONT_GROUP DB table'

define view ZHA_I_CONT_GROUP
  as select from zha_d_cont_group
{

  key cont_gr_id,
      cont_gr_name,
      struct_division,
      description

}
