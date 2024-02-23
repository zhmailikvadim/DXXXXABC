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

@AbapCatalog.sqlViewAppendName: 'ZSDECUSTSLSAREA'
@EndUserText.label: 'Extension view for I_CUSTOMERSALESAREA'
extend view I_CustomerSalesArea with ZSD_E_CUSTOMERSALESAREA association [1..1] to knvv
on $projection.Customer = knvv.kunnr and
   $projection.SalesOrganization = knvv.vkorg and
   $projection.DistributionChannel = knvv.vtweg and
    $projection.Division = knvv.spart {
   
    knvv.fsh_sc_cid as  ZZ_fsh_sc_cid
}
