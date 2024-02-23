@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Tradeco Po' 
define root view entity Zraghav_tradecoPo 
  as select from ZSP_I_Market_PO           as MpcEkpo
    inner join   I_PurchaseOrderAPI01      as SelEkko on SelEkko.PurchaseOrder = MpcEkpo.PurchaseOrder
    inner join   I_PurchaseOrderItemAPI01  as SelEkpo on  SelEkpo.PurchaseOrder     = MpcEkpo.PurchaseOrder
                                                      and SelEkpo.PurchaseOrderItem = MpcEkpo.PurchaseOrderItem
    inner join   I_PurchaseOrderPartner    as SelEkpa on  SelEkpa.PurchaseOrder   = MpcEkpo.PurchaseOrder
                                                      and SelEkpa.PartnerFunction = MpcEkpo.PartnerFunction
    inner join   I_PurchaseOrderAPI01      as Ekko    on Ekko.PurchaseOrder = MpcEkpo.MpoPurchaseOrder
    inner join   I_PurchaseOrderPartner    as Ekpa    on  Ekpa.PurchaseOrder   = MpcEkpo.MpoPurchaseOrder
                                                      and Ekpa.PartnerFunction = MpcEkpo.PartnerFunction
    inner join   I_PurchaseOrderItemAPI01  as Ekpo    on  Ekpo.PurchaseOrder     = MpcEkpo.MpoPurchaseOrder
                                                      and Ekpo.PurchaseOrderItem = MpcEkpo.MpoPurchaseOrderItem
    inner join   I_PurOrdScheduleLineAPI01 as Eket    on  Eket.PurchaseOrder     = MpcEkpo.MpoPurchaseOrder
                                                      and Eket.PurchaseOrderItem = MpcEkpo.MpoPurchaseOrderItem
    inner join   I_SalesDocument           as Vbak    on Vbak.SalesDocument = MpcEkpo.TsoSalesDocument
    inner join   I_SalesDocumentItem       as Vbap    on  Vbap.SalesDocument     = MpcEkpo.TsoSalesDocument
                                                      and Vbap.SalesDocumentItem = MpcEkpo.TsoSalesDocumentItem
    inner join   I_PurchaseOrderAPI01      as TpoEkko on TpoEkko.PurchaseOrder = MpcEkpo.TpoPurchaseOrder
    inner join   I_PurchaseOrderItemAPI01  as TpoEkpo on  TpoEkpo.PurchaseOrder     = MpcEkpo.TpoPurchaseOrder
                                                      and TpoEkpo.PurchaseOrderItem = MpcEkpo.TpoPurchaseOrderItem
    inner join   I_PurchaseOrderPartner    as TpoEkpa on  TpoEkpa.PurchaseOrder   = MpcEkpo.TpoPurchaseOrder
                                                      and TpoEkpa.PartnerFunction = MpcEkpo.PartnerFunction
    inner join   I_PurOrdScheduleLineAPI01 as TpoEket on  TpoEket.PurchaseOrder     = MpcEkpo.TpoPurchaseOrder
                                                      and TpoEket.PurchaseOrderItem = MpcEkpo.TpoPurchaseOrderItem

