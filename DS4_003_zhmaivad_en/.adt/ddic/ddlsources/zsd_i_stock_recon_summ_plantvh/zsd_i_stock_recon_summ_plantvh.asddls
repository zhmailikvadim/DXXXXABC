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
@ObjectModel.dataCategory: #VALUE_HELP
@Search.searchable: true
@EndUserText.label: 'Stock Reconciliation Summary plant VH'

define view entity zsd_i_stock_recon_summ_plantvh
  as select from I_Plant
  association to I_ValuationArea as _valuationarea on _valuationarea.ValuationArea = $projection.Plant
{
  key Plant,
      PlantName,
      @UI.hidden: true
      _valuationarea.CompanyCode,

      _valuationarea._CompanyCode
}
where
  PlantCategory = 'A'
