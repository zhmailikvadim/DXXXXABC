/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 27.10.2023 | 26318     : DN OS compliance Report      *
*              |            | DS4K968461                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Outbound deliv sched STO'
@Metadata.allowExtensions: true
@VDM.viewType: #CONSUMPTION
@ObjectModel: { usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED },
    semanticKey: ['PurchaseOrder', 'PurchasingDocumentItem'] }
define root view entity ZSD_C_OUTB_SCHED_STO
  provider contract transactional_query
  as projection on ZSD_I_OUTB_SCHED_STODCUBE
{
  key PurchaseOrder,
  key PurchasingDocumentItem,
      @ObjectModel.text.element : [ 'PurchasingDocumentTypeName' ]
      PurchasingDocumentType,
      @UI.hidden: true
      PurchasingDocumentTypeName,
      @ObjectModel.text.element : [ 'PurchasingOrganizationName' ]
      PurchasingOrganization,
      @UI.hidden: true
      PurchasingOrganizationName,
      @ObjectModel.text.element : [ 'PurchasingGroupName' ]
      PurchasingGroup,
      @UI.hidden: true
      PurchasingGroupName,
      @ObjectModel.text.element : [ 'SupplierName' ]
      Supplier,
      @UI.hidden: true
      SupplierName,
      @EndUserText.label: 'STO Created on'
      PurchasingDocumentCreatedOn,
      @EndUserText.label: 'STO Created by'
      PurchasingDocumentCreatedBy,
      @ObjectModel.text.element : [ 'SupplyingPlantName' ]
      SupplyingPlant,
      @UI.hidden: true
      SupplyingPlantName,
      InternalReference,
      ExternalReference,
      RequestedOnShelfDate,
      @EndUserText.label: 'Order Reason'
      OrderReason,
      @EndUserText.label: 'Header Return Reason'
      HeaderReturnReason,
      SalesChannel,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      OrderQuantity,
      @UI.hidden: true
      OrderQuantityUnit,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @EndUserText.label: 'Net Value(STO)'
      NetValue,
      @UI.hidden: true
      DocumentCurrency,
      @EndUserText.label: 'Confirmation Control Key'
      ConfirmationControlKey,
      @ObjectModel.text.element : [ 'StorageLocationName' ]
      StorageLocation,
      @UI.hidden: true
      StorageLocationName,
      @ObjectModel.text.element : [ 'ReceivingPlantName' ]
      ReceivingPlant,
      @UI.hidden: true
      ReceivingPlantName,
      @ObjectModel.text.element : [ 'MaterialName' ]
      Material,
      @UI.hidden: true
      MaterialName,
      Generic,
      GRProcessingTime,
      @EndUserText.label: 'Item Return Reason'
      ItemReturnReason,
      @EndUserText.label: 'EAN/UPC'
      EANUPC,
      @EndUserText.label: 'Delivery Document'
      OutboundDelivery,
      @EndUserText.label: 'Delivery Document Item'
      DeliveryDocumentItem,
      ProductDivision,
      FulfillmentScenario,
      FulfillmentDate,
      RSDItem,
      RejectionReason,
      InitialRDD,
      InitialRSD,
      @EndUserText.label: 'VAS Exist'
      VASExist,
      @EndUserText.label: 'Grid Value'
      GridValue,
      GRDate,
      DeliveryPriority,
      @ObjectModel.text.element : [ 'SalesOrganizationName' ]
      SalesOrganization,
      @UI.hidden: true
      SalesOrganizationName,
      ShippingCondition,
      @ObjectModel.text.element : [ 'ShippingPointName' ]
      ShippingPoint,
      @UI.hidden: true
      ShippingPointName,
      @EndUserText.label: 'Shipping Point Factory Calendar'
      ShippingPointFactoryCalendar,
      DepartureCountry,
      DepartureZone,
      @EndUserText.label: 'DN: Created on'
      DeliveryNoteCreatedOn,
      @EndUserText.label: 'Proof of Delivery Date'
      DeliveryDateProof,
      @ObjectModel.text.element : [ 'DeliveryDocumentTypeName' ]
      DeliveryDocumentType,
      @UI.hidden: true
      DeliveryDocumentTypeName,
      @Semantics.amount.currencyCode: 'NetValueCurrency'
      @EndUserText.label: 'Net Value(DN)'
      NetValueDN,
      @UI.hidden: true
      NetValueCurrency,
      @ObjectModel.text.element : [ 'SoldToPartyName' ]
      SoldToParty,
      @UI.hidden: true
      SoldToPartyName,
      @ObjectModel.text.element : [ 'ShipToPartyName' ]
      ShipToParty,
      @UI.hidden: true
      ShipToPartyName,
      @EndUserText.label: 'DN Route'
      DNRoute,
      ActualGIDate,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      CumulativeConfirmedQuantity,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      @EndUserText.label: 'Goods Issue Quantity'
      GoodsIssueQuantity,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      @EndUserText.label: 'Goods Received Quantity'
      GoodsReceivedQuantity,
      @UI.hidden: true
      QuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      DeliveryQuantity,
      @UI.hidden: true
      DeliveryQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'PickedQuantityUnit'
      @EndUserText.label: 'Picked Quantity'
      PickedQuantity,
      @UI.hidden: true
      PickedQuantityUnit,
      GoodsMovementStatus,
      ItemCategory,
      @EndUserText.label: 'Inbound DN'
      InboundDN,
      MaterialAvailablityDate,
      @EndUserText.label: 'DN Loading Date'
      DNLoadingDate,
      @EndUserText.label: 'STO Loading Date'
      STOLoadingDate,
      ConfirmedDeliveryDate,
      ConfirmedShelfDate,
      @EndUserText.label: 'STO Route'
      STORoute,
      @EndUserText.label: 'STO Route Factory Calendar'
      RouteFactoryCalendar,
      @EndUserText.label: 'STO Route Transporation Lead Time'
      STORouteTransporationLeadTime,
      VirtualReturnSTONumber,
      @UI.hidden: true
      STOstatus,
      STOstatusdesc,
      @UI.hidden: true
      STOstatuscriticality,
      @EndUserText.label: 'Overall Delivery Status'
      OverallDelvstatus,
      @EndUserText.label: 'STO VAS Lead Time'
      VASLeadTimeSTO,
      @EndUserText.label: 'DN VAS Lead Time'
      VASLeadTimeDN,
      @EndUserText.label: 'Creation Lead Time'
      CreationLeadTime,
      @EndUserText.label: 'Loading Lead Time'
      LoadingLeadTime,
      @EndUserText.label: 'Processing Lead Time'
      ProcessingLeadTime,
      @EndUserText.label: 'Size Description'
      SizeDescription,
      @EndUserText.label: 'DN Route Transporation Lead Time'
      DNRoutedata.tdvzt              as DNRouteTransporationLeadTime,
      @EndUserText.label: 'S4 Planned Picking Date'
      DNEvent.zs4plnpick_even_tstfr  as S4PlannedPickingDate,
      @EndUserText.label: 'S4 Planned Loading Date'
      DNEvent.zs4plnload_even_tstfr  as S4PlannedLoadingDate,
      @EndUserText.label: 'S4 Planned Goods Issue Date'
      DNEvent.zs4plngdis_even_tstfr  as S4PlannedGoodsIssueDate,
      @EndUserText.label: 'S4 Planned Delivery Date'
      DNEvent.zs4plndeli_even_tstfr  as S4PlannedDeliveryDate,
      @EndUserText.label: 'S4 Planned STO Conf On Shelf Date'
      DNEvent.zs4plncons_even_tstfr  as S4PlannedSTOConfOnShelfDate,
      @EndUserText.label: 'Entry Date'
      AccountingDocDate.CreationDate as EntryDate
}
