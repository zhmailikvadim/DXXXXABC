@AbapCatalog.sqlViewName: 'ZHA_I_Q_SPR_PRT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZZHA_SPARE_PARTS DB table'
define view ZHA_I_SPARE_PARTS
  as select from zha_spare_parts
{
  key     matnr,
//          lower ( matnr ) as matnr_lower,
//          upper ( matnr ) as matnr_upper,
  key     werks,
  key     lgort,
          maktx,
          name1,
          lgobe,
          amount,
          meins,
          cost,
          waers
}
