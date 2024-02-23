/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ADAKHIKB     | 13.05.2023 | 21056: STO under delivery logging & Maint*
*              |            | DS4K951650                               *
*----------------------------------------------------------------------*
* KONRANAR     | 31.10.2023 | 26244 : HU CR 63689                      *
*              |            | DS4K968189                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'STO Down Adjustment Consumption View'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED }

@UI.headerInfo: {
  typeName: 'STO Virtual UnderDelivery Monitor',
  title: {
    type: #STANDARD,
    value: 'UnderDeliveredSto'
  }
}

define view entity ZSD_C_STO_UD_DownAdjustment
  as projection on ZSD_I_STO_UD_DownAdjustment
{
      @Search.defaultSearchElement: true
      @EndUserText.label: 'STO No.(U)'
  key UnderDeliveredSto,
      @EndUserText.label: 'STO Item(U)'
  key UnderDeliveredStoItem,
      @EndUserText.label: 'Delivery Note(U)'
  key DeliverNoteNumber,
      @EndUserText.label: 'Delivery Note Item(U)'
  key DeliveryNoteItem, 
      @UI.hidden: true
  key UnderDeliveredHU,
      @EndUserText.label: 'STO UD Creation date'
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
      WaitingDaysFromGRDate,
      @EndUserText.label: 'Waiting Days from GI'
      WaitingDaysFromGIDate,
      @EndUserText.label: 'IBD(V)'
      VirtualGRInboundDelivery,
      @EndUserText.label: 'OBD(V)'
      OutboundDeliveryVirtual,
      @EndUserText.label: 'Down Adjustment MatDoc'
      DownAdjustmentMatDoc,
      @EndUserText.label: 'Down Adjustment MatDoc Year'
      DownAdjustmentMatDocYear,
      @EndUserText.label: 'Error Number'
      ErrorNumber,
      @EndUserText.label: 'Error Message'
      ErrorText,
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
      SalesChannel,
      @EndUserText.label: 'Article'
      Article,
      ArticleDescription,
      @EndUserText.label: 'OrderReason'
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
      @EndUserText.label: 'Down Adjustmed Posted On(V)'
      DownAdjustmentMatDocPostedOn,

      @EndUserText.label: 'Supplying Plant name'
      SupplyingPlantName,
      @EndUserText.label: 'Receiving Plant name'
      ReceivingPlantName,
      @EndUserText.label: 'Sales Organizaiton Name'
      SalesOrganizationName,
      StatusCriticality,
      /* Associations */
      _DeliveryDocument,
      _UnderDeliveryCommon : redirected to parent ZSD_C_STO_Underdelivery_Common ,
      _PurchaseOrder,
      _PurchaseOrderItem,
      _STO_shipping,
      _Messages
}
