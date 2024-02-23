/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZUJSKAS      | 31.01.2023 | FB_17550_SD_Feature - Supply Demand Overview  (SDO) E*
*              |            | DS4K942335                                *
* ZUJSKAS      | 12.04.2023 | FB_19677_SD_Feature - Supply Demand Overview  (SDO) E*
*              |            | DS4K949096                                *
*----------------------------------------------------------------------*/

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Shipped OB cube'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_SupDmndAllDocShipOBCube
  as select from    ZSD_I_SupDmndAllDocShipOB      as Delivery
    left outer join ZPE_I_HM( iv_id: '0000000789') as Language  on Language.sequence = '001'
    left outer join ZSD_I_SupDmndAllDocDemand      as Demand    on  Demand.RequirementDocumentNumber = Delivery.SDDocument
                                                                and Demand.RequirementDocumentItem   = Delivery.SDDocumentItem
    left outer join ZSD_I_SupDmndProduct           as Product   on Demand.Material = Product.Product
    left outer join ZSD_I_SupDmndSalesArea         as SalesArea on  Demand.Customer            = SalesArea.Customer
                                                                and Demand.SalesOrganization   = SalesArea.SalesOrganization
                                                                and Demand.DistributionChannel = SalesArea.DistributionChannel
                                                                and Demand.Division            = SalesArea.OrganizationDivision
    left outer join I_SDDocumentCompletePartners   as SDPartner on  Demand.RequirementDocumentNumber = SDPartner.SDDocument
                                                                and '000000'                         = SDPartner.SDDocumentItem
                                                                and Demand.PayerParty                = SDPartner.Customer
                                                                and SDPartner.PartnerFunction        = 'RG'
  association [0..1] to zsd_i_product_collection_text  as _ProductCollectionText      on  $projection.ProductSeasonYear = _ProductCollectionText.SeasonYear
                                                                                      and $projection.ProductSeason     = _ProductCollectionText.Season
                                                                                      and $projection.ProductCollection = _ProductCollectionText.ProductCollection
                                                                                      and $projection.Language          = _ProductCollectionText.Language

  association [0..1] to zsd_i_product_season_text      as _ProductSeasonText          on  $projection.ProductSeasonYear = _ProductSeasonText.SeasonYear
                                                                                      and $projection.ProductSeason     = _ProductSeasonText.ProductSeason
                                                                                      and $projection.Language          = _ProductSeasonText.Language

  association [0..1] to zsd_i_product_theme_text       as _ProductThemeText           on  $projection.ProductSeasonYear = _ProductThemeText.SeasonYear
                                                                                      and $projection.ProductSeason     = _ProductThemeText.Season
                                                                                      and $projection.ProductCollection = _ProductThemeText.ProductCollection
                                                                                      and $projection.ProductTheme      = _ProductThemeText.ProductTheme
                                                                                      and $projection.Language          = _ProductThemeText.Language

  association [0..1] to I_Plant                        as _Plant                      on  $projection.Plant = _Plant.Plant

  association [0..1] to zsd_i_order_reason_text        as _OrderReasonText            on  $projection.SDDocumentReason = _OrderReasonText.OrderReason
                                                                                      and $projection.Language         = _OrderReasonText.Language

  association [0..1] to zsd_i_fullfillment_scenario_t  as _FullfillmentScenarioText   on  $projection.FulfillmentScenario = _FullfillmentScenarioText.FullfillmentScenario
                                                                                      and $projection.Language            = _FullfillmentScenarioText.Language

  association [0..1] to I_AdditionalCustomerGroup1     as _AdditionalCustomerGroup1   on  $projection.AdditionalCustomerGroup1 = _AdditionalCustomerGroup1.AdditionalCustomerGroup1
  association [0..1] to I_AdditionalCustomerGroup5     as _AdditionalCustomerGroup5   on  $projection.AdditionalCustomerGroup5 = _AdditionalCustomerGroup5.AdditionalCustomerGroup5

  association [0..1] to zsd_i_additional_customer_grp6 as _AdditionalCustomerGroup6   on  $projection.SalesOrganization        = _AdditionalCustomerGroup6.SalesOrganization
                                                                                      and $projection.AdditionalCustomerGroup6 = _AdditionalCustomerGroup6.AdditionalCustomerGroup6

  association [0..1] to zsd_i_additional_custmr_grp10  as _AdditionalCustomerGroup10  on  $projection.SalesOrganization         = _AdditionalCustomerGroup10.SalesOrganization
                                                                                      and $projection.AdditionalCustomerGroup10 = _AdditionalCustomerGroup10.AdditionalCustomerGroup10

  association [0..1] to ZSC_C_DELV_PRIO_T              as _DeliveryPriorityText       on  $projection.DeliveryPriority = _DeliveryPriorityText.Code
                                                                                      and $projection.Language         = _DeliveryPriorityText.Language

  association [0..1] to I_DistributionChannelText      as _DistrChnl                  on  $projection.DistributionChannel = _DistrChnl.DistributionChannel
                                                                                      and $projection.Language            = _DistrChnl.Language

  association [0..1] to I_SalesDistributionStatusText  as _SalesStatusText            on  $projection.DistribChainSpecifMatStat = _SalesStatusText.ProductSalesStatus
                                                                                      and $projection.Language                  = _SalesStatusText.Language
  association [0..1] to I_Customer                     as _Customer                   on  Demand.Customer = _Customer.Customer

  association [0..1] to zsd_i_sd_item_category_text    as _SDItemCategoryText         on  $projection.SalesDocumentItemCategory = _SDItemCategoryText.SalesDocumentItemCategory
                                                                                      and $projection.Language                  = _SDItemCategoryText.Language

  association [0..1] to zsd_i_sd_type_text             as _SDTypeText                 on  $projection.SalesDocumentType = _SDTypeText.SalesDocumentType
                                                                                      and $projection.Language          = _SDTypeText.Language

  association [0..1] to I_ShippingTypeText             as _ShippingTypeText           on  $projection.ShippingType = _ShippingTypeText.ShippingType
                                                                                      and $projection.Language     = _ShippingTypeText.Language

  association [0..1] to I_StorageLocation              as _StorageLocation            on  $projection.StorageLocation = _StorageLocation.StorageLocation
                                                                                      and $projection.Plant           = _StorageLocation.Plant

  association [0..1] to I_BillingDocumentItemBasic     as _BillingDocumentItem        on  $projection.RequirementDocumentNumber    =  _BillingDocumentItem.ReferenceSDDocument
                                                                                      and $projection.RequirementDocumentItem      =  _BillingDocumentItem.ReferenceSDDocumentItem
                                                                                      and _BillingDocumentItem.ReferenceSDDocument <> ''

  association [0..1] to zsd_i_sport_category_text      as _SportCategoryText          on  $projection.SportCategory = _SportCategoryText.SportCategory
                                                                                      and $projection.Language      = _SportCategoryText.Language
  association [0..1] to zsd_i_supdmnd_shipped_qty_shob as _Supdmnd_Shipped_Qty        on  $projection.DeliveryDocument     = _Supdmnd_Shipped_Qty.DeliveryDocument
                                                                                      and $projection.DeliveryDocumentItem = _Supdmnd_Shipped_Qty.DeliveryDocumentItem
  association [0..1] to ZSD_I_SupDmndOvwTechSize       as _TechSize                   on  $projection.CrossPlantConfigurableProduct = _TechSize.objek
                                                                                      and $projection.ProductCharacteristic2        = _TechSize.atwrt
  association [0..1] to ZSD_I_SupDmndGridValue         as _SupDmndGridValue           on  $projection.MatConvId              = _SupDmndGridValue.MatConvId
                                                                                      and $projection.CustSuppID             = _SupDmndGridValue.CustSuppID
                                                                                      and $projection.ProductCharacteristic2 = _SupDmndGridValue.CharacteristicValue
  association [0..1] to zsd_i_out_dn_event_datetime    as _OutDNEventTime             on  _OutDNEventTime.HeadHandler = Delivery.EventHeadHandler
  association [0..1] to ZSP_I_ROUTES_TP                as _Routes                     on  Delivery.Route = _Routes.route
  association [0..1] to I_ProductGroupText             as _ProductGroupText           on  $projection.MaterialGroup = _ProductGroupText.MaterialGroup
                                                                                      and $projection.Language      = _ProductGroupText.Language
  association [0..1] to I_ProductTypeText              as _ProductTypeText            on  $projection.MaterialType = _ProductTypeText.ProductType
                                                                                      and $projection.Language     = _ProductTypeText.Language
  association [0..1] to I_SalesOrganizationText        as _SalesOrgText               on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                                      and $projection.Language          = _SalesOrgText.Language
  association [0..1] to I_DivisionText                 as _Divn                       on  $projection.Division = _Divn.Division
                                                                                      and $projection.Language = _Divn.Language
  association [0..1] to I_SalesDistrictText            as _SalesDist                  on  $projection.SalesDistrict = _SalesDist.SalesDistrict
                                                                                      and $projection.Language      = _SalesDist.Language
  association [0..1] to I_CompanyCode                  as _CompanyCode                on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_Address                      as _PayerAddress               on  SDPartner.AddressID = _PayerAddress.AddressID
  association [0..1] to I_CustomerGroup                as _CustomerGroup              on  $projection.CustomerGroup = _CustomerGroup.CustomerGroup
  association [0..1] to I_PurchasingDocumentTypeText   as _PurchasingDocumentTypeText on  Demand.OrderType             = _PurchasingDocumentTypeText.PurchasingDocumentType
                                                                                      and Demand.PurchaseOrderCategory = _PurchasingDocumentTypeText.PurchasingDocumentCategory
                                                                                      and $projection.Language         = _PurchasingDocumentTypeText.Language

  association [0..1] to I_SupDmndAllDocRqmtTypeT       as _RqmtText                   on  $projection.RequirementType = _RqmtText.RequirementType
                                                                                      and _RqmtText.Language          = $projection.Language

