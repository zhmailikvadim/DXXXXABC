/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BOBRULA      | 10.03.2023 | 18926: IC Mark-up costs maintenance App  *
*              |            |        - Select All workaround           *
*              |            | DS4K946491                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*/
@EndUserText.label: 'Abstract entity for filters values'
define abstract entity zsd_d_stock_recon_fe_filter
{
  filters: string_data;
}
