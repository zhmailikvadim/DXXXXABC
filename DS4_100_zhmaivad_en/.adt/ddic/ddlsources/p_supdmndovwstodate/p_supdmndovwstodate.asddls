@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
  viewType: #COMPOSITE,
  private: true
}
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'PSDOSTODATE',
  compiler.compareFilter: true,
  preserveKey: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XXL
   }
}
//@EndUserText.label: 'View for Earliest Requested Delivery Date for STO'
define view P_SupDmndOvwSTODate
  as select from I_PurgDocScheduleLineBasic as Sched
{
  key PurchasingDocument            as RequirementDocumentNumber,
  key PurchasingDocumentItem        as RequirementDocumentItem,
      _PurchasingDocumentItem.Material  as Material,
      _PurchasingDocument.SupplyingPlant as Plant,
      min(Batch)                    as Batch,
      min(ScheduleLineDeliveryDate) as EarliestRequestedDeliveryDate
}
group by
  PurchasingDocument,
  PurchasingDocumentItem,
  _PurchasingDocumentItem.Material,
  _PurchasingDocument.SupplyingPlant
