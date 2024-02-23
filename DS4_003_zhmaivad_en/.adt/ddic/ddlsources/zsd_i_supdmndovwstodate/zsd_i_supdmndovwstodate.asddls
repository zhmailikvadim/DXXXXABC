/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SHNIPALI     | 05.01.2023 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for Conf Deliv Date for STO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_SupDmndOvwSTODate 
 as select from I_PurgDocScheduleLineBasic as Sched
{
  key PurchasingDocument            as RequirementDocumentNumber,
  key PurchasingDocumentItem        as RequirementDocumentItem,
  max(ScheduleLineDeliveryDate)     as ConfirmedDeliveryDate
}
where ScheduleLineCommittedQuantity > 0
group by
  PurchasingDocument,
  PurchasingDocumentItem 
  
