@AbapCatalog.sqlViewName: 'ZHA_IQ_AR_PRK_NM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Agr park''s value help'

define view ZHA_I_ARG_PARK_NAME
  as select from zha_i_agr_park
  association [1..1] to ZHA_I_FARMS as _farmData on $projection.farm_id = _farmData.farm_id 
{
    key model,
    @UI.hidden: true
    farm_id,
    _farmData.farm_name,
    batch,
    _farmData.farm_country,
    _farmData.farm_region
 }
  where model > '' and batch > ''
