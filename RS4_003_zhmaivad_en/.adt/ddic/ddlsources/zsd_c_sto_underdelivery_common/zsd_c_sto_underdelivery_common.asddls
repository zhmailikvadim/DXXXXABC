/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ADAKHIKB     | 13.05.2023 | 21056: STO under delivery logging & Maint*
*              |            | DS4K951650                               *
*----------------------------------------------------------------------*
* ADAKHIKB     | 28.09.2023 | 19848 : Development - Store Refusal Auto *
*              |            | DS4K949317                               *
*----------------------------------------------------------------------*
* KONRANAR     | 31.10.2023 | 26244 : HU CR 63689                      *
*              |            | DS4K968189                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'STO Underdelivery Log View'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED }

@UI.headerInfo: {
  typeName: 'STO UnderDelivery Monitor',
  title: {
    type: #STANDARD,
    value: 'UnderDeliveredSto'
  }
}
define root view entity ZSD_C_STO_Underdelivery_Common
  provider contract transactional_query
  as projection on ZSD_I_STO_UnderDelivery_Common
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @EndUserText.label: 'STO No.(U)'
  key UnderDeliveredSto,
      @EndUserText.label: 'STO Item(U)'
  key UnderDeliveredStoItem,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @EndUserText.label: 'Delivery Note(U)'
  key DeliverNoteNumber,      
      @EndUserText.label: 'Delivery Note Item(U)'
  key DeliveryNoteItem,
      @UI.hidden: true
  key UnderDeliveredHU,
      @EndUserText.label: 'STO Creation Data(U)'
      CreatedOn,
      @EndUserText.label: 'Step'
      @ObjectModel.text.element: ['StepText']
      @UI.textArrangement: #TEXT_LAST
      @UI.multiLineText: true
      @Consumption.groupWithElement: 'Status'
      Step,
      StepText,
      @EndUserText.label: 'Process'
      @ObjectModel.text.element: ['ProcessText']
      @UI.multiLineText: true
      @UI.textArrangement: #TEXT_ONLY
      Process,
      @EndUserText.label: 'Process Text'
      ProcessText,
      @EndUserText.label: 'Short Qty'
      ShortQuantity,
      @EndUserText.label: 'Waiting Days from GR'
      WaitingDaysFromGR,
      @EndUserText.label: 'Waiting Days from GI'
      WaitingDaysFromGI,
      @EndUserText.label: 'IBD(V)'
      VirtualGRInboundDelivery,
      @EndUserText.label: 'GR Mat.Doc.(V)'
      VirtualGRMaterialDoc,
      @EndUserText.label: 'GR Mat.DocYear(V)'
      VirtualGRMaterialDocYear,
      @EndUserText.label: 'STO(V)'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      VirtualReturnSto,
      @EndUserText.label: 'OBD(V)'
      OutboundDeliveryVirtual,
      @EndUserText.label: 'STO MatDoc(V)'
      StoGRMatDocVirtual,
      @EndUserText.label: 'STO GR MatDoc Year(V)'
      StoGRMatDocYearVirtual,
      @EndUserText.label: 'STO GI MatDoc(V)'
      StoGIMatDocVirtual,
      @EndUserText.label: 'STO GI MatDoc Year(V)'
      StoGIMatDocYearVirtual,
      @EndUserText.label: 'Down Adjustment MatDoc'
      DownAdjustmentMatDoc,
      @EndUserText.label: 'Down Adjustment MatDoc Year'
      DownAdjustmentMatDocYear,
      @EndUserText.label: 'Error Number'
      ErrorMsgNo,
      @EndUserText.label: 'Error Message'
      ErrorMsgText,
      @EndUserText.label: 'Status'
      @ObjectModel.text.element: ['StatusText']
      @UI.textArrangement: #TEXT_ONLY
      @UI.multiLineText: true
      @Consumption.valueHelpDefinition: [  { entity: { name:    'ZSD_I_STO_UD_Status_VH', element: 'STATUS'  }, qualifier: '' } ]
      Status,
      @EndUserText.label: 'Status Text'
      Statustext,
      @EndUserText.label: 'Purchase Org.'
      PurchaseOrganization,
      @EndUserText.label: 'Company Code'
      CompanyCode,
      @EndUserText.label: 'Purchase Group'
      PurchasingGroup,
      @EndUserText.label: 'STO Created On.'
      StoCreatedOn,
      @EndUserText.label: 'STO Created By'
      StoCreatedBy,
      @EndUserText.label: 'STO Type(U)'
      StoType,
      @EndUserText.label: 'Suppl.Plant(U)'
      @Consumption.valueHelpDefinition: [{ entity: { name:    'I_PlantVH', element: 'Plant' } }]
      @ObjectModel.text.element: ['SupplyingPlantName']
      @UI.textArrangement: #TEXT_LAST
      SupplyingPlant,
      RequestedShelfDate,
      YourReference,
      OurReference,
      @EndUserText.label: 'Sales Org.'

      @ObjectModel.text.element: ['SalesOrganizationName']
      @UI.textArrangement: #TEXT_LAST
      @UI.multiLineText: true
      SalesOrganization,
      @EndUserText.label: 'Sales Channel'
      SalesChannel,
      @EndUserText.label: 'Article'
      Article,
      ArticleDescription,
      @EndUserText.label: 'Order Reason'
      OrderReason,
      @EndUserText.label: 'Receiving Plant'
      @ObjectModel.text.element: ['ReceivingPlantName']
      @UI.textArrangement: #TEXT_LAST
      ReceivingPlant,
      StorageLocation,
      POQuantityUnit,
      POQuantity,
      RejectionReason,
      ConfirmationControlKey,
      ProductDivision,
      DNCreatedOn,
      DNCreatedBy,
      @EndUserText.label: 'GR Posted on(V)'
      GRPostedOnVirtual,
      @EndUserText.label: 'STO Type(V)'
      StoTypeVirtualReturn,
      @EndUserText.label: 'Suppl.Plant(V)'
      SupplyingPlantVirtual,
      @EndUserText.label: 'Requested On Shelf Date(V)'
      RequestedShelfDateVirtReturn,
      @EndUserText.label: 'Your Reference(V)'
      YourReferenceVirtualReturn,
      @EndUserText.label: 'Our Reference(V)'
      OurReferenceVirtualReturn,
      @EndUserText.label: 'Rejection Reason(V)'
      RejectionReasonVirtualReturn,
      @EndUserText.label: 'PO Reason Code(V)'
      POReasonCode,
      @EndUserText.label: 'Receiving Plant(V)'
      ReceivingPlantVirtual,
      @EndUserText.label: 'Storage Location(V)'
      StorageLocationVirtual,
      @EndUserText.label: 'Conf. Control(V)'
      ConfirmationControlKeyVirtual,
      @EndUserText.label: 'Product Division(V)'
      ProductDivisionVirtualReturn,
      @EndUserText.label: 'Shipping Point(V)'
      ShippingPointVirtual,
      @EndUserText.label: 'Customer(V)'
      CustomerVirtual,
      @EndUserText.label: 'DeliveryNote(V)'
      DNTypeVirtual,
      @EndUserText.label: 'GR Posted On(V)'
      GoodsReceiptMatDocPostedOn,
      @EndUserText.label: 'GI Posted On(V)'
      GoodsIssueMatDocPostedOn,
      @EndUserText.label: 'Down Adjustmed Posted On(V)'
      DownAdjustmentMatDocPostedOn,

      /*Texts */
      @EndUserText.label: 'Supplying Plant name'
      SupplyingPlantName,
      @EndUserText.label: 'Receiving Plant name'
      ReceivingPlantName,
      @EndUserText.label: 'Sales Organizaiton Name'
      SalesOrganizationName,
      StatusCriticality,


      @EndUserText.label: 'Actual GR'
      ActualGR,


      /* Associations */
      _DeliveryDocument,
      _ReceivingPlant,
      _SupplyingPlant,
      _PurchaseOrder,
      _PurchaseOrderItem,
      _StoProcLog,
      _DownAdjustment : redirected to composition child ZSD_C_STO_UD_DownAdjustment,
      _Refusal        : redirected to composition child ZSD_C_STO_UD_Refusal,
      _VirtualReturn  : redirected to composition child ZSD_C_STO_UD_VirtualReturn,
      _STO_shipping,
      _Messages
}
