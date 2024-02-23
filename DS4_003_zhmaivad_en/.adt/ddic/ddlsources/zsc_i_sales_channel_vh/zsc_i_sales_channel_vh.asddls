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
@ObjectModel.dataCategory: #TEXT
@EndUserText.label: 'Sales Channel Value Help'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZSC_I_SALES_CHANNEL_VH as select from tvtwt 
{
   @Search.defaultSearchElement: true
 key vtweg as SalesChannel,
 vtext as Description 
}where spras = $session.system_language
