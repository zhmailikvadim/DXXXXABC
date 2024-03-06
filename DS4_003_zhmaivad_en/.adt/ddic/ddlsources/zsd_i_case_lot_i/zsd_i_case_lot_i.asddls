/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CHUTLGIO     | 14.06.2022 | 11280     : BE Dev - Case Lot data structure, fields *
*              |            | DS4K919167                               *
*----------------------------------------------------------------------*
************************************************************************
* SRIKAVEN     | 12.01.2023 | 15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *
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
@EndUserText.label: 'Case Lot Item Information'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_case_lot_i
  as select from zsd_t_case_lot_i as item
  association        to parent zsd_i_case_lot_h as _CaseLotHeader on  _CaseLotHeader.CaseLotHUUID = $projection.CaselotHUUID
  association [1..1] to zsd_i_salesorder_rdd    as _SalesOrder    on  $projection.SalesOrder     = _SalesOrder.SalesOrder
                                                                  and $projection.SalesOrderItem = _SalesOrder.SalesOrderItem


{
  key item.caseloth_uuid                    as CaselotHUUID,
  key item.caseloti_uuid                    as CaselotIUUID,
      item.caselot_item                     as CaselotItem,
      item.matnr                            as Material,
      item.uepos                            as HigherLevelItem,
      item.etenr                            as ScheduleLine,
      item.edatu                            as ConfirmedDeliveryDate,
      _CaseLotHeader.SalesDocumentType      as SalesDocumentType,
      _CaseLotHeader.SalesOrder             as SalesOrder,
      _CaseLotHeader.SalesOrganization      as SalesOrganization,
      _CaseLotHeader.DistributionChannel    as DistributionChannel,
      _CaseLotHeader.Division               as Division,
      item.posnr                            as SalesOrderItem,
      _CaseLotHeader.TotalOrderQuantityUnit as TotalOrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit'
      item.kwmeng                           as OrderQuantity,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit'
      item.kbmeng                           as ConfdQuantity,
      item.caselot_cl_pb                    as CaseLotQuantity,
      ''                                    as Checkqty,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit'
      item.caselot_tt_qty                   as CLTotalQty,
      case when item.kwmeng = item.kbmeng
        then 3
        else 1
        end                                 as Criticality,

      _CaseLotHeader.PBFieldControl         as PBFieldControlI,
      @Semantics.systemDateTime.createdAt: true
      item.created_at                       as CreatedAt,
      @Semantics.user.createdBy: true
      item.created_by                       as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      item.changed_at                       as ChangedAt,
      @Semantics.user.lastChangedBy: true
      item.changed_by                       as ChangedBy,
      _CaseLotHeader,
      _SalesOrder

}
