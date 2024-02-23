/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.11.2022 | 13444     : [Build] - Stock reconciliati *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.04.2023 | 19610     : FB_19610_SD_Feature - DEFECT - Stock Reconciliation *
*              |            | DS4K949060                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@ClientHandling.type: #CLIENT_INDEPENDENT
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bw Snapshot Table Function'
define table function zsd_i_bw_snapshot_tf
returns
{
  date0          : abap.dats;
  s4plant        : char4;
  stor_loc       : char4;
  s4product      : char40;
  doc_number     : char10;
  s_ord_item     : abap.numc( 6 );
  recordmode     : char01;
  wms_timestamp  : abap.dec( 21, 7);
  sap_timestamp  : abap.dec( 21, 7);
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMUUST  : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMQIST  : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMBLST  : abap.quan( 17, 3 );
  unit           : abap.char( 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMSUUST : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMSQIST : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMSBLST : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMUUDIF : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMUURDF : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  /BIC/RLMMUUDFV : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMBLDIF : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMBLRDF : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  /BIC/RLMMBLDFV : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMQIDIF : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMQIRDF : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMQIDFV : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMTLN   : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMTLNA  : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  /BIC/RLMMTLV   : abap.curr( 17, 2 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  /BIC/RLMMTLVA  : abap.curr( 17, 2 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMUUET  : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMBLET  : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMQIET  : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMUUEGR : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMQIEGR : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMBLEGR : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMEGI   : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMEGREC : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMEGIEC : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMUUEIP : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMBLEIP : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  /BIC/RLMMQIEIP : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  /BIC/RLMMPRICE : abap.curr( 17, 2 );
  /BIC/RLMMFLDIF : char01;
  CURRENCY       : abap.cuky( 5 );
  ERRORS_CHON    : abap.dats;
  /BIC/RLMMECHBY : abap.dats;

}
implemented by method
  ZCL_SD_BW_SNAPSHOT_TF=>get_bw_snapshot;