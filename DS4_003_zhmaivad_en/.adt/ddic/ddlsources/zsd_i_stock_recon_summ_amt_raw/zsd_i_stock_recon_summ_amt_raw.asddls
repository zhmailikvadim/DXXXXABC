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
@EndUserText.label: 'Stock Reconciliation Summary amounts'

define table function zsd_i_stock_recon_summ_amt_raw
returns
{
  date0     : abap.dats;
  s4plant   : werks_d;
  unit      : meins;
  createdon : abap.dats;
  createdby : syuname;
  rlmmsales : abap.quan(17, 3);
  rlmmrtrn  : abap.quan(17, 3);
  rlmmgi    : abap.quan(17, 3);
  rlmmgr    : abap.quan(17, 3);
}
implemented by method
  zcl_sd_stock_recon_summ=>get_amounts_from_bw