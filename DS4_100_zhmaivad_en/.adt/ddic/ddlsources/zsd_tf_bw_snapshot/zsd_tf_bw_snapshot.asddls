/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@ClientHandling.type: #CLIENT_INDEPENDENT
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bw Snapshot'
define table function zsd_tf_bw_snapshot
returns
{
  date0           : abap.dats;
  plant           : char4;
  stor_loc        : char4;
  s4product       : char40;
  cold_store_flag : char1;
  doc_number      : char10;
  s_ord_item      : abap.numc( 6 );
  wms_timestamp   : abap.dec( 21, 7);
  sap_timestamp   : abap.dec( 21, 7);
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMWMSST  : abap.quan( 17, 3 );
  unit            : abap.char( 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMSAPST  : abap.quan( 17, 3 );
  /BIC/RLMMSTTYP  : abap.char( 2 );
}
implemented by method
  zcl_sd_table_func_implement=>get_bw_snapshot;