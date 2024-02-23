/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ADAKHIKB     | 07.06.2023 | 21056: STO under delivery logging & Maint*
*              |            | DS4K951650                               *
*----------------------------------------------------------------------*
* KONRANAR     | 31.10.2023 | 26244 : HU CR 63689                      *
*              |            | DS4K968189                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'STO Down Adjustment UnderDelivery'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZSD_I_STO_UD_DownAdjustment
  as select from ZSD_I_STO_UnderDelivery_Common
  association        to parent ZSD_I_STO_UnderDelivery_Common as _UnderDeliveryCommon on  $projection.UnderDeliveredSto     = _UnderDeliveryCommon.UnderDeliveredSto
                                                                                      and $projection.UnderDeliveredStoItem = _UnderDeliveryCommon.UnderDeliveredStoItem
                                                                                      and $projection.DeliverNoteNumber     = _UnderDeliveryCommon.DeliverNoteNumber
                                                                                      and $projection.DeliveryNoteItem      = _UnderDeliveryCommon.DeliveryNoteItem
                                                                                      and $projection.UnderDeliveredHU      = _UnderDeliveryCommon.UnderDeliveredHU
                                                                                      
  association [1..1] to I_Plant                               as _Plant               on  $projection.SupplyingPlant = _Plant.Plant
                                                                                      and _Plant.Language            = $session.system_language
  association [1..1] to I_Plant                               as _ReceivingPlant      on  $projection.ReceivingPlant = _ReceivingPlant.Plant
                                                                                      and _ReceivingPlant.Language   = $session.system_language
  association [1..1] to I_SalesOrganizationText               as _SalesOrgText        on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                                      and _SalesOrgText.Language        = $session.system_language

{
  key UnderDeliveredSto,
  key UnderDeliveredStoItem,
  key DeliverNoteNumber,
  key DeliveryNoteItem,
  key UnderDeliveredHU,
      CreatedOn,
      Process,
      ProcessText,
      Step,
      StepText,
      ShortQuantity,
      WaitingDaysFromGR                   as WaitingDaysFromGRDate,
      WaitingDaysFromGI                   as WaitingDaysFromGIDate,
      VirtualGRInboundDelivery,
      OutboundDeliveryVirtual,
      DownAdjustmentMatDoc,
      DownAdjustmentMatDocYear,
      ErrorMsgNo                          as ErrorNumber,
      ErrorMsgText                        as ErrorText,
      case
      when Step = 'D4' and ErrorMsgNo is initial then 'C'
      when ErrorMsgNo is not initial or ErrorMsgText is not initial then 'E'
      when Step < 'D4' then 'P'
      else 'P'
      end                                 as Status,
      PurchaseOrganization,
      CompanyCode,
      PurchasingGroup,
      StoCreatedOn,
      StoCreatedBy,
      StoType,
      SupplyingPlant,
      RequestedShelfDate,
      YourReference,
      OurReference,
      SalesOrganization,
      SalesChannel,
      Article,
      ArticleDescription,
      OrderReason,
      ReceivingPlant,
      StorageLocation,
      POQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'POQuantityUnit'
      POQuantity,
      RejectionReason,
      ConfirmationControlKey,
      ProductDivision,
      DNCreatedOn,
      DNCreatedBy,
      GRPostedOnVirtual,

      DownAdjustmentMatDocPostedOn,

      /*Texts*/
      _Plant.PlantName                    as SupplyingPlantName,
      _ReceivingPlant.PlantName           as ReceivingPlantName,
      _SalesOrgText.SalesOrganizationName as SalesOrganizationName,
      Statustext,
      StatusCriticality,
      
      
      @Semantics.quantity.unitOfMeasure: 'POQuantityUnit'
      ActualGR,


      /* Associations */
      _UnderDeliveryCommon,
      _DeliveryDocument,
      _PurchaseOrder,
      _PurchaseOrderItem,
      _STO_shipping,
      ZSD_I_STO_UnderDelivery_Common._Messages
}
where
  Process = 'D' //Down Adjustment
