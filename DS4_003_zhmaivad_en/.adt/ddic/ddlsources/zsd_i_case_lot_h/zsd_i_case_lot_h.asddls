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
*----------------------------------------------------------------------*
* NAGARSOW     | 19.09.2023 | 23489     : BE: Case Lot -Enhancement    *
*              |            | DS4K963105                               *
*----------------------------------------------------------------------*
* BATCHVIN     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Case Lot Header Information'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsd_i_case_lot_h
  as select from zsd_t_case_lot_h as CaseLotHeader
  composition [1..*] of zsd_i_case_lot_i          as _CaseLotItem
  association [0..1] to I_SalesDocumentBasic      as _Salesdoc      on  $projection.SalesOrder = _Salesdoc.SalesDocument
  association [1..*] to zsd_i_salesorder_rdd      as _SalesOrder    on  $projection.SalesOrder       = _SalesOrder.SalesOrder
                                                                    and $projection.Material         = _SalesOrder.GenericMaterial
                                                                    and $projection.Plant            = _SalesOrder.Plant
                                                                    and $projection.RequestedDelDate = _SalesOrder.RequestedDelDate
  association [0..1] to ZSD_I_PCKNG_MODE          as _Pckngmode     on  $projection.PackingMode = _Pckngmode.pkmode
  association [0..1] to zsd_i_case_lot_rej_status as DeliveryStatus on  $projection.SalesOrder = DeliveryStatus.SalesDoc
  association [0..1] to zsd_i_po_vascutoff        as vascutoff      on  CaseLotHeader.vbeln = vascutoff.sales_vascutoff


{
  key caseloth_uuid                                           as CaseLotHUUID,
      vbeln                                                   as SalesOrder,
      caselot_no                                              as CaselotNo,
      matnr                                                   as Material,
      werks                                                   as Plant,
      _Salesdoc.SalesDocumentType                             as SalesDocumentType,
      _Salesdoc.OrganizationDivision                          as Division,
      _Salesdoc.DistributionChannel                           as DistributionChannel,
      _Salesdoc.SalesOrganization                             as SalesOrganization,
      edatu                                                   as RequestedDelDate, //RDD
      @UI.hidden: true
      vbtyp                                                   as SDDocumentCategory,
      no_caselot_cnt                                          as NumberOfMPB,
      no_maspb_ctn                                            as NumberOfMPBPerCnt,
      caselot_pkmode                                          as PackingMode,
      caselot_text                                            as CaseLotText,
      ebeln                                                   as PurchaseOrderNum,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit'
      caselot_total_kwmeng                                    as TotalActualQty,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit'
      cast( caselot_total_kbmeng as zsd_total_confirmed_qty ) as TotalConfirmedQty,
      sounit                                                  as TotalOrderQuantityUnit,
      no_caselot_units                                        as NumberOfUnits,
      total_qty_ctn                                           as TotalQtyPerCtn,
      @Semantics.systemDateTime.createdAt: true
      created_at                                              as CreatedAt,
      @Semantics.user.createdBy: true
      created_by                                              as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      changed_at                                              as ChangedAt,
      @Semantics.user.lastChangedBy: true
      changed_by                                              as ChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                         as LastChangedAt,
      @EndUserText.label: 'Case Lot Status'
      cl_status                                               as CaseLotStatus,
      @EndUserText.label: 'Total Quantity'
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit'
      total_caselot_qty                                       as TotalQuantity,
      @UI.hidden: true
      case
      when caselot_pkmode = 'SSP'then cast( 'X' as boolean preserving type )
      when caselot_pkmode = 'MSP'then cast( 'X' as boolean preserving type )
      else cast( '' as boolean preserving type )
      end                                                     as PBFieldControl,
      @UI.hidden: true
      cast('' as boolean preserving type )                    as manualflag,
      vascutoff.sales_vascutoff                               as vascutoffsales,
      @UI.hidden: true
      case
      when vascutoff.CustomizationStatus = 'Y'
      then cast( 'X' as boolean preserving type )
      else cast( '' as boolean preserving type )
      end                                                     as vascutoffflag,
      DeliveryStatus.deliverystatus                           as DeliveryStatus,
      _CaseLotItem,
      _Pckngmode,
      _SalesOrder
}
