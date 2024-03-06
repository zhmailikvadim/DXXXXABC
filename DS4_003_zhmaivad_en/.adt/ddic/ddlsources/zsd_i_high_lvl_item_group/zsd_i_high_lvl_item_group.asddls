/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* HURTSALE     | 11.09.2023 | 23489     : BE: Case Lot -Enhancement app*
*              |            | DS4K963105                                    *
*----------------------------------------------------------------------*
* BATCHVIN     | 19.12.2023 | 27722     : BE: Case Lot -Enhancement    *
*              |            | DS4K974369                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Case Lot - High Level Item Group'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_HIGH_LVL_ITEM_GROUP
  as select from I_SalesDocumentItem         as vbap
    inner join   I_SalesDocumentScheduleLine as vbep on  vbap.SalesDocument                 = vbep.SalesDocument
                                                     and vbap.SalesDocumentItem             = vbep.SalesDocumentItem
                                                     and vbep.ItemIsDeliveryRelevant        is not initial
                                                     and vbep.ConfdOrderQtyByMatlAvailCheck is not initial
                                                     and vbep.IsConfirmedDelivSchedLine     = 'X'
                                                     and vbep.ItemIsDeliveryRelevant        = 'X'
{
  key vbap.SalesDocument        as SalesOrder,
  key vbap.Material             as GenericMaterial,
      min(vbap.HigherLevelItem) as HigherLevelItem,

      vbap.DistributionChannel, //for auth check
      vbap.SalesOrganization, //for auth check
      vbap.OrganizationDivision, //for auth check
      vbap.SalesDocumentType //for auth check
}
where
  vbap.HigherLevelItem is not initial
group by
  vbap.SalesDocument,
  vbap.Material,
  vbap.DistributionChannel,
  vbap.SalesOrganization,
  vbap.OrganizationDivision,
  vbap.SalesDocumentType

union select from I_SalesDocumentItem         as vbap
  inner join      I_SalesDocumentScheduleLine as vbep on  vbap.SalesDocument                 = vbep.SalesDocument
                                                      and vbap.SalesDocumentItem             = vbep.SalesDocumentItem
                                                      and vbep.ItemIsDeliveryRelevant        is not initial
                                                      and vbep.ConfdOrderQtyByMatlAvailCheck is not initial
                                                      and vbep.IsConfirmedDelivSchedLine     = 'X'
                                                      and vbep.ItemIsDeliveryRelevant        = 'X'
{
  key vbap.SalesDocument          as SalesOrder,
  key vbap.Material               as GenericMaterial,
      min(vbap.SalesDocumentItem) as HigherLevelItem,

      vbap.DistributionChannel, //for auth check
      vbap.SalesOrganization, //for auth check
      vbap.OrganizationDivision, //for auth check
      vbap.SalesDocumentType //for auth check
}
where
  vbap.HigherLevelItem is initial
group by
  vbap.SalesDocument,
  vbap.Material,
  vbap.DistributionChannel,
  vbap.SalesOrganization,
  vbap.OrganizationDivision,
  vbap.SalesDocumentType
