/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewName: 'ZMATDOCUMENTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Documents Basis'
define view zsd_i_material_documents
  as select from nsdm_v_mseg
{
  key mblnr as Mblnr,
  key mjahr as Mjahr,
  key zeile as Zeile,
      insmk as Insmk,
      menge as Menge,
      meins as Meins,
      bwart as MoveType,
      shkzg as DebitCreditIndicator
}
