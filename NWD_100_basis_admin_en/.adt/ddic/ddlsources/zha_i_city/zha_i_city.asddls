@AbapCatalog.sqlViewName: 'ZHA_I_Q_CT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Citys value help'
define view ZHA_I_CITY as select distinct from zha_d_partners {
   key ort01,
       landx   
} where ort01 > ''
