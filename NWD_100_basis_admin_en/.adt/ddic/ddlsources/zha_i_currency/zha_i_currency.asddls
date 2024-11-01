@AbapCatalog.sqlViewName: 'ZHA_I_Q_CRR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'Currence value help'
@Search.searchable: true
define view ZHA_I_CURRENCY
  as select from zha_d_currency
{
  @Search.defaultSearchElement: true
  @EndUserText.label: 'Валюта'
  key currency
}
