/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 13.09.2022 | B_13622_SD_Build - [BE] - Gap SDO Enhancements for*
*              |            | DS4K930002                                *
* BLAGUKAR     | 24.10.2022 | FB_13622_SD_Build - [BE] - Gap SDO Enhancements for*
*              |            | DS4K931934                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewName: 'ZSDISUPDMADSUPC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@EndUserText.label: 'I_SupDmndAllDocTotSupCube Custom View'
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
define view ZSD_I_SupDmndAllDocTotSupCube
  as select from ZSD_I_SupDmndAllDocTotSup as Supply
  association [0..1] to I_ProductText              as _ProductText              on  $projection.Material  = _ProductText.Product
                                                                                and _ProductText.Language = $session.system_language
  association [0..1] to I_ProductGroupText         as _ProductGroupText         on  $projection.MaterialGroup  = _ProductGroupText.MaterialGroup
                                                                                and _ProductGroupText.Language = $session.system_language
  //Should it be replaced with I_MaterialGroupText as ProductGroup has status Deprecated?
  association [0..1] to I_ProductTypeText          as _ProductTypeText          on  $projection.MaterialType  = _ProductTypeText.ProductType
                                                                                and _ProductTypeText.Language = $session.system_language
  association [0..1] to I_SalesOrganizationText    as _SalesOrgText             on  $projection.SalesOrganization = _SalesOrgText.SalesOrganization
                                                                                and _SalesOrgText.Language        = $session.system_language
  association [0..1] to I_DistributionChannelText  as _DistrChnl                on  $projection.DistributionChannel = _DistrChnl.DistributionChannel
                                                                                and _DistrChnl.Language             = $session.system_language
  association [0..1] to I_DivisionText             as _Divn                     on  $projection.Division = _Divn.Division
                                                                                and _Divn.Language       = $session.system_language
  association [0..1] to I_SalesDistrictText        as _SalesDist                on  $projection.SalesDistrict = _SalesDist.SalesDistrict
                                                                                and _SalesDist.Language       = $session.system_language
  association [0..1] to I_PurchasingOrganization   as _PurchasingOrganization   on  $projection.PurchasingOrganization = _PurchasingOrganization.PurchasingOrganization
                                                                                and $projection.CompanyCode            = _PurchasingOrganization.CompanyCode
  association [0..1] to I_PurchasingGroup          as _PurchasingGroup          on  $projection.PurchasingGroup = _PurchasingGroup.PurchasingGroup
  association [0..1] to I_Plant                    as _Plant                    on  $projection.Plant = _Plant.Plant
  association [0..1] to I_CompanyCode              as _CompanyCode              on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_Customer                 as _Customer                 on  $projection.Customer = _Customer.Customer
  association [0..1] to I_UnitOfMeasure            as _BaseUnit                 on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_SupDmndAllDocSupTypeT    as _SupText                  on  $projection.AssignedSupplyType = _SupText.AssignedSupplyType
                                                                                and _SupText.Language              = $session.system_language
  association [0..1] to I_SupDmndAllDocSupSourceT  as _SupSrceText              on  $projection.SupAssgmtSource = _SupSrceText.SupAssgmtSource
                                                                                and _SupSrceText.Language       = $session.system_language
  association [0..1] to zsd_i_confirm_category_txt as _ConfirmationCategoryText on  _ConfirmationCategoryText.ConfirmationCategoryCode = $projection.ConfirmationCategoryCode

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
      cast( TotalQuantity as abap.quan( 25, 3 ))                                  as TotalQuantity,
      @EndUserText.label: 'Open Supply Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      cast( OpenSupplyQuantity as abap.quan( 25, 3 ))                             as OpenSupplyQuantity,
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
      cast( ' ' as meins )                                                        as SupAssgmtAggrgQtyUnit,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetPriceAmount,
      @Semantics.currencyCode: true
      DocumentCurrency,
      StockSegment,
      cast( Supply.FirstConfirmedExFactoryDate as zsd_first_conf_ex_factory_date) as FirstConfirmedExFactoryDate,
      cast( Supply.LastConfirmedExFactoryDate  as zsd_last_conf_ex_factory_date)  as LastConfirmedExFactoryDate,
      @EndUserText.label: 'Reference Document Number'
      Supply.ReferenceDocumentNumber,
      @EndUserText.label: 'Confirmation Category Code'
      Supply.ConfirmationCategoryCode,
      @EndUserText.label: 'Confirmation Control Key'
      Supply.ConfirmationControlKey,
      Supply.DelayReasonCodeConf,
      cast( Supply.ExFactoryDate as zz1_mm_exfactorydt )                          as ExFactoryDate,
      cast( Supply.ConfirmedShelfDate as zz1_zcsd )                               as ConfirmedShelfDate,
      Supply.ManufacturingLeadTime,
      cast( Supply.RequestedShelfDate as zz1_zrsd_initial )                       as RequestedShelfDate,
      cast( Supply.PlannedDate as  zz1_adi_m_planned )                            as PlannedDate,
      cast( Supply.MarketDeliveryDate as zz1_mdd_da )                             as MarketDeliveryDate,
      Supply.DelayReasonPO,
      Supply.ShipmentNumber,
      Supply.actual_v_dept_eventstfr_date,
      Supply.actual_v_dept_eventstfr_time,
      Supply.actual_v_dept_zonfr,
      Supply.actual_v_arr_eventstfr_date,
      Supply.actual_v_arr_eventstfr_time,
      Supply.actual_v_arr_zonfr,
      Supply.plan_v_arr_eventstfr_date,
      Supply.plan_v_arr_eventstfr_time,
      Supply.plan_v_arr_zonfr,
      Supply.actual_c_relea_eventstfr_date,
      Supply.actual_c_relea_eventstfr_time,
      Supply.actual_c_relea_zonfr,
      Supply.actual_r_load_eventstfr_date,
      Supply.actual_r_load_eventstfr_time,
      Supply.actual_r_load_zonfr,
      Supply.actual_r_unload_eventstfr_date,
      Supply.actual_r_unload_eventstfr_time,
      Supply.actual_r_unl_zonfr,
      Supply.plan_r_unl_eventstfr_date,
      Supply.plan_r_unl_eventstfr_time,
      Supply.plan_r_unl_zonfr,
      Supply.actual_t_load_eventstfr_date,
      Supply.actual_t_load_eventstfr_time,
      Supply.actual_t_load_zonfr,
      Supply.actual_t_unl_eventstfr_date,
      Supply.actual_t_unl_eventstfr_time,
      Supply.actual_t_unl_zonfr,
      Supply.plan_t_unl_eventstfr_date,
      Supply.plan_t_unl_eventstfr_time,
      Supply.plan_t_unl_zonfr,
      Supply.actual_air_eventstfr_date,
      Supply.actual_air_eventstfr_time,
      Supply.actual_air_zonfr,
      Supply.actual_air_arr_eventstfr_date,
      Supply.actual_air_arr_eventstfr_time,
      Supply.actual_air_arr_zonfr,
      Supply.plan_air_arr_eventstfr_date,
      Supply.plan_air_arr_eventstfr_time,
      Supply.plan_air_arr_zonfr,
      Supply.actual_cnt_arr_eventstfr_date,
      Supply.actual_cnt_arr_eventstfr_time,
      Supply.actual_cnt_arr_zonfr,
      Supply.plan_cnt_arr_eventstfr_date,
      Supply.plan_cnt_arr_eventstfr_time,
      Supply.plan_cnt_arr_zonfr,
      Supply.actual_cnt_dep_eventstfr_date,
      Supply.actual_cnt_dep_eventstfr_time,
      Supply.actual_cnt_dep_zonfr,
      Supply.actual_cus_arr_eventstfr_date,
      Supply.actual_cus_arr_eventstfr_time,
      Supply.actual_cus_arr_zonfr,
      Supply.actual_r_dep_eventstfr_date,
      Supply.actual_r_dep_eventstfr_time,
      Supply.actual_r_dep_zonfr,
      Supply.actual_r_arr_eventstfr_date,
      Supply.actual_r_arr_eventstfr_time,
      Supply.actual_r_arr_zonfr,
      Supply.plan_r_arr_eventstfr_date,
      Supply.plan_r_arr_eventstfr_time,
      Supply.plan_r_arr_zonfr,
      Supply.actual_whse_arr_eventstfr_date,
      Supply.actual_whse_arr_eventstfr_time,
      Supply.actual_whse_arr_zonfr,
      Supply.plan_whse_arr_eventstfr_date,
      Supply.plan_whse_arr_eventstfr_time,
      Supply.plan_whse_arr_zonfr,
      Supply.plan_user_eta_eventstfr_date,
      Supply.plan_user_eta_eventstfr_time,
      Supply.plan_user_eta_zonfr,
      //      Associations
      _ConfirmationCategoryText,
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