{

      @EndUserText.label: 'Delivery Note Number'
  key Delivery.RequirementDocumentNumber   as DeliveryDocument,
      @EndUserText.label: 'Delivery Note Item'
  key Delivery.RequirementDocumentItem     as DeliveryDocumentItem,
      @EndUserText.label: 'Requested Date'
  key Demand.RequestedDate,
      @EndUserText.label: 'Material Staging/Availability Date'
  key Delivery.ProductAvailabilityDate,
      @ObjectModel.text.association: '_RqmtText'
      @EndUserText.label: 'Requirement type'
  key Demand.RequirementType,
      Delivery.HigherLvlItmOfBatSpltItm,
      @EndUserText.label: 'Requested delivery date'
      Demand.RequestedDeliveryDate,
      @EndUserText.label: 'CDD (Confirmed Delivery Date)'
      Demand.ConfirmedDeliveryDate,
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      @EndUserText.label: 'Delivery Quantity'
      Delivery.DeliveredQuantity,
      Delivery.SupAssgmtAggrgQtyUnit,
      @EndUserText.label: 'UoM'
      Demand.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      @EndUserText.label: 'Cummulative Confirmed Qty'
      Demand.CumulativeConfirmedQuantity,
      @Semantics.calendar.year: true
      @EndUserText.label: 'Year'
      Delivery.CalendarYear,
      @EndUserText.label: 'Month'
      @Semantics.calendar.month: true
      @ObjectModel.text.element: ['CalendarMonthName']
      Delivery.CalendarMonth,
      @Semantics.text: true
      @EndUserText.label: 'Month'
      Delivery.CalendarMonthName,
      @EndUserText.label: 'Week'
      @Semantics.calendar.week: true
      Delivery.CalendarWeek,
      @EndUserText.label: 'Day'
      @Semantics.calendar.dayOfMonth: true
      Delivery.CalendarDay,
      @ObjectModel.text.association: '_ProductGroupText'
      @EndUserText.label: 'Product Group'
      Delivery.MaterialGroup,
      @ObjectModel.text.association: '_ProductTypeText'
      @EndUserText.label: 'Product Type'
      Delivery.MaterialType,
      @ObjectModel.text.element: ['ShippingTypeName']
      Demand.ShippingType,
      _ShippingTypeText.ShippingTypeName,
      @ObjectModel.text.association: '_SalesOrgText'
      Delivery.SalesOrganization,
      @ObjectModel.text.association: '_Divn'
      Delivery.Division,
      @ObjectModel.text.association: '_SalesDist'
      Delivery.SalesDistrict,
      @EndUserText.label: 'Delivery Note Type'
      Delivery.DeliveryDocumentType,
      @ObjectModel.text.association: '_CompanyCode'
      Delivery.CompanyCode,
      @ObjectModel.text.element: ['StorageLocationText']
      Demand.StorageLocation,
      @EndUserText.label: 'Storage Location Name'
      _StorageLocation.StorageLocationName as StorageLocationText,
      @EndUserText.label: 'Requirement Document Number'
      Delivery.SDDocument                  as RequirementDocumentNumber,
      @EndUserText.label: 'Requirement Document Item'
      Delivery.SDDocumentItem              as RequirementDocumentItem,
      @EndUserText.label: 'Delivery Status'
      Delivery.DeliveryStatus,
      @EndUserText.label: 'Actual GI Date'
      Delivery.ActualGoodsMovementDate,
      @EndUserText.label: 'Planned GI Date'
      Delivery.PlannedGoodsIssueDate,
      @EndUserText.label: 'Shipped Qty'
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      _Supdmnd_Shipped_Qty.ShippedQty,
      _Supdmnd_Shipped_Qty.DeliveryQuantityUnit,
      @EndUserText.label: 'EDD (Estim.Deliv.Time)'
      case
      //with actual Post Goods Issue
        when Delivery.ActualGoodsMovementDate is not initial
        then dats_add_days (Delivery.ActualGoodsMovementDate, cast( div(_Routes.traztd, 240000) as abap.int4 ), 'INITIAL')
      //without Post Goods Issue
        when ( _OutDNEventTime.zwsplngdis_even_tstfr_date is initial or _OutDNEventTime.zwsplngdis_even_tstfr_date is null ) and
             ( _OutDNEventTime.zwsprjgdis_even_tstfr_date is initial or _OutDNEventTime.zwsprjgdis_even_tstfr_date is null )
        then dats_add_days (Delivery.PlannedGoodsIssueDate, cast( div(_Routes.traztd, 240000) as abap.int4 ), 'INITIAL')
        when ( _OutDNEventTime.zwsplngdis_even_tstfr_date is not initial ) and
             ( _OutDNEventTime.zwsprjgdis_even_tstfr_date is initial or _OutDNEventTime.zwsprjgdis_even_tstfr_date is null )
        then dats_add_days (_OutDNEventTime.zwsplngdis_even_tstfr_date, cast( div(_Routes.traztd, 240000) as abap.int4 ), 'INITIAL')
        when _OutDNEventTime.zwsprjgdis_even_tstfr_date is not initial
        then dats_add_days (_OutDNEventTime.zwsprjgdis_even_tstfr_date, cast( div(_Routes.traztd, 240000) as abap.int4 ), 'INITIAL')
      end                                  as EstimatedDeliveryDate,

      @ObjectModel.text.element: ['ProductCollectionText']
      @EndUserText.label: 'Collection'
      Demand.ProductCollection,
      @EndUserText.label: 'Collection description'
      _ProductCollectionText.ProductCollectionText,
      @EndUserText.label: 'Season year'
      Demand.ProductSeasonYear,
      @ObjectModel.text.element: ['ProductSeasonText']
      @EndUserText.label: 'Season'
      Demand.ProductSeason,
      @EndUserText.label: 'Season description'
      _ProductSeasonText.ProductSeasonText,
      @ObjectModel.text.element: ['ProductThemeText']
      @EndUserText.label: 'Theme'
      Demand.ProductTheme,
      @EndUserText.label: 'Theme description'
      _ProductThemeText.ProductThemeText,
      @EndUserText.label: 'Customer reference'
      Demand.PurchaseOrderByCustomer,
      @EndUserText.label: 'Sold-to party PO type'
      Demand.CustomerPurchaseOrderType,
      @EndUserText.label:'Sport Category'
      Demand.SportCategory,
      @EndUserText.label:'Sport Category Description'
      _SportCategoryText.SportCategoryText,
      @EndUserText.label: 'Confirmed Shelf Date'
      Demand.ConfirmedShelvedDate,
      @EndUserText.label: 'Customer group'
      Demand.CustomerGroup,
      @EndUserText.label: 'Customer group'
      _CustomerGroup._Text[1: Language = $projection.language ].CustomerGroupName,
      @ObjectModel.text.element: ['AdditionalCustomerGroup1Name']
      @EndUserText.label: 'Customer group 1'
      Demand.AdditionalCustomerGroup1,
      @EndUserText.label: 'Customer group 1 description'
      _AdditionalCustomerGroup1._Text[1: Language = $projection.language ].AdditionalCustomerGroup1Name,
      @ObjectModel.text.element: ['AdditionalCustomerGroup5Name']
      @EndUserText.label: 'Customer group 5'
      Demand.AdditionalCustomerGroup5,
      @EndUserText.label: 'Customer group 5 description'
      _AdditionalCustomerGroup5._Text[1: Language = $projection.language ].AdditionalCustomerGroup5Name,
      @ObjectModel.text.element: ['AdditionalCustomerGroup6Name']
      @EndUserText.label: 'Customer group 6'
      Demand.AdditionalCustomerGroup6,
      @EndUserText.label: 'Customer group 6 description'
      _AdditionalCustomerGroup6._Text[1: Language = $projection.language ].AdditionalCustomerGroup6Name,
      @EndUserText.label: 'Customer group 10'
      Demand.AdditionalCustomerGroup10,
      @EndUserText.label: 'Customer group 10 description'
      _AdditionalCustomerGroup10._Text[1: Language = $projection.language ].AdditionalCustomerGroup10Name,
      @ObjectModel.text.element: ['DeliveryPriorityText']
      @EndUserText.label: 'Delivery Priority'
      Demand.DeliveryPriority,
      @EndUserText.label: 'Delivery Priority description'
      _DeliveryPriorityText.Description    as DeliveryPriorityText,
      @ObjectModel.text.association: '_DistrChnl'
      Demand.DistributionChannel,
      @EndUserText.label: 'Customer Product Number'
      Demand.MaterialByCustomer,
      @EndUserText.label: 'Distr-chain-specific material status'
      @ObjectModel.text.association:'_SalesStatusText'
      Demand.DistribChainSpecifMatStat,
      @EndUserText.label: 'EAN'
      Demand.EAN,
      @EndUserText.label: 'Fulfillment Date'
      Demand.FulfillmentDate,
      @ObjectModel.text.element: ['FullfillmentScenarioText']
      @EndUserText.label: 'Fulfillment Scenario'
      Demand.FulfillmentScenario,
      _FullfillmentScenarioText.FullfillmentScenarioText,
      @EndUserText.label: 'Generic Product'
      Demand.CrossPlantConfigurableProduct,
      @EndUserText.label: 'Created by (Delivery)'
      Delivery.CreatedByDel,
      @EndUserText.label: 'Created by (Demand)'
      Demand.CreatedByUser                 as CreatedBySO,
      @EndUserText.label: 'Created on (Delivery)'
      Delivery.CreatedOnDel,
      @EndUserText.label: 'Sold-to party PO Item'
      Demand.UnderlyingPurchaseOrderItem,
      @EndUserText.label: 'Product'
      Demand.Material,
      @EndUserText.label: 'Material Description'
      Demand.SalesDocumentItemText,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @EndUserText.label: 'Net price'
      Demand.NetPriceAmount,
      @EndUserText.label: 'Requirement Document Currency'
      Demand.DocumentCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      Demand.NetAmount,
      Demand.TransactionCurrency,
      @ObjectModel.text.element: ['SDDocumentReasonText']
      @EndUserText.label: 'Order Reason'
      Demand.SDDocumentReason,
      @EndUserText.label: 'Order Reason description'
      _OrderReasonText.OrderReasonText     as SDDocumentReasonText,
      @EndUserText.label: 'Planned GI Date'
      Demand.GoodsIssueDate,

      @ObjectModel.text.association: '_Plant'
      Demand.Plant,
      @EndUserText.label: 'Sold-to Party'
      @ObjectModel.text.association: '_Customer'
      @ObjectModel.text.element: ['SoldToPartyName']
      Demand.Customer,
      @EndUserText.label: 'Sold-to party Name'
      Demand.SoldToPartyName,

      @EndUserText.label: 'Planned Delivery Time(Days)'
      Demand.PlannedDeliveryTime,

      Demand.PREIndicator,
      Demand.PrepackHoldIndicator,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      @EndUserText.label: 'Requested Quantity'
      Demand.RequestedRqmtQtyInBaseUnit,
      @EndUserText.label: 'Requested Shelf date'
      Demand.RequestedShelfDate,
      @ObjectModel.text.element: ['SalesDocumentItemCategoryText']
      @EndUserText.label: 'Requirement Item category'
      Demand.SalesDocumentItemCategory,
      @EndUserText.label: 'Requirement Item category Description'
      _SDItemCategoryText.SalesDocumentItemCategoryText,
      @EndUserText.label: 'Requirement Document Type'
      Demand.OrderType                     as SalesDocumentType,
      @EndUserText.label: 'Requirement Document Type Description'
      case
      when Demand.RequirementType = 'U1'
      then _PurchasingDocumentTypeText.PurchasingDocumentTypeName
      else _SDTypeText.SalesDocumenTypeText
      end                                  as SalesDocumenTypeText,
      @EndUserText.label: 'Requirement Document Schedule Line'
      Demand.ScheduleLine,

      @EndUserText.label: 'Ship-to Party'
      @ObjectModel.text.element: ['ShipToPartyName']
      Demand.ShipToParty,
      @EndUserText.label: 'Ship-to Party name'
      Demand.ShipToPartyName,
      @EndUserText.label: 'Plant/ Shipping point'
      Demand.ShippingPoint,
      @EndUserText.label: 'Requirement Creation Date'
      Demand.CreationDate,

      @ObjectModel.text.element: ['PayerPartyName']
      Demand.PayerParty,
      _PayerAddress.BusinessPartnerName1   as PayerPartyName,

      @EndUserText.label: 'Converted Size'
      _SupDmndGridValue.GridValue,
      Product.MatConvId,
      SalesArea.CustSuppID,

      @EndUserText.label: 'Billing Date'
      case
        when Demand.RequirementType = 'VC' or
             Demand.RequirementType = 'VI' or
             Demand.RequirementType = 'VS' or
             Demand.RequirementType = 'VE'
             then cast('00000000' as fkdat)
        when Demand.RequirementType = 'U1'
             then
             coalesce(_BillingDocumentItem._BillingDocumentBasic.BillingDocumentDate,
                       Delivery.BillingDate)
        else cast('00000000' as fkdat)
      end                                  as BillingDate,
      @EndUserText.label: 'Invoice'
      _BillingDocumentItem.BillingDocument as Invoice,
      @EndUserText.label: 'Billing Status(header)'
      case
        when Demand.RequirementType = 'VC' or
             Demand.RequirementType = 'VI' or
             Demand.RequirementType = 'VS' or
             Demand.RequirementType = 'VE'
             then Delivery.DelRelBillStatusAll
        when Demand.RequirementType = 'U1'
             then Delivery.IntercompBillStatusAll
        else ''
      end                                  as BillingStatusHeader,
      @EndUserText.label: 'Billing Status(item)'
      case
        when Demand.RequirementType = 'VC' or
             Demand.RequirementType = 'VI' or
             Demand.RequirementType = 'VS' or
             Demand.RequirementType = 'VE'
             then Delivery.DelRelBillStatusItem
        when Demand.RequirementType = 'U1'
             then Delivery.IntercompBillStatusItem
        else ''
      end                                  as BillingStatusItem,
      @EndUserText.label: 'Early Access Date'
      Demand.EarlyAccessDate,
      @EndUserText.label: 'Hard Launch Date'
      Demand.HardLaunchDate,
      @EndUserText.label: 'UPC'
      Demand.UPC,
      @EndUserText.label: 'Total Gds Mvt Stat. (GI)'
      Demand.TotalGdsMvtStat,
      @EndUserText.label: 'Billing block(item)'
      Demand.BillingBlockItem,
      Demand.ProductCharacteristic2,
      @EndUserText.label: 'Tech Size/Value'
      _TechSize.atwtb                      as TechSize,

      Delivery.EventHeadHandler,
      _OutDNEventTime.HeadHandler,
      _OutDNEventTime.zwsplnpick_even_tstfr_date,
      _OutDNEventTime.zwsplnpick_even_tstfr_time,
      _OutDNEventTime.zwsplnpick_even_zonfr,
      _OutDNEventTime.zwsplnload_even_tstfr_date,
      _OutDNEventTime.zwsplnload_even_tstfr_time,
      _OutDNEventTime.zwsplnload_even_zonfr,
      _OutDNEventTime.zwsplngdis_even_tstfr_date,
      _OutDNEventTime.zwsplngdis_even_tstfr_time,
      _OutDNEventTime.zwsplngdis_even_zonfr,
      _OutDNEventTime.zwsplandel_even_tstfr_date,
      _OutDNEventTime.zwsplandel_even_tstfr_time,
      _OutDNEventTime.zwsplandel_even_zonfr,
      _OutDNEventTime.zwsactrece_even_tstfr_date,
      _OutDNEventTime.zwsactrece_even_tstfr_time,
      _OutDNEventTime.zwsactrece_even_zonfr,
      _OutDNEventTime.zwsactpick_even_tstfr_date,
      _OutDNEventTime.zwsactpick_even_tstfr_time,
      _OutDNEventTime.zwsactpick_even_zonfr,
      _OutDNEventTime.zwsactpack_even_tstfr_date,
      _OutDNEventTime.zwsactpack_even_tstfr_time,
      _OutDNEventTime.zwsactpack_even_zonfr,
      _OutDNEventTime.zwsactload_even_tstfr_date,
      _OutDNEventTime.zwsactload_even_tstfr_time,
      _OutDNEventTime.zwsactload_even_zonfr,
      _OutDNEventTime.zwsactgdis_even_tstfr_date,
      _OutDNEventTime.zwsactgdis_even_tstfr_time,
      _OutDNEventTime.zwsactgdis_even_zonfr,
      _OutDNEventTime.zwsprjgdis_even_tstfr_date,
      _OutDNEventTime.zwsprjgdis_even_tstfr_time,
      _OutDNEventTime.zwsprjgdis_even_zonfr,
      _OutDNEventTime.zwsreqrout_even_tstfr_date,
      _OutDNEventTime.zwsreqrout_even_tstfr_time,
      _OutDNEventTime.zwsreqrout_even_zonfr,
      _OutDNEventTime.zwsactrout_even_tstfr_date,
      _OutDNEventTime.zwsactrout_even_tstfr_time,
      _OutDNEventTime.zwsactrout_even_zonfr,
      _OutDNEventTime.zwsactdeli_even_tstfr_date,
      _OutDNEventTime.zwsactdeli_even_tstfr_time,
      _OutDNEventTime.zwsactdeli_even_zonfr,
      _OutDNEventTime.zwsactdeli_even_tstto_date,
      _OutDNEventTime.zwsactdeli_even_tstto_time,
      _OutDNEventTime.zwsactdeli_even_zonto,
      _OutDNEventTime.zstconshel_even_tstfr_date,
      _OutDNEventTime.zstconshel_even_tstfr_time,
      _OutDNEventTime.zstconshel_even_zonfr,


      Language.field1                      as Language,

      //Associations
      _Plant,
      _DistrChnl,
      _SalesOrgText,
      _Divn,
      _SalesDist,
      _CompanyCode,
      _SalesStatusText,
      _Customer,
      _ProductGroupText,
      _ProductTypeText,
      _StorageLocation,
      _CustomerGroup,
      _RqmtText
}
