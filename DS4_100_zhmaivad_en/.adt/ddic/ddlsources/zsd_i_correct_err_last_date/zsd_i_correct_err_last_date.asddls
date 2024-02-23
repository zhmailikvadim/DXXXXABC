@EndUserText.label: 'Get freshest Error Data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zsd_i_correct_err_last_date
  as select from zsd_i_stock_correction_errors
{
  key StockCorrectionUuid,
      max(LastChangedAt) as LastChangedAt

}
group by
  StockCorrectionUuid,
  ErrorUuid
