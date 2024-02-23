/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* RAZMYEGO     | 29.12.2022 | 16546     : [Feature] [BUILD] - FPS-WRIC *
*              |            | DS4K939046                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Fields for calculat.Cust.Trans.Lead time'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #XL,
    dataClass: #MIXED
}
define view entity ZPD_I_IBP_TRANS_DURATION
  as select from ZPD_I_IBP_CUSTPROD             as custprod
    inner join   /ibp/loc_ext                   as loc          on custprod.KUNNR = loc.locno
    inner join   ZPE_I_HM( iv_id: '0000000556') as LocationType on  LocationType.field1   = loc.loctype
                                                                and LocationType.sequence = '003'
    inner join   trolz                                          on loc.zztzone_tc = trolz.lzone
    inner join   tvro                                           on trolz.route = tvro.route

{
  custprod.KUNNR      as KUNNR,
  custprod.MATNR      as MATNR,
  custprod.VTWEG      as VTWEG,
  loc.zzkeyaacount_tc as ZZKEYAACOUNT_TC,
  tvro.traztd         as TRAZTD,

  tvro.route,
  trolz.lzone,
  loc.locno,
  loc.loctype,
  loc.zztzone_tc 

}

