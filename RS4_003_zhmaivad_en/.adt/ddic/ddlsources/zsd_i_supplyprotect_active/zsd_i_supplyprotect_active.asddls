/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 04.07.2023 | 22968     : Feature - ATP push from S/4  *
*              |            | DS4K957400                               *
* ---------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Active Supply Protections'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_supplyprotect_active
  as select distinct from I_SupplyProtectionTP
{
  key    Material,
  key    Plant,
         SupProtLifecycleStatus
}
where
  SupProtLifecycleStatus = '02'
