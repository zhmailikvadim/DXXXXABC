@AbapCatalog.sqlViewName: 'ZHA_IQ_FRM_NM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Farm name value help'
define view ZHA_I_FARM_NAME
  as select distinct from ZHA_I_FARMS
  association [1..1] to ZHA_I_ARG_PARK_NAME as _agrDate on $projection.farm_id = _agrDate.farm_id
{
  key   _agrDate.model,
        @UI.hidden: true
        farm_id,
        farm_name,
        farm_country,
        farm_region,
        @UI.hidden: true
        kunnr,
        @UI.hidden: true
        bland

}
where
  _agrDate.model > ''
