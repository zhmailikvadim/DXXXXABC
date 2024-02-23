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
@EndUserText.label: 'Market PO consistency check'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@VDM.viewType: #COMPOSITE
define view entity ZSP_I_Market_PO_MPC_Rep
  as select from    ZSP_I_Market_PO_MPC_Con_Check    as Mpc
    left outer join ZPE_I_HM( iv_id : '0000002459' ) as NoError         on NoError.id = '0000002459'
    left outer join ZPE_I_HM( iv_id : '0000002477' ) as DataIncons      on DataIncons.id = '0000002477'
    left outer join ZPE_I_HM( iv_id : '0000002478' ) as DataFlowIncmplt on DataFlowIncmplt.id = '0000002478'
{
  key    Mpc.PurchaseOrder                     as PurchaseOrder,
  key    Mpc.PurchaseOrderItem                 as PurchaseOrderItem,
  key    Mpc.MpoPurchaseOrder                  as MpoPurchaseOrder,
  key    Mpc.MpoPurchaseOrderItem              as MpoPurchaseOrderItem,
  key    Mpc.TpoPurchaseOrder                  as TpoPurchaseOrder,
  key    Mpc.TpoPurchaseOrderItem              as TpoPurchaseOrderItem,
  key    Mpc.TsoSalesDocument                  as TsoSalesDocument,
  key    Mpc.TsoSalesDocumentItem              as TsoSalesDocumentItem,
         Mpc.PurchaseOrderType                 as PurchaseOrderType,
         Mpc.PurchasingOrganization            as PurchasingOrganization,
         Mpc.PurchasingGroup                   as PurchasingGroup,
         Mpc.plant                             as Plant,
         case when
           Mpc.MpoPurchaseOrder <> '0000000000' and Mpc.MpoPurchaseOrderItem <> '00000' and
           Mpc.TsoSalesDocument <> '0000000000' and Mpc.TsoSalesDocumentItem <> '000000' and
           Mpc.TpoPurchaseOrder <> '0000000000' and Mpc.TpoPurchaseOrderItem <> '00000'
           then case when
           Mpc.P_check_vnd     is initial and Mpc.P_check_tcm     is initial and
           Mpc.P_check_qnt     is initial and Mpc.P_check_del     is initial and
           Mpc.P_Check_custsta is initial and Mpc.P_Check_custind is initial and
           Mpc.P_Check_dci     is initial and Mpc.P_Check_shi     is initial and
           Mpc.P_Check_pd      is initial and Mpc.P_Check_ppf     is initial and
           Mpc.P_Check_fpd     is initial and Mpc.P_Check_ck      is initial and
           Mpc.P_check_ii      is initial and Mpc.P_Check_ipd     is initial and
           Mpc.P_Check_lpd     is initial and Mpc.P_Check_opi     is initial and
           Mpc.P_Check_ipi     is initial and Mpc.P_Check_scs     is initial
           then NoError.field1
           else DataIncons.field1
           end else DataFlowIncmplt.field1 end as Status,
         Mpc.SelPurchaseOrderType              as SelPurchaseOrderType,
         Mpc.SelPurchasingOrganization         as SelPurchasingOrganization,
         Mpc.SelCompanyCode                    as SelCompanyCode,
         Mpc.SelPurchaseOrderDate              as SelPurchaseOrderDate,
         Mpc.SelMaterial                       as SelMaterial,
         Mpc.SelPlant                          as SelPlant,
         Mpc.SelPurchaseOrder                  as SelPurchaseOrder,
         Mpc.SelZZ1_MM_Exfactorydt_PDI         as SelZZ1_MM_Exfactorydt_PDI,
         Mpc.SelPurDocumentDeletionCode        as SelPurDocumentDeletionCode,
         Mpc.SelIsCompletelyDelivered          as SelIsCompletelyDelivered,
         Mpc.SelSupplier                       as SelSupplier,
         Mpc.TpoPurchasingOrganization         as TpoPurchasingOrganization,
         Mpc.TpoCompanyCode                    as TpoCompanyCode,
         Mpc.TpoZZ1_MM_TradeCoMODEL_PDH        as TpoZZ1_MM_TradeCoMODEL_PDH,
         Mpc.TpoSupplier                       as TpoSupplier,
         Mpc.TpoEkpaSupplier                   as TpoEkpaSupplier,
         Mpc.TpoPlant                          as TpoPlant,
         Mpc.TpoSupconf_PDI                    as TpoSupconf_PDI,
         Mpc.TpoHTS_Eligibility_PDI            as TpoHTS_Eligibility_PDI,
         Mpc.TpoHTS_SCOPE_PDI                  as TpoHTS_SCOPE_PDI,
         Mpc.TpoHTS_Curr_PDI                   as TpoHTS_Curr_PDI,
         Mpc.TpoPurchDocumentDeletionCode      as TpoPurchDocumentDeletionCode,
         Mpc.TpoIsCompletelyDelivered          as TpoIsCompletelyDelivered,
         Mpc.TpoOrderQuantityUnit              as TpoOrderQuantityUnit,
         @Semantics.quantity.unitOfMeasure: 'TpoOrderQuantityUnit'
         Mpc.TpoOrderQuantity                  as TpoOrderQuantity,
         Mpc.TpoMM_Exfactorydt_pdi             as TpoMM_Exfactorydt_pdi,
         Mpc.TpoCustin_pdi                     as TpoCustin_pdi,
         Mpc.TpoCustom_stat_pdi                as TpoCustom_stat_pdi,
         Mpc.TpoShippingInstruction            as TpoShippingInstruction,
         Mpc.TpoAdi_m_planned_pdi              as TpoAdi_m_planned_pdi,
         Mpc.TpoAdi_m_promoflag_pdi            as TpoAdi_m_promoflag_pdi,
         Mpc.TpoFprod_da_pdi                   as TpoFprod_da_pdi,
         Mpc.TpoInit_plan_da_pdi               as TpoInit_plan_da_pdi,
         Mpc.TpoLprod_da_pdi                   as TpoLprod_da_pdi,
         Mpc.TpoOrdprio_pdi                    as TpoOrdprio_pdi,
         Mpc.TpoPrior_ind_pdi                  as TpoPrior_ind_pdi,
         Mpc.TpoScheduleLineDeliveryDate       as TpoScheduleLineDeliveryDate,
         Mpc.MpoPurchaseOrderType              as MpoPurchaseOrderType,
         Mpc.MpoPurchasingOrganization         as MpoPurchasingOrganization,
         Mpc.MpoCompanyCode                    as MpoCompanyCode,
         Mpc.MpoSupplier                       as MpoSupplier,
         Mpc.MpoPurchaseOrderDate              as MpoPurchaseOrderDate,
         Mpc.MpoZZ1_MM_Tradecomodel_PDH        as MpoZZ1_MM_Tradecomodel_PDH,
         Mpc.MpoMaterial                       as MpoMaterial,
         Mpc.MpoPlant                          as MpoPlant,
         Mpc.MpoSupconf_PDI                    as MpoSupconf_PDI,
         Mpc.MpoHTS_Eligibility_PDI            as MpoHTS_Eligibility_PDI,
         Mpc.MpoHTS_SCOPE_PDI                  as MpoHTS_SCOPE_PDI,
         Mpc.MpoHTS_Curr_PDI                   as MpoHTS_Curr_PDI,
         Mpc.MpoIsCompletelyDelivered          as MpoIsCompletelyDelivered,
         Mpc.MpoOrderQuantityUnit              as MpoOrderQuantityUnit,
         @Semantics.quantity.unitOfMeasure: 'MpoOrderQuantityUnit'
         Mpc.MpoOrderQuantity                  as MpoOrderQuantity,
         Mpc.MpoPurchDocumentDeletionCode      as MpoPurchDocumentDeletionCode,
         Mpc.MpoShippingInstruction            as MpoShippingInstruction,
         Mpc.MpoMM_Exfactorydt_pdi             as MpoMM_Exfactorydt_pdi,
         Mpc.MpoCustin_pdi                     as MpoCustin_pdi,
         Mpc.MpoCustom_stat_pdi                as MpoCustom_stat_pdi,
         Mpc.MpoAdi_m_planned_pdi              as MpoAdi_m_planned_pdi,
         Mpc.MpoAdi_m_promoflag_pdi            as MpoAdi_m_promoflag_pdi,
         Mpc.MpoFprod_da_pdi                   as MpoFprod_da_pdi,
         Mpc.MpoInit_plan_da_pdi               as MpoInit_plan_da_pdi,
         Mpc.MpoLprod_da_pdi                   as MpoLprod_da_pdi,
         Mpc.MpoOrdprio_pdi                    as MpoOrdprio_pdi,
         Mpc.MpoPrior_ind_pdi                  as MpoPrior_ind_pdi,
         Mpc.MpoScheduleLineDeliveryDate       as MpoScheduleLineDeliveryDate,
         Mpc.MpoEkpaSupplier                   as MpoEkpaSupplier,
         Mpc.TsoSalesOrganization              as TsoSalesOrganization,
         Mpc.TsoSoldToParty                    as TsoSoldToParty,
         Mpc.TsoBaseUnit                       as TsoBaseUnit,
         @Semantics.quantity.unitOfMeasure: 'TsoBaseUnit'
         Mpc.TsoOrderQuantity                  as TsoOrderQuantity,
         Mpc.TsoSalesDocumentRjcnReason        as TsoSalesDocumentRjcnReason,
         Mpc.P_check_vnd                       as P_check_vnd,
         Mpc.P_check_tcm                       as P_check_tcm,
         Mpc.P_check_qnt                       as P_check_qnt,
         Mpc.P_check_del                       as P_check_del,
         Mpc.P_Check_custsta                   as P_Check_custsta,
         Mpc.P_Check_custind                   as P_Check_custind,
         Mpc.P_Check_dci                       as P_Check_dci,
         Mpc.P_Check_shi                       as P_Check_shi,
         Mpc.P_Check_pd                        as P_Check_pd,
         Mpc.P_Check_ppf                       as P_Check_ppf,
         Mpc.P_Check_fpd                       as P_Check_fpd,
         Mpc.P_Check_ck                        as P_Check_ck,
         Mpc.P_check_ii                        as P_check_ii,
         Mpc.P_Check_ipd                       as P_Check_ipd,
         Mpc.P_Check_lpd                       as P_Check_lpd,
         Mpc.P_Check_opi                       as P_Check_opi,
         Mpc.P_Check_ipi                       as P_Check_ipi,
         Mpc.P_Check_scs                       as P_Check_scs
}
