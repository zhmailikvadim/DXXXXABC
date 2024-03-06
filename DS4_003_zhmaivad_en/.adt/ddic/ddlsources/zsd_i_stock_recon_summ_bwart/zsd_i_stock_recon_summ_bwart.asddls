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
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Reconciliation Summary movTypeCat'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_stock_recon_summ_bwart
  as select from ZPE_I_HM(iv_id: '0000001472')
{
  key field2 as goodsmovementtype,

      field1 as goodsmovementtypecategory
}
