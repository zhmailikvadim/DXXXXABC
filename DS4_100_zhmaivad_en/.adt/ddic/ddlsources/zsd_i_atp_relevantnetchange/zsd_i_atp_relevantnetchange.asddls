/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 11.05.2023 | 20690     : Feature - ATP push from S/4  *
*              |            | DS4K950897                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 04.07.2023 | 22968     : Feature - ATP push from S/4  *
*              |            | DS4K957400                               *
* ---------------------------------------------------------------------*
* NAGARSOW     | 24.08.2023 | 22968     : Feature - ATP push from S/4  *
*              |            | DS4K957400                               *
* ---------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ATP Relevant Net Change'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity zsd_i_atp_relevantnetchange
  as select distinct from atpnetchgfilter         as AtpNetChange
    join                  atpncftstamp            as AtpNetChangeTimestamp    on AtpNetChange.netchguuid = AtpNetChangeTimestamp.netchguuid
    join                  zsd_i_atp_max_timestamp as MaxAtpNetChangeTimestamp on  AtpNetChange.matnr                 = MaxAtpNetChangeTimestamp.Material
                                                                              and AtpNetChange.werks                 = MaxAtpNetChangeTimestamp.Plant
                                                                              and AtpNetChange.berid                 = MaxAtpNetChangeTimestamp.MrpArea
                                                                              and AtpNetChange.netchgcategory        = MaxAtpNetChangeTimestamp.NetchgCategory
                                                                              and AtpNetChangeTimestamp.netchgtstamp = MaxAtpNetChangeTimestamp.NetChgMaxTimestamp
  association to atpncftstamp               as _AtpNetChangeTimestamp   on  $projection.Netchguuid = _AtpNetChangeTimestamp.netchguuid
  association to I_Plant                    as _Plant                   on  $projection.Plant = _Plant.Plant
  association to tvkwz                      as _AllowedSalesOrgPerPlant on  $projection.Plant = _AllowedSalesOrgPerPlant.werks
  association to I_Product                  as _Product                 on  $projection.Material = _Product.Product
  association to zsd_i_supplyprotect_active as _SupplyProtectionActive  on  $projection.Plant    = _SupplyProtectionActive.Plant
                                                                        and $projection.Material = _SupplyProtectionActive.Material
  association to zpe_t_runtime              as _Lastchange              on  _Lastchange.program_name = 'ZSD_R_DELTA_ATP'
                                                                        and $projection.Plant        = _Lastchange.additional_info1
                                                                        and $projection.Material     = _Lastchange.additional_info2
{
  key AtpNetChange.netchguuid                                                                                      as Netchguuid,

      AtpNetChange.matnr                                                                                           as Material,
      _Product.CrossPlantConfigurableProduct                                                                       as ParentID,
      AtpNetChange.werks                                                                                           as Plant,
      cast(case when $projection.NetChangeCategory = '03' then 'X' else 'F' end  as zsd_sup_flag preserving type ) as SupFlag,
      case when $projection.NetChangeCategory = '03' then '' else _AllowedSalesOrgPerPlant.vtweg   end             as DistributionChannel,
      _Product.BaseUnit                                                                                            as BaseUnit,
      _AtpNetChangeTimestamp.netchgtstamp                                                                          as AtpCallTimestamp,
      ''                                                                                                           as KafkaPublishingTimestamp,
      '99'                                                                                                         as SubCharacteristic,
      _Product.ProductStandardID                                                                                   as EanUpcCode,
      cast( '' as prreg )                                                                                          as CheckingRule,
      AtpNetChange.netchgcategory                                                                                  as NetChangeCategory,
      AtpNetChange.berid                                                                                           as MrpArea,
      _Plant.PlantCategory                                                                                         as PlantCategory,
      _Plant._Address._Country.Country                                                                             as CountryCode,
      _Plant._Address._Country._Text[1:Language = $session.system_language ].CountryName                           as CountryText,
      _SupplyProtectionActive.SupProtLifecycleStatus                                                               as SupplyProtectionIsActive,
      _Lastchange.timestamp                                                                                        as Lastchangetimestamp

}
