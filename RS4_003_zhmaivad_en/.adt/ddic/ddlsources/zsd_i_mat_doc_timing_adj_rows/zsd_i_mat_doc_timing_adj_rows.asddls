/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 06.12.2022 | 13444     : [Build] - Stock reconciliation with WMS *
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
@EndUserText.label: 'Material Document Items Timing Adj Rows'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_mat_doc_timing_adj_rows
  as select from zsd_i_material_documents_items
{
  key       MaterialDocument,
  key       MaterialDocumentItem,
  key       MaterialDocumentYear,
  key       DocumentDate,
  key       Material                                     as Article,
  key       Plant,
  key       StorageLocation,
  key       SalesOrder                                   as SalesOrderNumber,
  key       SalesOrderItem,
            StockType,
            @Semantics.quantity.unitOfMeasure : 'EntryUnit'
            case when ( WmsDocCreationTimeStamp < WmsTimeStamp
            and SapDocCreationTimeStamp > SapTimeStamp )
            then  AdjustmentQty else - AdjustmentQty end as TimingAdjustment,
            SapTimeStamp,
            WmsTimeStamp,
            WmsDocCreationTimeStamp,
            SapDocCreationTimeStamp,
            GoodsMovementType,
            DebitCreditCode,
            QuantityInBaseUnit,
            MaterialBaseUnit,
            QuantityInEntryUnit,
            EntryUnit,
            PostingDate,
            SapDocCreationDate,
            SapDocCreationTime,
            CreatedByUser,
            WmsDocCreationDate,
            WmsDocCreationTime,
            CompanyCodeCurrency,
            PurchaseOrder,
            PurchaseOrderItem,
            OrderItem,
            DeliveryDocument,
            DeliveryDocumentItem,
            CompanyCode,
            IssgOrRcvgMaterial,
            IssuingOrReceivingPlant,
            IssuingOrReceivingStorageLoc,
            ReceivingSalesOrder,
            ReceivingSalesOrderItem,
            /* Associations */
            _MaterialDocumentHeader,
            _MaterialDocumentYear
}
where
  (
        WmsDocCreationTimeStamp < WmsTimeStamp
    and SapDocCreationTimeStamp > SapTimeStamp
  )
  or(
        WmsDocCreationTimeStamp > WmsTimeStamp
    and SapDocCreationTimeStamp < SapTimeStamp
  )
