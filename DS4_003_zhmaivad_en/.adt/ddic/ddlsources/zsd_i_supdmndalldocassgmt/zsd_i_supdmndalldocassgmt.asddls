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
  authorizationCheck: #CHECK
}
@EndUserText.label: 'I_SupDmndAllDocAssgmt Custom View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
define view entity ZSD_I_SupDmndAllDocAssgmt
  as select from    ZSD_I_ARunAllAssignments       as Assgmt
    left outer join ZPE_I_HM( iv_id: '0000000789') as Language         on Language.sequence = '001'
    left outer join I_SupDmndOvwPlant              as Plant            on Assgmt.Plant = Plant.Plant
    inner join      ZSD_I_SupDmndAllDocDemand      as Demand           on  Assgmt.RequirementDocumentNumber = Demand.RequirementDocumentNumber
                                                                       and Assgmt.RequirementDocumentItem   = Demand.RequirementDocumentItem
                                                                       and Assgmt.SupProtTimeBucketUUID     = Demand.SupProtTimeBucketUUID
                                                                       and Assgmt.RequestedDate             = Demand.RequestedDate
                                                                       and Assgmt.ProductAvailabilityDate   = Demand.ProductAvailabilityDate
                                                                       and Assgmt.RequirementType           = Demand.RequirementType
    left outer join ZSD_I_SupDmndAllDocTotSup      as Supply           on  Supply.SupplyNumber       = Assgmt.SupplyNumber
                                                                       and Supply.SupplyItem         = Assgmt.SupplyItem
                                                                       and Supply.SupplyScheduleLine = Assgmt.SupplyScheduleLine
                                                                       and Supply.Plant              = Assgmt.Plant
                                                                       and Supply.Material           = Assgmt.Material
                                                                       and Supply.StorageLocation    = Assgmt.StorageLocation
                                                                       and Supply.Batch              = Assgmt.Batch
                                                                       and Supply.AssignedSupplyType = Assgmt.AssignedSupplyType
    left outer join I_ARunCalendarDate             as CalDate          on Demand.ProductAvailabilityDate = CalDate.CalendarDate
    left outer join I_CalendarMonthName            as CalMonth         on CalDate.CalendarMonth = CalMonth.CalendarMonth
    left outer join I_ARunTimeUnitText             as ARunTimeUnitText on  ARunTimeUnitText.ARunDisplayTimeUnit = '02'
                                                                       and ARunTimeUnitText.Language            = Language.field1
    left outer join ZSD_I_SupDmndProduct           as Product          on Assgmt.Material = Product.Product
    left outer join ZSD_I_SupDmndSalesArea         as SalesArea        on  Demand.Customer            = SalesArea.Customer
                                                                       and Demand.SalesOrganization   = SalesArea.SalesOrganization
                                                                       and Demand.DistributionChannel = SalesArea.DistributionChannel
                                                                       and Demand.Division            = SalesArea.OrganizationDivision
  association [0..1] to ZSD_I_SupDmndOvwTechSize as _TechSize         on  $projection.CrossPlantConfigurableProduct = _TechSize.objek
                                                                      and $projection.ProductCharacteristic2        = _TechSize.atwrt
  association [0..1] to ZSD_I_SupDmndGridValue   as _SupDmndGridValue on  $projection.MatConvId              = _SupDmndGridValue.MatConvId
                                                                      and $projection.CustSuppID             = _SupDmndGridValue.CustSuppID
                                                                      and $projection.ProductCharacteristic2 = _SupDmndGridValue.CharacteristicValue
{
  key Assgmt.Plant,
  key Assgmt.Material,
  key Assgmt.StorageLocation,
  key Assgmt.Batch,
  key Assgmt.RequirementType,
  key Assgmt.RequirementDocumentNumber,
  key Assgmt.RequirementDocumentItem,
  key Assgmt.SupProtTimeBucketUUID,
  key Assgmt.AssignedSupplyType,
  key Assgmt.SupAssgmtSource,
  key Assgmt.SupplyNumber,
  key Assgmt.SupplyItem,
  key Assgmt.SupplyScheduleLine,
  key Assgmt.RequestedDate,
  key Assgmt.ProductAvailabilityDate,
  key Assgmt.SupplyDeliveryDate,
  key Assgmt.SupplyAssignmentStatus,
      Demand.RequestedDeliveryDate,
      Assgmt.NumberOfDays,
      //      'Mat. Avail Date - Supply Delivery Date'
      case
        when Assgmt.NumberOfDays <= 0  then '00'
        when Assgmt.NumberOfDays < 7   then '01'
        when Assgmt.NumberOfDays < 14  then '02'
        when Assgmt.NumberOfDays < 21  then '03'
        when Assgmt.NumberOfDays <= 28 then '04'
        when Assgmt.NumberOfDays > 28  then cast( '05' as abap.char( 2 ) )
        else ' '
      end                                                                                   as ARunSupDlyHrznInWeeks,

      Demand.CumulativeConfirmedQuantity,
      CalDate.CalendarYear,
      CalDate.CalendarMonth,
      CalMonth.CalendarMonthName,
      concat_with_space( ARunTimeUnitText.ARunDisplayTimeUnitText, CalDate.CalendarWeek, 1) as CalendarWeek,
      CalDate.CalendarDay,
      Assgmt.AssignedQuantityInBaseUnit                                                     as AssignedQuantityInBaseUnit,
      Assgmt.NormalAssignedQuantityInBsUnt                                                  as NormalAssignedQuantityInBsUnt,
      Assgmt.PreviewAssignedQuantityInBsUnt                                                 as PreviewAssignedQuantityInBsUnt,
      Assgmt.ARunTmpAssignedQuantityInBsUnt                                                 as ARunTmpAssignedQuantityInBsUnt,
      Demand.RequestedRqmtQtyInBaseUnit,
      cast(coalesce(Demand.OpenDemandQuantity, 0 ) -
           coalesce(Assgmt.AssignedQuantityInBaseUnit, 0)  as abap.dec( 12, 3 ))            as OpenDemandQuantity,
      Assgmt.BaseUnit,
      Supply.InboundDelivery,
      Demand.MaterialGroup,
      Demand.OrderType                                                                      as SalesDocumentType,
      Demand.MaterialType,
      Demand.RequirementSegment,
      Demand.CrossPlantConfigurableProduct,
      Demand.SupplyProtectionName,
      Demand.MaterialByCustomer,
      case
        when Demand.SalesOrganization is initial
        then coalesce( Plant.SalesOrganization, '' )
        else Demand.SalesOrganization
      end                                                                                   as SalesOrganization,
      case
        when Demand.DistributionChannel is initial
        then coalesce( Plant.DistributionChannel, '' )
        else Demand.DistributionChannel
      end                                                                                   as DistributionChannel,
      case
        when Demand.Division is initial
        then coalesce( Plant.Division, '' )
        else Demand.Division
      end                                                                                   as Division,
      case
        when Demand.SalesDistrict is initial
        then coalesce( Plant.SalesDistrict, '' )
        else Demand.SalesDistrict
      end                                                                                   as SalesDistrict,
      case
        when Demand.CompanyCode is initial
        then coalesce( Plant.CompanyCode, '' )
        else Demand.CompanyCode
      end                                                                                   as CompanyCode,
      Demand.NetPriceAmount,
      Demand.DocumentCurrency,
      Demand.ProductSeasonYear,
      Demand.ProductSeason,
      Demand.ProductCollection,
      Demand.ConfirmedShelvedDate,
      Demand.CreatedByUser,
      Demand.CustomerGroup,
      Demand.AdditionalCustomerGroup1,
      Demand.AdditionalCustomerGroup5,
      Demand.AdditionalCustomerGroup6,
      Demand.DeliveryPriority,
      Demand.DistribChainSpecifMatStat,
      Demand.ScheduleLine,
      Demand.GoodsIssueDate,
      Demand.ConfirmedDeliveryDate,
      Demand.ConfirmedDeliveryDate                                                          as EstimatedDeliveryDate,
      Demand.EAN,
      Demand.FulfillmentDate,
      Demand.FulfillmentScenario,
      Demand.ProductCharacteristic2,
      _TechSize.atwtb                                                                       as TechSize,
      Demand.UnderlyingPurchaseOrderItem,
      Demand.SalesDocumentItemText,
      Demand.AdditionalMaterialGroup1,
      Demand.MaterialGroup1Text,
      Demand.NetAmount,
      Demand.TransactionCurrency,
      Demand.FashionCancelDate,
      Demand.PayerParty,
      Demand.SDDocumentReason,
      Demand.PREIndicator,
      Demand.PrepackHoldIndicator,
      cast( Demand.RequestedShelfDate as zz1_zrsd_initial )                                 as RequestedShelfDate,
      Demand.SalesDocumentItemCategory,
      Demand.ShippingType,
      Demand.ShipToParty,
      Demand.ShipToPartyName,
      Demand.ProductTheme,
      Demand.PurchaseOrderByCustomer,
      Demand.CustomerPurchaseOrderType,
      coalesce( Demand.PlannedDeliveryTime, Supply.PlannedDeliveryTime )                    as PlannedDeliveryTime,
      Demand.DeliveryBlockReason,
      Demand.AgrmtValdtyEndDate,
      Supply.Vendor,
      Supply.CountryFrom,
      cast( Supply.ExFactoryDate as zz1_mm_exfactorydt )                                    as ExFactoryDate,
      Supply.DelayReasonCodeConf,
      Supply.DelayReasonPO                                                                  as DelayReasonCodePODelD,
      cast( Supply.FirstConfirmedExFactoryDate as zsd_first_conf_ex_factory_date)           as FirstConfExFDT,
      cast( Supply.LastConfirmedExFactoryDate  as zsd_last_conf_ex_factory_date)            as LastConfExFDT,
      cast( Supply.MarketDeliveryDate as zz1_mdd_da )                                       as MarketDeliveryDate,
      Demand.CreationDate,
      Supply.OrderType                                                                      as PurchaseOrderType,
      Demand.PurchaseOrderCategory,
      case
        when Assgmt.SupAssgmtSource = 'S' //stock
        then cast('' as ekorg)
        else Supply.PurchasingOrganization
      end                                                                                   as PurchasingOrganization,
      Supply.ReferenceDocumentNumber,
      Supply.ShippingInstruction,
      Supply.FactoryCode,
      case
        when Demand.Customer is initial
        then coalesce( Plant.PlantCustomer, '' )
        else Demand.Customer
      end                                                                                   as Customer,
      Demand.SoldToPartyName,
      Demand.UPC,
      Demand.RetailIntroDate,
      Demand.HardLaunchDate,
      Demand.EarlyAccessDate,
      Demand.RecommendedRetailPrice,
      Demand.ConditionQuantityUnitRRP,
      Demand.WholesalePrice,
      Demand.ConditionQuantityUnitWP,
      @Semantics.quantity.unitOfMeasure: 'CallOffQuantityUnit'
      Demand.CallOffQuantity,
      Demand.CallOffQuantityUnit,
      case
        when Assgmt.AssignedQuantityInBaseUnit < Demand.RequestedRqmtQtyInBaseUnit and Demand.RequestedRqmtQtyInBaseUnit <> 0
        then 100 - cast( ( Demand.RequestedRqmtQtyInBaseUnit - Assgmt.AssignedQuantityInBaseUnit ) / Demand.RequestedRqmtQtyInBaseUnit * 100  as abap.dec(4,2) )
        else cast('0' as abap.dec(4,2))
      end                                                                                   as AllocQtyInPerc,
      cast( '%' as abap.unit( 3 ) )                                                         as PercentageUnit,
      Assgmt.DateNormalAssgmnt,
      Assgmt.DateTempAssgmnt,
      _SupDmndGridValue.GridValue,
      Product.MatConvId,
      SalesArea.CustSuppID,
      dats_days_between(Demand.RequestedDeliveryDate, Assgmt.SupplyDeliveryDate)            as DelaysEarlyAvailability,
      Supply.ConfirmationCategoryCode,
      Supply._ConfExt.actual_v_dept_eventstfr_date                                          as actual_v_dept_eventstfr_date,
      Supply._ConfExt.actual_v_dept_eventstfr_time                                          as actual_v_dept_eventstfr_time,
      Supply._ConfExt.actual_v_dept_zonfr,
      Supply._ConfExt.actual_v_arr_eventstfr_date,
      Supply._ConfExt.actual_v_arr_eventstfr_time,
      Supply._ConfExt.actual_v_arr_zonfr,
      Supply._ConfExt.plan_v_arr_eventstfr_date,
      Supply._ConfExt.plan_v_arr_eventstfr_time,
      Supply._ConfExt.plan_v_arr_zonfr,
      Supply._ConfExt.actual_c_relea_eventstfr_date,
      Supply._ConfExt.actual_c_relea_eventstfr_time,
      Supply._ConfExt.actual_c_relea_zonfr,
      Supply._ConfExt.actual_r_load_eventstfr_date,
      Supply._ConfExt.actual_r_load_eventstfr_time,
      Supply._ConfExt.actual_r_load_zonfr,
      Supply._ConfExt.actual_r_unload_eventstfr_date,
      Supply._ConfExt.actual_r_unload_eventstfr_time,
      Supply._ConfExt.actual_r_unl_zonfr,
      Supply._ConfExt.plan_r_unl_eventstfr_date,
      Supply._ConfExt.plan_r_unl_eventstfr_time,
      Supply._ConfExt.plan_r_unl_zonfr,
      Supply._ConfExt.actual_t_load_eventstfr_date,
      Supply._ConfExt.actual_t_load_eventstfr_time,
      Supply._ConfExt.actual_t_load_zonfr,
      Supply._ConfExt.actual_t_unl_eventstfr_date,
      Supply._ConfExt.actual_t_unl_eventstfr_time,
      Supply._ConfExt.actual_t_unl_zonfr,
      Supply._ConfExt.plan_t_unl_eventstfr_date,
      Supply._ConfExt.plan_t_unl_eventstfr_time,
      Supply._ConfExt.plan_t_unl_zonfr,
      Supply._ConfExt.actual_air_eventstfr_date,
      Supply._ConfExt.actual_air_eventstfr_time,
      Supply._ConfExt.actual_air_zonfr,
      Supply._ConfExt.actual_air_arr_eventstfr_date,
      Supply._ConfExt.actual_air_arr_eventstfr_time,
      Supply._ConfExt.actual_air_arr_zonfr,
      Supply._ConfExt.plan_air_arr_eventstfr_date,
      Supply._ConfExt.plan_air_arr_eventstfr_time,
      Supply._ConfExt.plan_air_arr_zonfr,
      Supply._ConfExt.actual_cnt_arr_eventstfr_date,
      Supply._ConfExt.actual_cnt_arr_eventstfr_time,
      Supply._ConfExt.actual_cnt_arr_zonfr,
      Supply._ConfExt.plan_cnt_arr_eventstfr_date,
      Supply._ConfExt.plan_cnt_arr_eventstfr_time,
      Supply._ConfExt.plan_cnt_arr_zonfr,
      Supply._ConfExt.actual_cnt_dep_eventstfr_date,
      Supply._ConfExt.actual_cnt_dep_eventstfr_time,
      Supply._ConfExt.actual_cnt_dep_zonfr,
      Supply._ConfExt.actual_cus_arr_eventstfr_date,
      Supply._ConfExt.actual_cus_arr_eventstfr_time,
      Supply._ConfExt.actual_cus_arr_zonfr,
      Supply._ConfExt.actual_r_dep_eventstfr_date,
      Supply._ConfExt.actual_r_dep_eventstfr_time,
      Supply._ConfExt.actual_r_dep_zonfr,
      Supply._ConfExt.actual_r_arr_eventstfr_date,
      Supply._ConfExt.actual_r_arr_eventstfr_time,
      Supply._ConfExt.actual_r_arr_zonfr,
      Supply._ConfExt.plan_r_arr_eventstfr_date,
      Supply._ConfExt.plan_r_arr_eventstfr_time,
      Supply._ConfExt.plan_r_arr_zonfr,
      Supply._ConfExt.actual_whse_arr_eventstfr_date,
      Supply._ConfExt.actual_whse_arr_eventstfr_time,
      Supply._ConfExt.actual_whse_arr_zonfr,
      Supply._ConfExt.plan_whse_arr_eventstfr_date,
      Supply._ConfExt.plan_whse_arr_eventstfr_time,
      Supply._ConfExt.plan_whse_arr_zonfr,
      Supply._ConfExt.plan_user_eta_eventstfr_date,
      Supply._ConfExt.plan_user_eta_eventstfr_time,
      Supply._ConfExt.plan_user_eta_zonfr
}
