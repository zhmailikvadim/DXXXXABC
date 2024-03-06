/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SRIKAVEN     | 06.06.2023 | 20611     : BE: Case Lot -Enhancement    *
*              |            | DS4K950721                               *
************************************************************************
* HURTSALE     | 11.09.2023 | 23489     : BE: Case Lot -Enhancement app*
*              |            | DS4K963105                                     *
*----------------------------------------------------------------------*
* BATCHVIN     | 20.12.2023 | 27722     : BE: Case Lot -Enhancement    *
*              |            | DS4K974369                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Confirmend Quantity ANd ordered Quantity Group'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZSD_I_CONF_QUANT_GROUP
  as select from I_SalesDocumentItem         as vbap
    inner join   I_SalesDocumentScheduleLine as vbep            on  vbap.SalesDocument                 = vbep.SalesDocument
                                                                and vbap.SalesDocumentItem             = vbep.SalesDocumentItem
                                                                and vbep.ItemIsDeliveryRelevant        is not initial
                                                                and vbep.ConfdOrderQtyByMatlAvailCheck is not initial
                                                                and vbep.IsConfirmedDelivSchedLine     = 'X'
                                                                and vbep.ItemIsDeliveryRelevant        = 'X'
    inner join   ZSD_I_HIGH_LVL_ITEM_LIMITED as high_item_limit on  vbap.SalesDocument = high_item_limit.SalesOrder
                                                                and vbap.Material      = high_item_limit.GenericMaterial
{
  key vbap.SalesDocument                       as SalesOrder,
      min( high_item_limit.HigherLevelItem )   as SalesOrderItem,
      vbap.PricingReferenceMaterial,
      vbep.OrderQuantityUnit                   as OrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      sum ( vbap.ConfdDelivQtyInOrderQtyUnit ) as conf,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      sum ( vbap.OrderQuantity )               as ordered,


      vbap.DistributionChannel, //for auth check
      vbap.SalesOrganization, //for auth check
      vbap.OrganizationDivision, //for auth check
      vbap.SalesDocumentType //for auth check
}
where
  vbap.SDDocumentRejectionStatus <> 'C'
group by
  vbap.SalesDocument,
  vbep.OrderQuantityUnit,
  vbap.PricingReferenceMaterial,
  vbap.DistributionChannel,
  vbap.SalesOrganization,
  vbap.OrganizationDivision,
  vbap.SalesDocumentType
