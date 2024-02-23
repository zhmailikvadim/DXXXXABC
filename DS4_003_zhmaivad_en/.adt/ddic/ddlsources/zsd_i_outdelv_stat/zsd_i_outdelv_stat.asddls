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
@EndUserText.label: 'Basic view for Outbound delv status rep'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_I_OUTDELV_STAT
  as select from I_DeliveryDocument
  association [0..1] to zsd_i_Invoice_for_order      as _Invoicedet          on  $projection.OutboundDelivery     = _Invoicedet.DeliveryNumber
                                                                             and $projection.DeliveryDocumentItem = _Invoicedet.DeliveryItemNumber
  association [0..1] to ZSD_I_RP_LEDSPD_FLOW         as _ParentDN            on  $projection.OutboundDelivery     = _ParentDN.vbeln_new
                                                                             and $projection.DeliveryDocumentItem = _ParentDN.posnr_new
  association [0..1] to ZSD_I_RP_J_3RFGTD            as _CustomerDeclaration on  $projection.PurchaseOrder = _CustomerDeclaration.ordernum
                                                                             and $projection.Material      = _CustomerDeclaration.matnr
  association [0..1] to I_SalesDocumentScheduleLine  as _SalesdocSch         on  $projection.SalesOrder        = _SalesdocSch.SalesDocument
                                                                             and $projection.SalesDocumentItem = _SalesdocSch.SalesDocumentItem
                                                                             and _SalesdocSch.ScheduleLine     = '0001'
  association [0..1] to I_BillingBlockReason         as _BillingBlock        on  $projection.BillingBlock = _BillingBlock.BillingBlockReason
  association [0..1] to I_ProductText                as _ProductText         on  $projection.Material  = _ProductText.Product
                                                                             and _ProductText.Language = $session.system_language
  association [0..1] to ZSD_I_PICKQUAN_DELV          as _PickQuantity        on  $projection.OutboundDelivery     = _PickQuantity.DeliveryDocument
                                                                             and $projection.DeliveryDocumentItem = _PickQuantity.DeliveryDocumentItem
  association [0..1] to P_SAFTCommodityCode          as _CommunityCode       on  $projection.Material = _CommunityCode.ProductID
                                                                             and $projection.Plant    = _CommunityCode.werks
  association [0..1] to ZSD_I_MVKE_SEAS              as _ArticleSeason       on  $projection.Material            = _ArticleSeason.Matnr
                                                                             and $projection.SalesOrganization   = _ArticleSeason.Vkorg
                                                                             and $projection.DistributionChannel = _ArticleSeason.Vtweg
                                                                             and $projection.ProductSeason       = _ArticleSeason.FshSeason
                                                                             and $projection.ProductSeasonYear   = _ArticleSeason.FshSeasonYear
  association [0..1] to P_ProdAllocSalesOrderPartner as _SalesdocPartner     on  $projection.ReferenceSDDocument     = _SalesdocPartner.vbeln
                                                                             and $projection.ReferenceSDDocumentItem = _SalesdocPartner.posnr
                                                                             and _SalesdocPartner.parvw              = 'RG'
  association [0..1] to zsd_i_out_dn_event_time_seg  as _DNEvent             on  $projection.Handle = _DNEvent.HeadHandler
  association [0..1] to I_Plant                      as _ReceivingPlant      on  $projection.ReceivingPlant = _ReceivingPlant.Plant
                                                                             and _ReceivingPlant.Language   = $session.system_language
  association [0..1] to I_Plant                      as _SupplyingPlant      on  $projection.SupplyingPlant = _SupplyingPlant.Plant
                                                                             and _SupplyingPlant.Language   = $session.system_language
{
  key         DeliveryDocument                                                              as OutboundDelivery,
  key         case when _Item.DeliveryDocumentItem is null then '000000'
                  else _Item.DeliveryDocumentItem
                  end                                                                       as DeliveryDocumentItem,
              DeliveryDocumentType                                                          as DeliveryDocumentType,
              _DeliveryDocumentType.
              _Text[1:Language=$session.system_language].DeliveryDocumentTypeName           as DeliveryDocumentTypeName,
              SalesOrganization                                                             as SalesOrganization,
              _SalesOrganization.
              _Text[1:Language=$session.system_language].SalesOrganizationName              as SalesOrganizationName,
              ShippingPoint                                                                 as ShippingPoint,
              _ShippingPoint._Text[1:Language=$session.system_language].ShippingPointName   as ShippingPointName,
              CreationDate                                                                  as DeliveryNoteCreatedOn,
              CreatedByUser                                                                 as DeliveryNoteCreatedBy,
              SoldToParty                                                                   as SoldToParty,
              _SoldToParty.CustomerName                                                     as SoldToPartyName,
              ShipToParty                                                                   as ShipToParty,
              _ShipToParty.CustomerName                                                     as ShipToPartyName,
              PaymentTermCreditCheckStatus                                                  as TermsofPayment,
              @ObjectModel.virtualElement: true
              @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_STAT'
              cast('' as abap.char( 20 ))                                                   as OverallDelvstatus,
              @ObjectModel.virtualElement: true
              @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_STAT'
              cast('0' as abap.int1)                                                        as OverallDelvstatuscriticality,
              cast('' as /spe/de_ident)                                                     as AlternativeHUIdentification,
              ZZ1_SEQ_NO_DLH                                                                as SequenceNumber,
              DeliveryDate                                                                  as DeliveryDate,
              BillingDocumentDate                                                           as InvoiceDate,
              PickingDate                                                                   as PickingDate,
              DeliveryPriority                                                              as DeliveryPriorityHeader,
              ZZ1_ROUTE_ST_DLH                                                              as RoutingStatus,
              HeaderBillingBlockReason                                                      as BillingBlock,
              _BillingBlock.
              _Text[1:Language=$session.system_language].BillingBlockReasonDescription      as BillingBlockDescription,
              DeliveryBlockReason                                                           as DeliveryBlock,
              TotalCreditCheckStatus                                                        as OverallCreditStatus,
              @Semantics.amount.currencyCode: 'NetValueCurrency'
              TotalNetAmount                                                                as NetValue,
              TransactionCurrency                                                           as NetValueCurrency,
              CustomerCreditAccount                                                         as CreditAccount,
              OverallPackingStatus                                                          as PackingStatus,
              OverallDelivReltdBillgStatus                                                  as DeliveryRelBillingStatus,
              TransportationPlanningStatus                                                  as TransportPlanningStatus,
              LoadingDate                                                                   as LoadingDate,
              OverallGoodsMovementStatus                                                    as GoodsMovementStatus,
              PlannedGoodsIssueDate                                                         as PlannedGIDate,
              ActualGoodsMovementDate                                                       as ActualGoodsMovementDate,
              TotalBlockStatus                                                              as OverallBlockStatus,
              Handle                                                                        as Handle,
              zzsbgrp                                                                       as Creditrepgroup,
              zzctlpc                                                                       as RiskCategory,
              _Item.ReferenceSDDocument                                                     as ReferenceSDDocument,
              _Item.ReferenceSDDocumentItem                                                 as ReferenceSDDocumentItem,
              _Item.Material                                                                as Material,
              @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
              _Item.ActualDeliveryQuantity                                                  as DeliveryQuantity,
              _Item.DeliveryQuantityUnit                                                    as DeliveryQuantityUnit,
              left(_Item.Material, 6 )                                                      as Generic,
              _Item.Plant                                                                   as Plant,
              _Item._Plant[1:Language=$session.system_language].PlantName                   as PlantName,
              _Item.StorageLocation                                                         as StorageLocation,
              _Item.DistributionChannel                                                     as DistributionChannel,
              _Item._DistributionChannel.
              _Text[1:Language=$session.system_language].DistributionChannelName            as DistributionChannelName,
              _Item.Division                                                                as Division,
              _Item._Division._Text[1:Language=$session.system_language].DivisionName       as DivisionName,
              _Item.InternationalArticleNumber                                              as EANUPC,
              _Item.ProductCharacteristic2                                                  as GridValue,
              _Item.ProductSeasonYear                                                       as ProductSeasonYear,
              _Item.ProductSeason                                                           as ProductSeason,
              _Item._PurchaseOrder.PurchaseOrder                                            as PurchaseOrder,
              _Item._PurchaseOrder.PurchaseOrderType                                        as STOType,
              _Item._PurchaseOrder.PurchasingOrganization                                   as PurchasingOrganization,
              _Item._PurchaseOrder.PurchasingGroup                                          as PurchasingGroup,
              _Item._PurchaseOrder.CompanyCode                                              as CompanyCode,
              _Item._PurchaseOrder.CreationDate                                             as STOCreatedOn,
              _Item._PurchaseOrder.SupplyingPlant                                           as SupplyingPlant,
              _Item._PurchaseOrder.CorrespncInternalReference                               as InternalReference,
              _Item._PurchaseOrder.CorrespncExternalReference                               as ExternalReference,
              _Item._PurchaseOrder.ZZ1_ZSALES_CHANNEL_PDH                                   as SalesChannel,
              _Item._PurchaseOrderItem.Plant                                                as ReceivingPlant,
              _Item._PurchaseOrderItem.ZZ1_ZFSH_MG_AT_1_PDI                                 as ProductDivision,
              _Item._PurchaseOrderItem.ZZ1_ABGRU_PDI                                        as RejectionReason,
              _Item._ReferenceSDDocument.SalesDocument                                      as SalesOrder,
              _Item._ReferenceSDDocument.SalesDocumentType                                  as SalesDocumentType,
              _Item._ReferenceSDDocument._SalesDocumentType.
              _Text[1:Language=$session.system_language].SalesDocumentTypeName              as SalesDocumentTypeName,
              @Semantics.amount.currencyCode: 'SODocumentCurrency'
              _Item._ReferenceSDDocument.TotalNetAmount                                     as NetValueSO,
              _Item._ReferenceSDDocument.TransactionCurrency                                as SODocumentCurrency,
              _Item._ReferenceSDDocument.SDDocumentReason                                   as OrderReason,
              _Item._ReferenceSDDocument.ZZ1_RSD_HEAD                                       as RSDHeader,
              _Item._ReferenceSDDocument.CreationDate                                       as SalesdocumentCreatedOn,
              _Item._ReferenceSDDocument.ShippingCondition                                  as ShippingCondition,
              _Item._ReferenceSDDocument._ShippingCondition.
              _Text[1:Language=$session.system_language].ShippingConditionName              as ShippingConditionName,
              _Item._ReferenceSDDocument.PurchaseOrderByCustomer                            as CustomerPurchaseOrderNo,
              _Item._ReferenceSDDocument.CustomerPurchaseOrderType                          as CustomerPurchaseOrderType,
              _Item._ReferenceSDDocument.RequestedDeliveryDate                              as RDDHeader,
              _Item._ReferenceSalesDocumentItem.SalesDocumentItem                           as SalesDocumentItem,
              _Item._ReferenceSalesDocumentItem.ZZ1_RSD_ITEM                                as RSDItem,
              _Item._ReferenceSalesDocumentItem.ZZ1_DELSCEN_SDI                             as FulfillmentScenarioSO,
              _Item._ReferenceSalesDocumentItem.ZZ1_OTCDLDATE_SDI                           as FulfillmentScenarioDate,
              @Semantics.quantity.unitOfMeasure: 'VolumeUnit'
              _Item.ItemVolume                                                              as Volume,
              _Item.ItemVolumeUnit                                                          as VolumeUnit,
              @Semantics.quantity.unitOfMeasure: 'WeightUnit'
              _Item.ItemGrossWeight                                                         as Grossweight,
              @Semantics.quantity.unitOfMeasure: 'WeightUnit'
              _Item.ItemNetWeight                                                           as Netweight,
              _Item.ItemWeightUnit                                                          as WeightUnit,
              _Item.SalesOffice                                                             as SalesOffice,
              _Item._SalesOffice._Text[1:Language=$session.system_language].SalesOfficeName as SalesOfficeName,
              OverallPickingStatus                                                          as PickingStatus,
              _Item.ProductAvailabilityDate                                                 as MaterialAvailabilityDate,
              _Item.ProofOfDeliveryStatus                                                   as OverallPODStatus,
              _DNEvent.zs4_tz_zone                                                          as ZTimeZone,
              _DNEvent.zs4plnpick_even_tstfr                                                as S4PlannedPickingDate,
              _DNEvent.zs4plnload_even_tstfr                                                as S4PlannedLoadingDate,
              _DNEvent.zs4plngdis_even_tstfr                                                as S4PlannedGoodsIssueDate,
              _DNEvent.zs4plndeli_even_tstfr                                                as S4PlannedDeliveryDate,
              _DNEvent.zs4plncons_even_tstfr                                                as S4PlannedSTOConfOnShelfDate,
              _DNEvent.zs4plnrout_even_tstfr                                                as S4CustomerRouteDate,
              _DNEvent.zwsplnload_even_tstfr                                                as ProjectedPlannedLoadingDate,
              _DNEvent.zwsactrece_even_tstfr                                                as WMSActualReceivedDate,
              _DNEvent.zwsactpick_even_tstfr                                                as WMSActualPickingDate,
              _DNEvent.zwsactpack_even_tstfr                                                as WMSActualPackingDate,
              _DNEvent.zwsactload_even_tstfr                                                as WMSActualLoadingDate,
              _DNEvent.zwsactgdis_even_tstfr                                                as WMSActualGoodsIssueDate,
              _DNEvent.zwsplnrorq_even_tstfr                                                as WMSActualRoutingRequestedDate,
              _DNEvent.zwsactrois_even_tstfr                                                as WMSActualRoutingIssueDate,
              _DNEvent.zwsactrout_even_tstfr                                                as WMSRouteDate,
              _DNEvent.zwsactrore_even_tstfr                                                as WMSRevisedRouteDate,
              _DNEvent.ztsplngdis_even_tstfr                                                as TMSEstimatedPickUpDate,
              _DNEvent.ztsplndeli_even_tstfr                                                as TMSEstimatedDeliveryDate,
              _DNEvent.ztsactcoll_even_tstfr                                                as TMSCollectedbyCarrier,
              _DNEvent.ztsactarri_even_tstfr                                                as TMSArrivedatCarrierTerminal,
              _DNEvent.ztsactdept_even_tstfr                                                as TMSDepartedfromCarrierTerminal,
              _DNEvent.ztsactatmp_even_tstfr                                                as AttempttoDeliver,
              _DNEvent.ztsactdeli_even_tstfr                                                as ActualDeliveryDate,
              _DNEvent.ztsactrefu_even_tstfr                                                as ActualRefusalDate,
              _DNEvent.zs4plndgis_even_tstfr                                                as PlannedGoodsIssueDate,
              _DNEvent.ztsactrout_even_tstfr                                                as CarrierRouteDate,
              _DNEvent.ztsactrrou_even_tstfr                                                as RevisedCarrierRouteDate,
              _ReceivingPlant,
              _SupplyingPlant,
              _PickQuantity,
              _Invoicedet,
              _ProductText,
              _CommunityCode,
              _CustomerDeclaration,
              _ArticleSeason,
              _SalesdocPartner,
              _ParentDN,
              _SalesdocSch

}
