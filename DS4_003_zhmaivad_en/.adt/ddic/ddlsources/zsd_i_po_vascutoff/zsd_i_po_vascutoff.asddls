/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SRIKAVEN     | 12.01.2023 | 15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *
* SRIKAVEN     | 26.04.2023 | 20611     : BE: Case Lot -Enhancement *
*              |            | DS4K950721                               *
*----------------------------------------------------------------------*
* ADAKHIKB     | 16.08.2023 | 24320     : Development - Custom Stat.Y  *
*              |            | DS4K960820                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'VAS Cutoff date determination'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_po_vascutoff
  as select from I_SalesDocumentItem         as vbap
    inner join   I_SalesDocumentScheduleLine as vbep on  vbap.SalesDocument     = vbep.SalesDocument
                                                     and vbap.SalesDocumentItem = vbep.SalesDocumentItem

    inner join   ZSD_I_HM_ITEMCAT            as hm   on vbap.SalesDocumentItemCategory = hm.field1
    inner join   ekpo                                on  ekpo.banfn = vbep.PurchaseRequisition
                                                     and ekpo.bnfpo = vbep.PurchaseRequisitionItem
{
  vbap.SalesDocument       as sales_vascutoff,
  vbap.SalesDocumentItem   as item_number,
  vbap.Material            as Material,
  vbap.SalesOrganization   as SalesOrganization,
  ekpo.zz1_custom_stat_pdi as CustomizationStatus
}
where
      vbep.ConfdOrderQtyByMatlAvailCheck is not initial
  and vbap.DeliveryStatus                = 'A'
  and ekpo.zz1_custom_stat_pdi           = 'Y'
