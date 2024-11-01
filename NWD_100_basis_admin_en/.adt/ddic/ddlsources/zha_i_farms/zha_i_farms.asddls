@AbapCatalog.sqlViewName: 'ZHA_I_Q_FRMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_FARMS DB table'

define view ZHA_I_FARMS
  as select from zha_d_farms
{

  key farm_id,
      farm_name,
      farm_country,
      bland,
      farm_region,
      farm_city,
      farm_adress,
      telephon,
      e_mail,
      kunnr,
      name1,
      user_who_changed,
      date_changed,
      time_changed,
      lower ( farm_name ) as lower_farm_name,
      lower ( farm_country ) as lower_farm_country,
      lower ( farm_adress ) as lower_farm_adress
}
