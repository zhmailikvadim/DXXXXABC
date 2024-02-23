/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CHUTLGIO     | 14.06.2022 | 11280     : BE Dev - Case Lot data structure, fields *
*              |            | DS4K919167                               *
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

  composition [1..*] of zsd_i_case_lot_i     as _CaseLotItem

  association [1..*] to zsd_i_salesorder_rdd as _SalesOrder on  $projection.SalesOrder       = _SalesOrder.SalesOrder
                                                            and $projection.Material         = _SalesOrder.GenericMaterial
                                                            and $projection.Plant            = _SalesOrder.Plant
                                                            and $projection.RequestedDelDate = _SalesOrder.RequestedDelDate
  association [0..1] to ZSD_I_PCKNG_MODE     as _Pckngmode  on  $projection.PackingMode      = _Pckngmode.pkmode

{
  key caseloth_uuid                                           as CaseLotHUUID,
      vbeln                                                   as SalesOrder,
      caselot_no                                              as CaselotNo,
      matnr                                                   as Material,
      werks                                                   as Plant,
      edatu                                                   as RequestedDelDate, //RDD
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

      case
      when caselot_pkmode = 'SSP'then cast( 'X' as boolean preserving type )
      when caselot_pkmode = 'MSP'then cast( 'X' as boolean preserving type )
      else cast( '' as boolean preserving type )
      end                                                     as PBFieldControl,

      case
      when caselot_pkmode = 'SSP' then cast( 'X' as boolean preserving type )
      when caselot_pkmode = 'SSSP'then cast( 'X' as boolean preserving type )
      else cast( '' as boolean preserving type )
      end                                                     as CLQuanFieldControl,
      
      cast('' as boolean preserving type ) as manualflag,

      _CaseLotItem,
      _Pckngmode,
      _SalesOrder
}
