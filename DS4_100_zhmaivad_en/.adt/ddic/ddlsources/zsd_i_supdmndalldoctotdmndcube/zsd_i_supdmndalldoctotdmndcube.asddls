@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Cube View for Total Demand of All Document Types'
define view entity zsd_i_supdmndalldoctotdmndcube
  as select from zsd_i_supdmndalldoctotdmnd as Demand
  association [0..1] to I_ProductText             as _ProductText      on  $projection.Material  = _ProductText.Product
                                                                       and _ProductText.Language = $session.system_language
  association [0..1] to I_ProductGroupText        as _ProductGroupText on  $projection.MaterialGroup  = _ProductGroupText.MaterialGroup
                                                                       and _ProductGroupText.Language = $session.system_language
  //Should it be replaced with I_MaterialGroupText as ProductGroup has status Deprecated?
  association [0..1] to I_ProductTypeText         as _ProductTypeText  on  $projection.MaterialType  = _ProductTypeText.ProductType
                                                                       and _ProductTypeText.Language = $session.system_language
  association [0..1] to I_SalesOrganizationText   as _SalesOrgText     on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                       and _SalesOrgText.Language        = $session.system_language
  association [0..1] to I_DistributionChannelText as _DistrChnl        on  $projection.DistributionChannel = _DistrChnl.DistributionChannel
                                                                       and _DistrChnl.Language             = $session.system_language
  association [0..1] to I_DivisionText            as _Divn             on  $projection.Division = _Divn.Division
                                                                       and _Divn.Language       = $session.system_language
  association [0..1] to I_SalesDistrictText       as _SalesDist        on  $projection.SalesDistrict = _SalesDist.SalesDistrict
                                                                       and _SalesDist.Language       = $session.system_language
  association [0..1] to I_Plant                   as _Plant            on  $projection.Plant = _Plant.Plant
  association [0..1] to I_CompanyCode             as _CompanyCode      on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_Customer                as _Customer         on  $projection.Customer = _Customer.Customer
  association [0..1] to I_UnitOfMeasure           as _BaseUnit         on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_SupDmndAllDocRqmtTypeT  as _RqmtText         on  $projection.RequirementType = _RqmtText.RequirementType
                                                                       and _RqmtText.Language          = $session.system_language

{
      @EndUserText.label: 'Requirement Document Number'
  key RequirementDocumentNumber,
      @EndUserText.label: 'Requirement Document Item'
  key RequirementDocumentItem,
  key Demand.SupProtTimeBucketUUID,
      @EndUserText.label: 'Requested Date'
  key RequestedDate,
      @EndUserText.label: 'Delivery Date'
  key ProductAvailabilityDate,
      @ObjectModel.text.association: '_RqmtText'
      @EndUserText.label: 'Requirement Type'
  key Demand.RequirementType,
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      RequestedRqmtQtyInBaseUnit,
      @EndUserText.label: 'Requested Delivery Date'
      Demand.RequestedDeliveryDate,
      @EndUserText.label: 'Canceled Quantity A'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      RequestedRqmtQtyInBaseUnit                                                     as CanceledQuantity_A,
      @EndUserText.label: 'Canceled Quantity B'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      cast( cast( RequestedRqmtQtyInBaseUnit as abap.decfloat16 ) -
      cast( DeliveredQuantityInBaseUnit as abap.decfloat16 ) as abap.quan( 13, 3 ) ) as CanceledQuantity_B,
      
      @EndUserText.label: 'Confirmed Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      ConfirmedRqmtQtyInBaseUnit,
      @EndUserText.label: 'Delivered Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      DeliveredQuantityInBaseUnit,
      @EndUserText.label: 'Open Demand Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      OpenDemandQuantity,
      @EndUserText.label: 'Total Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      AssignedQuantityInBaseUnit,
      @EndUserText.label: 'Normal Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      NormalAssignedQuantityInBsUnt,
      @EndUserText.label: 'Preview Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      PreviewAssignedQuantityInBsUnt,
      @EndUserText.label: 'Temporary Assigned Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      ARunTmpAssignedQuantityInBsUnt,
      @ObjectModel.foreignKey.association: '_BaseUnit'
      BaseUnit,
      @EndUserText.label: 'Year'
      @Semantics.calendar.year: true
      CalendarYear,
      @EndUserText.label: 'Month'
      @Semantics.calendar.month: true
      CalendarMonth,
      @Semantics.text: true
      @EndUserText.label: 'Month'
      CalendarMonthName,
      @EndUserText.label: 'Week'
      @Semantics.calendar.week: true
      CalendarWeek,
      @EndUserText.label: 'Day'
      @Semantics.calendar.dayOfMonth: true
      CalendarDay,
      @ObjectModel.text.association: '_ProductText'
      @EndUserText.label: 'Product'
      Material,
      @ObjectModel.text.association: '_ProductGroupText'
      @EndUserText.label: 'Product Group'
      MaterialGroup,
      @ObjectModel.text.association: '_ProductTypeText'
      @EndUserText.label: 'Product Type'
      MaterialType,
      @EndUserText.label: 'Generic Product'
      CrossPlantConfigurableProduct,
      @ObjectModel.text.association: '_Plant'
      //      @EndUserText.label: 'Plant'
      Plant,
      @ObjectModel.text.association: '_SalesOrgText'
      //      @EndUserText.label: 'Sales Organization'
      SalesOrganization,
      @ObjectModel.text.association: '_DistrChnl'
      //      @EndUserText.label: 'Distribution Channel'
      DistributionChannel,
      @ObjectModel.text.association: '_Divn'
      //      @EndUserText.label: 'Division'
      Division,
      @ObjectModel.text.association: '_SalesDist'
      //      @EndUserText.label: 'Sales District'
      SalesDistrict,
      @ObjectModel.text.association: '_Customer'
      //      @EndUserText.label: 'Customer'
      Customer,
      @ObjectModel.text.association: '_CompanyCode'
      //      @EndUserText.label: 'Company Code'
      CompanyCode,
      StorageLocation,
      @EndUserText.label: 'Supply Protection Name'
      SupplyProtectionName,
      cast( ' ' as meins )                                                           as SupAssgmtAggrgQtyUnit,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetPriceAmount,
      DocumentCurrency,
      RequirementSegment,
      PlantCountry,
      PlantRegion,
      //Associations
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
