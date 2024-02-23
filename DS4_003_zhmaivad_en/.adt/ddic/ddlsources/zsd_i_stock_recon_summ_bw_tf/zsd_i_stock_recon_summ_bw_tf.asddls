//@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ClientHandling.type: #CLIENT_INDEPENDENT
@EndUserText.label: 'Stock Reconciliation Summary - BW TF'

define table function ZSD_I_Stock_Recon_Summ_BW_TF
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
  zcl_sd_stock_recon_summ=>get_summ_from_bw