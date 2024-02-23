/*
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NIABOALI     | 28.08.2023 | 23771 : Intercompany Billing - Forms and *
*              |            | Layout TradeCo                           *
*              |            | DS4K959473                               *
*----------------------------------------------------------------------*/

@AbapCatalog.sqlViewAppendName: 'ZPDEPRODUCT'
@EndUserText.label: 'Extension view for I_Product'
extend view I_Product with ZPD_E_PRODUCT association [1..1] to mara
on $projection.Product = mara.matnr {
    mara.fsh_sc_mid as zz_fsh_sc_mid,
    mara.fsh_mg_at1 as zz_fsh_mg_at1
}
