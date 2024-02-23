/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
************************************************************************
* BALUNYAN     | 27.02.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 04.04.2023 | 19667     : SD_Feature - [Defect]-Feature - SDO  Enhance *
*              |            | DS4K949084                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Cube View Total Demand All Document Type'
define view entity zsd_i_supdmndalltotdmndcube_rj
  as select from    zsd_i_supdmndalltotdmnd_rj     as Demand
    left outer join ZPE_I_HM( iv_id: '0000000789') as Language  on Language.sequence = '001'

    left outer join I_SDDocumentCompletePartners   as SDPartner on  Demand.RequirementDocumentNumber = SDPartner.SDDocument
                                                                and '000000'                               = SDPartner.SDDocumentItem
                                                                and Demand.Payer                = SDPartner.Customer
                                                                and SDPartner.PartnerFunction        = 'RG'

  association        to I_Address                     as _PayerAddress                  on  SDPartner.AddressID = _PayerAddress.AddressID
  association        to zsd_i_product_rj              as _Product                       on  $projection.Material = _Product.Product
  association        to I_ProductSalesDelivery        as _ProductSalesDelivery          on  $projection.Material            = _ProductSalesDelivery.Product
                                                                                        and $projection.SalesOrganization   = _ProductSalesDelivery.ProductSalesOrg
                                                                                        and $projection.DistributionChannel = _ProductSalesDelivery.ProductDistributionChnl
  association        to I_ProductText                 as _ProductText                   on  $projection.Material = _ProductText.Product
                                                                                        and $projection.Language = _ProductText.Language
  association        to I_ProductText                 as _GenericProductText            on  $projection.CrossPlantConfigurableProduct = _GenericProductText.Product
                                                                                        and $projection.Language                      = _GenericProductText.Language
  association        to I_ProductGroupText            as _ProductGroupText              on  $projection.MaterialGroup = _ProductGroupText.MaterialGroup
                                                                                        and $projection.Language      = _ProductGroupText.Language
  association        to I_ProductTypeText             as _ProductTypeText               on  $projection.MaterialType  = _ProductTypeText.ProductType
                                                                                        and _ProductTypeText.Language = $projection.Language
  association        to I_SalesOrganizationText       as _SalesOrgText                  on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                                        and _SalesOrgText.Language        = $projection.Language
  association        to I_DistributionChannelText     as _DistrChnl                     on  $projection.DistributionChannel = _DistrChnl.DistributionChannel
                                                                                        and _DistrChnl.Language             = $projection.Language
  association        to I_DivisionText                as _Divn                          on  $projection.Division = _Divn.Division
                                                                                        and _Divn.Language       = $projection.Language
  association        to I_SalesDistrictText           as _SalesDist                     on  $projection.SalesDistrict = _SalesDist.SalesDistrict
                                                                                        and _SalesDist.Language       = $projection.Language
  association        to I_Plant                       as _Plant                         on  $projection.Plant = _Plant.Plant
  association        to I_CompanyCode                 as _CompanyCode                   on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association        to I_Customer                    as _Customer                      on  $projection.Customer = _Customer.Customer
  association        to I_UnitOfMeasure               as _BaseUnit                      on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association        to I_SupDmndAllDocRqmtTypeT      as _RqmtText                      on  $projection.RequirementType = _RqmtText.RequirementType
                                                                                        and _RqmtText.Language          = $projection.Language
  association        to I_CustomerGroup               as _CustomerGroup                 on  $projection.CustomerGroup = _CustomerGroup.CustomerGroup
  association        to zsd_i_product_collection_text as _ProductCollectionText         on  $projection.ProductSeasonYear = _ProductCollectionText.SeasonYear
                                                                                        and $projection.ProductSeason     = _ProductCollectionText.Season
                                                                                        and $projection.ProductCollection = _ProductCollectionText.ProductCollection
                                                                                        and $projection.Language          = _ProductCollectionText.Language
  association        to zsd_i_fullfillment_scenario_t as _FullfillmentScenarioText      on  $projection.FulfillmentScenario = _FullfillmentScenarioText.FullfillmentScenario
                                                                                        and $projection.Language            = _FullfillmentScenarioText.Language
  association        to zsd_i_order_reason_text       as _OrderReasonText               on  $projection.OrderReason = _OrderReasonText.OrderReason
                                                                                        and $projection.Language    = _OrderReasonText.Language
  association        to zsd_i_sd_item_category_text   as _SDItemCaategoryText           on  $projection.SalesDocumentItemCategory = _SDItemCaategoryText.SalesDocumentItemCategory
                                                                                        and $projection.Language                  = _SDItemCaategoryText.Language
  association        to zsd_i_product_theme_text      as _ProductThemeText              on  $projection.ProductSeasonYear = _ProductThemeText.SeasonYear
                                                                                        and $projection.ProductSeason     = _ProductThemeText.Season
                                                                                        and $projection.ProductCollection = _ProductThemeText.ProductCollection
                                                                                        and $projection.ProductTheme      = _ProductThemeText.ProductTheme
                                                                                        and $projection.Language          = _ProductThemeText.Language
  association        to zsd_i_product_season_text     as _ProductSeasonText             on  $projection.ProductSeasonYear = _ProductSeasonText.SeasonYear
                                                                                        and $projection.ProductSeason     = _ProductSeasonText.ProductSeason
                                                                                        and $projection.Language          = _ProductSeasonText.Language
  association        to I_SalesDistributionStatusText as _SalesStatusText               on  $projection.productsalesstatus = _SalesStatusText.ProductSalesStatus
                                                                                        and $projection.Language           = _SalesStatusText.Language
  association        to zsd_i_customer_po_type_text   as _CustomerPurchaseOrderTypeText on  $projection.SoldToPartyPoType = _CustomerPurchaseOrderTypeText.CustomerPurchaseOrderType
                                                                                        and $projection.Language          = _CustomerPurchaseOrderTypeText.Language
  association        to zsd_i_sd_type_text            as _SDTypeText                    on  $projection.SalesDocumentType = _SDTypeText.SalesDocumentType
                                                                                        and $projection.Language          = _SDTypeText.Language
  association        to I_StorageLocation             as _StorageLocation               on  $projection.StorageLocation = _StorageLocation.StorageLocation
                                                                                        and $projection.Plant           = _StorageLocation.Plant
  association        to I_SalesDocumentRjcnReasonText as _SalesDocumentRjcnReasonText   on  $projection.SalesDocumentRjcnReason = _SalesDocumentRjcnReasonText.SalesDocumentRjcnReason
                                                                                        and $projection.Language                = _SalesDocumentRjcnReasonText.Language
  association [0..1] to I_Customer                    as _ShipToParty                   on  $projection.ShipToParty = _ShipToParty.Customer
  association [0..1] to zsd_i_billingdocumensum       as _BillingDocumentItem           on  $projection.RequirementDocumentNumber = _BillingDocumentItem.ReferenceSDDocument
                                                                                        and $projection.RequirementDocumentItem   = _BillingDocumentItem.ReferenceSDDocumentItem

