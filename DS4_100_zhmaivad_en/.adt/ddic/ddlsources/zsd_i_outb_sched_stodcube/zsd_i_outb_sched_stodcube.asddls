/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 18.11.2023 | 26318     : DN OS compliance Report      *
*              |            | DS4K968461                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Outbound deliv sched STO rep'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_I_OUTB_SCHED_STODCUBE
  as select from ZSD_I_OUTB_SCHED_STOCUBE
  association [0..1] to zsd_i_out_dn_event_time_seg as DNEvent           on $projection.DeliveryHandle = DNEvent.HeadHandler
  association [0..1] to ZSP_I_ROUTES_TP             as DNRoutedata       on $projection.DNRoute = DNRoutedata.route
  association [0..1] to ZSD_I_MATERIALDOCUMENT_DATE as AccountingDocDate on $projection.AccountingDocument = AccountingDocDate.MaterialDocument
{
  key PurchaseOrder,
  key PurchasingDocumentItem,
      PurchasingDocumentType,
      PurchasingDocumentTypeName,
      PurchasingOrganization,
      PurchasingOrganizationName,
      PurchasingGroup,
      PurchasingGroupName,
      Supplier,
      SupplierName,
      PurchasingDocumentCreatedOn,
      PurchasingDocumentCreatedBy,
      SupplyingPlant,
      SupplyingPlantName,
      InternalReference,
      ExternalReference,
      RequestedOnShelfDate,
      OrderReason,
      HeaderReturnReason,
      SalesChannel,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      OrderQuantity,
      OrderQuantityUnit,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetValue,
      DocumentCurrency,
      ConfirmationControlKey,
      StorageLocation,
      StorageLocationName,
      ReceivingPlant,
      ReceivingPlantName,
      PlantFactoryCalendar,
      Material,
      MaterialName,
      Generic,
      GRProcessingTime,
      ItemReturnReason,
      EANUPC,
      OutboundDelivery,
      DeliveryDocumentItem,
      ProductDivision,
      FulfillmentScenario,
      FulfillmentDate,
      RSDItem,
      RejectionReason,
      InitialRDD,
      InitialRSD,
      VASExist,
      case VASExist when '' then ''
      else VAS.ValueAddedSubServiceType
      end                                                                 as ValueAddedSubServiceType,
      case VASExist when '' then ''
      else VASDN.ValueAddedSubServiceType
      end                                                                 as DNValueAddedSubServiceType,
      GridValue,
      GRDate,
      DeliveryPriority,
      SalesOrganization,
      SalesOrganizationName,
      ShippingCondition,
      ShippingPoint,
      ShippingPointName,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      CumulativeConfirmedQuantity,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      IssuedQuantity,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      GoodsReceivedQuantity,
      QuantityUnit,
      STOstatus,
      STOstatusdesc,
      STOstatuscriticality,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('' as abap.char( 20 ))                                         as OverallDelvstatus,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('0' as abap.int1)                                              as VASLeadTimeSTO,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('0' as abap.int1)                                              as VASLeadTimeDN,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('0' as abap.int1)                                              as CreationLeadTime,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('0' as abap.int1)                                              as LoadingLeadTime,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('0' as abap.int1)                                              as ProcessingLeadTime,
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('' as abap.char(100))                                          as SizeDescription,
      @ObjectModel.virtualElement: true
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_OUTBDELV_SCHSTO'
      cast('0' as abap.quan( 13 ))                                        as GoodsIssueQuantity,
      Deliverydata.CreationDate                                           as DeliveryNoteCreatedOn,
      Deliverydata.ProofOfDeliveryDate                                    as DeliveryDateProof,
      Deliverydata.DeliveryDocumentType                                   as DeliveryDocumentType,
      Deliverydata._DeliveryDocumentType.
      _Text[1:Language=$session.system_language].DeliveryDocumentTypeName as DeliveryDocumentTypeName,
      @Semantics.amount.currencyCode: 'NetValueCurrency'
      Deliverydata.TotalNetAmount                                         as NetValueDN,
      Deliverydata.TransactionCurrency                                    as NetValueCurrency,
      Deliverydata.SoldToParty                                            as SoldToParty,
      Deliverydata._SoldToParty.CustomerName                              as SoldToPartyName,
      Deliverydata.ShipToParty                                            as ShipToParty,
      Deliverydata._ShipToParty.CustomerName                              as ShipToPartyName,
      Deliverydata.ProposedDeliveryRoute                                  as DNRoute,
      Deliverydata.Handle                                                 as DeliveryHandle,
      Deliverydata.ActualGoodsMovementDate                                as ActualGIDate,
      Deliverydata.LoadingDate                                            as DNLoadingDate,
      Deliverydata.ShippingPoint                                          as DNShippingPoint,
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      DeliveryItemdata.ActualDeliveryQuantity                             as DeliveryQuantity,
      DeliveryItemdata.DeliveryQuantityUnit                               as DeliveryQuantityUnit,
      DeliveryItemdata.GoodsMovementStatus                                as GoodsMovementStatus,
      DeliveryItemdata.DeliveryDocumentItemCategory                       as ItemCategory,
      InboundDN.SubsequentDocument                                        as InboundDN,
      PurchasingDocumentScheduleLine.ProductAvailabilityDate              as MaterialAvailablityDate,
      PurchasingDocumentScheduleLine.LoadingDate                          as STOLoadingDate,
      PurchasingDocumentScheduleLine.ScheduleLineDeliveryDate             as ConfirmedDeliveryDate,
      PurchasingDocumentSchLineEx.ConfirmedShelfDate                      as ConfirmedShelfDate,
      DepartureCountry,
      ShippingPointData.zzazone                                           as DepartureZone,
      ShippingPointData.zzfabkl                                           as ShippingPointFactoryCalendar,
      STORoute,
      Routedata.spfbk                                                     as RouteFactoryCalendar,
      Routedata.tdvzt                                                     as STORouteTransporationLeadTime,
      @Semantics.quantity.unitOfMeasure: 'PickedQuantityUnit'
      PickQuantity.PickedQuantity                                         as PickedQuantity,
      PickQuantity.UOM                                                    as PickedQuantityUnit,
      Accountingdoc.SubsequentDocument                                    as AccountingDocument,
      UnderDelivered.VirtualReturnSto                                     as VirtualReturnSTONumber,
      /* Associations */
      DNEvent,
      DNRoutedata,
      AccountingDocDate
}
