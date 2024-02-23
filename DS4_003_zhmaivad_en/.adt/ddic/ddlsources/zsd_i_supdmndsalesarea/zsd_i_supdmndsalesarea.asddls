/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SHNIPALI     | 13.12.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I_SupDmndSalesArea Custom View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #X,
     sizeCategory:   #XXL
   }
}
define view entity ZSD_I_SupDmndSalesArea
  as select from knvv as SalesArea
{
  key SalesArea.kunnr       as Customer,
  key SalesArea.vkorg       as SalesOrganization,
  key SalesArea.vtweg       as DistributionChannel,
  key SalesArea.spart       as OrganizationDivision,
      SalesArea.kdgrp       as CustomerGroup,
      SalesArea.bzirk       as SalesDistrict,
      ''                    as DeliveryIsBlockedForCustomer,
      cast ('' as faksd_x ) as BillingIsBlockedForCustomer,
      ''                    as SalesGroup,
      ''                    as SalesOffice,
      SalesArea.kvgr1       as AdditionalCustomerGroup1,
      ''                    as AdditionalCustomerGroup2,
      ''                    as AdditionalCustomerGroup3,
      ''                    as AdditionalCustomerGroup4,
      SalesArea.kvgr5       as AdditionalCustomerGroup5,
      SalesArea.fsh_kvgr6   as AdditionalCustomerGroup6,
      SalesArea.fsh_sc_cid  as CustSuppID
}
