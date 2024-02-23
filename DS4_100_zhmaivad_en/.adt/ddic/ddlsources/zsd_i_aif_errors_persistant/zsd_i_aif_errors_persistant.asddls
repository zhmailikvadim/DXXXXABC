@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'AIF Errors from Persistant Tabe'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_aif_errors_persistant
  as select from zsc_t_pgrpr_item             as AifPersistentTable
    join         sdsls_bussys_idx             as _AifMessagesIndexTable on AifPersistentTable.msgguid = _AifMessagesIndexTable.msgguid
    join         zsd_i_get_max_aif_log_number as MaxAifLogNumber        on _AifMessagesIndexTable.lognumber = MaxAifLogNumber.MaxLogNumber
  association to I_DeliveryDocumentItem as _DeliveryDocumentItem on  AifPersistentTable.delivery     = _DeliveryDocumentItem.DeliveryDocument
                                                                 and AifPersistentTable.deliveryitem = _DeliveryDocumentItem.DeliveryDocumentItem
  association to I_DeliveryDocument     as _DeliveryDocument     on  AifPersistentTable.delivery = _DeliveryDocument.DeliveryDocument


{
  key cast(_DeliveryDocumentItem.Product as matnr preserving type ) as Product,
  key AifPersistentTable.msgguid                                    as Msgguid,
  key AifPersistentTable.version                                    as Version,
  key AifPersistentTable.counter                                    as Counter,
  key AifPersistentTable.ns                                         as Ns,
  key AifPersistentTable.ifname                                     as Ifname,
  key AifPersistentTable.ifver                                      as Ifver,
      _AifMessagesIndexTable.status,
      _DeliveryDocument.ShippingPoint,
      AifPersistentTable.parent_id                                  as ParentId,
      AifPersistentTable.delivery                                   as Delivery,
      AifPersistentTable.deliveryitem                               as Deliveryitem,
      AifPersistentTable.plant                                      as Plant,
      _DeliveryDocumentItem.DeliveryQuantityUnit,
      @Semantics.quantity.unitOfMeasure : 'DeliveryQuantityUnit'
      AifPersistentTable.quantity_su                                as QuantitySu,
      AifPersistentTable.purchaseorder                              as Purchaseorder,
      AifPersistentTable.purchaseorderite                           as Purchaseorderite,
      AifPersistentTable.wms_date                                   as WmsDate,
      AifPersistentTable.wms_time                                   as WmsTime,
      AifPersistentTable.transaction_numb                           as TransactionNumb,
      _DeliveryDocumentItem,
      _DeliveryDocumentItem._DeliveryQuantityUnit,
      _DeliveryDocument._ShippingPoint
}
where
      _AifMessagesIndexTable.status <> 'S'
  and _AifMessagesIndexTable.status <> 'W'
