/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*
" ZHMAIVAD     | 21.07.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Documents Items'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity zsd_i_material_documents_items
  as select from I_MaterialDocumentItem_2
  association to matdoc                         as _MaterialDocuments on  $projection.MaterialDocument     = _MaterialDocuments.mblnr
                                                                      and $projection.MaterialDocumentYear = _MaterialDocuments.mjahr
                                                                      and $projection.MaterialDocumentItem = _MaterialDocuments.zeile
  association to zsd_i_move_types_rows_transfer as _MoveTypes         on  $projection.GoodsMovementType = _MoveTypes.MoveType
  association to zsd_i_bw_or_sap_snapshot       as _BwSnapshot        on  $projection.Material        = _BwSnapshot.Article
                                                                      and $projection.Plant           = _BwSnapshot.Plant
                                                                      and $projection.StorageLocation = _BwSnapshot.StorageLocation
                                                                      and $projection.SalesOrder      = _BwSnapshot.SalesOrderNumber
                                                                      and $projection.SalesOrderItem  = _BwSnapshot.SalesOrderItem
                                                                      and $projection.DocumentDate    = _BwSnapshot.WmsSnapshotDate
{
  key         DocumentDate,
  key         Material,
  key         Plant,
  key         StorageLocation,
  key         SalesOrder,
  key         SalesOrderItem,
  key         MaterialDocumentYear,
  key         MaterialDocument,
  key         MaterialDocumentItem,
  key         case when  coalesce(_MoveTypes.StockType, '' ) = '' then
                                 case when  InventoryUsabilityCode = 'F' or InventoryUsabilityCode = '' then 'UU'
                                      when  InventoryUsabilityCode = 'S' or InventoryUsabilityCode = '3' then 'BL'
                                      when  InventoryUsabilityCode = 'X' or InventoryUsabilityCode = '2' then 'QI'
                                      else '' end else _MoveTypes.StockType end              as StockType,

              @Semantics.quantity.unitOfMeasure : 'EntryUnit'
              case when _MoveTypes.Reverse = 'X' then 1 else -1 end *
                   case when _MoveTypes.MoveGroupIsTransfer = 'X' then -1 else 1 end *
                    case
                        when DebitCreditCode = 'S' then QuantityInBaseUnit
                        else  - QuantityInBaseUnit end                                       as AdjustmentQty,
              _MoveTypes.Reverse,
              _BwSnapshot.WmsTimeStamp,
              _BwSnapshot.SapTimeStamp,
              dats_tims_to_tstmp( _MaterialDocuments.zz1_wmsdate_mmi,
                   _MaterialDocuments.zz1_wmstime_mmi,
                   abap_system_timezone( $session.client,'NULL' ), $session.client, 'NULL' ) as WmsDocCreationTimeStamp,

              dats_tims_to_tstmp( _MaterialDocumentHeader.CreationDate,
                   _MaterialDocumentHeader.CreationTime,
                   abap_system_timezone( $session.client,'NULL' ), $session.client, 'NULL' ) as SapDocCreationTimeStamp,

              GoodsMovementType,
              DebitCreditCode,
              QuantityInBaseUnit,
              MaterialBaseUnit,
              QuantityInEntryUnit,
              EntryUnit,
              PostingDate,
              _MaterialDocumentHeader.CreationDate                                           as SapDocCreationDate,
              _MaterialDocumentHeader.CreationTime                                           as SapDocCreationTime,
              _MaterialDocumentHeader.CreatedByUser,
              _MaterialDocuments.zz1_wmsdate_mmi                                             as WmsDocCreationDate,
              _MaterialDocuments.zz1_wmstime_mmi                                             as WmsDocCreationTime,
              CompanyCodeCurrency,
              PurchaseOrder,
              PurchaseOrderItem,
              OrderItem,
              DeliveryDocument,
              DeliveryDocumentItem,
              CompanyCode,
              _MaterialDocumentYear,
              _MaterialDocumentHeader,
              IssgOrRcvgMaterial,
              IssuingOrReceivingPlant,
              IssuingOrReceivingStorageLoc,
              IssgOrRcvgBatch,
              IssgOrRcvgSpclStockInd,
              _MaterialDocuments.mat_kdauf                                                   as ReceivingSalesOrder,
              _MaterialDocuments.mat_kdpos                                                   as ReceivingSalesOrderItem

}
where
      _MaterialDocuments.zz1_wmsdate_mmi > '00000000'
  and IsAutomaticallyCreated             = ''
