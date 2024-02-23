/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.11.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}
@EndUserText.label: 'I_SupDmndAllDocAssgmtCube Custom View'
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #D,
     sizeCategory:   #XXL
   }
}
@Metadata:{
  allowExtensions:              true,
  ignorePropagatedAnnotations:  false
}
define view entity ZSD_I_SupDmndAllDocAssgmtCube
  as select from    ZSD_I_SupDmndAllDocAssgmt      as Assgmt
    left outer join ZPE_I_HM( iv_id: '0000000789') as Language  on Language.sequence = '001'

    left outer join I_SDDocumentCompletePartners   as SDPartner on  Assgmt.RequirementDocumentNumber = SDPartner.SDDocument
                                                                and '000000'                               = SDPartner.SDDocumentItem
                                                                and Assgmt.PayerParty                = SDPartner.Customer
                                                                and SDPartner.PartnerFunction        = 'RG'
  association [0..1] to I_ProductText                  as _ProductText                   on  $projection.Material = _ProductText.Product
                                                                                         and $projection.Language = _ProductText.Language
  association [0..1] to I_ProductGroupText             as _ProductGroupText              on  $projection.MaterialGroup = _ProductGroupText.MaterialGroup
                                                                                         and $projection.Language      = _ProductGroupText.Language
  //Should it be replaced with I_MaterialGroupText as ProductGroup has status Deprecated?
  association [0..1] to I_ProductTypeText              as _ProductTypeText               on  $projection.MaterialType = _ProductTypeText.ProductType
                                                                                         and $projection.Language     = _ProductTypeText.Language
  association [0..1] to I_SalesOrganizationText        as _SalesOrgText                  on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                                         and $projection.Language          = _SalesOrgText.Language
  association [0..1] to I_DistributionChannelText      as _DistrChnl                     on  $projection.DistributionChannel = _DistrChnl.DistributionChannel
                                                                                         and $projection.Language            = _DistrChnl.Language
  association [0..1] to I_DivisionText                 as _Divn                          on  $projection.Division = _Divn.Division
                                                                                         and $projection.Language = _Divn.Language
  association [0..1] to I_SalesDistrictText            as _SalesDist                     on  $projection.SalesDistrict = _SalesDist.SalesDistrict
                                                                                         and $projection.Language      = _SalesDist.Language
  association [0..1] to I_Plant                        as _Plant                         on  $projection.Plant = _Plant.Plant
  association [0..1] to I_CompanyCode                  as _CompanyCode                   on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_Customer                     as _Customer                      on  $projection.Customer = _Customer.Customer
  association [0..1] to I_UnitOfMeasure                as _BaseUnit                      on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_SupDmndAllDocRqmtTypeT       as _RqmtText                      on  $projection.RequirementType = _RqmtText.RequirementType
                                                                                         and $projection.Language        = _RqmtText.Language
  association [0..1] to I_SupDmndAllDocSupTypeT        as _SupText                       on  $projection.AssignedSupplyType = _SupText.AssignedSupplyType
                                                                                         and $projection.Language           = _SupText.Language
  association [0..1] to I_SupDmndAllDocSupSourceT      as _SupSrceText                   on  $projection.SupAssgmtSource = _SupSrceText.SupAssgmtSource
                                                                                         and $projection.Language        = _SupSrceText.Language
  association [0..1] to I_ARunSupDlyHrznText           as _SupDlyHrznText                on  $projection.ARunSupDlyHrznInWeeks = _SupDlyHrznText.ARunSupDlyHrznInWeeks
                                                                                         and $projection.Language              = _SupDlyHrznText.Language
  association [0..1] to I_CustomerGroup                as _CustomerGroup                 on  $projection.CustomerGroup = _CustomerGroup.CustomerGroup

  association [0..1] to I_AdditionalCustomerGroup1     as _AdditionalCustomerGroup1      on  $projection.AdditionalCustomerGroup1 = _AdditionalCustomerGroup1.AdditionalCustomerGroup1
  association [0..1] to I_AdditionalCustomerGroup5     as _AdditionalCustomerGroup5      on  $projection.AdditionalCustomerGroup5 = _AdditionalCustomerGroup5.AdditionalCustomerGroup5
  association [0..1] to zsd_i_additional_customer_grp6 as _AdditionalCustomerGroup6      on  $projection.SalesOrganization        = _AdditionalCustomerGroup6.SalesOrganization
                                                                                         and $projection.AdditionalCustomerGroup6 = _AdditionalCustomerGroup6.AdditionalCustomerGroup6
  association [0..1] to zsd_i_product_collection_text  as _ProductCollectionText         on  $projection.ProductSeasonYear = _ProductCollectionText.SeasonYear
                                                                                         and $projection.ProductSeason     = _ProductCollectionText.Season
                                                                                         and $projection.ProductCollection = _ProductCollectionText.ProductCollection
                                                                                         and $projection.Language          = _ProductCollectionText.Language
  association [0..1] to zsd_i_fullfillment_scenario_t  as _FullfillmentScenarioText      on  $projection.FulfillmentScenario = _FullfillmentScenarioText.FullfillmentScenario
                                                                                         and $projection.Language            = _FullfillmentScenarioText.Language
  association [0..1] to zsd_i_order_reason_text        as _OrderReasonText               on  $projection.SDDocumentReason = _OrderReasonText.OrderReason
                                                                                         and $projection.Language         = _OrderReasonText.Language
  association [0..1] to zsd_i_sd_item_category_text    as _SDItemCaategoryText           on  $projection.SalesDocumentItemCategory = _SDItemCaategoryText.SalesDocumentItemCategory
                                                                                         and $projection.Language                  = _SDItemCaategoryText.Language
  association [0..1] to zsd_i_product_theme_text       as _ProductThemeText              on  $projection.ProductSeasonYear = _ProductThemeText.SeasonYear
                                                                                         and $projection.ProductSeason     = _ProductThemeText.Season
                                                                                         and $projection.ProductCollection = _ProductThemeText.ProductCollection
                                                                                         and $projection.ProductTheme      = _ProductThemeText.ProductTheme
                                                                                         and $projection.Language          = _ProductThemeText.Language
  association [0..1] to zsd_i_product_season_text      as _ProductSeasonText             on  $projection.ProductSeasonYear = _ProductSeasonText.SeasonYear
                                                                                         and $projection.ProductSeason     = _ProductSeasonText.ProductSeason
                                                                                         and $projection.Language          = _ProductSeasonText.Language
  association [0..1] to zsd_i_customer_po_type_text    as _CustomerPurchaseOrderTypeText on  $projection.CustomerPurchaseOrderType = _CustomerPurchaseOrderTypeText.CustomerPurchaseOrderType
                                                                                         and $projection.Language                  = _CustomerPurchaseOrderTypeText.Language

  association [0..1] to zsd_i_sd_type_text             as _SDTypeText                    on  $projection.SalesDocumentType = _SDTypeText.SalesDocumentType
                                                                                         and $projection.Language          = _SDTypeText.Language
  association [0..1] to zsd_i_deliv_block_reason_text  as _DeveliryBlockReasonText       on  $projection.DeliveryBlockReason = _DeveliryBlockReasonText.DeliveryBlockReason
                                                                                         and $projection.Language            = _DeveliryBlockReasonText.Language
  association [0..1] to I_Address                      as _PayerAddress                  on  SDPartner.AddressID = _PayerAddress.AddressID
  association [0..1] to I_Supplier                     as _Supplier                      on  $projection.Vendor = _Supplier.Supplier
  association [0..1] to ZSC_C_DELV_PRIO_T              as _DeliveryPriorityText          on  $projection.DeliveryPriority = _DeliveryPriorityText.Code
                                                                                         and $projection.Language         = _DeliveryPriorityText.Language
  association [0..1] to I_StorageLocation              as _StorageLocation               on  $projection.StorageLocation = _StorageLocation.StorageLocation
                                                                                         and $projection.Plant           = _StorageLocation.Plant
  association [0..1] to I_Shippinginstructiontext      as _ShippingInstructionText       on  $projection.Language            = _ShippingInstructionText.Language
                                                                                         and $projection.ShippingInstruction = _ShippingInstructionText.ShippingInstruction
  association [0..1] to I_SalesDistributionStatusText  as _SalesStatusText               on  $projection.DistribChainSpecifMatStat = _SalesStatusText.ProductSalesStatus
                                                                                         and $projection.Language                  = _SalesStatusText.Language
  association [0..1] to zsd_i_confirm_category_txt     as _ConfirmationCategoryText      on  $projection.ConfirmationCategoryCode = _ConfirmationCategoryText.ConfirmationCategoryCode
                                                                                         and $projection.Language                 = _ConfirmationCategoryText.Language
  association [0..1] to I_PurchasingDocumentTypeText   as _PurchasingDocumentTypeText    on  $projection.PurchaseOrderType     = _PurchasingDocumentTypeText.PurchasingDocumentType
                                                                                         and $projection.PurchaseOrderCategory = _PurchasingDocumentTypeText.PurchasingDocumentCategory
                                                                                         and $projection.Language              = _PurchasingDocumentTypeText.Language
  association [0..1] to I_PurchasingOrganization       as _PurchasingOrganizationText    on  $projection.PurchasingOrganization = _PurchasingOrganizationText.PurchasingOrganization
  association [0..1] to I_ShippingTypeText             as _ShippingTypeText              on  $projection.ShippingType = _ShippingTypeText.ShippingType
  association [0..1] to I_CountryText                  as _CountryText                   on  $projection.CountryFrom = _CountryText.Country
                                                                                         and $projection.Language    = _CountryText.Language
{
      @ObjectModel.text.association: '_Plant'
  key Assgmt.Plant,
      @ObjectModel.text.association: '_ProductText'
      @EndUserText.label: 'Product'
  key Assgmt.Material,
      @ObjectModel.text.element: ['StorageLocationText']
  key Assgmt.StorageLocation,
  key Assgmt.Batch,
      @ObjectModel.text.association: '_RqmtText'
      @EndUserText.label: 'Requirement Type'
  key Assgmt.RequirementType,
      @EndUserText.label: 'Requirement Document Number'
  key Assgmt.RequirementDocumentNumber,
      @EndUserText.label: 'Requirement Document Item'
  key Assgmt.RequirementDocumentItem,
  key Assgmt.SupProtTimeBucketUUID,
      @ObjectModel.text.association: '_SupText'
      @EndUserText.label: 'Supply Type'
  key Assgmt.AssignedSupplyType,
      @EndUserText.label: 'Supply Document No.'
  key Assgmt.SupplyNumber,
      @EndUserText.label: 'Supply Document Item'
  key Assgmt.SupplyItem,
      @EndUserText.label: 'Supply Schedule Line'
  key Assgmt.SupplyScheduleLine,
      @EndUserText.label: 'Requested Date'
  key Assgmt.RequestedDate,
      @EndUserText.label: 'Delivery Date'
  key Assgmt.ProductAvailabilityDate,
      @EndUserText.label: 'Supply Delivery Date'
  key Assgmt.SupplyDeliveryDate,
      @EndUserText.label: 'Supply Assignment Status'
  key Assgmt.SupplyAssignmentStatus,
      Assgmt.RequestedDeliveryDate,
      @EndUserText.label: 'Mat. Avail Date - Supply Delivery Date'
      @ObjectModel.text.association: '_SupDlyHrznText'
      Assgmt.ARunSupDlyHrznInWeeks,
      @EndUserText.label: 'Supply Source'
      @ObjectModel.text.association: '_SupSrceText'
      Assgmt.SupAssgmtSource,
      @Semantics.calendar.year: true
      @EndUserText.label: 'Year'
      Assgmt.CalendarYear,
      @EndUserText.label: 'Month'
      @Semantics.calendar.month: true
      @ObjectModel.text.element: ['CalendarMonthName']
      Assgmt.CalendarMonth,
      @Semantics.text: true
      @EndUserText.label: 'Month'
      Assgmt.CalendarMonthName,
      @EndUserText.label: 'Week'
      @Semantics.calendar.week: true
      Assgmt.CalendarWeek,
      @EndUserText.label: 'Day'
      @Semantics.calendar.dayOfMonth: true
      Assgmt.CalendarDay,
      @EndUserText.label: 'Cummulative Confirmed Qty'
      Assgmt.CumulativeConfirmedQuantity,
      @EndUserText.label: 'Total Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      Assgmt.AssignedQuantityInBaseUnit,
      @EndUserText.label: 'Normal Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      Assgmt.NormalAssignedQuantityInBsUnt,
      @EndUserText.label: 'Preview Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      Assgmt.PreviewAssignedQuantityInBsUnt,
      @EndUserText.label: 'Temporary Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      Assgmt.ARunTmpAssignedQuantityInBsUnt,
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Requested Quantity'
      Assgmt.RequestedRqmtQtyInBaseUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      @EndUserText.label: 'Unconfirmed Quantity'
      Assgmt.OpenDemandQuantity,
      @ObjectModel.foreignKey.association: '_BaseUnit'
      Assgmt.BaseUnit,
      @ObjectModel.text.association: '_ProductGroupText'
      @EndUserText.label: 'Product Group'
      Assgmt.MaterialGroup,
      @ObjectModel.text.association: '_ProductTypeText'
      @EndUserText.label: 'Product Type'
      Assgmt.MaterialType,
      @EndUserText.label: 'Generic Product'
      Assgmt.CrossPlantConfigurableProduct,
      @EndUserText.label: 'Supply Protection Name'
      Assgmt.SupplyProtectionName,
      @ObjectModel.text.association: '_SalesOrgText'
      Assgmt.SalesOrganization,
      @ObjectModel.text.association: '_DistrChnl'
      Assgmt.DistributionChannel,
      @ObjectModel.text.association: '_Divn'
      Assgmt.Division,
      @ObjectModel.text.association: '_SalesDist'
      Assgmt.SalesDistrict,
      @ObjectModel.text.association: '_CompanyCode'
      Assgmt.CompanyCode,
      cast( ' ' as meins )                 as SupAssgmtAggrgQtyUnit,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Assgmt.NetPriceAmount,
      Assgmt.DocumentCurrency,
      Assgmt.RequirementSegment,
      @EndUserText.label: 'Season year'
      Assgmt.ProductSeasonYear,
      @ObjectModel.text.element: ['ProductSeasonText']
      @EndUserText.label: 'Season'
      Assgmt.ProductSeason,
      @EndUserText.label: 'Season'
      _ProductSeasonText.ProductSeasonText,
      @ObjectModel.text.element: ['ProductCollectionText']
      @EndUserText.label: 'Collection'
      Assgmt.ProductCollection,
      @EndUserText.label: 'Collection'
      _ProductCollectionText.ProductCollectionText,
      @EndUserText.label: 'Confirmed Shelf Date'
      Assgmt.ConfirmedShelvedDate,
      @EndUserText.label: 'Created by (Demand)'
      Assgmt.CreatedByUser,
      @ObjectModel.text.element: ['CustomerGroupName']
      @EndUserText.label: 'Customer group'
      Assgmt.CustomerGroup,
      @EndUserText.label: 'Customer group'
      _CustomerGroup._Text[1: Language = $projection.language ].CustomerGroupName,
      @ObjectModel.text.element: ['AdditionalCustomerGroup1Name']
      @EndUserText.label: 'Customer group 1'
      Assgmt.AdditionalCustomerGroup1,
      @EndUserText.label: 'Customer group 1'
      _AdditionalCustomerGroup1._Text[1: Language = $projection.language ].AdditionalCustomerGroup1Name,
      @ObjectModel.text.element: ['AdditionalCustomerGroup5Name']
      @EndUserText.label: 'Customer group 5'
      Assgmt.AdditionalCustomerGroup5,
      @EndUserText.label: 'Customer group 5'
      _AdditionalCustomerGroup5._Text[1: Language = $projection.language ].AdditionalCustomerGroup5Name,
      @ObjectModel.text.element: ['AdditionalCustomerGroup6Name']
      @EndUserText.label: 'Customer group 6'
      Assgmt.AdditionalCustomerGroup6,
      @EndUserText.label: 'Customer group 6'
      _AdditionalCustomerGroup6._Text[1: Language = $projection.language ].AdditionalCustomerGroup6Name,
      @ObjectModel.text.element: ['DeliveryPriorityText']
      @EndUserText.label: 'Delivery Priority'
      Assgmt.DeliveryPriority,
      @EndUserText.label: 'Delivery Priority'
      _DeliveryPriorityText.Description    as DeliveryPriorityText,
      @EndUserText.label: 'Distribut-chain-specific material status'
      @ObjectModel.text.association:'_SalesStatusText'
      Assgmt.DistribChainSpecifMatStat,
      @EndUserText.label: 'Requirement Document Schedule Line'
      Assgmt.ScheduleLine,
      Assgmt.GoodsIssueDate,
      @EndUserText.label: 'CDD (Confirmed Delivery Date)'
      Assgmt.ConfirmedDeliveryDate,
      @EndUserText.label: 'EDD (Estim.Deliv.Time)'
      Assgmt.EstimatedDeliveryDate,
      Assgmt.EAN,
      Assgmt.FulfillmentDate,
      @ObjectModel.text.element: ['FullfillmentScenarioText']
      Assgmt.FulfillmentScenario,
      _FullfillmentScenarioText.FullfillmentScenarioText,
      @EndUserText.label: 'Tech Size/Value'
      Assgmt.TechSize,
      Assgmt.UnderlyingPurchaseOrderItem,
      @EndUserText.label: 'Material Description'
      Assgmt.SalesDocumentItemText,
      @ObjectModel.text.element: ['MaterialGroup1Text']
      Assgmt.AdditionalMaterialGroup1,
      Assgmt.MaterialGroup1Text,
      Assgmt.NetAmount,
      Assgmt.TransactionCurrency,
      Assgmt.FashionCancelDate,
      @ObjectModel.text.element: ['PayerPartyName']
      Assgmt.PayerParty,
      _PayerAddress.BusinessPartnerName1   as PayerPartyName,
      @ObjectModel.text.element: ['OrderReasonText']
      @EndUserText.label: 'Order Reason'
      Assgmt.SDDocumentReason,
      @EndUserText.label: 'Order Reason'
      _OrderReasonText.OrderReasonText,
      Assgmt.PREIndicator,
      Assgmt.PrepackHoldIndicator,
      @EndUserText.label: 'Requested Shelf date'
      Assgmt.RequestedShelfDate,
      @ObjectModel.text.element: ['SalesDocumentItemCategoryText']
      Assgmt.SalesDocumentItemCategory,
      _SDItemCaategoryText.SalesDocumentItemCategoryText,
      @ObjectModel.text.element: ['ShippingTypeName']
      Assgmt.ShippingType,
      _ShippingTypeText.ShippingTypeName,
      @EndUserText.label: 'Ship-to Party'
      @ObjectModel.text.element: ['ShipToPartyName']
      Assgmt.ShipToParty,
      @EndUserText.label: 'Ship-to Party'
      Assgmt.ShipToPartyName,
      @ObjectModel.text.element: ['ProductThemeText']
      @EndUserText.label: 'Theme'
      Assgmt.ProductTheme,
      @EndUserText.label: 'Theme'
      _ProductThemeText.ProductThemeText,
      Assgmt.PurchaseOrderByCustomer,
      @ObjectModel.text.element: ['CustomerPurchaseOrderTypeText']
      Assgmt.CustomerPurchaseOrderType,
      _CustomerPurchaseOrderTypeText.CustomerPurchaseOrderTypeText,
      @EndUserText.label: 'Planned Delivery Time(Days)'
      Assgmt.PlannedDeliveryTime,
      @ObjectModel.text.element: ['DeliveryBlockReasonText']
      Assgmt.DeliveryBlockReason,
      _DeveliryBlockReasonText.DeliveryBlockReasonText,
      @ObjectModel.text.element: ['SalesDocumenTypeText']
      Assgmt.SalesDocumentType,
      _SDTypeText.SalesDocumenTypeText,
      @ObjectModel.text.association: '_Customer'
      @ObjectModel.text.element: ['SoldToPartyName']
      Assgmt.Customer,
      @EndUserText.label: 'Sold-to party Name'
      Assgmt.SoldToPartyName,
      Assgmt.UPC,
      Assgmt.RetailIntroDate,
      @EndUserText.label: 'Hard Launch Date'
      Assgmt.HardLaunchDate,
      @EndUserText.label: 'Early Access Date'
      Assgmt.EarlyAccessDate,
      @EndUserText.label: 'RRP(Recomm Retail Price)'
      Assgmt.RecommendedRetailPrice,
      Assgmt.ConditionQuantityUnitRRP,
      @Semantics.quantity.unitOfMeasure: 'CallOffQuantityUnit'
      Assgmt.CallOffQuantity,
      Assgmt.CallOffQuantityUnit,
      @EndUserText.label: 'Wholesale price'
      Assgmt.WholesalePrice,
      Assgmt.ConditionQuantityUnitWP,
      Assgmt.AgrmtValdtyEndDate,
      @ObjectModel.text.element: ['VendorName']
      Assgmt.Vendor,
      _Supplier.OrganizationBPName1        as VendorName,
      @ObjectModel.text.association: '_CountryText'
      @EndUserText.label: 'Country of Origin(Supply)'
      Assgmt.CountryFrom,
      Assgmt.InboundDelivery,
      Assgmt.ExFactoryDate,
      Assgmt.DelayReasonCodeConf,
      Assgmt.DelayReasonCodePODelD,
      Assgmt.FirstConfExFDT,
      Assgmt.LastConfExFDT,
      Assgmt.MarketDeliveryDate,
      @EndUserText.label: 'Requirement Creation Date'
      Assgmt.CreationDate,
      @EndUserText.label: 'PO type'
      @ObjectModel.text.element: ['PurchasingDocumentTypeName']
      Assgmt.PurchaseOrderType,
      _PurchasingDocumentTypeText.PurchasingDocumentTypeName,
      Assgmt.PurchaseOrderCategory,
      @ObjectModel.text.element: ['PurchasingOrganizationName']
      Assgmt.PurchasingOrganization,
      _PurchasingOrganizationText.PurchasingOrganizationName,
      @EndUserText.label: 'PO Shipping Instructions'
      @ObjectModel.text.association: '_ShippingInstructionText'
      Assgmt.ShippingInstruction,
      Assgmt.FactoryCode,
      Assgmt.ReferenceDocumentNumber,
      _StorageLocation.StorageLocationName as StorageLocationText,
      @Semantics.quantity.unitOfMeasure: 'PercentageUnit'
      @EndUserText.label: '% Allocated Quantity'
      Assgmt.AllocQtyInPerc,
      Assgmt.PercentageUnit,
      @EndUserText.label: 'Latest Date(Normal Assignment)'
      Assgmt.DateNormalAssgmnt,
      @EndUserText.label: 'Latest Date(Temp Assignment)'
      Assgmt.DateTempAssgmnt,
      @EndUserText.label: 'Delay(+)/Early(-)(No of days)'
      Assgmt.DelaysEarlyAvailability,
      @EndUserText.label: 'Confirmation Category Code'
      @ObjectModel.text.element: ['ConfirmationcategoryText']
      Assgmt.ConfirmationCategoryCode,
      @EndUserText.label: 'Confirmation Category Code'
      _ConfirmationCategoryText.ConfirmationcategoryText,
      Assgmt.MatConvId,
      Assgmt.CustSuppID,
      Assgmt.GridValue,
      Assgmt.MaterialByCustomer,
      Language.field1                      as Language,
      Assgmt.actual_v_dept_eventstfr_date  as actual_v_dept_eventstfr_date,
      Assgmt.actual_v_dept_eventstfr_time  as actual_v_dept_eventstfr_time,
      Assgmt.actual_v_dept_zonfr,
      Assgmt.actual_v_arr_eventstfr_date,
      Assgmt.actual_v_arr_eventstfr_time,
      Assgmt.actual_v_arr_zonfr,
      Assgmt.plan_v_arr_eventstfr_date,
      Assgmt.plan_v_arr_eventstfr_time,
      Assgmt.plan_v_arr_zonfr,
      Assgmt.actual_c_relea_eventstfr_date,
      Assgmt.actual_c_relea_eventstfr_time,
      Assgmt.actual_c_relea_zonfr,
      Assgmt.actual_r_load_eventstfr_date,
      Assgmt.actual_r_load_eventstfr_time,
      Assgmt.actual_r_load_zonfr,
      Assgmt.actual_r_unload_eventstfr_date,
      Assgmt.actual_r_unload_eventstfr_time,
      Assgmt.actual_r_unl_zonfr,
      Assgmt.plan_r_unl_eventstfr_date,
      Assgmt.plan_r_unl_eventstfr_time,
      Assgmt.plan_r_unl_zonfr,
      Assgmt.actual_t_load_eventstfr_date,
      Assgmt.actual_t_load_eventstfr_time,
      Assgmt.actual_t_load_zonfr,
      Assgmt.actual_t_unl_eventstfr_date,
      Assgmt.actual_t_unl_eventstfr_time,
      Assgmt.actual_t_unl_zonfr,
      Assgmt.plan_t_unl_eventstfr_date,
      Assgmt.plan_t_unl_eventstfr_time,
      Assgmt.plan_t_unl_zonfr,
      Assgmt.actual_air_eventstfr_date,
      Assgmt.actual_air_eventstfr_time,
      Assgmt.actual_air_zonfr,
      Assgmt.actual_air_arr_eventstfr_date,
      Assgmt.actual_air_arr_eventstfr_time,
      Assgmt.actual_air_arr_zonfr,
      Assgmt.plan_air_arr_eventstfr_date,
      Assgmt.plan_air_arr_eventstfr_time,
      Assgmt.plan_air_arr_zonfr,
      Assgmt.actual_cnt_arr_eventstfr_date,
      Assgmt.actual_cnt_arr_eventstfr_time,
      Assgmt.actual_cnt_arr_zonfr,
      Assgmt.plan_cnt_arr_eventstfr_date,
      Assgmt.plan_cnt_arr_eventstfr_time,
      Assgmt.plan_cnt_arr_zonfr,
      Assgmt.actual_cnt_dep_eventstfr_date,
      Assgmt.actual_cnt_dep_eventstfr_time,
      Assgmt.actual_cnt_dep_zonfr,
      Assgmt.actual_cus_arr_eventstfr_date,
      Assgmt.actual_cus_arr_eventstfr_time,
      Assgmt.actual_cus_arr_zonfr,
      Assgmt.actual_r_dep_eventstfr_date,
      Assgmt.actual_r_dep_eventstfr_time,
      Assgmt.actual_r_dep_zonfr,
      Assgmt.actual_r_arr_eventstfr_date,
      Assgmt.actual_r_arr_eventstfr_time,
      Assgmt.actual_r_arr_zonfr,
      Assgmt.plan_r_arr_eventstfr_date,
      Assgmt.plan_r_arr_eventstfr_time,
      Assgmt.plan_r_arr_zonfr,
      Assgmt.actual_whse_arr_eventstfr_date,
      Assgmt.actual_whse_arr_eventstfr_time,
      Assgmt.actual_whse_arr_zonfr,
      Assgmt.plan_whse_arr_eventstfr_date,
      Assgmt.plan_whse_arr_eventstfr_time,
      Assgmt.plan_whse_arr_zonfr,
      Assgmt.plan_user_eta_eventstfr_date,
      Assgmt.plan_user_eta_eventstfr_time,
      Assgmt.plan_user_eta_zonfr,
      //Associations
      _ProductText,
      _ProductGroupText,
      _ProductTypeText,
      _SupSrceText,
      _SalesOrgText,
      _DistrChnl,
      _Divn,
      _SalesDist,
      _Plant,
      _CompanyCode,
      _Customer,
      _BaseUnit,
      _SupText,
      _RqmtText,
      _SupDlyHrznText,
      _Supplier,
      _StorageLocation,
      _ShippingInstructionText,
      _SalesStatusText,
      _ConfirmationCategoryText,
      _CountryText
}
