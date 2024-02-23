/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewName: 'ZSDINSDMVMARD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Mard Stock'
define view zsd_i_nsdm_v_mard
  as select from nsdm_v_mard
    inner join   I_Product as _Product on nsdm_v_mard.matnr = _Product.Product
{
  key nsdm_v_mard.matnr,
  key nsdm_v_mard.werks,
  key nsdm_v_mard.lgort,
      nsdm_v_mard.pstat,
      nsdm_v_mard.lvorm,
      nsdm_v_mard.lfgja,
      nsdm_v_mard.lfmon,
      nsdm_v_mard.sperr,
      @Semantics.quantity.unitOfMeasure : 'BaseUnit'
      nsdm_v_mard.insme,
      @Semantics.quantity.unitOfMeasure : 'BaseUnit'
      nsdm_v_mard.speme,
      _Product.BaseUnit,
      @Semantics.quantity.unitOfMeasure : 'BaseUnit'
      nsdm_v_mard.labst
}
