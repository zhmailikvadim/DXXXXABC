@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics: {
  dataCategory: #CUBE,
  internalName:#LOCAL
}
@VDM: {
  viewType: #COMPOSITE,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #REQUIRED
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADSUPC',
  compiler.compareFilter: true,
  preserveKey:true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #D,
     sizeCategory:   #XXL
   }
}
@Metadata:{
  allowExtensions:              true,
  ignorePropagatedAnnotations:  true
}
@EndUserText.label: 'Cube View for Total Supply of All Document Types'
define view I_SupDmndAllDocTotSupCube
  as select from I_SupDmndAllDocTotSup as Supply
  association [0..1] to I_ProductText             as _ProductText            on  $projection.Material  = _ProductText.Product
                                                                             and _ProductText.Language = $session.system_language
  association [0..1] to I_ProductGroupText        as _ProductGroupText       on  $projection.MaterialGroup  = _ProductGroupText.MaterialGroup
                                                                             and _ProductGroupText.Language = $session.system_language
  //Should it be replaced with I_MaterialGroupText as ProductGroup has status Deprecated?
  association [0..1] to I_ProductTypeText         as _ProductTypeText        on  $projection.MaterialType  = _ProductTypeText.ProductType
                                                                             and _ProductTypeText.Language = $session.system_language
  association [0..1] to I_SalesOrganizationText   as _SalesOrgText           on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                             and _SalesOrgText.Language        = $session.system_language
  association [0..1] to I_DistributionChannelText as _DistrChnl              on  $projection.DistributionChannel = _DistrChnl.DistributionChannel
                                                                             and _DistrChnl.Language             = $session.system_language
  association [0..1] to I_DivisionText            as _Divn                   on  $projection.Division = _Divn.Division
                                                                             and _Divn.Language       = $session.system_language
  association [0..1] to I_SalesDistrictText       as _SalesDist              on  $projection.SalesDistrict = _SalesDist.SalesDistrict
                                                                             and _SalesDist.Language       = $session.system_language
  association [0..1] to I_PurchasingOrganization  as _PurchasingOrganization on  $projection.PurchasingOrganization = _PurchasingOrganization.PurchasingOrganization
                                                                             and $projection.CompanyCode            = _PurchasingOrganization.CompanyCode
  association [0..1] to I_PurchasingGroup         as _PurchasingGroup        on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup
  association [0..1] to I_Plant                   as _Plant                  on  $projection.Plant = _Plant.Plant
  association [0..1] to I_CompanyCode             as _CompanyCode            on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_Customer                as _Customer               on  $projection.Customer = _Customer.Customer
  association [0..1] to I_UnitOfMeasure           as _BaseUnit               on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_SupDmndAllDocSupTypeT   as _SupText                on  $projection.AssignedSupplyType = _SupText.AssignedSupplyType
                                                                             and _SupText.Language              = $session.system_language
  association [0..1] to I_SupDmndAllDocSupSourceT as _SupSrceText            on  $projection.SupAssgmtSource = _SupSrceText.SupAssgmtSource
                                                                             and _SupSrceText.Language       = $session.system_language
{
      @ObjectModel.text.association: '_ProductText'
      @EndUserText.label: 'Product'
  key Material,
      @ObjectModel.text.association: '_Plant'
  key Plant,
  key Batch,
  key StorageLocation,
      @EndUserText.label: 'Supply Document No.'
  key SupplyNumber,
      @EndUserText.label: 'Supply Document Item'
  key SupplyItem,
      @EndUserText.label: 'Supply Schedule Line'
  key SupplyScheduleLine,
      @EndUserText.label: 'Supply Delivery Date'
  key ProductAvailabilityDate,
      @ObjectModel.text.association: '_SupText'
      @EndUserText.label: 'Supply Type'
  key AssignedSupplyType,
      @EndUserText.label: 'Requested Delivery Date'
      Supply.RequestedDeliveryDate,
      @EndUserText.label: 'Total Supply Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      cast( TotalQuantity as abap.quan( 25, 3 ))      as TotalQuantity,
      @EndUserText.label: 'Open Supply Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      cast( OpenSupplyQuantity as abap.quan( 25, 3 )) as OpenSupplyQuantity,
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
      @ObjectModel.text.element: 'CalendarMonthName'
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
      @ObjectModel.text.association: '_ProductGroupText'
      @EndUserText.label: 'Product Group'
      MaterialGroup,
      @ObjectModel.text.association: '_ProductTypeText'
      @EndUserText.label: 'Product Type'
      MaterialType,
      @EndUserText.label: 'Supply Source'
      @ObjectModel.text.association: '_SupSrceText'
      SupAssgmtSource,
      @EndUserText.label: 'Generic Product'
      CrossPlantConfigurableProduct,
      @ObjectModel.text.association: '_PurchasingOrganization'
      PurchasingOrganization,
      @ObjectModel.text.association: '_PurchasingGroup'
      PurchasingGroup,
      @ObjectModel.text.association: '_SalesOrgText'
      SalesOrganization,
      @ObjectModel.text.association: '_DistrChnl'
      DistributionChannel,
      @ObjectModel.text.association: '_Divn'
      Division,
      @ObjectModel.text.association: '_SalesDist'
      SalesDistrict,
      @ObjectModel.text.association: '_CompanyCode'
      CompanyCode,
      @ObjectModel.text.association: '_Customer'
      Customer,
      @Semantics.unitOfMeasure: true
      cast( ' ' as meins ) as SupAssgmtAggrgQtyUnit,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetPriceAmount,
      @Semantics.currencyCode: true
      DocumentCurrency,
      StockSegment,
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
      _PurchasingOrganization,
      _PurchasingGroup,
      _Customer,
      _BaseUnit,
      _SupText
}
