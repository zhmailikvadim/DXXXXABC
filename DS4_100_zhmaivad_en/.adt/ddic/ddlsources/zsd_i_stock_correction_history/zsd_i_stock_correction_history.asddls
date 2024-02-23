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
@EndUserText.label: 'Stock Correction History - Basic'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_stock_correction_history
  as select from zsd_t_stcor_hist
  association to parent zsd_i_stock_corr_rprt as _StockCorrectionReport on $projection.StockCorrectionUuid = _StockCorrectionReport.Uuid
  association to zsd_t_stock_type             as _StockType             on $projection.TransferTo = _StockType.stock_type
{
  key history_uuid                as HistoryUuid,
  key stock_correction_uuid       as StockCorrectionUuid,
      semantic_count_number as SemanticCountNumber,
      plant                       as Plant,
      storage_location            as StorageLocation,
      article                     as Article,
      sales_order_number          as SalesOrderNumber,
      sales_order_item            as SalesOrderItem,
      status                      as Status,
      meins                       as Meins,
      mat_doc                     as MaterialDocument,
      mat_doc_year                as MaterialDocumentYear,
      bwart                       as MoveType,
      sap_snapshot_date           as SapSnapshotDate,
      wms_snapshot_date           as WmsSnapshotDate,
      transfer_to                 as TransferTo,
      _StockType.type_description as TransferToDescription,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      adjustment_qty              as AdjustmentQty,
      case status
      when 'ERROR' then  1
      when 'OPEN' then   2
      when 'COMPLETE' then 3
      else 0 end                  as StatusCriticality,
      create_timestamp            as CreateTimestamp,
      @Semantics.systemDateTime.createdAt: true
      created_at                  as CreatedAt,
      @Semantics.user.createdBy: true
      created_by                  as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      changed_at                  as ChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      changed_by                  as ChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at             as LastChangedAt,

      _StockCorrectionReport
}
