/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ADAKHIKB     | 13.025.2023 | 21056: STO under delivery logging & Maint*
*              |            | DS4K951650                               *
*----------------------------------------------------------------------*
* KONRANAR     | 31.10.2023 | 26244 : HU CR 63689                      *
*              |            | DS4K968189                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Common UnderDelivery Process Elements'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZSD_I_STO_UnderDelivery_Common
  as select from ZSD_I_STO_UnderDeliveryProcLog as StoLog
    inner join   dd07t                          as StatusDomainText on  StatusDomainText.domname    = 'ZSD_STO_PROCESS_STATUS'
                                                                    and StatusDomainText.domvalue_l = StoLog.StatusStep
  composition [1..1] of ZSD_I_STO_UD_VirtualReturn     as _VirtualReturn
  composition [1..1] of ZSD_I_STO_UD_DownAdjustment    as _DownAdjustment
  composition [1..1] of ZSD_I_STO_UD_Refusal           as _Refusal

  association [1..1] to ZSD_I_STO_UnderDeliveryProcLog as _StoProcLog                  on  $projection.UnderDeliveredSto     = _StoProcLog.UnderDeliveredSto
                                                                                       and $projection.UnderDeliveredStoItem = _StoProcLog.UnderDeliveredStoItem
                                                                                       and $projection.DeliverNoteNumber     = _StoProcLog.UnderDeliveredDN
                                                                                       and $projection.DeliveryNoteItem      = _StoProcLog.UnderDeliveredDNItem

  association [1..1] to I_PurchaseOrderAPI01           as _VirtualReturnSto            on  $projection.VirtualReturnSto = _VirtualReturnSto.PurchaseOrder
  association [1..1] to I_PurchaseOrderItemAPI01       as _VirtualReturnStoItem        on  $projection.VirtualReturnSto      = _VirtualReturnStoItem.PurchaseOrder
                                                                                       and $projection.UnderDeliveredStoItem = _VirtualReturnStoItem.PurchaseOrderItem
  association [1..1] to I_StockTransportOrderShipping  as _VirtualReturnStoShipping    on  $projection.VirtualReturnSto      = _VirtualReturnStoShipping.PurchaseOrder
                                                                                       and $projection.UnderDeliveredStoItem = _VirtualReturnStoShipping.PurchaseOrderItem
  association [1..1] to I_DeliveryDocument             as _VirtualReturnStoDeliveryDoc on  $projection.VirtualGRInboundDelivery = _VirtualReturnStoDeliveryDoc.DeliveryDocument

  association [1..1] to I_MaterialDocumentHeader_2     as _GoodsReceiptMaterialDoc     on  $projection.StoGRMatDocVirtual     = _GoodsReceiptMaterialDoc.MaterialDocument
                                                                                       and $projection.StoGRMatDocYearVirtual = _GoodsReceiptMaterialDoc.MaterialDocumentYear
  association [1..1] to I_MaterialDocumentHeader_2     as _GoodsIssueMaterialDoc       on  $projection.StoGIMatDocVirtual     = _GoodsIssueMaterialDoc.MaterialDocument
                                                                                       and $projection.StoGIMatDocYearVirtual = _GoodsIssueMaterialDoc.MaterialDocumentYear
  association [1..1] to I_MaterialDocumentHeader_2     as _DownAdjustmentMaterialDoc   on  $projection.DownAdjustmentMatDoc     = _DownAdjustmentMaterialDoc.MaterialDocument
                                                                                       and $projection.DownAdjustmentMatDocYear = _DownAdjustmentMaterialDoc.MaterialDocumentYear

  association [1..1] to I_Plant                        as _ReceivingPlant              on  $projection.ReceivingPlant = _ReceivingPlant.Plant
                                                                                       and _ReceivingPlant.Language   = $session.system_language
  association [1..1] to I_Plant                        as _SupplyingPlant              on  $projection.SupplyingPlant = _SupplyingPlant.Plant
                                                                                       and _SupplyingPlant.Language   = $session.system_language
  association [1..1] to I_SalesOrganizationText        as _SalesOrgText                on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                                       and _SalesOrgText.Language        = $session.system_language
  association [0..*] to ZSD_I_STO_UD_Message           as _Messages                    on  $projection.UnderDeliveredSto     = _Messages.UnderDeliveredSto
                                                                                       and $projection.UnderDeliveredStoItem = _Messages.UnderDeliveredStoItem
                                                                                       and $projection.DeliverNoteNumber     = _Messages.UnderDeliveredDn 
                                                                                       and $projection.DeliveryNoteItem      = _Messages.UnderDeliveredDnItem
{


  key StoLog.UnderDeliveredSto,
  key StoLog.UnderDeliveredStoItem,
  key StoLog.UnderDeliveredDN                                  as DeliverNoteNumber,
  key StoLog.UnderDeliveredDNItem                              as DeliveryNoteItem,
  key StoLog.UnderDeliveredHU,
      StoLog.CreatedOn,
      StoLog.Process,
      case StoLog.Process
      when 'V' then 'Virtual'
      when 'D' then 'DownAdjustment'
      when 'R' then 'Refusal'
      else 'Unknown'end                                        as ProcessText,
      StoLog.StatusStep                                        as Step,
      @Semantics.text: true
      StatusDomainText.ddtext                                  as StepText,
      StoLog.QuantityShort                                     as ShortQuantity,
      StoLog.WaitingDaysFromGR, 
      StoLog.WaitingDaysFromGI, 
      StoLog.VirtualGRInboundDelivery,
      StoLog.VirtualGRMaterialDoc,
      StoLog.VirtualGRMaterialDocYear,
      StoLog.VirtualReturnSto,
      StoLog.VirtualOutboundDelivery                           as OutboundDeliveryVirtual,
      StoLog.VirtReturnStoGRMatDoc                             as StoGRMatDocVirtual,
      StoLog.VirtReturnStoGRMatDocYear                         as StoGRMatDocYearVirtual,
      StoLog.VirtReturnStoGIMatDoc                             as StoGIMatDocVirtual,
      StoLog.VirtReturnStoGIMatdocYear                         as StoGIMatDocYearVirtual,
      StoLog.DownAdjustmentMatDoc,
      StoLog.DownAdjustmentMatDocYear,
      StoLog.RefusalInboundDelivery,
      StoLog.ErrorMsgNo,
      StoLog.ErrorMsgText,

      StoLog._PurchaseOrder.PurchasingOrganization             as PurchaseOrganization,
      StoLog._PurchaseOrder.CompanyCode                        as CompanyCode,
      StoLog._PurchaseOrder.PurchasingGroup                    as PurchasingGroup,
      StoLog._PurchaseOrder.CreationDate                       as StoCreatedOn,
      StoLog._PurchaseOrder.CreatedByUser                      as StoCreatedBy,
      StoLog._PurchaseOrder.PurchaseOrderType                  as StoType,
      StoLog.SupplyingPlant,

      StoLog._PurchaseOrder.ZZ1_ZRSD_PDH                       as RequestedShelfDate,
      StoLog._PurchaseOrder.CorrespncExternalReference         as YourReference,
      StoLog._PurchaseOrder.CorrespncInternalReference         as OurReference,
      StoLog.SalesOrganization                                 as SalesOrganization,
      StoLog._STO_shipping.DistributionChannel                 as SalesChannel,
      StoLog._PurchaseOrderItem.Material                       as Article,
      StoLog._PurchaseOrderItem.PurchaseOrderItemText          as ArticleDescription,
      StoLog._PurchaseOrder.ZZ1_ZOrderReason_PDH               as OrderReason,
      StoLog.ReceivingPlant,

      StoLog._PurchaseOrderItem.StorageLocation                as StorageLocation,
      StoLog._PurchaseOrderItem.PurchaseOrderQuantityUnit      as POQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'POQuantityUnit'
      StoLog._PurchaseOrderItem.OrderQuantity                  as POQuantity,
      StoLog._PurchaseOrderItem.ZZ1_ABGRU_PDI                  as RejectionReason,
      StoLog._PurchaseOrderItem.SupplierConfirmationControlKey as ConfirmationControlKey,
      StoLog._PurchaseOrderItem.ZZ1_ZFSH_MG_AT_1_PDI           as ProductDivision,
      StoLog._DeliveryDocument.CreationDate                    as DNCreatedOn,
      StoLog._DeliveryDocument.CreatedByUser                   as DNCreatedBy,
      _VirtualReturnStoDeliveryDoc.CreationDate                as GRPostedOnVirtual,
      _VirtualReturnSto.PurchaseOrderType                      as StoTypeVirtualReturn,
      StoLog.SupplyingPlantVirtual,

      _VirtualReturnSto.ZZ1_ZRSD_PDH                           as RequestedShelfDateVirtReturn,
      _VirtualReturnSto.CorrespncExternalReference             as YourReferenceVirtualReturn,
      _VirtualReturnSto.CorrespncInternalReference             as OurReferenceVirtualReturn,
      _VirtualReturnStoItem.ZZ1_ABGRU_PDI                      as RejectionReasonVirtualReturn,
      _VirtualReturnStoItem.PurchasingOrderReason              as POReasonCode,
      _VirtualReturnStoItem.Plant                              as ReceivingPlantVirtual,
      _VirtualReturnStoItem.StorageLocation                    as StorageLocationVirtual,
      _VirtualReturnStoItem.SupplierConfirmationControlKey     as ConfirmationControlKeyVirtual,
      _VirtualReturnStoItem.ZZ1_ZFSH_MG_AT_1_PDI               as ProductDivisionVirtualReturn,
      _VirtualReturnStoShipping.ShippingPoint                  as ShippingPointVirtual,
      _VirtualReturnStoShipping.ShipToParty                    as CustomerVirtual,
      _VirtualReturnStoDeliveryDoc.DeliveryDocumentType        as DNTypeVirtual,
      _GoodsReceiptMaterialDoc.PostingDate                     as GoodsReceiptMatDocPostedOn,
      _GoodsIssueMaterialDoc.PostingDate                       as GoodsIssueMatDocPostedOn,
      _DownAdjustmentMaterialDoc.PostingDate                   as DownAdjustmentMatDocPostedOn,

      /*Texts*/
      _SupplyingPlant.PlantName                                as SupplyingPlantName,
      _ReceivingPlant.PlantName                                as ReceivingPlantName,
      _SalesOrgText.SalesOrganizationName                      as SalesOrganizationName,


      // Status
      case
      when StoLog.Process = 'V' and StoLog.StatusStep  = 'V70' and StoLog.ErrorMsgNo is initial then 'C'
      when StoLog.Process = 'V' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 'E'
      when StoLog.Process = 'V' and StoLog.StatusStep  < 'V70' then 'P'
      when StoLog.Process = 'D' and StoLog.StatusStep  = 'D30' and StoLog.ErrorMsgNo is initial then 'C'
      when StoLog.Process = 'D' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 'E'
      when StoLog.Process = 'D' and StoLog.StatusStep  < 'D30' then 'P'
      when StoLog.Process = 'R' and StoLog.StatusStep  = 'R60' and StoLog.ErrorMsgNo is initial then 'C'
      when StoLog.Process = 'R' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 'E'
      when StoLog.Process = 'R' and StoLog.StatusStep  < 'R60' then 'P'
      else 'E'
      end                                                      as Status,

      case
      when StoLog.Process = 'V' and StoLog.StatusStep  = 'V70' and StoLog.ErrorMsgNo is initial then 'Completed'
      when StoLog.Process = 'V' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 'Error'
      when StoLog.Process = 'V' and StoLog.StatusStep  < 'V70' then 'In Process'
      when StoLog.Process = 'D' and StoLog.StatusStep  = 'D30' and StoLog.ErrorMsgNo is initial then 'Completed'
      when StoLog.Process = 'D' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 'Error'
      when StoLog.Process = 'D' and StoLog.StatusStep  < 'D30' then 'In Process'
      when StoLog.Process = 'R' and StoLog.StatusStep  = 'R60' and StoLog.ErrorMsgNo is initial then 'Completed'
      when StoLog.Process = 'R' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 'Error'
      when StoLog.Process = 'R' and StoLog.StatusStep  < 'R60' then 'In Process'
      else 'Error'
      end                                                      as Statustext,
      case
      when StoLog.Process = 'V' and StoLog.StatusStep  = 'V70' and StoLog.ErrorMsgNo is initial then  3 --green
      when StoLog.Process = 'V' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 1 --red
      when StoLog.Process = 'V' and StoLog.StatusStep  < 'V70' then 2 --yellow
      when StoLog.Process = 'D' and StoLog.StatusStep  = 'D30' and StoLog.ErrorMsgNo is initial then 3 
      when StoLog.Process = 'D' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 1 
      when StoLog.Process = 'D' and StoLog.StatusStep  < 'D30' then 2 
      when StoLog.Process = 'R' and StoLog.StatusStep  = 'R60' and StoLog.ErrorMsgNo is initial then 3 
      when StoLog.Process = 'R' and StoLog.ErrorMsgNo is not initial or StoLog.ErrorMsgText is not initial then 1 
      when StoLog.Process = 'R' and StoLog.StatusStep  < 'R60' then 2 
      else 1
      end                                                      as StatusCriticality,


      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_STO_UD_ACTUAL_GR_CALC'
      @Semantics.quantity.unitOfMeasure: 'POQuantityUnit'
      cast(0 as menge_d )                                      as ActualGR,

      /* Associations */
      _StoProcLog,
      _VirtualReturn,
      _DownAdjustment,
      _Refusal,
      _SupplyingPlant,
      _ReceivingPlant,
      StoLog._DeliveryDocument,
      StoLog._PurchaseOrder,
      StoLog._PurchaseOrderItem,
      StoLog._STO_shipping,
      _Messages
}
