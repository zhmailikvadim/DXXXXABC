/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SHNIPALI     | 02.02.2023 | FB_17550_SD_Feature - Supply Demand Overview  (SDO) E*
*              |            | DS4K942335                               *
* ZAICHART     | 30.06.2022 | FB_21361_SD_Build - Supply and Demand Overview - Consolidation*
*              |            | DS4K952788                               *
*----------------------------------------------------------------------*/
extend view entity ZSD_I_SupDmndAllDocDemand with
//SD
{
  SD.AdditionalCustomerGroup8,
  SD.AdditionalCustomerGroup9,
  SD.AdditionalCustomerGroup10,
  SD.ShippingPoint,
  SD.SportCategory,
  SD.DeliveryStatus         as TotalGdsMvtStat,
  SD.ItemBillingBlockReason as BillingBlockItem
}
//STO
union all
{ 
  STO.AdditionalCustomerGroup8,
  STO.AdditionalCustomerGroup9,
  STO.AdditionalCustomerGroup10,
  STO.ShippingPoint,
  STO.SportCategory,
  cast('' as lfsta) as TotalGdsMvtStat,
  cast('' as faksp) as BillingBlockItem
}
union all
{ 
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
union all
{
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
union all
{
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
union all
{
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
union all
{
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
union all
{
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
union all
{
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
union all
{
  cast('' as fsh_kvgr8) as AdditionalCustomerGroup8,
  cast('' as fsh_kvgr9) as AdditionalCustomerGroup9,
  cast('' as fsh_kvgr10) as AdditionalCustomerGroup10,
  cast('' as vstel)      as ShippingPoint,
  cast('' as zpd_zzmsc)  as SportCategory,
  cast('' as lfsta)      as TotalGdsMvtStat,
  cast('' as faksp)      as BillingBlockItem
}
