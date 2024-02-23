/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* PISHCALI     | 13.09.2022 | 13391: FI_BE BUILD - Limit Custom Report *
*              |            | DS4K929386                               *
*----------------------------------------------------------------------*/

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface to get BKK45'
define view entity ZFI_I_LIM_REP_BKK45
  as select from bkk45 as _BKK45
  association [0..1] to I_BusinessPartner as _BusinessPartner on $projection.partner = _BusinessPartner.BusinessPartner

{
  key _BKK45.bkkrs,
  key _BKK45.partner,
  key _BKK45.rltyp,

      _BusinessPartner
}

where
  _BKK45.rltyp = 'BKK010' //Account Holder

group by
  _BKK45.bkkrs,
  _BKK45.partner,
  _BKK45.rltyp
