/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 04.04.2023 | 19667     : SD_Feature - [Defect]-Feature - SDO  Enhance *
*              |            | DS4K949084                               *
*----------------------------------------------------------------------*/

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}
@Analytics.dataExtraction.enabled : true
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel:{
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #D,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'Enhanced view for Rejected Orderbook '

@UI.presentationVariant: [{ sortOrder: [{ by: 'RequirementType' },
                                        { by: 'RequirementDocumentNumber'},
                                        { by: 'RequirementDocumentItem'},
                                        { by: 'RequestedDeliveryDate'} ] }]

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_c_supdmndrejectedoball
  as select from zsd_i_supdmndalltotdmndcube_rj
{
            @UI:{lineItem:       [{ position: 330, importance: #HIGH }]}
            @EndUserText.label: 'Plant'
  key       Plant,
            @UI:{lineItem:       [{ position: 10, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Document Number'
  key       RequirementDocumentNumber,
            @UI:{lineItem:       [{ position: 20, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Document Item'
  key       RequirementDocumentItem,
            @UI:{lineItem:       [{ position: 25, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Type'
  key       RequirementType,
            @UI:{lineItem:       [{ position: 390, importance: #HIGH }]}
            @EndUserText.label: 'Requested Delivery Date'
  key       RequestedDeliveryDate,
            @UI:{lineItem:       [{ position: 30, importance: #HIGH }]}
            @EndUserText.label: 'UoM'
            BaseUnit                                                     as UoM,
            @UI:{lineItem:       [{ position: 53, importance: #HIGH }]}
            @EndUserText.label: 'Cancelled Qty'
            @DefaultAggregation: #SUM
            CanceledQuantity,
            @UI:{lineItem:       [{ position: 55, importance: #HIGH }]}
            @EndUserText.label: 'Delivered'
            @DefaultAggregation: #SUM
            DeliveredQuantityInBaseUnit                                  as Delivered,
            @UI:{lineItem:       [{ position: 60, importance: #HIGH }]}
            @EndUserText.label: 'Collection'
            ProductCollection                                            as Collections,
            @UI:{lineItem:       [{ position: 60, importance: #HIGH }]}
            @EndUserText.label: 'Collection Text'
            _ProductCollectionText.ProductCollectionText                 as CollectionText,
            @UI:{lineItem:       [{ position: 70, importance: #HIGH }]}
            @EndUserText.label: 'Confirmed Shelf Date'
            ConfirmedShelfDate                                           as ConfirmedShelfDate,
            @UI:{lineItem:       [{ position: 80, importance: #HIGH }]}
            @EndUserText.label: 'Created by (Demand)'
            CreatedByUser                                                as CreatedBy_Demand,
            @UI:{lineItem:       [{ position: 90, importance: #HIGH }]}
            @EndUserText.label: 'Customer group'
            CustomerGroup,
            @UI:{lineItem:       [{ position: 95, importance: #HIGH }]}
            @EndUserText.label: 'Customer group name'
            CustomerGroupName,
            @EndUserText.label: 'Customer reference'
            @UI:{lineItem:       [{ position: 100, importance: #HIGH }]}
            PurchaseOrderByCustomer                                      as CustomerReference,
            @EndUserText.label: 'Sold-to party PO type'
            @UI:{lineItem:       [{ position: 110, importance: #HIGH }]}
            SoldToPartyPoType,
            @EndUserText.label: 'Sold-to party PO type Text'
            @UI:{lineItem:       [{ position: 115, importance: #HIGH }]}
            _CustomerPurchaseOrderTypeText.CustomerPurchaseOrderTypeText as SoldToPartyPoTypeText,
            @EndUserText.label: 'Customers Product Number'
            @UI:{lineItem:       [{ position: 120, importance: #HIGH }]}
            MaterialByCustomer                                           as CustomersProductNumber,
            @EndUserText.label: 'Distribution Channel'
            @UI:{lineItem:       [{ position: 130, importance: #HIGH }]}
            DistributionChannel,
            @EndUserText.label: 'Distribution Channel Text'
            @UI:{lineItem:       [{ position: 135, importance: #HIGH }]}
            _DistrChnl.DistributionChannelName                           as DistributionChannelText,
            @EndUserText.label: 'Distribution-chain-specific status'
            @UI:{lineItem:       [{ position: 140, importance: #HIGH }]}
            ProductSalesStatus                                           as DistrChainSpecifMaterialStatus,
            @EndUserText.label: 'Distribution-chain-specific status Text'
            @UI:{lineItem:       [{ position: 145, importance: #HIGH }]}
            _SalesStatusText.ProductSalesStatusDescription               as DistrChainSpecifMateriaStatTxt,
            @EndUserText.label: 'Division'
            @UI:{lineItem:       [{ position: 150, importance: #HIGH }]}
            Division,
            @UI:{lineItem:       [{ position: 160, importance: #HIGH }]}
            @EndUserText.label: 'EAN'
            EAN,
            @EndUserText.label: 'Early Access Date'
            @UI:{lineItem:       [{ position: 170, importance: #HIGH }]}
            EarlyAccessDate,
            @EndUserText.label: 'Fulfillment Date'
            @UI:{lineItem:       [{ position: 180, importance: #HIGH }]}
            FulfillmentDate,
            @EndUserText.label: 'Fulfillment Scenario'
            @UI:{lineItem:       [{ position: 190, importance: #HIGH }]}
            FulfillmentScenario,
            @EndUserText.label: 'Fulfillment Scenario Text'
            @UI:{lineItem:       [{ position: 195, importance: #HIGH }]}
            _FullfillmentScenarioText.FullfillmentScenarioText,
            @UI:{lineItem:       [{ position: 200, importance: #HIGH }]}
            @EndUserText.label: 'Generic Product'
            CrossPlantConfigurableProduct                                as GenericProduct,
            @UI:{lineItem:       [{ position: 200, importance: #HIGH }]}
            @EndUserText.label: 'Generic Product Text'
            _GenericProductText.ProductName,
            @UI:{lineItem:       [{ position: 210, importance: #HIGH }]}
            @EndUserText.label: 'Converted Size'
            ProductCharacteristic2                                       as ConvertedSize,
            @EndUserText.label: 'Hard Launch Date'
            @UI:{lineItem:       [{ position: 220, importance: #HIGH }]}
            HardLaunchDate,
            @EndUserText.label: 'Sold-to party PO Item '
            UnderlyingPurchaseOrderItem                                  as SoldToPartyPoItem,
            @UI:{lineItem:       [{ position: 233, importance: #HIGH }]}
            @EndUserText.label: 'Material Group'
            MaterialGroup,
            @UI:{lineItem:       [{ position: 235, importance: #HIGH }]}
            @EndUserText.label: 'Material Group Text'
            _ProductGroupText.MaterialGroupName                          as MaterialGroupText,
            @UI:{lineItem:       [{ position: 235, importance: #HIGH }]}
            @EndUserText.label: 'Product Group Long'
            _ProductGroupText.MaterialGroupText                          as ProductGroupLong,
            @UI:{lineItem:       [{ position: 240, importance: #HIGH }]}
            @EndUserText.label: 'Material group 1'
            AdditionalMaterialGroup1                                     as MaterialGroup1,
            @UI:{lineItem:       [{ position: 250, importance: #HIGH }]}
            @EndUserText.label: 'Product'
            Material                                                     as Product,
            @EndUserText.label: 'Sold-to party Name'
            @UI:{lineItem:       [{ position: 260, importance: #HIGH }]}
            SoldToPartyName,
            @UI:{lineItem:       [{ position: 270, importance: #HIGH }]}
            @EndUserText.label: 'Net Price'
            NetPriceAmount                                               as NetPrice,
            @UI:{lineItem:       [{ position: 280, importance: #HIGH }]}
            @EndUserText.label: 'Net Value'
            NetAmount                                                    as NetValue,
            @UI:{lineItem:       [{ position: 290, importance: #HIGH }]}
            @EndUserText.label: 'Cancellation Date'
            FashionCancelDate                                            as CancellationDate,
            @UI:{lineItem:       [{ position: 300, importance: #HIGH }]}
            @EndUserText.label: 'Order Reason'
            OrderReason,
            @UI:{lineItem:       [{ position: 305, importance: #HIGH }]}
            @EndUserText.label: 'Order Reason Text'
            _OrderReasonText.OrderReasonText,
            @UI:{lineItem:       [{ position: 310, importance: #HIGH }]}
            @EndUserText.label: 'Payer'
            Payer,
            @UI:{lineItem:       [{ position: 315, importance: #HIGH }]}
            @EndUserText.label: 'Payer Name'
            _PayerAddress.BusinessPartnerName1                           as PayerText,
            @UI:{lineItem:       [{ position: 320, importance: #HIGH }]}
            @EndUserText.label: 'Goods Issue Date'
            GoodsIssueDate,
            @UI:{lineItem:       [{ position: 335, importance: #HIGH }]}
            @EndUserText.label: 'Plant Name'
            _Plant.PlantName,
            @UI:{lineItem:       [{ position: 340, importance: #HIGH }]}
            @EndUserText.label: 'Shipping Point'
            ShippingPoint,
            @UI:{lineItem:       [{ position: 350, importance: #HIGH }]}
            @EndUserText.label: 'PRE/RE Indicator'
            PRE_RE_Indicator,
            @UI:{lineItem:       [{ position: 360, importance: #HIGH }]}
            @EndUserText.label: 'Rejection Code'
            SalesDocumentRjcnReason                                      as RejectionCode,
            @UI:{lineItem:       [{ position: 370, importance: #HIGH }]}
            @EndUserText.label: 'Rejection Date'
            LastChangeDate                                               as RejectionDate,
            @UI:{lineItem:       [{ position: 380, importance: #HIGH }]}
            @EndUserText.label: 'Rejection Description'
            SalesDocumentRjcnReasonName                                  as RejectionDescription,
            @UI:{lineItem:       [{ position: 400, importance: #HIGH }]}
            @EndUserText.label: 'Requested Shelf Date'
            RequestedShelfDate,
            @UI:{lineItem:       [{ position: 410, importance: #HIGH }]}
            @EndUserText.label: 'Retail Intro Date'
            RetailIntroDate,
            @UI:{lineItem:       [{ position: 420, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Item category'
            SalesDocumentItemCategory                                    as RequirementItemCategory,
            @UI:{lineItem:       [{ position: 425, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Item category Text'
            _SDItemCaategoryText.SalesDocumentItemCategoryText,
            @UI:{lineItem:       [{ position: 430, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Document Type'
            SalesDocumentType                                            as RequirementDocumentType,
            @UI:{lineItem:       [{ position: 440, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Document Type Text'
            _SDTypeText.SalesDocumenTypeText                             as RequirementDocumentTypeText,
            @UI:{lineItem:       [{ position: 450, importance: #HIGH }]}
            @EndUserText.label: 'Sales Office'
            SalesOffice,
            @UI:{lineItem:       [{ position: 460, importance: #HIGH }]}
            @EndUserText.label: 'CDD (Confirmed Delivery Date)'
            DeliveryDate                                                 as ConfirmedDeliveryDate,
            @UI:{lineItem:       [{ position: 470, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Document Schedule Line'
            ScheduleLine                                                 as RequirementDocumentScheduleLin,
            @UI:{lineItem:       [{ position: 480, importance: #HIGH }]}
            @EndUserText.label: 'Sales Organization'
            SalesOrganization,
            @UI:{lineItem:       [{ position: 490, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Document Currency'
            DocumentCurrency                                             as RequirementDocumentCurrency,
            @UI:{lineItem:       [{ position: 500, importance: #HIGH }]}
            @EndUserText.label: 'Season'
            ProductSeason                                                as Season,
            @UI:{lineItem:       [{ position: 505, importance: #HIGH }]}
            @EndUserText.label: 'Season Description'
            _ProductSeasonText.ProductSeasonText,
            @UI:{lineItem:       [{ position: 510, importance: #HIGH }]}
            @EndUserText.label: 'Season year'
            ProductSeasonYear                                            as SeasonYear,
            @UI:{lineItem:       [{ position: 520, importance: #HIGH }]}
            @EndUserText.label: 'Ship-to Party'
            ShipToParty,
            @UI:{lineItem:       [{ position: 530, importance: #HIGH }]}
            @EndUserText.label: 'Ship-to party name'
            ShipToPartyName,
            @UI:{lineItem:       [{ position: 540, importance: #HIGH }]}
            @EndUserText.label: 'Requirement Creation Date'
            CreationDate                                                 as RequirementCreationDate,
            @UI:{lineItem:       [{ position: 550, importance: #HIGH }]}
            @EndUserText.label: 'Sold-to Party'
            SoldToParty,
            @UI:{lineItem:       [{ position: 560, importance: #HIGH }]}
            @EndUserText.label: 'Sport Category'
            _Product.SportCategory,
            @UI:{lineItem:       [{ position: 570, importance: #HIGH }]}
            @EndUserText.label: 'Sport Description'
            SportDescription,
            @UI:{lineItem:       [{ position: 580, importance: #HIGH }]}
            @EndUserText.label: 'Storage Location'
            StorageLocation,
            @UI:{lineItem:       [{ position: 585, importance: #HIGH }]}
            @EndUserText.label: 'Storage Location Name'
            _StorageLocation.StorageLocationName,
            @UI:{lineItem:       [{ position: 590, importance: #HIGH }]}
            @EndUserText.label: 'Theme'
            ProductTheme                                                 as Theme,
            @UI:{lineItem:       [{ position: 595, importance: #HIGH }]}
            @EndUserText.label: 'Theme description'
            _ProductThemeText.ProductThemeText                           as ThemeDescription,
            @UI:{lineItem:       [{ position: 600, importance: #HIGH }]}
            @EndUserText.label: 'Open Demand Quantity'
            OpenDemandQuantity                                           as OpenDemandQuantity,
            @UI:{lineItem:       [{ position: 610, importance: #HIGH }]}
            @EndUserText.label: 'UPC'
            ean11                                                        as UPC,
            @UI:{lineItem:       [{ position: 620, importance: #HIGH }]}
            @EndUserText.label: 'Contract end of validity'
            AgrmtValdtyEndDate                                           as ContractEndOfValidity,
            @EndUserText.label: 'Department'
            Department,
            SupProtTimeBucketUUID,
            ProductAvailabilityDate,
            @EndUserText.label: 'Requested Quantity'
            RequestedRqmtQtyInBaseUnit                                   as RequestedQuantity,
            @EndUserText.label: 'Confirmed'
            ConfirmedRqmtQtyInBaseUnit,
            @EndUserText.label: 'Delivered'
            @DefaultAggregation: #SUM
            DeliveredQuantityInBaseUnit,
            @EndUserText.label: 'Total Assigned'
            @DefaultAggregation: #SUM
            AssignedQuantityInBaseUnit,
            @EndUserText.label: 'Normal Assigned'
            @DefaultAggregation: #SUM
            NormalAssignedQuantityInBsUnt,
            TransactionCurrency,
            @EndUserText.label: 'Quantity'
            OrderQuantity,
            OrderQuantityUnit,
            @EndUserText.label: 'Requirement Creation Date'
            CreationDate,
            @EndUserText.label: 'Requirement Document'
            cast(
                  concat(concat(RequirementDocumentNumber, '/'), RequirementDocumentItem)
                  as arun_doc_item_unique_id preserving type
            )                                                            as ARunDocumentItemUniqueID,
            cast(
                  concat(concat(RequirementDocumentNumber, '/'), RequirementDocumentItem)
                  as arun_doc_item_unique_id preserving type
            )                                                            as DocumentItemConcatenatedID,

            @EndUserText.label: 'Preview Assigned'
            @DefaultAggregation: #SUM
            PreviewAssignedQuantityInBsUnt,
            @EndUserText.label: 'Temporary Assigned'
            @DefaultAggregation: #SUM
            ARunTmpAssignedQuantityInBsUnt,
            CalendarYear,
            CalendarMonth,
            CalendarMonthName,
            CalendarWeek,
            CalendarDay,
            @EndUserText.label: 'Eligible for Dedication'
            EligibleForDedication,
            BillingQuantityUnit,
            @EndUserText.label: 'Invoiced Qty'
            InvoicedQty                                                  as InvoicedQty,
            @EndUserText.label: 'Sub Brand'
            SubBrand,
            @EndUserText.label: 'Tech Size/Value'
            TechSizeValue,
            MaterialType,
            @EndUserText.label: 'Product Type Long'
            _ProductTypeText.MaterialTypeName                            as ProductTypeLong,
            SalesDistrict,
            @EndUserText.label: 'Sold-to party'
            Customer,
            CompanyCode,
            SupplyProtectionName,
            RequirementSegment,
            Language,
            /* Associations */
            _ProductCollectionText,
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
            _RqmtText
}
