/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 19611     : [Feature] [Build] - Stock re *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 28.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
* ---------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock correction report - basic CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity zsd_i_stock_corr_rprt
  as select from zsd_i_stock_corr
  composition [1..*] of zsd_i_stock_correction_history as _StockCorrectionHistory
  composition [1..*] of zsd_i_stock_correction_errors  as _StockCorrectionErrors
  association [1..*] to I_ProductDescription           as _ProductDescription               on  $projection.Article = _ProductDescription.Product
  association        to I_Product                             as _Product                   on  $projection.Article = _Product.Product
  association        to zsd_i_article_valuation               as _ArticleValuation          on  $projection.Article             = _ArticleValuation.Article
                                                                                            and $projection.Plant               = _ArticleValuation.ValuationArea
                                                                                            and _ArticleValuation.ValuationType = ''
  association        to zsd_i_correct_history_qnt_sum         as _CorrectionHistorySum      on  $projection.Uuid = _CorrectionHistorySum.StockCorrectionUuid
  association        to zsd_i_corr_hist_via_mat_sum           as _MaterialDocumentsStockSum on  $projection.WmsSnapshotDate  = _MaterialDocumentsStockSum.WmsSnapshotDate
                                                                                            and $projection.Article          = _MaterialDocumentsStockSum.Article
                                                                                            and $projection.StorageLocation  = _MaterialDocumentsStockSum.StorageLocation
                                                                                            and $projection.Plant            = _MaterialDocumentsStockSum.Plant
                                                                                            and $projection.SalesOrderNumber = _MaterialDocumentsStockSum.SalesOrderNumber
                                                                                            and $projection.SalesOrderItem   = _MaterialDocumentsStockSum.SalesOrderItem
                                                                                            and $projection.StockType        = _MaterialDocumentsStockSum.StockType
  association        to zsd_i_move_types                      as _MoveTypes                 on  $projection.StockType  = _MoveTypes.MoveFrom
                                                                                            and $projection.TransferTo = _MoveTypes.MoveTo
  association        to zsd_i_correct_errors_freshest         as _FreshestError             on  $projection.Uuid = _FreshestError.StockCorrectionUuid
  association        to zsd_i_stock_corr_hist_freshest        as _FreshestHistory           on  $projection.Uuid = _FreshestHistory.StockCorrectionUuid
  association        to t157d                                 as _ReasonForMovement         on  $projection.MoveType = _ReasonForMovement.bwart

{
  key Uuid                                                                              as Uuid,
      cast(case when  AdjustmentQty = _CorrectionHistorySum.AdjustmentQtySum then 'Complete' else
      case when _FreshestHistory.Status is null then 'Open'
           else _FreshestHistory.Status end end as abap.char( 10 ) )                    as Status,

      case when AdjustmentQty =  _CorrectionHistorySum.AdjustmentQtySum
        then 3
        else
        case when _FreshestHistory.Status = 'Error'
            then 1 else 2 end
        end                                                                             as StatusCriticality,

      case when AdjustmentQty =  _CorrectionHistorySum.AdjustmentQtySum
      then 3
      else
      case when _FreshestHistory.Status = 'Error'
      then 1 else 2 end
      end                                                                               as StatusCriticalityHighLight,

      _FreshestHistory.Status                                                           as LastMovementStatus,
      _FreshestHistory.StatusCriticality                                                as LastMovementStatusCriticality,
      Plant                                                                             as Plant,
      StorageLocation                                                                   as StorageLocation,
      Article                                                                           as Article,
      _ProductDescription[1:Language = $session.system_language].ProductDescription     as ArticleDescription,
      _Product.CrossPlantConfigurableProduct                                            as GenericArticle,
      _Product.ProductType                                                              as MaterialType,
      _Product.ProductGroup                                                             as MaterialGroup,
      cast ('EUR' as abap.cuky)                                                         as CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _ArticleValuation.Price                                                           as Price,
      StockType                                                                         as StockType,
      SalesOrderNumber                                                                  as SalesOrderNumber,
      SalesOrderItem                                                                    as SalesOrderItem,
      ExecutionTimestamp                                                                as ExecutionTimeStamp,
      tstmp_to_dats( ExecutionTimestamp,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                                           as ExecutionDate,
      tstmp_to_tims( ExecutionTimestamp,
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )                                                           as ExecutionTime,
      TransferTo                                                                        as TransferTo,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      AdjustmentQty                                                                     as AdjustmentQty,
      MoveTypeGroup                                                                     as MoveTypeGroup,
      case
          when AdjustmentQty > 0 then _MoveTypes.MoveTypeIncrease
          when AdjustmentQty < 0 then _MoveTypes.MoveTypeDecrease else '' end           as MoveType,

      @Semantics.quantity.unitOfMeasure : 'Meins'
      cast(case when _CorrectionHistorySum.AdjustmentQtySum is null
      then 0 else _CorrectionHistorySum.AdjustmentQtySum end as abap.quan( 8, 0 ))      as Adjusted,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      Difference,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      Difference
      + cast(case when _MaterialDocumentsStockSum.AdjustmentQtySum is null
      then 0 else _MaterialDocumentsStockSum.AdjustmentQtySum end as abap.quan( 8, 0 )) as DifferenceCalc,
      case when
      Difference + cast(case when _MaterialDocumentsStockSum.AdjustmentQtySum is null
      then 0 else _MaterialDocumentsStockSum.AdjustmentQtySum end as abap.quan( 8, 0 ))  > 0 then 1
      else 3 end                                                                        as DifferenceCalcCriticality,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      _MaterialDocumentsStockSum.AdjustmentQtySum                                       as MaterialDocumentsStockSum,
      _Product.BaseUnit                                                                 as Meins,
      case
        when AdjustmentQty <=       case when AdjustmentQty > 0 and MoveTypeGroup = 1
      then _MaterialDocumentsStockSum.AdjustmentQtySum
      else
      _CorrectionHistorySum.AdjustmentQtySum  end then 3
        when AdjustmentQty <       case when AdjustmentQty > 0 and MoveTypeGroup = 1
      then _MaterialDocumentsStockSum.AdjustmentQtySum
      else
      _CorrectionHistorySum.AdjustmentQtySum  end then 1
        when AdjustmentQty >       case when AdjustmentQty > 0 and MoveTypeGroup = 1
      then _MaterialDocumentsStockSum.AdjustmentQtySum
      else
      _CorrectionHistorySum.AdjustmentQtySum  end then 2 else 0 end                     as AdjustmentCriticality,
      WmsSnapshotDate                                                                   as WmsSnapshotDate,
      _FreshestError.Message                                                            as FreshestErrorMessage,
      _FreshestError.MessageId                                                          as FreshestErrorMessageId,
      _FreshestError.MessageNumber                                                      as FreshestErrorMessageNumber,
      _FreshestError.CountErrors                                                        as CountErrors,
      0                                                                                 as InterfaceGrError,
      0                                                                                 as InterfaceTransferError,
      0                                                                                 as InterfaceGiError,
      0                                                                                 as TotalInterfaceError,
      0                                                                                 as TotalTimingAdjustment,
      0                                                                                 as EcomTotal,
      0                                                                                 as SortKey,
      _StockCorrectionHistory,
      _StockCorrectionErrors,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt                                                                         as CreatedAt,
      @Semantics.user.createdBy: true
      CreatedBy                                                                         as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      ChangedAt                                                                         as ChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      ChangedBy                                                                         as ChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt                                                                     as LastChangedAt,
      _ReasonForMovement
}
