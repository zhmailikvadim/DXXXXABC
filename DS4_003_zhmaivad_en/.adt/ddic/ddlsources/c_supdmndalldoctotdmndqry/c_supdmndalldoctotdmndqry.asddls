@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type: #INHERITED
@VDM.viewType: #CONSUMPTION
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}
@AbapCatalog: {
  sqlViewName: 'CSUPDMNDADDMNDQ',
  compiler.compareFilter: true,
  preserveKey:true
}
@ObjectModel:{
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #D,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'Query View for Total Demand of All Document Types'
define view C_SupDmndAllDocTotDmndQry
  as select from I_SupDmndAllDocTotDmndCube
{
      //I_SupDmndAllDocTotDmndCube
  key RequirementDocumentNumber,
  key RequirementDocumentItem,
  key SupProtTimeBucketUUID,
  key RequestedDate,
  key ProductAvailabilityDate,
      @EndUserText.label: 'Demand Type'
  key RequirementType,
      @EndUserText.label: 'Requested Delivery Date'
      RequestedDeliveryDate,
      @EndUserText.label: 'Requirement Document'
      cast(
            concat(concat(RequirementDocumentNumber, '/'), RequirementDocumentItem)
            as arun_doc_item_unique_id preserving type
      )                                                                                  as ARunDocumentItemUniqueID,
      cast(
            concat(concat(RequirementDocumentNumber, '/'), RequirementDocumentItem)
            as arun_doc_item_unique_id preserving type
      )                                                                                  as DocumentItemConcatenatedID,
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
      BaseUnit,
      CalendarYear,
      CalendarMonth,
      CalendarMonthName,
      CalendarWeek,
      CalendarDay,
      Material,
      MaterialGroup,
      MaterialType,
      CrossPlantConfigurableProduct,
      Plant,
      SalesOrganization,
      DistributionChannel,
      Division,
      SalesDistrict,
      Customer,
      CompanyCode,
      StorageLocation,
      SupplyProtectionName,
      NetPriceAmount,
      DocumentCurrency,
      RequirementSegment,
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
      _RqmtText
}
