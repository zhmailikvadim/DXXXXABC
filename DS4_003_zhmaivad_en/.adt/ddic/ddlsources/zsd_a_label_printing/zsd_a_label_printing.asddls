/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHADDFAD     | 19.09.2023 | 24801: {Label Printing}  Carton scanning *
*              |            | DS4K962480                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Label Printing API'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZSD_A_LABEL_PRINTING
  as projection on ZSD_I_LABEL_PRINTING

{
  key HandlingUnit,
  key Plant,
      InternalID,
      ItemCount,
      _Item : redirected to ZSD_C_LABEL_PRINTING_MATERIAL
}