{
            @EndUserText.label: 'Requirement Document Number'
  key       Demand.RequirementDocumentNumber,
            @EndUserText.label: 'Requirement Document Item'
  key       Demand.RequirementDocumentItem,
            @ObjectModel.text.association: '_RqmtText'
            @EndUserText.label: 'Requirement Type'
  key       Demand.RequirementType,
            @EndUserText.label: 'Requested Delivery Date'
  key       case  when DATS_IS_VALID(Demand.RequestedDeliveryDate)  = 1
            then Demand.RequestedDeliveryDate end                                                 as RequestedDeliveryDate,
            @EndUserText.label: 'Delivery Date'
  key       Demand.ProductAvailabilityDate,
            Demand.SupProtTimeBucketUUID,
            @EndUserText.label: 'Requested Date'
            Demand.RequestedDate                                                                  as RequestedDate,
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.RequestedRqmtQtyInBaseUnit,
            @EndUserText.label: 'Canceled Quantity A'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.RequestedRqmtQtyInBaseUnit                                                     as CanceledQuantity_A,
            @EndUserText.label: 'Canceled Quantity B'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            cast( cast( Demand.RequestedRqmtQtyInBaseUnit as abap.decfloat16 ) -
            cast( Demand.DeliveredQuantityInBaseUnit as abap.decfloat16 ) as abap.quan( 13, 3 ) ) as CanceledQuantity_B,
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            cast( cast( Demand.RequestedRqmtQtyInBaseUnit as abap.decfloat16 ) -
            cast( Demand.DeliveredQuantityInBaseUnit as abap.decfloat16 ) as abap.quan( 13, 3 ) ) as CanceledQuantity,
            @EndUserText.label: 'Confirmed Quantity'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.ConfirmedRqmtQtyInBaseUnit,
            @EndUserText.label: 'Delivered Quantity'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.DeliveredQuantityInBaseUnit,
            @EndUserText.label: 'Open Demand Quantity'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.OpenDemandQuantity,
            @EndUserText.label: 'Total Assigned Quantity'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.AssignedQuantityInBaseUnit,
            @EndUserText.label: 'Normal Assigned Quantity'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.NormalAssignedQuantityInBsUnt,
            @EndUserText.label: 'Preview Assigned Quantity'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.PreviewAssignedQuantityInBsUnt,
            @EndUserText.label: 'Temporary Assigned Quantity'
            @DefaultAggregation: #SUM
            @Semantics.quantity.unitOfMeasure: 'BaseUnit'
            Demand.ARunTmpAssignedQuantityInBsUnt,
            @ObjectModel.foreignKey.association: '_BaseUnit'
            Demand.BaseUnit,
            @EndUserText.label: 'Year'
            @Semantics.calendar.year: true
            Demand.CalendarYear,
            @EndUserText.label: 'Month'
            @Semantics.calendar.month: true
            Demand.CalendarMonth,
            @Semantics.text: true
            @EndUserText.label: 'Month'
            Demand.CalendarMonthName,
            @EndUserText.label: 'Week'
            @Semantics.calendar.week: true
            Demand.CalendarWeek,
            @EndUserText.label: 'Day'
            @Semantics.calendar.dayOfMonth: true
            Demand.CalendarDay,
            @ObjectModel.text.association: '_ProductText'
            @EndUserText.label: 'Product'
            Demand.Material,
            @ObjectModel.text.association: '_ProductGroupText'
            @EndUserText.label: 'Product Group'
            Demand.MaterialGroup,
            @ObjectModel.text.association: '_ProductTypeText'
            @EndUserText.label: 'Product Type'
            Demand.MaterialType,
            @EndUserText.label: 'Generic Product'
            Demand.CrossPlantConfigurableProduct,
            @ObjectModel.text.association: '_Plant'
            @EndUserText.label: 'Plant'
            Demand.Plant,
            @ObjectModel.text.association: '_SalesOrgText'
            @EndUserText.label: 'Sales Organization'
            Demand.SalesOrganization,
            @ObjectModel.text.association: '_DistrChnl'
            @EndUserText.label: 'Distribution Channel'
            Demand.DistributionChannel,
            @ObjectModel.text.association: '_Divn'
            @EndUserText.label: 'Division'
            Demand.Division,
            @ObjectModel.text.association: '_SalesDist'
            @EndUserText.label: 'Sales District'
            Demand.SalesDistrict,
            @ObjectModel.text.association: '_Customer'
            @EndUserText.label: 'Customer'
            Demand.Customer,
            @ObjectModel.text.association: '_CompanyCode'
            @EndUserText.label: 'Company Code'
            Demand.CompanyCode,
            Demand.StorageLocation,
            @EndUserText.label: 'Supply Protection Name'
            Demand.SupplyProtectionName,
            cast( ' ' as meins )                                                                  as SupAssgmtAggrgQtyUnit,
            @Semantics.amount.currencyCode: 'DocumentCurrency'
            Demand.NetPriceAmount,
            Demand.DocumentCurrency,
            Demand.RequirementSegment,
            Demand.PlantCountry,
            Demand.PlantRegion,
            Demand.ProductCollection,
            Demand.CreatedByUser,
            Demand.UnderlyingPurchaseOrderItem,
            Demand.SalesDocumentItemText,
            Demand.AdditionalMaterialGroup1,
            Demand.CustomerGroup,
            Demand.MaterialByCustomer,
            Demand.ean11,
            Demand.ProductCharacteristic2,
            case when DATS_IS_VALID(Demand.FulfillmentDate)  = 1
            then Demand.FulfillmentDate end                                                       as FulfillmentDate,
            Demand.FulfillmentScenario,
            @Semantics.amount.currencyCode: 'TransactionCurrency'
            Demand.NetAmount,
            Demand.TransactionCurrency,
            case when DATS_IS_VALID(Demand.FashionCancelDate)  = 1
              then Demand.FashionCancelDate end                                                   as FashionCancelDate,
            Demand.ShippingPoint,
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
            Demand.OrderQuantity,
            Demand.OrderQuantityUnit,
            Demand.SalesDocumentRjcnReason,
            _SalesDocumentRjcnReasonText.SalesDocumentRjcnReasonName                              as SalesDocumentRjcnReasonName,
            case when DATS_IS_VALID(Demand.LastChangeDate)  = 1
            then Demand.LastChangeDate end                                                        as LastChangeDate,
            Demand.SalesDocumentItemCategory,
            Demand.SalesOffice,
            Demand.ProductSeason,
            Demand.ProductSeasonYear,
            Demand.ShipToParty,
            case when DATS_IS_VALID(Demand.CreationDate)  = 1
            then Demand.CreationDate end                                                          as CreationDate,
            Demand.SoldToParty,
            Demand.ProductTheme,
            Demand.Payer,
            Demand.PRE_RE_Indicator,
            case when DATS_IS_VALID(Demand.RequestedShelfDate)  = 1
            then Demand.RequestedShelfDate end                                                    as RequestedShelfDate,
            Demand.PurchaseOrderByCustomer,
            Demand.OrderReason,
            Demand.SalesDocumentType,
            case when DATS_IS_VALID(Demand.AgrmtValdtyEndDate)  = 1
            then Demand.AgrmtValdtyEndDate end                                                    as AgrmtValdtyEndDate,
            case when DATS_IS_VALID(Demand.GoodsIssueDate)  = 1
            then Demand.GoodsIssueDate end                                                        as GoodsIssueDate,
            Demand.ScheduleLine,
            case when DATS_IS_VALID(Demand.DeliveryDate)  = 1
            then Demand.DeliveryDate end                                                          as DeliveryDate,
            case when DATS_IS_VALID(Demand.ConfirmedShelfDate)  = 1
            then Demand.ConfirmedShelfDate end                                                    as ConfirmedShelfDate,
            Demand.EAN,
            case when DATS_IS_VALID(Demand.RetailIntroDate)  = 1
            then Demand.RetailIntroDate end                                                       as RetailIntroDate,
            case when DATS_IS_VALID(Demand.EarlyAccessDate)  = 1
            then Demand.EarlyAccessDate end                                                       as EarlyAccessDate,
            case when DATS_IS_VALID(Demand.HardLaunchDate)  = 1
            then Demand.HardLaunchDate end                                                        as HardLaunchDate,
            _ShipToParty.CustomerName                                                             as ShipToPartyName,
            Demand.SoldToPartyName,
            Demand.SoldToPartyPoType,
            _ProductSalesDelivery.ProductSalesStatus,
            _Product._SportsCodeDescriptions[1:spras = $projection.language].zzmsn                as SportDescription,
            Language.field1                                                                       as Language,
            _CustomerGroup._Text[1:Language = $projection.language].CustomerGroupName,
            SDPartner.AddressID,
            ''                                                                                    as EligibleForDedication,
            _BillingDocumentItem.BillingQuantityUnit,
            @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
            _BillingDocumentItem.BillingQuantity                                                  as InvoicedQty,
            ''                                                                                    as SubBrand,
            Demand.ProductCharacteristic2                                                         as TechSizeValue,
            ''                                                                                    as Department,
            //Associations
            _ProductSalesDelivery,
            _Product,
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
            _CustomerGroup,
            _ProductCollectionText,
            _FullfillmentScenarioText,
            _OrderReasonText,
            _SDItemCaategoryText,
            _ProductThemeText,
            _ProductSeasonText,
            _CustomerPurchaseOrderTypeText,
            _SDTypeText,
            _StorageLocation,
            _SalesStatusText,
            _GenericProductText,
            _PayerAddress,
            _RqmtText
}
