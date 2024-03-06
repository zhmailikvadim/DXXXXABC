/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CHUTLGIO     | 15.06.2022 | 11280     : BE Dev - Case Lot data structure, fields *
*              |            | DS4K919167                               *
*----------------------------------------------------------------------*
************************************************************************
* SRIKAVEN     | 12.01.2023 | 15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *
*----------------------------------------------------------------------*
* SRIKAVEN     | 06.06.2023 | 20611     : BE: Case Lot -Enhancement *
*              |            | DS4K950721                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 19.09.2023 | 23489     : BE: Case Lot -Enhancement *
*              |            | DS4K963105                               *
************************************************************************
* NAGARSOW     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data view for Sales Order grouping'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity zsd_i_salesorder_rdd
  as select from I_SalesDocumentItem         as vbap
    inner join   I_SalesDocumentScheduleLine as vbep     on  vbap.SalesDocument                 = vbep.SalesDocument
                                                         and vbap.SalesDocumentItem             = vbep.SalesDocumentItem
                                                         and vbep.ItemIsDeliveryRelevant        is not initial
                                                         and vbep.ConfdOrderQtyByMatlAvailCheck is not initial
                                                         and vbep.IsConfirmedDelivSchedLine     = 'X'
                                                         and vbep.ItemIsDeliveryRelevant        = 'X'
    inner join   I_SalesDocument             as vbak     on vbap.SalesDocument = vbak.SalesDocument
    inner join   ZSD_I_MATERIAL_GROUP        as material on  vbap.SalesDocument     = material.SalesOrder
                                                         and vbap.SalesDocumentItem = material.SalesOrderItem
    inner join   ZSD_I_TOTAL_QUANTITY        as total    on  vbap.SalesDocument     = total.SalesOrder
                                                         and vbap.SalesDocumentItem = total.SalesOrderItem

  association [0..*] to zsd_i_po_vascutoff  as vascutoff        on  vbap.SalesDocument     = vascutoff.sales_vascutoff
                                                                and vbap.SalesDocumentItem = vascutoff.item_number
  association [1..1] to I_SalesDocumentItem as _GenericMaterial on  _GenericMaterial.SalesDocument = $projection.SalesOrder
  association [1..1] to ZSD_I_HM_ITEMCAT    as _hm              on  vbap.SalesDocumentItemCategory = _hm.field1
{

  key vbap.SalesDocument                 as SalesOrder,
  key vbap.SalesDocumentItem             as SalesOrderItem,
      max ( vbap.Material )              as Material,
      max ( vbap.Plant )                 as Plant,
      max ( vbap.SalesDocumentType )     as SalesDocType,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbap.OrderQuantity                 as OrderQuantity,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbap.ConfdDelivQtyInOrderQtyUnit   as ConfirmedQuantity,
      vbap.OrderQuantityUnit             as OrderQuantityUnit,
      vbak.SalesOrganization             as SalesOrganization,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      max ( vbap.OrderQuantity )         as OrderQuantityAllSizes,
      max ( vbap.HigherLevelItem )       as HigherLevelItem,
      min ( vbep.ScheduleLine )          as ScheduleLineNumber,
      max ( vbep.DeliveryDate )          as ConfirmedDeliveryDate,
      max ( vbap.RequestedDeliveryDate ) as RequestedDelDate,
      max ( vbap.DistributionChannel )   as DistributionChanel,
      max ( vbap.Division )              as Division,
      max ( material.GenericMaterial )   as GenericMaterial,
      max ( vascutoff.sales_vascutoff )  as SalesOrderflag,
      max ( vbak.SDDocumentCategory )    as SDDocumentCategory,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      max ( total.sum_gross_amount )     as sum_gross_amount,


      _GenericMaterial
}
where
      vbak.SDDocumentCategory            =  'C'
  and vbap.SalesDocumentItemType         is initial
  and vbap.SDDocumentRejectionStatus     <> 'C'
  and vbep.ConfdOrderQtyByMatlAvailCheck is not initial
  and vbep.IsConfirmedDelivSchedLine     is not initial
  and vbep.ItemIsDeliveryRelevant        =  'X'
group by
  vbap.SalesDocument,
  vbap.SalesDocumentItem,
  vbak.SalesOrganization,
  vbap.OrderQuantity,
  vbap.ConfdDelivQtyInOrderQtyUnit,
  vbap.OrderQuantityUnit,
  vbap.ConfdDelivQtyInOrderQtyUnit
