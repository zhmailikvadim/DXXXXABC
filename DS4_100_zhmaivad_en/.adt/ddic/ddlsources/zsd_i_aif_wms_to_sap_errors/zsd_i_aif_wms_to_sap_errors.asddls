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

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity zsd_i_aif_wms_to_sap_errors
  as select from zsc_t_pgrpr_item             as AifPersistentTable
    join         sdsls_bussys_idx             as _AifMessagesIndexTable on AifPersistentTable.msgguid = _AifMessagesIndexTable.msgguid
    join         zsd_i_get_max_aif_log_number as MaxAifLogNumber        on _AifMessagesIndexTable.lognumber = MaxAifLogNumber.MaxLogNumber
  association to I_SDDocumentMultiLevelProcFlow as _SDDocumentMultiLevelProcFlow on  _SDDocumentMultiLevelProcFlow.SubsequentDocument        = AifPersistentTable.delivery
                                                                                 and _SDDocumentMultiLevelProcFlow.SubsequentDocumentItem    = AifPersistentTable.deliveryitem
                                                                                 and _SDDocumentMultiLevelProcFlow.PrecedingDocumentCategory = 'C'
  association to I_DeliveryDocumentItem         as _DeliveryDocumentItem         on  AifPersistentTable.delivery     = _DeliveryDocumentItem.DeliveryDocument
                                                                                 and AifPersistentTable.deliveryitem = _DeliveryDocumentItem.DeliveryDocumentItem
  association to I_DeliveryDocument             as _DeliveryDocument             on  AifPersistentTable.delivery = _DeliveryDocument.DeliveryDocument

{
  key              cast(_DeliveryDocumentItem.Product as matnr preserving type ) as Product,
  key              AifPersistentTable.plant                                      as Plant,
  key              AifPersistentTable.delivery                                   as Delivery,
  key              AifPersistentTable.deliveryitem                               as Deliveryitem,
  key              AifPersistentTable.wms_date                                   as WmsDate,
  key              _SDDocumentMultiLevelProcFlow.PrecedingDocument               as SalesOrder,
  key              _SDDocumentMultiLevelProcFlow.PrecedingDocument               as SalesOrderItem,
                   AifPersistentTable.wms_time                                   as WmsTime,
                   AifPersistentTable.msgguid                                    as MessageGuid,
                   AifPersistentTable.version                                    as PersistTableVersion,
                   AifPersistentTable.counter                                    as PersistTableCounter,
                   AifPersistentTable.ns                                         as AifNameSpace,
                   AifPersistentTable.ifname                                     as AifInterfaceName,
                   AifPersistentTable.ifver                                      as AifInterfaceVersion,
                   _AifMessagesIndexTable.status,
                   _DeliveryDocument.ShippingPoint,
                   AifPersistentTable.parent_id                                  as ParentId,
                   _DeliveryDocumentItem.DeliveryQuantityUnit,
                   @Semantics.quantity.unitOfMeasure : 'DeliveryQuantityUnit'
                   AifPersistentTable.quantity_su                                as Quantity,
                   AifPersistentTable.purchaseorder                              as Purchaseorder,
                   AifPersistentTable.purchaseorderite                           as PurchaseorderItem,
                   AifPersistentTable.transaction_numb                           as TransactionNumber,
                   _DeliveryDocumentItem,
                   _DeliveryDocumentItem._DeliveryQuantityUnit,
                   _DeliveryDocument._ShippingPoint
}
