/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 09.10.2023 | 25663     : [Build] Outbound Delivery Stat *
*              |            | DS4K965942                              *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view for Outb Deliv Status HU rep'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_I_OUTDELV_STAT_HU
  as select from I_DeliveryDocument
  association [0..1] to ZSD_I_RP_LEDSPD_FLOW    as _ParentDN            on  $projection.OutboundDelivery     = _ParentDN.vbeln_new
                                                                        and $projection.DeliveryDocumentItem = _ParentDN.posnr_new
  association [0..*] to I_HandlingUnitHeader    as _HandlingUnit        on  $projection.OutboundDelivery = _HandlingUnit.HandlingUnitPackingObjectKey
  association [0..1] to I_HandlingUnitItem      as _HandlingUnitItem    on  $projection.HandlingUnit           = _HandlingUnitItem.HandlingUnitInternalID
                                                                        and _HandlingUnitItem.HandlingUnitItem = '000001'
  association [0..1] to ZSD_I_OUTDELV_HU_STATUS as _HandlingUnitStatus  on  $projection.HandlingUnit = _HandlingUnitStatus.HandlingUnit
  association [0..1] to I_ProductText           as _ProductText         on  $projection.Material  = _ProductText.Product
                                                                        and _ProductText.Language = $session.system_language
  association [0..1] to P_SAFTCommodityCode     as _CommunityCode       on  $projection.Material = _CommunityCode.ProductID
                                                                        and $projection.Plant    = _CommunityCode.werks
  association [0..1] to ZSD_I_RP_J_3RFGTD       as _CustomerDeclaration on  $projection.PurchaseOrder = _CustomerDeclaration.ordernum
                                                                        and $projection.Material      = _CustomerDeclaration.matnr
  association [0..1] to zsd_i_Invoice_for_order as _Invoicedet          on  $projection.OutboundDelivery     = _Invoicedet.DeliveryNumber
                                                                        and $projection.DeliveryDocumentItem = _Invoicedet.DeliveryItemNumber
{
  key DeliveryDocument                                                            as OutboundDelivery,
  key _Item.DeliveryDocumentItem                                                  as DeliveryDocumentItem,
  key _HandlingUnit[inner].HandlingUnitInternalID                                 as HandlingUnit,
      DeliveryDocumentType                                                        as DeliveryDocumentType,
      CreationDate                                                                as DeliveryNoteCreatedOn,
      CreatedByUser                                                               as DeliveryNoteCreatedBy,
      Handle                                                                      as DeliveryHandle,
      DeliveryDate                                                                as DeliveryDate,
      SalesOrganization                                                           as SalesOrganization,
      _SalesOrganization.
      _Text[1:Language=$session.system_language].SalesOrganizationName            as SalesOrganizationName,
      SoldToParty                                                                 as SoldToParty,
      _SoldToParty.CustomerName                                                   as SoldToPartyName,
      ShipToParty                                                                 as ShipToParty,
      _ShipToParty.CustomerName                                                   as ShipToPartyName,
      ShippingPoint                                                               as ShippingPoint,
      _ShippingPoint._Text[1:Language=$session.system_language].ShippingPointName as ShippingPointName,
      ZZ1_SEQ_NO_DLH                                                              as SequenceNumber,
      @Semantics.amount.currencyCode: 'NetValueCurrency'
      TotalNetAmount                                                              as NetValue,
      TransactionCurrency                                                         as NetValueCurrency,
      cast('' as abap.char( 20 ))                                                 as OverallDelvstatusHU,
      cast('0' as int1)                                                           as OverallDelvstatuscriticalityHU,
      _Item.SalesOffice                                                           as SalesOffice,
      _Item.StorageLocation                                                       as StorageLocation,
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      _Item.ActualDeliveryQuantity                                                as DeliveryQuantity,
      _Item.DeliveryQuantityUnit                                                  as DeliveryQuantityUnit,
      _Item.InternationalArticleNumber                                            as EANUPC,
      _Item.Material                                                              as Material,
      _Item.Plant                                                                 as Plant,
      _Item._Plant[1:Language=$session.system_language].PlantName                 as PlantName,
      _Item.DistributionChannel                                                   as DistributionChannel,
      _Item._DistributionChannel.
      _Text[1:Language=$session.system_language].DistributionChannelName          as DistributionChannelName,
      _Item.Division                                                              as Division,
      _Item._Division._Text[1:Language=$session.system_language].DivisionName     as DivisionName,
      _Item._ReferenceSDDocument.SalesDocument                                    as SalesOrder,
      _Item._ReferenceSDDocument.SalesDocumentType                                as SalesDocumentType,
      _Item._ReferenceSDDocument._SalesDocumentType.
      _Text[1:Language=$session.system_language].SalesDocumentTypeName            as SalesDocumentTypeName,
      @Semantics.amount.currencyCode: 'SODocumentCurrency'
      _Item._ReferenceSDDocument.TotalNetAmount                                   as NetValueSO,
      _Item._ReferenceSDDocument.TransactionCurrency                              as SODocumentCurrency,
      _Item._ReferenceSDDocument.PurchaseOrderByCustomer                          as CustomerPurchaseOrderNo,
      _Item._PurchaseOrder.PurchaseOrder                                          as PurchaseOrder,
      _Item._PurchaseOrder.ZZ1_ZSALES_CHANNEL_PDH                                 as SalesChannel,
      _Item._PurchaseOrderItem.ZZ1_ZFSH_MG_AT_1_PDI                               as ProductDivision,
      _HandlingUnit[inner].HandlingUnitExternalID                                 as HUIdentification,
      _HandlingUnit[inner].HandlingUnitSecondExternalId                           as HUIdentification2,
      _HandlingUnit[inner].PackagingMaterial                                      as PackagingMaterial,
      @Semantics.quantity.unitOfMeasure: 'VolumeUnit'
      _HandlingUnit[inner].GrossVolume                                            as GrossVolume,
      @Semantics.quantity.unitOfMeasure: 'VolumeUnit'
      _HandlingUnit[inner].HandlingUnitNetVolume                                  as NetVolume,
      _HandlingUnit[inner].VolumeUnit                                             as VolumeUnit,
      _HandlingUnit[inner].zzalternativeHU                                        as AlternativeHUIdentification,
      _ParentDN,
      _HandlingUnitStatus,
      _HandlingUnitItem,
      _ProductText,
      _CommunityCode,
      _CustomerDeclaration,
      _Invoicedet
}
