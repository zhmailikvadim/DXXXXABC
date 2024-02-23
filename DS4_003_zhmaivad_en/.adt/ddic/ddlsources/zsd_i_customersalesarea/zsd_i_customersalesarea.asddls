/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* GERTSVIK     | 25.04.2023 | 19854     : Feature - S4 to WMS Delivery *
*              |            | DS4K949348                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SD Document: Delivery Header Data'

define view entity ZSD_I_CUSTOMERSALESAREA
  as select from knvv
{
  key kunnr,
  key vkorg,
  key vtweg,
  key spart,
      fsh_msopid
}
