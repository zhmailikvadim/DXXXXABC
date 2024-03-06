/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BATCHVIN     | 22.01.2024 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Case Lot App Sales Order Item with Rejected Status'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zsd_i_case_lot_rej_status
  as select distinct from I_SalesDocumentItem as vbap
{
  key vbap.SalesDocument     as SalesDoc,
      vbap.SalesOrganization as SalesOrg,
      case when vbap.DeliveryStatus = 'C' then 'X'
           when vbap.DeliveryStatus = 'B' then 'X'
              else ' '
         end                 as deliverystatus
}
where
     vbap.DeliveryStatus = 'C'
  or vbap.DeliveryStatus = 'B'
