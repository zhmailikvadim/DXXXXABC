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
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}
@Analytics.dataExtraction.enabled : true
@EndUserText.label: 'ZSD_C_SupDmndAllDocShipOB Custom View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel:{
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #D,
     sizeCategory:   #XXL
   }
   }
define view entity ZSD_C_SupDmndAllDocShipOB
  as select distinct from ZSD_I_SupDmndAllDocShipOBCube
{

  key RequirementDocumentNumber,
  key RequirementDocumentItem,
  key RequestedDate,
  key ProductAvailabilityDate,
  key RequirementType,
      HigherLvlItmOfBatSpltItm,
      RequestedDeliveryDate,
      ConfirmedDeliveryDate,
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      DeliveredQuantity,
      SupAssgmtAggrgQtyUnit,
      BaseUnit,
      CalendarYear,
      CalendarMonth,
      CalendarMonthName,
      CalendarWeek,
      CalendarDay,
      MaterialGroup,
      MaterialType,
      ShippingType,
      ShippingTypeName,
      Plant,
      SalesOrganization,
      DistributionChannel,
      Division,
      SalesDistrict,
      Customer,
      SoldToPartyName,
      DeliveryDocumentType,
      DeliveryStatus,
      CompanyCode,
      StorageLocation,
      StorageLocationText,
      ActualGoodsMovementDate,
      ShippedQty,
      DeliveryQuantityUnit,
      EstimatedDeliveryDate,

      ProductCollection,
      ProductCollectionText,
      ProductSeasonYear,
      ProductSeason,
      ProductSeasonText,
      ProductTheme,
      ProductThemeText,
      SportCategory,
      SportCategoryText,
      
      PayerParty,
      PayerPartyName,
         
      PurchaseOrderByCustomer,
      CustomerPurchaseOrderType,
      
      ConfirmedShelvedDate,
      CustomerGroup,
      CustomerGroupName,
      AdditionalCustomerGroup1,
      AdditionalCustomerGroup1Name,
      AdditionalCustomerGroup5,
      AdditionalCustomerGroup5Name,
      AdditionalCustomerGroup6,
      AdditionalCustomerGroup6Name,
      AdditionalCustomerGroup10,
      AdditionalCustomerGroup10Name,

      MaterialByCustomer,
      DeliveryPriority,
      DeliveryPriorityText,
      DistribChainSpecifMatStat,
      EAN,
      FulfillmentDate,
      FulfillmentScenario,
      FullfillmentScenarioText,
      CrossPlantConfigurableProduct,
      CreatedByDel,
      CreatedBySO,
      CreatedOnDel,
      CreationDate,
      UnderlyingPurchaseOrderItem,
      Material,
      SalesDocumentItemText,
      NetPriceAmount,
      DocumentCurrency,
      NetAmount,
      TransactionCurrency,
      SDDocumentReason,
      SDDocumentReasonText,
      GoodsIssueDate,
      PlannedDeliveryTime,

      PREIndicator,
      PrepackHoldIndicator,
      RequestedRqmtQtyInBaseUnit,
      RequestedShelfDate,
      SalesDocumentItemCategory,
      SalesDocumentItemCategoryText,
      SalesDocumentType,
      SalesDocumenTypeText,
      ScheduleLine,
      EarlyAccessDate,
      HardLaunchDate,
      UPC,
      TechSize,
      GridValue,
      TotalGdsMvtStat,


      ShipToParty,
      ShipToPartyName,
      ShippingPoint,

      BillingDate,
      Invoice,
      BillingStatusHeader,
      BillingStatusItem,
      DeliveryDocument,
      DeliveryDocumentItem,
      BillingBlockItem,

      CumulativeConfirmedQuantity, 
      HeadHandler,
      zwsplnpick_even_tstfr_date,
      zwsplnpick_even_tstfr_time,
      zwsplnpick_even_zonfr,
      zwsplnload_even_tstfr_date,
      zwsplnload_even_tstfr_time,
      zwsplnload_even_zonfr,
      zwsplngdis_even_tstfr_date,
      zwsplngdis_even_tstfr_time,
      zwsplngdis_even_zonfr,
      zwsplandel_even_tstfr_date,
      zwsplandel_even_tstfr_time,
      zwsplandel_even_zonfr,
      zwsactrece_even_tstfr_date,
      zwsactrece_even_tstfr_time,
      zwsactrece_even_zonfr,
      zwsactpick_even_tstfr_date,
      zwsactpick_even_tstfr_time,
      zwsactpick_even_zonfr,
      zwsactpack_even_tstfr_date,
      zwsactpack_even_tstfr_time,
      zwsactpack_even_zonfr,
      zwsactload_even_tstfr_date,
      zwsactload_even_tstfr_time,
      zwsactload_even_zonfr,
      zwsactgdis_even_tstfr_date,
      zwsactgdis_even_tstfr_time,
      zwsactgdis_even_zonfr,
      zwsprjgdis_even_tstfr_date,
      zwsprjgdis_even_tstfr_time,
      zwsprjgdis_even_zonfr,
      zwsreqrout_even_tstfr_date,
      zwsreqrout_even_tstfr_time,
      zwsreqrout_even_zonfr,
      zwsactrout_even_tstfr_date,
      zwsactrout_even_tstfr_time,
      zwsactrout_even_zonfr,
      zwsactdeli_even_tstfr_date,
      zwsactdeli_even_tstfr_time,
      zwsactdeli_even_zonfr,
      zwsactdeli_even_tstto_date,
      zwsactdeli_even_tstto_time,
      zwsactdeli_even_zonto,
      zstconshel_even_tstfr_date,
      zstconshel_even_tstfr_time,
      zstconshel_even_zonfr,


      Language,

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
