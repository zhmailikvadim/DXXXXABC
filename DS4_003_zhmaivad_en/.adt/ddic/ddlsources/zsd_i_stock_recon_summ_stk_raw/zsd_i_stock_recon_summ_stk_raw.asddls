/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SUFIYKON     | 13.04.2023 | 20028 Stock Reconciliation Summary       *
*              |            | DS4K949671                               *
************************************************************************/

@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.type: #CLIENT_INDEPENDENT
@EndUserText.label: 'Stock Reconciliation Summary stock'

define table function zsd_i_stock_recon_summ_stk_raw
returns
{
  date0     : abap.dats;
  s4plant   : werks_d;
  stor_loc  : lgort_d;
  unit      : meins;
  rlmmblst  : abap.quan(17, 3);
  rlmmqist  : abap.quan(17, 3);
  rlmmuust  : abap.quan(17, 3);
  rlmmsblst : abap.quan(17, 3);
  rlmmsqist : abap.quan(17, 3);
  rlmmsuust : abap.quan(17, 3);
}
implemented by method
  zcl_sd_stock_recon_summ=>get_stock_from_bw