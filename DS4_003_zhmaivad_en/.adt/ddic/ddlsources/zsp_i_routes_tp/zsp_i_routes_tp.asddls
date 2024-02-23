/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KALSHZHA     | 04.11.2022 | 14919     : STO carry DN GI date to IBD  *
*              |            | DS4K934415                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom entity for TVRO table'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #MASTER
define view entity ZSP_I_ROUTES_TP as select from tvro {
    key route,
    trazt,
    traztd,
    tdvzt,
    tdvztd,
    tdvznd,
    spfbk,
    expvz,
    tdiix,
    spzst,
    fahztd,
    distz,
    medst,
    vsart,
    vsavl,
    vsanl,
    tdlnr,
    routid,
    tctab,
    allowed_twgt,
    allowed_uom
}
