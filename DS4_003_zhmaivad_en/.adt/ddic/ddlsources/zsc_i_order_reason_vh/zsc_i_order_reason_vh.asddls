/*
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SRIKAVEN     | 16.08.2022 | 11662     : FB_11662_SC_[Development] STOs additional fields    *
*              |            | DS4K921038                               *
*----------------------------------------------------------------------*
*/

@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@Analytics.dataCategory: #DIMENSION
@EndUserText.label: 'Order Reason Value Help'
define view entity ZSC_I_ORDER_REASON_VH as select from ZPE_I_HM( iv_id: '0000000212' ) 

{
   @Search.defaultSearchElement: true
key  field2 as OrderReason,
     field3 as Description
} group by field2 , field3
