/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Difference report - basic CDS'
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity zsd_i_stock_dif_report_bw_base
  as select from zsd_i_bw_mock_col_typ

  association        to makt                           as _ArticleTexts                on  $projection.Article = _ArticleTexts.matnr
                                                                                       and _ArticleTexts.spras = $session.system_language
  association        to mara                           as _Mara                        on  $projection.Article = _Mara.matnr
  association        to zsd_i_article_valuation        as _ArticleValuation            on  $projection.Article             = _ArticleValuation.Article
                                                                                       and $projection.Plant               = _ArticleValuation.ValuationArea
                                                                                       and _ArticleValuation.ValuationType = ''
  association        to t001                           as _CompanyCodes                on  $projection.Plant = _CompanyCodes.bukrs
  association        to zsd_i_stock_corr_calc_for_diff as _StockCorrectionCalc         on  $projection.Plant            = _StockCorrectionCalc.Plant
                                                                                       and $projection.StorageLocation  = _StockCorrectionCalc.StorageLocation
                                                                                       and $projection.Article          = _StockCorrectionCalc.Article
                                                                                       and $projection.SalesOrderNumber = _StockCorrectionCalc.SalesOrderNumber
                                                                                       and $projection.SalesOrderItem   = _StockCorrectionCalc.SalesOrderItem
                                                                                       and $projection.WmsSnapshotDate  = _StockCorrectionCalc.WmsSnapshotDate
  //and $projection.StockType        = _StockCorrection.StockType
  //                                                                                   and $projection.BwSnapshotDate   = _StockCorrection.WmsSnapshotDate

  association [1..*] to zsd_i_idoc_errors              as _IdocErrors                  on  $projection.Article = _IdocErrors.Article
  association [1..*] to zsd_i_aif_err_return_orders    as _ReturnOrdersAIFErrors       on  $projection.Article = _ReturnOrdersAIFErrors.Article
  association [1..*] to zsd_i_aif_err_gr_and_invpost   as _AifInventPostErrorsMessages on  $projection.Article = _AifInventPostErrorsMessages.Article

  association [1..*] to zsd_i_sap_snapshot             as _HistorySapSnapShot          on  $projection.Article          = _HistorySapSnapShot.Article
                                                                                       and $projection.Plant            = _HistorySapSnapShot.Plant
                                                                                       and $projection.StorageLocation  = _HistorySapSnapShot.StorageLocation
                                                                                       and $projection.SalesOrderNumber = _HistorySapSnapShot.SalesOrderNumber
                                                                                       and $projection.SalesOrderItem   = _HistorySapSnapShot.SalesOrderItem
  association        to zsd_i_actual_picked_stock      as _ActualPickedStock           on  $projection.SalesOrderNumber = _ActualPickedStock.OrderNumber
                                                                                       and $projection.SalesOrderItem   = _ActualPickedStock.OrderItemNumber
{
  key WmsSnapshotDate,
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus                         as CountOpenStatuses,
      _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus                     as CountCompleteStatuses,

      _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus /
      _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus * 100                   as PercentStatusComplete,

      case  when _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus is null
            and _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus > 0
      then 'COMPLETE'
      when _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus <>
                case when _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus is null
                    then 0
                    else _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus end
           and _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus > 0
      then 'OPEN' else '' end                                                     as Status,

      case  when _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus is null
            and _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus > 0
      then 3
      when _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus <>
                case when _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus is null
                    then 0
                    else _StockCorrectionCalc[1:Status = 'COMPLETE'].CountStatus end
           and _StockCorrectionCalc[1:Status = 'OPEN'].CountStatus > 0
      then 2 else 0 end                                                           as StatusCriticality,

      SapTimestamp,
      cast( substring(cast( SapTimestamp as abap.char( 23 ) ),9,6) as abap.tims ) as SapStampTime,
      UnrectrictedSapStockQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      _ActualPickedStock.StockQuantity                                            as ActualPickedStock,
      InQualityInspSapStockQuantity,
      BlockedSapStockQuantity,
      WmsTimeStamp,
      cast( substring(cast( WmsTimeStamp as abap.char( 23 ) ),9,6) as abap.tims ) as WmsStampTime,
      UnrectrictedWmsStockQuantity,
      InQualityInspWmsStockQuantity,
      BlockedWmsStockQuantity,
      Meins,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity                 as UnrectrictedDifferenceQty,
      case
      when UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity <> 0
      then 2 else 0 end                                                           as UnrectrictedDifferenceCritical,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity               as InQualityInspDifferenceQty,
      case
      when InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity <> 0
      then 2 else 0 end                                                           as InQualityInspDifferenceCritica,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      BlockedWmsStockQuantity - BlockedSapStockQuantity                           as BlockedDifferenceQty,
      case
      when BlockedWmsStockQuantity - BlockedSapStockQuantity <> 0
      then 2 else 0 end                                                           as BlockedDifferenceCriticality,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity +
      InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity +
      BlockedWmsStockQuantity - BlockedSapStockQuantity                           as DifferenceQty,
      case
      when
      UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity +
      InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity +
      BlockedWmsStockQuantity - BlockedSapStockQuantity <> 0
      then 1 else 0 end                                                           as DifferenceCriticality,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast( ( UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity )
       * cast( _ArticleValuation.Price as abap.dec( 15, 2 ) )
       as abap.curr( 10, 2 ) )                                                    as UnrectrictedDifferenceValue,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast( ( InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity )
       * cast( _ArticleValuation.Price as abap.dec( 15, 2 ) )
       as abap.curr( 10, 2 ) )                                                    as InQualityInspDifferenceValue,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast( ( BlockedWmsStockQuantity - BlockedSapStockQuantity )
       * cast( _ArticleValuation.Price as abap.dec( 15, 2 ) )
       as abap.curr( 10, 2 ) )                                                    as BlockedDifferenceValue,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast( ( UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity +
              InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity +
              BlockedWmsStockQuantity - BlockedSapStockQuantity )
      * cast( _ArticleValuation.Price as abap.dec( 15, 2 ) )
      as abap.curr( 10, 2 ) )                                                     as DifferenceValue,
      _ArticleTexts.maktx                                                         as ArticleDescription,
      _Mara.mtart                                                                 as MaterialType,
      _Mara.matkl                                                                 as ArticleGroup,
      _Mara.satnr                                                                 as GenericArticle,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      _ArticleValuation.Price                                                     as Price,
      case
        when _CompanyCodes[1: spras = $session.system_language ].waers is null
        then cast ('EUR' as abap.cuky)
        else  _CompanyCodes[1: spras = $session.system_language ].waers
        end                                                                       as CurrencyCode,

      case
      when ( UnrectrictedWmsStockQuantity - UnrectrictedSapStockQuantity = 0 )
           and ( InQualityInspWmsStockQuantity - InQualityInspSapStockQuantity = 0 )
            and (BlockedWmsStockQuantity - BlockedSapStockQuantity = 0)
            then cast( ''  as boolean preserving type ) else
            cast( 'X'  as boolean preserving type ) end                           as DisplayOnlyDiffOrViceVersa,
      cast(_Mara.matnr as matnr preserving type )                                 as ArticleForSearch,
      case when SalesOrderNumber = ''
                  then cast( ''  as boolean preserving type ) else
                  cast( 'X'  as boolean preserving type ) end                     as DisplayOnlySOrdersOrViceVersa,

      '0'                                                                         as InterfaceGRError,
      '0'                                                                         as InterfaceTransferError,
      '0'                                                                         as InterfaceGIError,
      '0'                                                                         as TotalInterfaceError,
      '0'                                                                         as TotalTimingAdjustment,
      '0'                                                                         as ECOMtotal,
      '0'                                                                         as TimingAdjustment1,
      '0'                                                                         as TimingAdjustment2,
      '0'                                                                         as ECOMTimingAdjustment,
      '0'                                                                         as ECOMInterfaceGItoCustomerInEr,
      '0'                                                                         as ECOMIntCustomerReturnsInEr,
      '0'                                                                         as ECOMonWay,
      '0'                                                                         as UnrestrictedStockErrors,
      '0'                                                                         as InQualityStockErrors,
      '0'                                                                         as BlockedStockErrors,
      _IdocErrors,
      _ReturnOrdersAIFErrors,
      _AifInventPostErrorsMessages,
      _HistorySapSnapShot
}
