/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CHUTLGIO     | 30.06.2022 | 11280     : BE Dev - Case Lot data structure, fields *
*              |            | DS4K919167                               *
*----------------------------------------------------------------------*
************************************************************************
* SRIKAVEN     | 12.01.2023 | 15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *

* SRIKAVEN     | 26.04.2023 | 20611     : BE: Case Lot -Enhancement *
*              |            | DS4K950721                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 19.09.2023 | 23489     : BE: Case Lot -Enhancement *
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
@EndUserText.label: 'Grouping Sales Order data for Case Lot connection'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsd_i_salesorder_rdd_group
  as select from I_SalesDocumentItem               as vbap
    inner join   I_SalesDocument                   as vbak            on vbap.SalesDocument = vbak.SalesDocument
    inner join   I_SalesDocumentScheduleLine       as vbep            on  vbap.SalesDocument     = vbep.SalesDocument
                                                                      and vbap.SalesDocumentItem = vbep.SalesDocumentItem
    inner join   ZSD_I_MATERIAL_GROUP              as material        on  vbap.SalesDocument     = material.SalesOrder
                                                                      and vbap.SalesDocumentItem = material.SalesOrderItem

    inner join   ZPE_I_HM( iv_id  : '0000002746' ) as hardcodemanager on hardcodemanager.field1 = vbap.SalesDocumentType

    inner join   ZSD_I_CONF_QUANT_GROUP            as quant           on  quant.SalesOrder     = vbap.SalesDocument
                                                                      and quant.SalesOrderItem = vbap.SalesDocumentItem
  association [0..1] to zsd_i_case_lot_rej_status     as DeliveryStatus             on  vbap.SalesDocument = DeliveryStatus.SalesDoc
  association [0..*] to zsd_i_po_vascutoff            as vascutoff                  on  vbap.SalesDocument     = vascutoff.sales_vascutoff
                                                                                    and vbap.SalesDocumentItem = vascutoff.item_number
  association [1..1] to ZSD_I_HM_ITEMCAT              as _hm                        on  vbap.SalesDocumentItemCategory = _hm.field1
  association [0..1] to zsd_i_total_msp_case_lots_qty as _TotalCaseLotQtyMSP        on  $projection.SalesOrder       = _TotalCaseLotQtyMSP.SalesOrder
                                                                                    and $projection.GenericMaterial  = _TotalCaseLotQtyMSP.Material
                                                                                    and $projection.Plant            = _TotalCaseLotQtyMSP.Plant
                                                                                    and $projection.RequestedDelDate = _TotalCaseLotQtyMSP.RequestedDelDate
  association [0..1] to zsd_i_total_ssp_case_lots_qty as _TotalCaseLotQtySSP        on  $projection.SalesOrder       = _TotalCaseLotQtySSP.SalesOrder
                                                                                    and $projection.GenericMaterial  = _TotalCaseLotQtySSP.Material
                                                                                    and $projection.Plant            = _TotalCaseLotQtySSP.Plant
                                                                                    and $projection.RequestedDelDate = _TotalCaseLotQtySSP.RequestedDelDate
  association [0..1] to zsd_i_case_lot_mode           as _CaseLotSSPandSSSPPackMode on  $projection.SalesOrder       = _CaseLotSSPandSSSPPackMode.SalesOrder
                                                                                    and $projection.GenericMaterial  = _CaseLotSSPandSSSPPackMode.Material
                                                                                    and $projection.Plant            = _CaseLotSSPandSSSPPackMode.Plant
                                                                                    and $projection.RequestedDelDate = _CaseLotSSPandSSSPPackMode.RequestedDelDate
  association [0..1] to zsd_i_salesorder_rdd          as rdd                        on  vbap.SalesDocument = rdd.SalesOrder

  association [0..1] to zsd_i_case_lot_h              as header                     on  header.SalesOrder = vbap.SalesDocument
                                                                                    and header.Material   = material.GenericMaterial
{
  key vbap.SalesDocument                                      as SalesOrder,
  key material.GenericMaterial                                as GenericMaterial,
      vbak.SalesOrganization                                  as SalesOrganization,
      min (vbap.SalesDocumentItem )                           as SalesOrderItem,
      vbap.Plant                                              as Plant,
      vbap.RequestedDeliveryDate                              as RequestedDelDate,
      max(vbep.DeliveryDate)                                  as ConfirmedDeliveryDate,
      max(vbap.SalesDocumentType)                             as SalesDocType,
      max(vbap.DistributionChannel)                           as DistributionChanel,
      vbap.Division                                           as Division,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit_1'
      ceil( cast(   quant.conf  as abap.dec(20 , 5)  ) )      as ConfirmedQty_4,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit_1'
      ceil( cast(  quant.ordered  as abap.dec(20 , 5) ) )     as TotalOrderQty,
      vbep.OrderQuantityUnit                                  as TotalOrderQuantityUnit_1,
      vbep.OrderQuantityUnit                                  as QuantityUnit_2,
      case when min(_TotalCaseLotQtySSP.TotalCSQtySSP) > 0 then 'Yes'
           when min(_TotalCaseLotQtyMSP.TotalCSQtyMSP) > 0 then 'Yes'
           else 'No'
           end                                                as CaseLotExists,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit_1'
      min(_TotalCaseLotQtySSP.TotalCSQtySSP)                  as TotalConfirmedQty_SSP,
      @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit_1'
      min(_TotalCaseLotQtyMSP.TotalCSQtyMSP)                  as TotalConfirmedQty_MSP,
      min(_CaseLotSSPandSSSPPackMode.PackModeSSPandSSSPCount) as PackModeSSPandSSSPCount,
      max(vbap.HigherLevelItem)                               as HigherLevelItem,
      max(vbep.ScheduleLine)                                  as ScheduleLineNumber,
      rdd.SalesOrderflag                                      as SalesOrderflag,
      max(vbak.SDDocumentCategory)                            as SDDocumentCategory,
      _CaseLotSSPandSSSPPackMode,

      max( header.CaselotNo )                                 as caselotno,
      header.CaseLotStatus                                    as CaseLotStatus,
      _CaseLotSSPandSSSPPackMode.PackingMode                  as PackingMode,
      DeliveryStatus.deliverystatus                           as DeliveryStatus
}
where
      vbap.HigherLevelItem               is initial
  and vbep.ConfdOrderQtyByMatlAvailCheck is not initial
group by
  vbap.SalesDocument,
  material.GenericMaterial,
  vbak.SalesOrganization,
  vbap.Division,
  vbap.Plant,
  vbap.RequestedDeliveryDate,
  vbap.DistributionChannel,
  vbap.SalesDocumentType,
  vbep.OrderQuantityUnit,
  rdd.SalesOrderflag,
  quant.conf,
  quant.ordered,
  header.CaseLotStatus,
  _CaseLotSSPandSSSPPackMode.PackingMode,
  DeliveryStatus.deliverystatus
