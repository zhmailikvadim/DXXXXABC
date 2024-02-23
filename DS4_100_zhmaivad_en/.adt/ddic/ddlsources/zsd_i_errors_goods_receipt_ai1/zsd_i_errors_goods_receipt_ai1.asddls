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

define view entity ZSD_I_ERRORS_GOODS_RECEIPT_AI1
  as select from zsc_t_pgrpr_item             as AifPersistentTable
    join         sdsls_bussys_idx             as AifMessagesIndexTable  on AifPersistentTable.msgguid = AifMessagesIndexTable.msgguid
    join         zsd_i_get_max_aif_log_number as MaxAifLogNumber        on  AifMessagesIndexTable.lognumber = MaxAifLogNumber.MaxLogNumber
                                                                        and AifPersistentTable.plant        = MaxAifLogNumber.plant
                                                                        and AifPersistentTable.delivery     = MaxAifLogNumber.delivery
                                                                        and AifPersistentTable.deliveryitem = MaxAifLogNumber.deliveryitem
    join         I_DeliveryDocumentItem       as DeliveryDocumentItem   on  MaxAifLogNumber.delivery     = DeliveryDocumentItem.DeliveryDocument
                                                                        and MaxAifLogNumber.deliveryitem = DeliveryDocumentItem.DeliveryDocumentItem
    join         I_PurchasingDocumentItem     as PurchasingDocumentItem on  DeliveryDocumentItem.PurchaseOrder     = DeliveryDocumentItem.PurchaseOrder
                                                                        and DeliveryDocumentItem.PurchaseOrderItem = DeliveryDocumentItem.PurchaseOrderItem
{
  key                   AifPersistentTable.msgguid           as MessageGuid,
  key                   rtrim(AifPersistentTable.plant ,'' ) as Plant,
  key                   AifPersistentTable.wms_date          as WmsDate,
  key                   AifPersistentTable.delivery          as Delivery,
  key                   AifPersistentTable.deliveryitem      as Deliveryitem,
                        AifPersistentTable.wms_time          as WmsTime,
                        AifPersistentTable.version           as PersistTableVersion,
                        AifPersistentTable.counter           as PersistTableCounter,
                        AifPersistentTable.ns                as AifNameSpace,
                        AifPersistentTable.ifname            as AifInterfaceName,
                        AifPersistentTable.ifver             as AifInterfaceVersion,
                        AifMessagesIndexTable.status,
                        AifPersistentTable.parent_id         as ParentId,
                        AifPersistentTable.purchaseorder     as PurchaseorderOrig,
                        AifPersistentTable.purchaseorderite  as PurchaseorderItemOrig,
                        AifMessagesIndexTable.lognumber
}
where
  AifMessagesIndexTable.status = 'E'
