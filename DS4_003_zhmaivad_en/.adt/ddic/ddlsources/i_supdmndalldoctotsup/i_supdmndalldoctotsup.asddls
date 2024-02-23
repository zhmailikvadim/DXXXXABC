@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #COMPOSITE,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDADTSUP',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #MIXED,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
@EndUserText.label: 'View for Total Supply of All Document Types'
define view I_SupDmndAllDocTotSup
  as select from    I_SupDmndAllDocSupply as Supply
    left outer join I_SupDmndOvwPlant     as Plant            on Supply.Plant = Plant.Plant
    left outer join P_ARunAssgmtSup       as Assgmt           on  Supply.SupplyNumber       = Assgmt.SupplyNumber
                                                              and Supply.SupplyItem         = Assgmt.SupplyItem
                                                              and Supply.SupplyScheduleLine = Assgmt.SupplyScheduleLine
                                                              and Supply.Plant              = Assgmt.Plant
                                                              and Supply.Material           = Assgmt.Material
                                                              and Supply.StorageLocation    = Assgmt.StorageLocation
                                                              and Supply.Batch              = Assgmt.Batch
                                                              and Supply.AssignedSupplyType = Assgmt.AssignedSupplyType
    left outer join I_ARunCalendarDate    as CalDate          on Supply.ProductAvailabilityDate = CalDate.CalendarDate
    left outer join I_CalendarMonthName   as CalMonth         on CalDate.CalendarMonth = CalMonth.CalendarMonth
    left outer join I_ARunTimeUnitText    as ARunTimeUnitText on  ARunTimeUnitText.ARunDisplayTimeUnit = '02'
                                                              and ARunTimeUnitText.Language            = $session.system_language
{
  Supply.Material,
  Supply.Plant,
  Supply.Batch,
  Supply.StorageLocation,
  Supply.SupplyNumber,
  Supply.SupplyItem,
  Supply.SupplyScheduleLine,
  Supply.AssignedSupplyType,
  Supply.ProductAvailabilityDate,
  Supply.RequestedDeliveryDate,
  Supply.TotalQuantity,
  (   Supply.OpenSupplyQuantity
    - coalesce( Assgmt.AssignedQuantityInBaseUnit , 0 )
  )                                                                    as OpenSupplyQuantity,
  Assgmt.AssignedQuantityInBaseUnit,
  Assgmt.NormalAssignedQuantityInBsUnt,
  Assgmt.PreviewAssignedQuantityInBsUnt,
  Assgmt.ARunTmpAssignedQuantityInBsUnt,
  Supply.BaseUnit,
  Supply.SupAssgmtSource,
  CalDate.CalendarYear,
  CalDate.CalendarMonth,
  CalMonth.CalendarMonthName,
  concat_with_space( ARunDisplayTimeUnitText, CalDate.CalendarWeek, 1) as CalendarWeek,
  CalDate.CalendarDay,
  Supply.MaterialGroup,
  Supply.MaterialType,
  Supply.StockSegment,
  CrossPlantConfigurableProduct,
  case
    when Supply.PurchasingOrganization is initial
    then coalesce( Plant.PurchasingOrganization, '' )
    else Supply.PurchasingOrganization
  end                                                                  as PurchasingOrganization,
  PurchasingGroup,
  case
    when Supply.SalesOrganization is initial
    then coalesce( Plant.SalesOrganization, '' )
    else Supply.SalesOrganization
  end                                                                  as SalesOrganization,
  case
    when Supply.DistributionChannel is initial
    then coalesce( Plant.DistributionChannel, '' )
    else Supply.DistributionChannel
  end                                                                  as DistributionChannel,
  case
    when Supply.Division is initial
    then coalesce( Plant.Division, '' )
    else Supply.Division
  end                                                                  as Division,
  case
    when Supply.SalesDistrict is initial
    then coalesce( Plant.SalesDistrict, '' )
    else Supply.SalesDistrict
  end                                                                  as SalesDistrict,
  case
    when Supply.Customer is initial
    then coalesce( Plant.PlantCustomer, '' )
    else Supply.Customer
  end                                                                  as Customer,
  case
    when Supply.CompanyCode is initial
    then coalesce( Plant.CompanyCode, '' )
    else Supply.CompanyCode
  end                                                                  as CompanyCode,
  cast ( Supply.OpenSupplyQuantity * NetPriceAmount as netwr )         as ActlAmt,
  Supply.NetPriceAmount,
  Supply.DocumentCurrency
}
