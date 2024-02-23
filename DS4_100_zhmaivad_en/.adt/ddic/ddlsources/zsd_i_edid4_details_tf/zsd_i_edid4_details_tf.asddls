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
*----------------------------------------------------------------------*/
@EndUserText.label: 'Parse edid4-sdata fields values'
@AccessControl.authorizationCheck: #CHECK
define table function zsd_i_edid4_details_tf
returns
{
  client   : mandt;
  docnum   : edi_docnum;
  posnr    : posnr;
  Delivery : char10;
  Article  : char18;
  Quantity : char15;
  Plant    : char4;
  Lgort    : char4;
}
implemented by method
  zcl_sd_idocs_sdata_retrieval_t=>get_edid4_data