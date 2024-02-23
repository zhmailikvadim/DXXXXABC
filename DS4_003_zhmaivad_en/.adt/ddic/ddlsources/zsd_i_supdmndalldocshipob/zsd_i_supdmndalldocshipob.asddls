/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZUJSKAS      | 31.01.2023 | FB_17550_SD_Feature - Supply Demand Overview  (SDO) E*
*              |            | DS4K942335                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZSD_I_SupDmndAllDocShipOB view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_SupDmndAllDocShipOB
  as select from    I_SupDmndAllDocGdsIssdDelivC as GID
    association[1..1] to ZSD_I_SupDmndAllDocDeliv_Ext as _Deliv_Ext on  GID.RequirementDocumentNumber = _Deliv_Ext.DeliveryDocument
                                                                    and GID.RequirementDocumentItem   = _Deliv_Ext.DeliveryDocumentItem
{
  RequirementDocumentNumber,
  RequirementDocumentItem,
  RequestedDate,
  ProductAvailabilityDate,
  RequirementType,
  HigherLvlItmOfBatSpltItm,
  RequestedDeliveryDate,
  @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
  DeliveredQuantity,
  SupAssgmtAggrgQtyUnit,
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
  ShippingType,
  Plant,
  SalesOrganization,
  DistributionChannel,
  Division,
  SalesDistrict,
  Customer,
  CompanyCode,
  StorageLocation,
  _Deliv_Ext.SDDocument,
  _Deliv_Ext.SDDocumentItem,
  _Deliv_Ext.ActualGoodsMovementDate,
  _Deliv_Ext.PlannedGoodsIssueDate,
  _Deliv_Ext.DelRelBillStatusAll,
  _Deliv_Ext.IntercompBillStatusAll,
  _Deliv_Ext.DelRelBillStatusItem,
  _Deliv_Ext.IntercompBillStatusItem,
  _Deliv_Ext.BillingDate,
  _Deliv_Ext.CreatedByDel,
  _Deliv_Ext.CreatedOnDel,
  _Deliv_Ext.EventHeadHandler,
  _Deliv_Ext.DeliveryDocumentType,
  _Deliv_Ext.DeliveryStatus,
  _Deliv_Ext.Route
}

union all select from I_SupDmndAllDocOpenDelivC    as OD
  association[1..1] to ZSD_I_SupDmndAllDocDeliv_Ext as _Deliv_Ext on  OD.RequirementDocumentNumber = _Deliv_Ext.DeliveryDocument
                                                                  and OD.RequirementDocumentItem   = _Deliv_Ext.DeliveryDocumentItem
{
  RequirementDocumentNumber,
  RequirementDocumentItem,
  RequestedDate,
  ProductAvailabilityDate,
  RequirementType,
  HigherLvlItmOfBatSpltItm,
  RequestedDeliveryDate,
  DeliveredQuantity,
  SupAssgmtAggrgQtyUnit,
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
  ShippingType,
  Plant,
  SalesOrganization,
  DistributionChannel,
  Division,
  SalesDistrict,
  Customer,
  CompanyCode,
  StorageLocation,
  ReferenceSDDocument     as SDDocument,
  ReferenceSDDocumentItem as SDDocumentItem,
  _Deliv_Ext.ActualGoodsMovementDate,
  _Deliv_Ext.PlannedGoodsIssueDate,
  _Deliv_Ext.DelRelBillStatusAll,
  _Deliv_Ext.IntercompBillStatusAll,
  _Deliv_Ext.DelRelBillStatusItem,
  _Deliv_Ext.IntercompBillStatusItem,
  _Deliv_Ext.BillingDate,
  _Deliv_Ext.CreatedByDel,
  _Deliv_Ext.CreatedOnDel,
  _Deliv_Ext.EventHeadHandler,
  _Deliv_Ext.DeliveryDocumentType,
  _Deliv_Ext.DeliveryStatus,
  _Deliv_Ext.Route
}
