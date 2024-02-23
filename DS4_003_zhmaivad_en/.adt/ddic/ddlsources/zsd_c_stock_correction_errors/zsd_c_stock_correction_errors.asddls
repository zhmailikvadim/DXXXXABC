/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Stock Correction Errors Log - Projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define view entity zsd_c_stock_correction_errors
  as projection on zsd_i_stock_correction_errors
{
  key ErrorUuid,
  key StockCorrectionUuid,
      SemanticCountNumber,
      MessageType,
      MessageId,
      MessageNumber,
      Message,
      ParameterBapi,
      SystemClient,
      CreatedBy,
      CreatedAt,
      ChangedBy,
      ChangedAt,
      LastChangedAt,
      /* Associations */
      _StockCorrectionReport : redirected to parent zsd_c_stock_corr_rprt
}
where MessageType = 'E'
