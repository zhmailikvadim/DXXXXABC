@AbapCatalog.sqlViewName: 'ZHA_I_Q_MLFNC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_MALFUNC DB table'
define view ZHA_I_MALFUNC
  as select from zha_d_malfunc
{

  key malfunc_id,
      malfunc_number,
      malfunc_paper_number,
      model,
      batch,
      code_condition,
      worktime,
      meins,
      mseht,
      repair_date,
      message_date,
      farm_id,
      farm_name,
      message_definition,
      failure_photo,
      photo_link,
      failure_video,
      video_link,
      description,
      user_who_changed,
      date_changed, 
      time_changed
}
  
