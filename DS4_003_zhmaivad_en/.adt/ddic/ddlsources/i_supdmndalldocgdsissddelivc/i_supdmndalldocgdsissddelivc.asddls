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
  sqlViewName: 'ISUPDMNDADGIDLVC',
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
@EndUserText.label: 'Cube View for Goods Issued Deliveries'
define view I_SupDmndAllDocGdsIssdDelivC
  as select from    I_SupDmndAllDocGdsIssdDeliv as Demand
    inner join      I_SupDmndOvwPlant           as Plant            on Demand.Plant = Plant.Plant
    left outer join I_ARunCalendarDate          as CalDate          on Demand.ProductAvailabilityDate = CalDate.CalendarDate
    left outer join I_CalendarMonthName         as CalMonth         on CalDate.CalendarMonth = CalMonth.CalendarMonth
    left outer join I_ARunTimeUnitText          as ARunTimeUnitText on  ARunTimeUnitText.ARunDisplayTimeUnit = '02'
                                                                    and ARunTimeUnitText.Language            = $session.system_language
  association [0..1] to I_UnitOfMeasure as _BaseUnit    on $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_Currency      as _DocCurrency on $projection.DocumentCurrency = _DocCurrency.Currency
{
      @EndUserText.label: 'Requirement Document Number'
  key Demand.RequirementDocumentNumber,
      @EndUserText.label: 'Requirement Document Item'
  key Demand.RequirementDocumentItem,
      @EndUserText.label: 'Requested Date'
  key Demand.RequestedDate,
      @EndUserText.label: 'Delivery Date'
  key Demand.ProductAvailabilityDate,
      @EndUserText.label: 'Requirement Type'
  key Demand.RequirementType,
      Demand.HigherLvlItmOfBatSpltItm,
      @EndUserText.label: 'Requested Delivery Date'
      Demand.RequestedDeliveryDate,
      @EndUserText.label: 'Delivered Quantity'
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'SupAssgmtAggrgQtyUnit'
      DeliveredQuantity,
      @ObjectModel.foreignKey.association: '_BaseUnit'
      Demand.BaseUnit,
      @Semantics.calendar.year: true
      @EndUserText.label: 'Year'
      CalDate.CalendarYear,
      @EndUserText.label: 'Month'
      @Semantics.calendar.month: true
      @ObjectModel.text.element: 'CalendarMonthName'
      CalDate.CalendarMonth,
      @Semantics.text: true
      @EndUserText.label: 'Month'
      CalMonth.CalendarMonthName,
      @EndUserText.label: 'Week'
      @Semantics.calendar.week: true
      concat_with_space( ARunDisplayTimeUnitText, CalDate.CalendarWeek, 1)             as CalendarWeek,
      @EndUserText.label: 'Day'
      @Semantics.calendar.dayOfMonth: true
      CalDate.CalendarDay,
      @EndUserText.label: 'Product'
      Demand.Material,
      @EndUserText.label: 'Product Group'
      Demand.MaterialGroup,
      @EndUserText.label: 'Product Type'
      MaterialType,
      @EndUserText.label: 'Generic Article'
      Demand.CrossPlantConfigurableProduct,
      @EndUserText.label: 'Plannned Goods Issue Date'
      PlannedGoodsIssueDate,
      @EndUserText.label: 'Actual Goods Issue Date'
      ActualGoodsMovementDate,
      @EndUserText.label: 'Planned GI - Actual GI'
      case
        when Demand.GIToPlndGIDelayInDays <=0 then '00'
        when Demand.GIToPlndGIDelayInDays < 7   then '01'
        when Demand.GIToPlndGIDelayInDays < 14  then '02'
        when Demand.GIToPlndGIDelayInDays < 21  then '03'
        when Demand.GIToPlndGIDelayInDays <= 28 then '04'
        when Demand.GIToPlndGIDelayInDays > 28  then '05'
      end                                                                              as ARunGIDelayTmeHrznCode,
      @EndUserText.label: 'Mode of Transport'
      Demand.ShippingType,
      Demand.Plant,
      coalesce( Demand.SalesOrganization, coalesce( Plant.SalesOrganization, '' ) )    as SalesOrganization,
      coalesce( Demand.DistributionChannel, coalesce( Plant.DistributionChannel, '') ) as DistributionChannel,
      coalesce( Demand.Division, coalesce( Plant.Division, '') )                       as Division,
      coalesce( Demand.SalesDistrict, coalesce( Plant.SalesDistrict, '') )             as SalesDistrict,
      coalesce( Demand.SoldToParty, coalesce( Plant.PlantCustomer, '') )               as Customer,
      Plant.CompanyCode,
      Demand.StorageLocation,
      @Semantics.unitOfMeasure: true
      cast( ' ' as meins )                                                             as SupAssgmtAggrgQtyUnit,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Demand.NetPriceAmount,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_DocCurrency'
      Demand.DocumentCurrency,
      //Associations
      _BaseUnit,
      _DocCurrency
}

where
  IsBusinessPurposeCompleted = ''
