/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Freshest Error Message'
@AccessControl.authorizationCheck: #CHECK
define view entity zsd_i_correct_errors_freshest
  as select from zsd_i_stock_correction_errors as StockCorrection
    join         zsd_i_correct_err_last_number as LastErrorNumber on  StockCorrection.StockCorrectionUuid = LastErrorNumber.StockCorrectionUuid
                                                           and StockCorrection.SemanticCountNumber = LastErrorNumber.LastSemanticCountNumber
{
  key StockCorrection.ErrorUuid,
  key StockCorrection.StockCorrectionUuid,
      LastErrorNumber.CountErrors,
      StockCorrection.MessageType,
      StockCorrection.MessageId,
      StockCorrection.MessageNumber,
      StockCorrection.Message,
      StockCorrection.ParameterBapi,
      StockCorrection.SystemClient,
      StockCorrection.CreatedAt,
      StockCorrection.CreatedBy,
      StockCorrection.ChangedAt,
      StockCorrection.ChangedBy,
      StockCorrection.LastChangedAt
}
where
  StockCorrection.MessageType = 'E'
