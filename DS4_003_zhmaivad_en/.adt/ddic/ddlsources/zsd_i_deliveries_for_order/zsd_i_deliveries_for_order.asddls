/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Document Flow - Basic'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zsd_i_deliveries_for_order
  as select from vbap as _OrderItems
    inner join   vbfa as _Deliveries on  _OrderItems.vbeln   = _Deliveries.vbelv
                                     and _OrderItems.posnr   = _Deliveries.posnv
                                     and ( _Deliveries.vbtyp_n = 'J'
                                     or  _Deliveries.vbtyp_n = 'T' )

{
  key  _OrderItems.vbeln                                    as OrderNumber,
  key  cast(_OrderItems.posnr as posnr_vl preserving type ) as OrderItemNumber,
  key  _Deliveries.vbeln                                    as DeliveryDoc,
  key  _Deliveries.posnn                                    as DeliveryItem

}
