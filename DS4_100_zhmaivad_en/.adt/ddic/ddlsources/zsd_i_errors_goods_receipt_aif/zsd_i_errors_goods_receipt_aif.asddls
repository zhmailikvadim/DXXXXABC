/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.12.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | FB_16311_SD_[Feature] [Build] - Stock reconciliation *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.04.2023 | 19610     : FB_19610_SD_Feature - DEFECT - Stock Reconciliation *
*              |            | DS4K949060                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 29.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'AIF Errors from Persistent Tabe'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define view entity zsd_i_errors_goods_receipt_aif
  as select from zsc_t_pgrpr_item             as AifPersistentTable
    join         sdsls_bussys_idx             as AifMessagesIndexTable  on AifPersistentTable.msgguid = AifMessagesIndexTable.msgguid
    join         zsd_i_get_max_aif_log_number as MaxAifLogNumber        on  AifMessagesIndexTable.lognumber     = MaxAifLogNumber.MaxLogNumber
                                                                        and AifPersistentTable.plant            = MaxAifLogNumber.plant
                                                                        and AifPersistentTable.delivery         = MaxAifLogNumber.delivery
                                                                        and AifPersistentTable.deliveryitem     = MaxAifLogNumber.deliveryitem
                                                                        and AifPersistentTable.transaction_numb = MaxAifLogNumber.transaction_numb
    join         I_DeliveryDocumentItem       as DeliveryDocumentItem   on  MaxAifLogNumber.delivery     = DeliveryDocumentItem.DeliveryDocument
                                                                        and MaxAifLogNumber.deliveryitem = DeliveryDocumentItem.DeliveryDocumentItem
    join         I_PurchasingDocumentItem     as PurchasingDocumentItem on  PurchasingDocumentItem.PurchasingDocument     = DeliveryDocumentItem.PurchaseOrder
                                                                        and PurchasingDocumentItem.PurchasingDocumentItem = DeliveryDocumentItem.PurchaseOrderItem
{
  key                            AifPersistentTable.msgguid                                                                              as MessageGuid,
  key                            AifPersistentTable.version,
  key                            AifPersistentTable.counter                                                                              as PersistTableCounter,
  key                            AifPersistentTable.ns                                                                                   as AifNameSpace,
  key                            AifPersistentTable.ifname                                                                               as AifInterfaceName,
  key                            AifPersistentTable.ifver                                                                                as AifInterfaceVersion,
                                 rtrim(AifPersistentTable.plant ,'' )                                                                    as Plant,
                                 cast(DeliveryDocumentItem.Product as matnr preserving type )                                            as Product,
                                 case when  PurchasingDocumentItem.StockType = 'x' or
                                              PurchasingDocumentItem.StockType = 'X' or
                                              PurchasingDocumentItem.StockType = 's' or
                                              PurchasingDocumentItem.StockType = 'S' then  PurchasingDocumentItem.StockType else ''  end as StockType,
                                 AifPersistentTable.wms_date                                                                             as WmsDate,
                                 AifPersistentTable.delivery                                                                             as Delivery,
                                 AifPersistentTable.deliveryitem                                                                         as Deliveryitem,
                                 replace_regexpr(pcre => '[^XxSs]',
                                 value => PurchasingDocumentItem.StockType, with => '',result_length => 1  )                             as StockTypeRegex,
                                 AifPersistentTable.wms_time                                                                             as WmsTime,
                                 AifPersistentTable.version                                                                              as PersistTableVersion,
                                 AifMessagesIndexTable.status,
                                 AifPersistentTable.parent_id                                                                            as ParentId,
                                 DeliveryDocumentItem.DeliveryQuantityUnit,
                                 @Semantics.quantity.unitOfMeasure : 'DeliveryQuantityUnit'
                                 AifPersistentTable.quantity_su                                                                          as Quantity,
                                 AifPersistentTable.purchaseorder                                                                        as PurchaseorderOrig,
                                 AifPersistentTable.purchaseorderite                                                                     as PurchaseorderItemOrig,
                                 DeliveryDocumentItem.PurchaseOrder                                                                      as Purchaseorder,
                                 DeliveryDocumentItem.PurchaseOrderItem                                                                  as PurchaseorderItem,
                                 AifPersistentTable.transaction_numb                                                                     as TransactionNumber,
                                 DeliveryDocumentItem._DeliveryQuantityUnit,
                                 AifMessagesIndexTable.lognumber
}
where
  AifMessagesIndexTable.status = 'E'
