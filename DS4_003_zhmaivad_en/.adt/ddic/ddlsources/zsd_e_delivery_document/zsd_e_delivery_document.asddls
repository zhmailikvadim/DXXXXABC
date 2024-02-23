/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 17.11.2023 | 25663     : [Build] Outbound Delivery Stat *
*              |            | DS4K965942                              *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZILEDELIVDOC_CRG'
@EndUserText.label: 'Extension of delivery for Credit rep grp'
extend view I_DeliveryDocument with ZSD_E_DELIVERY_DOCUMENT
{
  sbgrp as zzsbgrp,
  ctlpc as zzctlpc
}
