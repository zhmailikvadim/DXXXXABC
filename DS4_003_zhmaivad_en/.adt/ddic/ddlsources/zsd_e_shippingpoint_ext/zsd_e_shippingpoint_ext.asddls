/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 21.11.2023 | 26318     : DN OS compliance Report      *
*              |            | DS4K968461                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZILESHIPPING_EXT'
@EndUserText.label: 'Extend view for Shipping Point'
extend view I_ShippingPoint with ZSD_E_Shippingpoint_Ext
{
  fabkl as zzfabkl,
  azone as zzazone
}
