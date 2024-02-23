/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
************************************************************************
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sum Move Type''s quantities'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_corr_hist_via_mat_doc
  as select from zsd_i_stock_correction_history as History
    join         zsd_i_material_documents       as MaterialDocuments on History.MaterialDocument = MaterialDocuments.Mblnr
    join         zsd_i_move_types_rows          as MoveTypes         on MaterialDocuments.MoveType = MoveTypes.MoveType

{
  key       History.WmsSnapshotDate,
  key       case
              when MaterialDocuments.DebitCreditIndicator = 'H' and
                   LEFT(History.MoveType, 1) = '3' then  MoveTypes.StockTypeTo
              else MoveTypes.StockType end        as StockType,
  key       History.Article,
  key       History.Plant,
  key       History.StorageLocation,
  key       History.SalesOrderItem,
  key       History.SalesOrderNumber,
            History.Meins,
            History.MoveType,
            History.TransferTo,
            @Semantics.quantity.unitOfMeasure : 'Meins'
            case when History.TransferTo <> '' then
            - case MaterialDocuments.DebitCreditIndicator
            when 'S' then - MaterialDocuments.Menge
            else  MaterialDocuments.Menge end
            else
            case MaterialDocuments.DebitCreditIndicator
            when 'S' then - MaterialDocuments.Menge
            else  MaterialDocuments.Menge end end as AdjustmentQty
}
where
  History.Status = 'Complete'
