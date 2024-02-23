/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock Correction Errors Log'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stock_correction_errors
  as select from zsd_t_corr_error
  association to parent zsd_i_stock_corr_rprt as _StockCorrectionReport on $projection.StockCorrectionUuid = _StockCorrectionReport.Uuid
{
  key error_uuid            as ErrorUuid,
  key stock_correction_uuid as StockCorrectionUuid,
      semantic_count_number as SemanticCountNumber,
      type                  as MessageType,
      id                    as MessageId,
      znumber               as MessageNumber,
      message               as Message,
      zparameter            as ParameterBapi,
      zsystem               as SystemClient,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      changed_at            as ChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by            as ChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      _StockCorrectionReport
}