{
  key       MpcEkpo.PurchaseOrder                                                                                                 as PurchaseOrder,
  key       MpcEkpo.PurchaseOrderItem                                                                                             as PurchaseOrderItem,
  key       MpcEkpo.MpoPurchaseOrder                                                                                              as MpoPurchaseOrder,
  key       MpcEkpo.MpoPurchaseOrderItem                                                                                          as MpoPurchaseOrderItem,
  key       MpcEkpo.TpoPurchaseOrder                                                                                              as TpoPurchaseOrder,
  key       MpcEkpo.TpoPurchaseOrderItem                                                                                          as TpoPurchaseOrderItem,
  key       MpcEkpo.TsoSalesDocument                                                                                              as TsoSalesDocument,
  key       MpcEkpo.TsoSalesDocumentItem                                                                                          as TsoSalesDocumentItem,
            MpcEkpo.PurchaseOrderType                                                                                             as PurchaseOrderType,
            MpcEkpo.PurchasingOrganization                                                                                        as PurchasingOrganization,
            MpcEkpo.PurchasingGroup                                                                                               as PurchasingGroup,
            MpcEkpo.plant                                                                                                         as plant,
            SelEkko.PurchaseOrderType                                                                                             as SelPurchaseOrderType,
            SelEkko.PurchasingOrganization                                                                                        as SelPurchasingOrganization,
            SelEkko.CompanyCode                                                                                                   as SelCompanyCode,
            SelEkko.PurchaseOrderDate                                                                                             as SelPurchaseOrderDate,
            SelEkpo.Material                                                                                                      as SelMaterial,
            SelEkpo.Plant                                                                                                         as SelPlant,
            SelEkpo.PurchaseOrder                                                                                                 as SelPurchaseOrder,
            SelEkpo.ZZ1_MM_EXFACTORYDT_PDI                                                                                        as SelZZ1_MM_Exfactorydt_PDI,
            cast( case when SelEkpo.PurchasingDocumentDeletionCode = 'L' then   'X'   else  ' ' end as boole_d preserving type )                                                            as SelPurDocumentDeletionCode,
            MpcEkpo.SelIsCompletelyDelivered                                                                                      as SelIsCompletelyDelivered,
            SelEkpa.Supplier                                                                                                      as SelSupplier,
            TpoEkko.PurchasingOrganization                                                                                        as TpoPurchasingOrganization,
            TpoEkko.CompanyCode                                                                                                   as TpoCompanyCode,
            TpoEkko.ZZ1_MM_TRADECOMODEL_PDH                                                                                       as TpoZZ1_MM_TradeCoMODEL_PDH,
            TpoEkko.Supplier                                                                                                      as TpoSupplier,
            TpoEkpa.Supplier                                                                                                      as TpoEkpaSupplier,
            TpoEkpo.Plant                                                                                                         as TpoPlant,
            TpoEkpo.ZZ1_SUPCONF_PDI                                                                                               as TpoSupconf_PDI,
            TpoEkpo.ZZ1_HTS_ELIGIBILITY_PDI                                                                                       as TpoHTS_Eligibility_PDI,
            TpoEkpo.ZZ1_HTS_SCOPE_PDI                                                                                             as TpoHTS_SCOPE_PDI,
            TpoEkpo.ZZ1_HTS_CURR_PDI                                                                                              as TpoHTS_Curr_PDI,
            TpoEkpo.PurchasingDocumentDeletionCode                                                                                as TpoPurchDocumentDeletionCode,
            TpoEkpo.IsCompletelyDelivered                                                                                         as TpoIsCompletelyDelivered,
            TpoEkpo.PurchaseOrderQuantityUnit                                                                                     as TpoOrderQuantityUnit,
            @Semantics.quantity.unitOfMeasure: 'TpoOrderQuantityUnit'
            TpoEkpo.OrderQuantity                                                                                                 as TpoOrderQuantity,
            TpoEkpo.ZZ1_MM_EXFACTORYDT_PDI                                                                                        as TpoMM_Exfactorydt_pdi,
            TpoEkpo.ZZ1_CUSTIN_PDI                                                                                                as TpoCustin_pdi,
            TpoEkpo.ZZ1_CUSTOM_STAT_PDI                                                                                           as TpoCustom_stat_pdi,
            TpoEkpo.ShippingInstruction                                                                                           as TpoShippingInstruction,
            TpoEkpo.ZZ1_ADI_M_PLANNED_PDI                                                                                         as TpoAdi_m_planned_pdi,
            TpoEkpo.ZZ1_ADI_M_PROMOFLAG_PDI                                                                                       as TpoAdi_m_promoflag_pdi,
            TpoEkpo.ZZ1_FPROD_DA_PDI                                                                                              as TpoFprod_da_pdi,
            TpoEkpo.ZZ1_INIT_PLAN_DA_PDI                                                                                          as TpoInit_plan_da_pdi,
            TpoEkpo.ZZ1_LPROD_DA_PDI                                                                                              as TpoLprod_da_pdi,
            TpoEkpo.ZZ1_ORDPRIO_PDI                                                                                               as TpoOrdprio_pdi,
            TpoEkpo.ZZ1_PRIOR_IND_PDI                                                                                             as TpoPrior_ind_pdi,
            TpoEket.ScheduleLineDeliveryDate                                                                                      as TpoScheduleLineDeliveryDate,
            Ekko.PurchaseOrderType                                                                                                as MpoPurchaseOrderType,
            Ekko.PurchasingOrganization                                                                                           as MpoPurchasingOrganization,
            Ekko.CompanyCode                                                                                                      as MpoCompanyCode,
            Ekko.Supplier                                                                                                         as MpoSupplier,
            Ekko.PurchaseOrderDate                                                                                                as MpoPurchaseOrderDate,
            Ekko.ZZ1_MM_TRADECOMODEL_PDH                                                                                          as MpoZZ1_MM_Tradecomodel_PDH,
            Ekpo.Material                                                                                                         as MpoMaterial,
            Ekpo.Plant                                                                                                            as MpoPlant,
            Ekpo.ZZ1_SUPCONF_PDI                                                                                                  as MpoSupconf_PDI,
            Ekpo.ZZ1_HTS_ELIGIBILITY_PDI                                                                                          as MpoHTS_Eligibility_PDI,
            Ekpo.ZZ1_HTS_SCOPE_PDI                                                                                                as MpoHTS_SCOPE_PDI,
            Ekpo.ZZ1_HTS_CURR_PDI                                                                                                 as MpoHTS_Curr_PDI,
            Ekpo.IsCompletelyDelivered                                                                                            as MpoIsCompletelyDelivered,
            Ekpo.PurchaseOrderQuantityUnit                                                                                        as MpoOrderQuantityUnit,
            @Semantics.quantity.unitOfMeasure: 'MpoOrderQuantityUnit'
            Ekpo.OrderQuantity                                                                                                    as MpoOrderQuantity,
            Ekpo.PurchasingDocumentDeletionCode                                                                                   as MpoPurchDocumentDeletionCode,
            Ekpo.ShippingInstruction                                                                                              as MpoShippingInstruction,
            Ekpo.ZZ1_MM_EXFACTORYDT_PDI                                                                                           as MpoMM_Exfactorydt_pdi,
            Ekpo.ZZ1_CUSTIN_PDI                                                                                                   as MpoCustin_pdi,
            Ekpo.ZZ1_CUSTOM_STAT_PDI                                                                                              as MpoCustom_stat_pdi,
            Ekpo.ZZ1_ADI_M_PLANNED_PDI                                                                                            as MpoAdi_m_planned_pdi,
            Ekpo.ZZ1_ADI_M_PROMOFLAG_PDI                                                                                          as MpoAdi_m_promoflag_pdi,
            Ekpo.ZZ1_FPROD_DA_PDI                                                                                                 as MpoFprod_da_pdi,
            Ekpo.ZZ1_INIT_PLAN_DA_PDI                                                                                             as MpoInit_plan_da_pdi,
            Ekpo.ZZ1_LPROD_DA_PDI                                                                                                 as MpoLprod_da_pdi,
            Ekpo.ZZ1_ORDPRIO_PDI                                                                                                  as MpoOrdprio_pdi,
            Ekpo.ZZ1_PRIOR_IND_PDI                                                                                                as MpoPrior_ind_pdi,
            Eket.ScheduleLineDeliveryDate                                                                                         as MpoScheduleLineDeliveryDate,
            Ekpa.Supplier                                                                                                         as MpoEkpaSupplier,

            Vbak.SalesOrganization                                                                                                as TsoSalesOrganization,
            Vbak.SoldToParty                                                                                                      as TsoSoldToParty,
            Vbap.BaseUnit                                                                                                         as TsoBaseUnit,
            @Semantics.quantity.unitOfMeasure: 'TsoBaseUnit'
            Vbap.OrderQuantity                                                                                                    as TsoOrderQuantity,
            case when Vbap.SalesDocumentRjcnReason is not initial then 'L' else '' end                                            as TsoSalesDocumentRjcnReason,

            --Inconsistencies (If there is a mismatch between the fields in the market PO and Trade Co PO an X should be inserted)--
            cast( case when Ekpa.Supplier  = TpoEkpa.Supplier  then  ''   else   'X' end as boole_d preserving type )                             as P_check_vnd,
            cast( case when Ekko.ZZ1_MM_TRADECOMODEL_PDH = TpoEkko.ZZ1_MM_TRADECOMODEL_PDH then  ''   else   'X' end as boole_d preserving type ) as P_check_tcm,
            case when Ekpo.OrderQuantity = Vbap.OrderQuantity
                  and Ekpo.OrderQuantity = TpoEkpo.OrderQuantity
                  and Vbap.OrderQuantity = TpoEkpo.OrderQuantity then cast ( '' as boole_d preserving type )  else cast ( 'X' as boole_d preserving type ) end     as P_check_qnt,

            case when Ekpo.PurchasingDocumentDeletionCode = Vbap.SalesDocumentRjcnReason
                  and Ekpo.PurchasingDocumentDeletionCode = TpoEkpo.PurchasingDocumentDeletionCode
                  and Vbap.SalesDocumentRjcnReason        = TpoEkpo.PurchasingDocumentDeletionCode
            then cast ( '' as boole_d preserving type  )
            else case when Ekpo.PurchasingDocumentDeletionCode is not initial
                        and Vbap.SalesDocumentRjcnReason  is not initial
                        and TpoEkpo.PurchasingDocumentDeletionCode is not initial
            then cast ( '' as boole_d preserving type )
            else cast ( 'X' as boole_d preserving type )   end end                                                                                as P_check_del,

            cast( case when Ekpo.ZZ1_CUSTOM_STAT_PDI = TpoEkpo.ZZ1_CUSTOM_STAT_PDI then ''  else  'X' end as boole_d preserving type )            as P_Check_custsta,
            cast( case when Ekpo.ZZ1_CUSTIN_PDI = TpoEkpo.ZZ1_CUSTIN_PDI then  ''   else   'X' end as boole_d preserving type )                   as P_Check_custind,

            case when Ekpo.IsCompletelyDelivered is initial and TpoEkpo.IsCompletelyDelivered is initial then cast ( '' as boole_d preserving type  )
            else case when Ekpo.IsCompletelyDelivered is initial and TpoEkpo.IsCompletelyDelivered is not initial then cast ( 'X' as boole_d preserving type )
            else case when Ekpo.IsCompletelyDelivered is not initial and TpoEkpo.IsCompletelyDelivered is initial then cast ( '' as boole_d preserving type )
            else case when Ekpo.IsCompletelyDelivered is not initial and TpoEkpo.IsCompletelyDelivered is not initial then cast ( '' as boole_d preserving type )
            else 'X' end end end end                                                                                              as P_Check_dci,

            cast( case when Ekpo.ShippingInstruction = TpoEkpo.ShippingInstruction then   ''   else  'X' end as boole_d preserving type )         as P_Check_shi,
            cast( case when Ekpo.ZZ1_ADI_M_PLANNED_PDI = TpoEkpo.ZZ1_ADI_M_PLANNED_PDI then  ''   else  'X' end as boole_d preserving type  )      as P_Check_pd,
            cast( case when Ekpo.ZZ1_ADI_M_PROMOFLAG_PDI = TpoEkpo.ZZ1_ADI_M_PROMOFLAG_PDI then '' else 'X' end as boole_d preserving type )      as P_Check_ppf,
            cast( case when Ekpo.ZZ1_FPROD_DA_PDI = TpoEkpo.ZZ1_FPROD_DA_PDI then   ''   else   'X' end as boole_d preserving type )              as P_Check_fpd,
            cast( case when Ekpo.ZZ1_HTS_CURR_PDI = TpoEkpo.ZZ1_HTS_CURR_PDI then   ''   else 'X' end as boole_d preserving type )                as P_Check_ck,
            cast( case when Ekpo.ZZ1_HTS_SCOPE_PDI = TpoEkpo.ZZ1_HTS_SCOPE_PDI then '' else 'X' end as boole_d preserving type )                  as P_check_ii,
            cast( case when Ekpo.ZZ1_HTS_ELIGIBILITY_PDI = TpoEkpo.ZZ1_HTS_ELIGIBILITY_PDI then ''  else 'X' end as  boole_d preserving type )    as P_Check_ipd,
            cast( case when Ekpo.ZZ1_LPROD_DA_PDI = TpoEkpo.ZZ1_LPROD_DA_PDI then ''  else 'X' end as boole_d preserving type )                   as P_Check_lpd,
            cast( case when Ekpo.ZZ1_ORDPRIO_PDI = TpoEkpo.ZZ1_ORDPRIO_PDI then ''  else  'X' end as boole_d preserving type )                    as P_Check_opi,
            cast( case when Ekpo.ZZ1_PRIOR_IND_PDI = TpoEkpo.ZZ1_PRIOR_IND_PDI then  ''  else  'X' end as boole_d preserving type )               as P_Check_ipi,
            cast( case when Ekpo.ZZ1_SUPCONF_PDI = TpoEkpo.ZZ1_SUPCONF_PDI then '' else 'X' end as boole_d preserving type )                      as P_Check_scs


}
