/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 25.10.2023 | 25663     : [Build] Outbound Delivery Stat *
*              |            | DS4K965942                              *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Wrapper class for delivery custom fields'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_DELV_CUSTOM
  as select from likp
{
  key vbeln                      as DeliveryDocument,
      vkorg                      as SalesOrganization,
      zz1_seq_no_dlh             as SequenceNumber,
      zz1_wms_palqty_dlh         as WMSPalletquantity,
      zz1_otcdldate_dlh          as FulfillmentDateSO,
      zz1_parentdeliverynote_dlh as ParentDeliveryNoteNumber,
      zz1_wms_carqty_dlh         as WMSCartonquantity,
      zz1_wms_carrierstr_dlh     as WMSCarrierString,
      zz1_wms_loadid_dlh         as WMSLoadID,
      zz1_delscen_sdi_dlh        as FulfillmentScenarioSTO,
      zz1_tms_carrierstr_dlh     as TMSCarrierString,
      zz1_tms_loadid_dlh         as TMSLoadID,
      zz1_otcdldate_sdi_dlh      as FulfillmentDateSTO,
      zz1_zotcbook_dlh           as BookingInRoutingIndicator,
      zz1_route_st_dlh           as RoutingStatus,
      zz1_delscen_dlh            as FulfillmentScenarioSO
}
