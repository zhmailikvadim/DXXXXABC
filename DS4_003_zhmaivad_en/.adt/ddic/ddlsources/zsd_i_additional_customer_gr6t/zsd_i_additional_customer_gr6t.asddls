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
@EndUserText.label: 'Additional Customer Group 6 Text'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
define view entity zsd_i_additional_customer_gr6t
  as select from fsh_tvv6t
  association [0..1] to zsd_i_additional_customer_grp6 as _AdditionalCustomerGroup6 on $projection.SalesOrganization        = _AdditionalCustomerGroup6.SalesOrganization and
                                                                                       $projection.AdditionalCustomerGroup6 = _AdditionalCustomerGroup6.AdditionalCustomerGroup6
  association [0..1] to I_Language                     as _Language                 on $projection.Language = _Language.Language
{

  key vkorg as SalesOrganization,
  key kvgr6 as AdditionalCustomerGroup6,
      @Semantics.language:true
      @ObjectModel.foreignKey.association: '_Language'
  key spras as Language,
      @Semantics.text:true
      bezei as AdditionalCustomerGroup6Name,

      _AdditionalCustomerGroup6,
      _Language
};
