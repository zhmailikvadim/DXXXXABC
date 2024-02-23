@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Basic View for Confirmations'
@VDM: {
  viewType: #BASIC
}
@AccessControl: {
  authorizationCheck: #CHECK,
  personalData.blocking: #('TRANSACTIONAL_DATA')
}
@AbapCatalog: {
  sqlViewName: 'ISUPDMNDIBD',
  compiler.compareFilter: true
 }
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
define view I_SupDmndInboundDelivBasic
  as select from ekes as sched
{

 key sched.ebeln                                                                                                      as  PurchasingDocument,
 key sched.ebelp                                                                                                      as  PurchasingDocumentItem,
 key sched.etens                                                                                                      as  SequentialNmbrOfSuplrConf ,
  sched.menge                                                                                                      as  ScheduleLineOrderQuantity,
  sched.eindt                                                                                                      as  ScheduleLineDeliveryDate,
  sched.dabmg                                                                                                      as  RoughGoodsReceiptQty,
  sched.menge - sched.dabmg                                                                                        as  OpenSupplyQuantity,
  vbeln                                                                                                            as  DeliveryDocument
}
where sched.kzdis = 'X'
  and sched.dabmg < sched.menge
