@AbapCatalog.sqlViewName: 'ZHA_I_Q_RGN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Region value help'
define view ZHA_I_REGION
  as select distinct from t005u
  association [1..1] to t005t on $projection.land1 = t005t.land1
{

  key     bezei,
          bland,
          land1,
          t005t.landx,
          t005t.spras
}
where
  t005t.spras = 'R'
