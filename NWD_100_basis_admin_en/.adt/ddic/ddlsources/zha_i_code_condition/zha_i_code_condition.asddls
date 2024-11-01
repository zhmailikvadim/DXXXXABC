@AbapCatalog.sqlViewName: 'ZHA_IQ_CNDTN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Code conditions value help'

define view ZHA_I_CODE_CONDITION
  as select from zha_d_code_cond
{
 key  code_condition,
      code_name
}
