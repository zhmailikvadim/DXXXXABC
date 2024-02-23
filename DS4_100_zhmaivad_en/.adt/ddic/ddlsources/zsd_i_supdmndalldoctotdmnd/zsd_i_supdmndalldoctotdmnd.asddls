@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Total Demand of All Document Types'
define view entity zsd_i_supdmndalldoctotdmnd
  as select from    ZSD_I_SupDmndAllDocDemand1 as Demand
    inner join      I_SupDmndOvwPlant          as Plant            on Demand.Plant = Plant.Plant
    left outer join P_ARunAssgmtDmnd           as Assgmt           on  Demand.RequirementDocumentNumber = Assgmt.RequirementDocumentNumber
                                                                   and Demand.RequirementDocumentItem   = Assgmt.RequirementDocumentItem
                                                                   and Demand.SupProtTimeBucketUUID     = Assgmt.SupProtTimeBucketUUID
                                                                   and Demand.RequestedDate             = Assgmt.RequestedDate
                                                                   and Demand.ProductAvailabilityDate   = Assgmt.ProductAvailabilityDate
                                                                   and Demand.RequirementType           = Assgmt.RequirementType
                                                                   and Demand.Material                  = Assgmt.Material
                                                                   and Demand.Plant                     = Assgmt.Plant
    left outer join P_SupDmndAllDocCnsmpn      as Cnsmpn           on  Demand.RequirementDocumentNumber = Cnsmpn.PlndIndepRqmtPlan
                                                                   and Demand.ProductAvailabilityDate   = Cnsmpn.ProductAvailabilityDate
                                                                   and Demand.RequirementType           = Cnsmpn.RequirementType
                                                                   and Demand.Material                  = Cnsmpn.Material
                                                                   and Demand.Plant                     = Cnsmpn.Plant
    left outer join I_ARunCalendarDate         as CalDate          on Demand.ProductAvailabilityDate = CalDate.CalendarDate
    left outer join I_CalendarMonthName        as CalMonth         on CalDate.CalendarMonth = CalMonth.CalendarMonth
    left outer join I_ARunTimeUnitText         as ARunTimeUnitText on  ARunTimeUnitText.ARunDisplayTimeUnit = '02'
                                                                   and ARunTimeUnitText.Language            = $session.system_language
{
  Demand.RequirementDocumentNumber,
  Demand.RequirementDocumentItem,
  Demand.SupProtTimeBucketUUID,
  Demand.RequestedDate,
  Demand.ProductAvailabilityDate,
  Demand.RequirementType,
  Demand.RequestedDeliveryDate,
  Demand.RequestedRqmtQtyInBaseUnit,
  Demand.ConfirmedRqmtQtyInBaseUnit,
  cast(case
    when Demand.RequirementType = 'PP'
      then coalesce( Cnsmpn.ARunConsumedQuantityInBsUnt, 0 )
    else Demand.DeliveredQuantityInBaseUnit
  end   as abap.dec( 12, 3 )  )                                                         as DeliveredQuantityInBaseUnit,
  cast((   Demand.OpenDemandQuantity
    - coalesce( Cnsmpn.ARunConsumedQuantityInBsUnt, 0 )
    - coalesce( Assgmt.AssignedQuantityInBaseUnit , 0 )
  ) as abap.dec( 12, 3 ) )                                                              as OpenDemandQuantity,

  cast(Assgmt.AssignedQuantityInBaseUnit as abap.dec( 12, 3 ) )                         as AssignedQuantityInBaseUnit,
  cast(Assgmt.NormalAssignedQuantityInBsUnt as abap.dec( 12, 3 ) )                      as NormalAssignedQuantityInBsUnt,
  cast( Assgmt.PreviewAssignedQuantityInBsUnt as abap.dec( 12, 3 ) )                    as PreviewAssignedQuantityInBsUnt,
  cast( Assgmt.ARunTmpAssignedQuantityInBsUnt as abap.dec( 12, 3 ) )                    as ARunTmpAssignedQuantityInBsUnt,
  cast( Assgmt.ARunPhysSupAssgdQtyInBsUnt as abap.dec( 12, 3 ) )                        as ARunPhysSupAssgdQtyInBsUnt,
  Demand.BaseUnit                                                                       as BaseUnit,
  CalDate.CalendarYear,
  CalDate.CalendarMonth,
  CalMonth.CalendarMonthName,
  concat_with_space( ARunTimeUnitText.ARunDisplayTimeUnitText, CalDate.CalendarWeek, 1) as CalendarWeek,
  CalDate.CalendarDay,
  Demand.Material,
  Demand.MaterialGroup,
  Demand.MaterialType,
  Demand.RequirementSegment,
  Demand.CrossPlantConfigurableProduct,
  Demand.Plant,
  Demand.SupplyProtectionName,
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
    when Demand.Customer is initial
    then coalesce( Plant.PlantCustomer, '' )
    else Demand.Customer
  end                                                                                   as Customer,
  case
    when Demand.CompanyCode is initial
    then coalesce( Plant.CompanyCode, '' )
    else Demand.CompanyCode
  end                                                                                   as CompanyCode,
  Demand.StorageLocation,
  @Semantics.amount.currencyCode: 'DocumentCurrency'
  cast ( cast(cast(Demand.NetPriceAmount as abap.quan( 13, 2 ) ) *
  Demand.OpenDemandQuantity as abap.quan( 13, 3 ) ) as netpr  )                         as ActlAmt,

  Demand.NetPriceAmount,
  Demand.DocumentCurrency,
  Plant.Country                                                                         as PlantCountry,
  Plant.Region                                                                          as PlantRegion
}
