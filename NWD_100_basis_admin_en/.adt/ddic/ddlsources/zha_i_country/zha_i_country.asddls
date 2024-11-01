@AbapCatalog.sqlViewName: 'ZHA_I_Q_CNTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Country value help'
define view ZHA_I_COUNTRY
  as select from t005t
{
  key land1,
      landx
}
where
  spras = 'R'
