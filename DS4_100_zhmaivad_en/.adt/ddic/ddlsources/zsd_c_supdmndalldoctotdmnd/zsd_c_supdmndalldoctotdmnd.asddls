@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}
@Analytics.dataExtraction.enabled : true
@EndUserText.label: 'c_supdmndalldoctotdmndqry Custom View'

@ObjectModel:{
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #D,
     sizeCategory:   #XXL
   }
}

define view entity zsd_c_supdmndalldoctotdmnd
  as select from I_SupDmndAllDocTotDmndCube
  //  association to I_SalesDocumentItemBasic    as _SalesDocumentItem         on  $projection.RequirementDocumentNumber = _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocument
  //                                                                           and $projection.RequirementDocumentItem   = _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocumentItem
  association to I_SalesDocumentScheduleLine as _SalesDocumentScheduleLine on  $projection.RequirementDocumentNumber = _SalesDocumentScheduleLine.SalesDocument
                                                                           and $projection.RequirementDocumentItem   = _SalesDocumentScheduleLine.SalesDocumentItem
  association to I_Product                   as _Product                   on  $projection.Material = _Product.Product
  association to I_ProductSalesDelivery      as _ProductSalesDelivery      on  $projection.Material            = _ProductSalesDelivery.Product
                                                                           and $projection.SalesOrganization   = _ProductSalesDelivery.ProductSalesOrg
                                                                           and $projection.DistributionChannel = _ProductSalesDelivery.ProductDistributionChnl
{
      @EndUserText.label: 'Requirement Document Number'
  key RequirementDocumentNumber,
      @EndUserText.label: 'Requirement Document Item'
  key RequirementDocumentItem,
  key SupProtTimeBucketUUID,
      @EndUserText.label: 'Requirement Creation Date'
  key RequestedDate,
  key ProductAvailabilityDate,
      @EndUserText.label: 'Requirement Type'
  key RequirementType,
      @EndUserText.label: 'Requested Delivery Date'
      RequestedDeliveryDate,
      @EndUserText.label: 'Collection'
      cast(_SalesDocumentScheduleLine._SalesDocumentItem.ProductCollection as fsh_collection preserving type ) as ProductCollection,
      @EndUserText.label: 'Created by (Demand)'
      _SalesDocumentScheduleLine._SalesDocumentItem.CreatedByUser,
      @EndUserText.label: 'Sold-to party PO Item '
      _SalesDocumentScheduleLine._SalesDocumentItem.UnderlyingPurchaseOrderItem,
      @EndUserText.label: 'Material Description'
      _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocumentItemText,
      @EndUserText.label: 'Material group 1'
      _SalesDocumentScheduleLine._SalesDocumentItem.AdditionalMaterialGroup1,
      @EndUserText.label: 'Customer group'
      _SalesDocumentScheduleLine._SalesDocumentItem.CustomerGroup,
      @EndUserText.label: 'Customer\'s Product Number'
      cast(_SalesDocumentScheduleLine._SalesDocumentItem.MaterialByCustomer as kdmat preserving type )         as MaterialByCustomer,
      @EndUserText.label: 'EAN'
      _SalesDocumentScheduleLine._SalesDocumentItem.EAN,
      @EndUserText.label: 'Converted Size'
      _SalesDocumentScheduleLine._SalesDocumentItem.ProductCharacteristic2,
      @EndUserText.label: 'Fulfillment Date'
      _SalesDocumentScheduleLine._SalesDocumentItem.FulfillmentDate,
      @EndUserText.label: 'Fulfillment Scenario'
      _SalesDocumentScheduleLine._SalesDocumentItem.FulfillmentScenario,
      @EndUserText.label: 'Net Value'
      _SalesDocumentScheduleLine._SalesDocumentItem.NetAmount,
      _SalesDocumentScheduleLine._SalesDocumentItem.TransactionCurrency,
      @EndUserText.label: 'Cancellation Date'
      _SalesDocumentScheduleLine._SalesDocumentItem.FashionCancelDate,
      @EndUserText.label: 'Shipping Point'
      _SalesDocumentScheduleLine._SalesDocumentItem.ShippingPoint,
      @EndUserText.label: 'Quantity'
      _SalesDocumentScheduleLine._SalesDocumentItem.OrderQuantity,
      _SalesDocumentScheduleLine._SalesDocumentItem.OrderQuantityUnit,
      @EndUserText.label: 'Rejection Code'
      _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocumentRjcnReason,
      @EndUserText.label: 'Rejection Date'
      _SalesDocumentScheduleLine._SalesDocumentItem.LastChangeDate,
      @EndUserText.label: 'Requirement Item category'
      _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocumentItemCategory,
      @EndUserText.label: 'Sales Office'
      _SalesDocumentScheduleLine._SalesDocumentItem.SalesOffice,
      @EndUserText.label: 'Requirement Document Number'
      _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocumentItem,
      @EndUserText.label: 'Season'
      _SalesDocumentScheduleLine._SalesDocumentItem.ProductSeason,
      @EndUserText.label: 'Season year'
      _SalesDocumentScheduleLine._SalesDocumentItem.ProductSeasonYear,
      @EndUserText.label: 'Ship-to Party'
      _SalesDocumentScheduleLine._SalesDocumentItem.ShipToParty,
      @EndUserText.label: 'Requirement Creation Date'
      _SalesDocumentScheduleLine._SalesDocumentItem.CreationDate,
      @EndUserText.label: 'Sold-to Party'
      _SalesDocumentScheduleLine._SalesDocumentItem.SoldToParty,
      @EndUserText.label: 'Theme'
      _SalesDocumentScheduleLine._SalesDocumentItem.ProductTheme,
      @EndUserText.label: 'Payer'
      _SalesDocumentScheduleLine._SalesDocumentItem.Payer,
      @EndUserText.label: 'PRE/RE Indicator'
      _SalesDocumentScheduleLine._SalesDocumentItem.PRE_RE_Indicator,
      @EndUserText.label: 'Requested Shelf Date'
      _SalesDocumentScheduleLine._SalesDocumentItem.RequestedShelfDate,
      @EndUserText.label: 'Customer reference'
      _SalesDocumentScheduleLine._SalesDocumentItem.PurchaseOrderByCustomer,
      @EndUserText.label: 'Order Reason'
      _SalesDocumentScheduleLine._SalesDocumentItem.OrderReason,
      @EndUserText.label: 'Requirement Document Type'
      _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocumentType,
      @EndUserText.label: 'Contract end of validity'
      _SalesDocumentScheduleLine._SalesDocumentItem.AgrmtValdtyEndDate,
      @EndUserText.label: 'Goods Issue Date'
      _SalesDocumentScheduleLine.GoodsIssueDate,
      @EndUserText.label: 'Requirement Document Schedule Line'
      _SalesDocumentScheduleLine.ScheduleLine,
      @EndUserText.label: 'CDD (Confirmed Delivery Date)'
      _SalesDocumentScheduleLine.DeliveryDate,
      @EndUserText.label: 'Confirmed Shelf Date'
      _SalesDocumentScheduleLine.ConfirmedShelfDate,
      @EndUserText.label: 'Sold-to party Name'
      _Customer.OrganizationBPName1,
      @EndUserText.label: 'Distribut-chain-specific Material Status'
      _ProductSalesDelivery.ProductSalesStatus,
      @EndUserText.label: 'Sport Category'
      _Product.SportCategory,
      @EndUserText.label: 'Hard Launch Date'
      _SalesDocumentScheduleLine._SalesDocumentItem.HardLaunchDate,









      @EndUserText.label: 'Requirement Document'
      cast(
            concat(concat(RequirementDocumentNumber, '/'), RequirementDocumentItem)
            as arun_doc_item_unique_id preserving type
      )                                                                                                        as ARunDocumentItemUniqueID,
      cast(
            concat(concat(RequirementDocumentNumber, '/'), RequirementDocumentItem)
            as arun_doc_item_unique_id preserving type
      )                                                                                                        as DocumentItemConcatenatedID,
      //      @EndUserText.label: 'Ordered'
      @DefaultAggregation: #SUM
      RequestedRqmtQtyInBaseUnit,
      //      @EndUserText.label: 'Confirmed'
      @DefaultAggregation: #SUM
      ConfirmedRqmtQtyInBaseUnit,
      //      @EndUserText.label: 'Delivered'
      @DefaultAggregation: #SUM
      DeliveredQuantityInBaseUnit,
      //      @EndUserText.label: 'Open Demand'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Open Demand Quantity'
      OpenDemandQuantity,
      //      @EndUserText.label: 'Total Assigned'
      @DefaultAggregation: #SUM
      AssignedQuantityInBaseUnit,
      //      @EndUserText.label: 'Normal Assigned'
      @DefaultAggregation: #SUM
      NormalAssignedQuantityInBsUnt,
      //      @EndUserText.label: 'Preview Assigned'
      @DefaultAggregation: #SUM
      PreviewAssignedQuantityInBsUnt,
      //      @EndUserText.label: 'Temporary Assigned'
      @DefaultAggregation: #SUM
      ARunTmpAssignedQuantityInBsUnt,
      @EndUserText.label: 'UoM'
      BaseUnit,
      CalendarYear,
      CalendarMonth,
      CalendarMonthName,
      CalendarWeek,
      CalendarDay,
      @EndUserText.label: 'Product'
      Material,
      @EndUserText.label: 'Material Group'
      MaterialGroup,
      MaterialType,
      @EndUserText.label: 'Generic Product'
      CrossPlantConfigurableProduct,
      @EndUserText.label: 'Plant'
      Plant,
      @EndUserText.label: 'Sales Organization'
      SalesOrganization,
      @EndUserText.label: 'Distribution Channel'
      DistributionChannel,
      @EndUserText.label: 'Division'
      Division,
      SalesDistrict,
      @EndUserText.label: 'Sold-to party'
      Customer,
      CompanyCode,
      @EndUserText.label: 'Storage Location'
      StorageLocation,
      SupplyProtectionName,
      @EndUserText.label: 'Net Price'
      NetPriceAmount,
      @EndUserText.label: 'Requirement Document Currency'
      DocumentCurrency,
      RequirementSegment,
      SupAssgmtAggrgQtyUnit,
      /* Associations */
      _ProductText,
      _ProductGroupText,
      _ProductTypeText,
      _SalesOrgText,
      _DistrChnl,
      _Divn,
      _SalesDist,
      _Plant,
      _CompanyCode,
      _Customer,
      _BaseUnit,
      _RqmtText,
      _SalesDocumentScheduleLine._SalesDocumentItem.SalesDocument,
      _SalesDocumentScheduleLine._SalesDocumentItem._AdditionalMaterialGroup1
}
