@AbapCatalog.sqlViewName: 'zzz5102'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zzzz'

@OData.publish: true
define view zzz as select from hrp5102
{

  key plvar,
    aedtm
}