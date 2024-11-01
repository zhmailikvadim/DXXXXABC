@AbapCatalog.sqlViewName: 'ZHA_I_Q_SD_CRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_SEED_CROP DB table'

define view zha_i_seed_crop
  as select from zha_d_seed_crop
{
  key crop_id,
      crop_name,
      farm_id,
      farm_name,
      crop_square,
      description,
      user_who_changed,
      date_changed,
      time_changed,
      upper(crop_name) as Crop
}
 