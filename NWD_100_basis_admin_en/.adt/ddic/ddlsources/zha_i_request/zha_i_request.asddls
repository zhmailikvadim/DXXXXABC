@AbapCatalog.sqlViewName: 'ZHA_I_Q_RQST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZHA_D_REQUEST DB table'
define view ZHA_I_REQUEST
  as select from zha_d_request
{
        
  key req_id,
      matnr,
      maktx,
      qnt,
      meins,
      zyear,
      zmonth,
      kunnr,
      name1,
      user_who_changed,
      date_changed,
      time_changed,
      lower( name1 ) as lower_name1
}
 