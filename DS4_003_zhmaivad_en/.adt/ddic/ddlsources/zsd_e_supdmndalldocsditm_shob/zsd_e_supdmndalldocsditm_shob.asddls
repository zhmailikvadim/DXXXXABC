/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BALUNYAN     | 02.02.2023 | FB_17550_SD_Feature - Supply Demand Overview  (SDO) E*
*              |            | DS4K942335                               *
* ZAICHART     | 30.06.2022 | FB_21361_SD_Build - Supply and Demand Overview - Consolidation*
*              |            | DS4K952788                               *
* ZUJSKAS      | 18.01.2024 | FB_27995_SD_Feature - SDO - Stabilization US                  *
*              |            | DS4K975972                                                    *
*----------------------------------------------------------------------*/
extend view entity ZSD_I_SupDmndAllDocSDItm with

{
  Item.DeliveryStatus,
  Item.ShippingPoint,
  Item.ItemBillingBlockReason,
  MatPlant.SportCategory,
  Item.AdditionalCustomerGroup8,
  Item.AdditionalCustomerGroup9,
  Item.AdditionalCustomerGroup10
}
group by
  Item.DeliveryStatus,
  Item.ShippingPoint,
  Item.ItemBillingBlockReason,
  MatPlant.SportCategory,
  Item.AdditionalCustomerGroup8,
  Item.AdditionalCustomerGroup9,
  Item.AdditionalCustomerGroup10
