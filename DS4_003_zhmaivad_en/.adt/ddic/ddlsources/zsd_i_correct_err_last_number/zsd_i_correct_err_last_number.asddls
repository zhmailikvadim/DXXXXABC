/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Get freshest Error Data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zsd_i_correct_err_last_number
  as select from zsd_i_stock_correction_errors
{
  key StockCorrectionUuid,
      max(SemanticCountNumber)                             as LastSemanticCountNumber,
      sum( case when MessageType = 'E' then 1 else 0 end ) as CountErrors
}
group by
  StockCorrectionUuid
