/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Params for Stock Snapshot'
define abstract entity zsd_d_stock_snapshot_date
{
  @Consumption.filter:{ selectionType:#SINGLE}
  @EndUserText.label: 'SAP Timestamp'
  sap_timestamp : zsd_snapshot_sap_timestamp;
}
