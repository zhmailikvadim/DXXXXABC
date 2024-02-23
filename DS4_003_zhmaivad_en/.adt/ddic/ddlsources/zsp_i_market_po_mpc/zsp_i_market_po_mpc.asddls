/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* LINGARAG     | 04.10.2023 | 25590  :[BUILD] TradeCo 1.5 PO  <-> Mar  *
*              |            | DS4K965604                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Market PO details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@VDM.viewType: #COMPOSITE
define view entity ZSP_I_Market_PO_MPC
  as select from    ZSP_I_Market_PO_MPC_Rep          as Mpc
    left outer join ZPE_I_HM( iv_id : '0000002459' ) as NoError    on NoError.id = '0000002459'
    left outer join ZPE_I_HM( iv_id : '0000002477' ) as DataIncons on DataIncons.id = '0000002477'
{
  key   Mpc.PurchaseOrder,
  key   Mpc.PurchaseOrderItem,
  key   Mpc.MpoPurchaseOrder,
  key   Mpc.MpoPurchaseOrderItem,
  key   Mpc.TpoPurchaseOrder,
  key   Mpc.TpoPurchaseOrderItem,
  key   Mpc.TsoSalesDocument,
  key   Mpc.TsoSalesDocumentItem,
        Mpc.PurchaseOrderType,
        Mpc.PurchasingOrganization,
        Mpc.PurchasingGroup,
        Mpc.Plant,
        Mpc.Status,
        case when Mpc.Status = NoError.field1 then 3
        else case when Mpc.Status = DataIncons.field1 then 2
        else  1 end end                                          as CriticalityStatus,
        @ObjectModel.virtualElement: true
        @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SP_MARKET_PO_VIRTUAL_CALC'
        cast( '' as /accgo/e_val_sched_charc )                   as Message1,
        @ObjectModel.virtualElement: true
        @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SP_MARKET_PO_VIRTUAL_CALC'
        cast( '' as /accgo/e_val_sched_charc )                   as Message2,
        Mpc.SelPurchaseOrderType,
        Mpc.SelPurchasingOrganization,
        Mpc.SelCompanyCode,
        Mpc.SelPurchaseOrderDate,
        Mpc.SelMaterial,
        Mpc.SelPlant,
        Mpc.SelPurchaseOrder,
        Mpc.SelZZ1_MM_Exfactorydt_PDI,
        Mpc.SelPurDocumentDeletionCode,
        Mpc.SelIsCompletelyDelivered,
        Mpc.SelSupplier,
        Mpc.TpoPurchasingOrganization,
        Mpc.TpoCompanyCode,
        Mpc.TpoZZ1_MM_TradeCoMODEL_PDH,
        Mpc.TpoSupplier,
        Mpc.TpoEkpaSupplier,
        Mpc.TpoPlant,
        Mpc.TpoSupconf_PDI,
        Mpc.TpoHTS_Eligibility_PDI,
        Mpc.TpoHTS_SCOPE_PDI,
        Mpc.TpoHTS_Curr_PDI,
        Mpc.TpoPurchDocumentDeletionCode,
        Mpc.TpoIsCompletelyDelivered,
        Mpc.TpoOrderQuantityUnit,
        @Semantics.quantity.unitOfMeasure: 'TpoOrderQuantityUnit'
        Mpc.TpoOrderQuantity,
        Mpc.TpoMM_Exfactorydt_pdi,
        Mpc.TpoCustin_pdi,
        Mpc.TpoCustom_stat_pdi,
        Mpc.TpoShippingInstruction,
        Mpc.TpoAdi_m_planned_pdi,
        Mpc.TpoAdi_m_promoflag_pdi,
        Mpc.TpoFprod_da_pdi,
        Mpc.TpoInit_plan_da_pdi,
        Mpc.TpoLprod_da_pdi,
        Mpc.TpoOrdprio_pdi,
        Mpc.TpoPrior_ind_pdi,
        Mpc.TpoScheduleLineDeliveryDate,
        Mpc.MpoPurchaseOrderType,
        Mpc.MpoPurchasingOrganization,
        Mpc.MpoCompanyCode,
        Mpc.MpoSupplier,
        Mpc.MpoPurchaseOrderDate,
        Mpc.MpoZZ1_MM_Tradecomodel_PDH,
        Mpc.MpoMaterial,
        Mpc.MpoPlant,
        Mpc.MpoSupconf_PDI,
        Mpc.MpoHTS_Eligibility_PDI,
        Mpc.MpoHTS_SCOPE_PDI,
        Mpc.MpoHTS_Curr_PDI,
        Mpc.MpoIsCompletelyDelivered,
        Mpc.MpoOrderQuantityUnit,
        @Semantics.quantity.unitOfMeasure: 'MpoOrderQuantityUnit'
        Mpc.MpoOrderQuantity,
        Mpc.MpoPurchDocumentDeletionCode,
        Mpc.MpoShippingInstruction,
        Mpc.MpoMM_Exfactorydt_pdi,
        Mpc.MpoCustin_pdi,
        Mpc.MpoCustom_stat_pdi,
        Mpc.MpoAdi_m_planned_pdi,
        Mpc.MpoAdi_m_promoflag_pdi,
        Mpc.MpoFprod_da_pdi,
        Mpc.MpoInit_plan_da_pdi,
        Mpc.MpoLprod_da_pdi,
        Mpc.MpoOrdprio_pdi,
        Mpc.MpoPrior_ind_pdi,
        Mpc.MpoScheduleLineDeliveryDate,
        Mpc.MpoEkpaSupplier,
        Mpc.TsoSalesOrganization,
        Mpc.TsoSoldToParty,
        Mpc.TsoBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'TsoBaseUnit'
        Mpc.TsoOrderQuantity,
        Mpc.TsoSalesDocumentRjcnReason,
        Mpc.P_check_vnd,
        case when Mpc.P_check_vnd = 'X' then '1' else '' end     as Criticality_check_vnd,
        Mpc.P_check_tcm,
        case when Mpc.P_check_tcm = 'X' then '1' else '' end     as Criticality_check_tcm,
        Mpc.P_check_qnt,
        case when Mpc.P_check_qnt = 'X' then '1' else '' end     as Criticality_check_qnt,
        Mpc.P_check_del,
        case when Mpc.P_check_del = 'X' then '1' else '' end     as Criticality_check_del,
        Mpc.P_Check_custsta,
        case when Mpc.P_Check_custsta = 'X' then '1' else '' end as Criticality_Check_custsta,
        Mpc.P_Check_custind,
        case when Mpc.P_Check_custind = 'X' then '1' else '' end as Criticality_Check_custind,
        Mpc.P_Check_dci,
        case when Mpc.P_Check_dci = 'X' then '1' else '' end     as Criticality_Check_dci,
        Mpc.P_Check_shi,
        case when Mpc.P_Check_shi = 'X' then '1' else '' end     as Criticality_Check_shi,
        Mpc.P_Check_pd,
        case when Mpc.P_Check_pd = 'X' then '1' else '' end      as Criticality_Check_pd,
        Mpc.P_Check_ppf,
        case when Mpc.P_Check_ppf = 'X' then '1' else '' end     as Criticality_Check_ppf,
        Mpc.P_Check_fpd,
        case when Mpc.P_Check_fpd = 'X' then '1' else '' end     as Criticality_Check_fpd,
        Mpc.P_Check_ck,
        case when Mpc.P_Check_ck = 'X' then '1' else '' end      as Criticality_Check_ck,
        Mpc.P_check_ii,
        case when Mpc.P_check_ii = 'X' then '1' else '' end      as Criticality_check_ii,
        Mpc.P_Check_ipd,
        case when Mpc.P_Check_ipd = 'X' then '1' else '' end     as Criticality_Check_ipd,
        Mpc.P_Check_lpd,
        case when Mpc.P_Check_lpd = 'X' then '1' else '' end     as Criticality_Check_lpd,
        Mpc.P_Check_opi,
        case when Mpc.P_Check_opi = 'X' then '1' else '' end     as Criticality_Check_opi,
        Mpc.P_Check_ipi,
        case when Mpc.P_Check_ipi = 'X' then '1' else '' end     as Criticality_Check_ipi,
        Mpc.P_Check_scs,
        case when Mpc.P_Check_scs = 'X' then '1' else '' end     as Criticality_Check_scs

}
