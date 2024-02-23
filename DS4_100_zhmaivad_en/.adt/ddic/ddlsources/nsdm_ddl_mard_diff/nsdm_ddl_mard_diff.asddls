@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.sqlViewName:      'NSDM_V_MARD_DIFF'
@EndUserText.label:            'MARD Compatibility View: Differentiation'
@DataAging.noAgingRestriction: 'false'

@ObjectModel.usageType.sizeCategory: 'L'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ClientHandling.algorithm: #AUTOMATED
@AccessControl.authorizationCheck: #NOT_ALLOWED
@AbapCatalog.viewEnhancementCategory: #PROJECTION_LIST
define view nsdm_e_mard_diff as
select from nsdm_e_mard_agg 
{
key mandt, 
key matnr, 
key werks, 
key lgort,

max(gjper_max) as gjper,

sum(case lbbsa when '01' then case sobkz when '' then stock_qty else 0 end else 0 end) as labst,
sum(case lbbsa when '04' then case sobkz when '' then stock_qty else 0 end else 0 end) as umlme,
sum(case lbbsa when '02' then case sobkz when '' then stock_qty else 0 end else 0 end) as insme,
sum(case lbbsa when '08' then case sobkz when '' then stock_qty else 0 end else 0 end) as einme,       
sum(case lbbsa when '07' then case sobkz when '' then stock_qty else 0 end else 0 end) as speme,
sum(case lbbsa when '03' then case sobkz when '' then stock_qty else 0 end else 0 end) as retme,

cast(0 as abap.quan(13, 3)) as vmlab,
cast(0 as abap.quan(13, 3)) as vmuml, 
cast(0 as abap.quan(13, 3)) as vmins,
cast(0 as abap.quan(13, 3)) as vmein,
cast(0 as abap.quan(13, 3)) as vmspe,
cast(0 as abap.quan(13, 3)) as vmret,

sum(case lbbsa when '01' then case sobkz when 'K' then stock_qty else 0 end else 0 end) as klabs,           
sum(case lbbsa when '02' then case sobkz when 'K' then stock_qty else 0 end else 0 end) as kinsm,
sum(case lbbsa when '08' then case sobkz when 'K' then stock_qty else 0 end else 0 end) as keinm,
sum(case lbbsa when '07' then case sobkz when 'K' then stock_qty else 0 end else 0 end) as kspem,  

sum(case lbbsa when '01' then case sobkz when '' then stock_vkwrt else 0 end else 0 end) as vklab,
sum(case lbbsa when '04' then case sobkz when '' then stock_vkwrt else 0 end else 0 end) as vkuml,

sum(case lbbsa when '01' then case sobkz when '' then /cwm/stock_qty else 0 end else 0 end) as /cwm/labst,
sum(case lbbsa when '04' then case sobkz when '' then /cwm/stock_qty else 0 end else 0 end) as /cwm/umlme,
sum(case lbbsa when '02' then case sobkz when '' then /cwm/stock_qty else 0 end else 0 end) as /cwm/insme,
sum(case lbbsa when '08' then case sobkz when '' then /cwm/stock_qty else 0 end else 0 end) as /cwm/einme,       
sum(case lbbsa when '07' then case sobkz when '' then /cwm/stock_qty else 0 end else 0 end) as /cwm/speme,
sum(case lbbsa when '03' then case sobkz when '' then /cwm/stock_qty else 0 end else 0 end) as /cwm/retme,
cast(0 as abap.quan(13, 3)) as /cwm/vmlab,
cast(0 as abap.quan(13, 3)) as /cwm/vmuml, 
cast(0 as abap.quan(13, 3)) as /cwm/vmins,
cast(0 as abap.quan(13, 3)) as /cwm/vmein,
cast(0 as abap.quan(13, 3)) as /cwm/vmspe,
cast(0 as abap.quan(13, 3)) as /cwm/vmret,
sum(case lbbsa when '01' then case sobkz when 'K' then /cwm/stock_qty else 0 end else 0 end) as /cwm/klabs,           
sum(case lbbsa when '02' then case sobkz when 'K' then /cwm/stock_qty else 0 end else 0 end) as /cwm/kinsm,
sum(case lbbsa when '08' then case sobkz when 'K' then /cwm/stock_qty else 0 end else 0 end) as /cwm/keinm,
sum(case lbbsa when '07' then case sobkz when 'K' then /cwm/stock_qty else 0 end else 0 end) as /cwm/kspem,

'X' as mdrue 

}
group by mandt, matnr, werks, lgort     
