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
@EndUserText.label: 'Stock Reconciliation Summary amounts'

define view entity zsd_i_stock_recon_summ_amt
  as select from zsd_i_stock_recon_summ_amt_raw
  association to I_ValuationArea as _valuationarea on _valuationarea.ValuationArea = $projection.plant
{

  key date0          as wmssnapshotdate,
  key _valuationarea.CompanyCode,
  key s4plant        as plant,
  key unit           as materialbaseunit,

      @Semantics.quantity.unitOfMeasure: 'materialbaseunit'
      sum(rlmmsales) as possales,
      @Semantics.quantity.unitOfMeasure: 'materialbaseunit'
      sum(rlmmrtrn)  as posreturn,
      @Semantics.quantity.unitOfMeasure: 'materialbaseunit'
      sum(rlmmgi)    as posgi,
      @Semantics.quantity.unitOfMeasure: 'materialbaseunit'
      sum(rlmmgr)    as posgr
}
group by
  date0,
  _valuationarea.CompanyCode,
  s4plant,
  unit
