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
*----------------------------------------------------------------------*
* ZHMAIVAD     | 21.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@ClientHandling.type: #CLIENT_INDEPENDENT
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bw Snapshot Table Function'
define table function zsd_i_bw_snapshot_tf
returns
{
  date0         : abap.dats;
  s4plant       : char4;
  stor_loc      : char4;
  s4product     : char40;
  doc_number    : char10;
  s_ord_item    : abap.numc( 6 );
  wms_timestamp : abap.dec( 21, 7);
  sap_timestamp : abap.dec( 21, 7);
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMUUST      : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMQIST      : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMBLST      : abap.quan( 17, 3 );
  unit          : abap.char( 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMSUUST     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMSQIST     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMSBLST     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMUUDIF     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMUURDF     : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  RLMMUUDFV     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMBLDIF     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMBLRDF     : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  RLMMBLDFV     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMQIDIF     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMQIRDF     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMQIDFV     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMTLN       : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMTLNA      : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  RLMMTLV       : abap.curr( 17, 2 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  RLMMTLVA      : abap.curr( 17, 2 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMUUET      : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMBLET      : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMQIET      : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMUUEGR     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMQIEGR     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMBLEGR     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMEGI       : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMEGREC     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMEGIEC     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMUUEIP     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMBLEIP     : abap.quan( 17, 3 );
  @Semantics.quantity.unitOfMeasure : 'unit'
  RLMMQIEIP     : abap.quan( 17, 3 );
  @Semantics.amount.currencyCode: 'CURRENCY'
  RLMMPRICE     : abap.curr( 17, 2 );
  RLMMFLDIF     : char01;
  CURRENCY      : abap.cuky( 5 );
  ERRORS_CHON   : abap.dec( 21, 7);
  RLMMECHBY     : changeby;
  RLMMUNIT      : abap.char( 3 );

}
implemented by method
  ZCL_SD_BW_SNAPSHOT_TF=>get_bw_snapshot;