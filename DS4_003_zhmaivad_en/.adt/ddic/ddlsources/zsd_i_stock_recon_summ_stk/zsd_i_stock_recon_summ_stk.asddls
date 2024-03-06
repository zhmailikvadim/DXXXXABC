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
@EndUserText.label: 'Stock Reconciliation Summary stock'

define view entity zsd_i_stock_recon_summ_stk
  as select from zsd_i_stock_recon_summ_stk_raw
  association to I_ValuationArea as _valuationarea on _valuationarea.ValuationArea = $projection.plant
{
  key date0          as wmssnapshotdate,
  key _valuationarea.CompanyCode,
  key s4plant        as plant,
  key stor_loc       as storagelocation,
  key unit           as materialbaseunit,

      @Semantics.quantity.unitOfMeasure: 'materialbaseunit'
      sum(rlmmuust)  as rfidstock,
      @Semantics.quantity.unitOfMeasure: 'materialbaseunit'
      sum(rlmmsuust) as sapstock
}
group by
  date0,
  _valuationarea.CompanyCode,
  s4plant,
  stor_loc,
  unit
