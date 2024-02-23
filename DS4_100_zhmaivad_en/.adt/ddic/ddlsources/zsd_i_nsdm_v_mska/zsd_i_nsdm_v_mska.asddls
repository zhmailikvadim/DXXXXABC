/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 29.09.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewName: 'ZSDINSDMVMSKA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Mska Stock'
define view zsd_i_nsdm_v_mska
  as select from nsdm_v_mska
    join         I_Product as _Product           on nsdm_v_mska.matnr = _Product.Product
    join         ZPE_I_HM( iv_id: '0000002423' ) on nsdm_v_mska.sobkz = ZPE_I_HM.field1
{
  key nsdm_v_mska.matnr,
  key nsdm_v_mska.werks,
  key nsdm_v_mska.lgort,
      nsdm_v_mska.vbeln,
      nsdm_v_mska.posnr,
      @Semantics.quantity.unitOfMeasure : 'BaseUnit'
      nsdm_v_mska.kalab,
      @Semantics.quantity.unitOfMeasure : 'BaseUnit'
      nsdm_v_mska.kains,
      @Semantics.quantity.unitOfMeasure : 'BaseUnit'
      nsdm_v_mska.kaspe,
      _Product.BaseUnit
}
