/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.11.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Additional Customer Group 6'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
define view entity zsd_i_additional_customer_grp6
  as select from fsh_tvv6
  association [0..*] to zsd_i_additional_customer_gr6t as _Text on  $projection.SalesOrganization        = _Text.SalesOrganization
                                                                and $projection.AdditionalCustomerGroup6 = _Text.AdditionalCustomerGroup6

{
  key vkorg as SalesOrganization,
  key kvgr6 as AdditionalCustomerGroup6,
      _Text
}
