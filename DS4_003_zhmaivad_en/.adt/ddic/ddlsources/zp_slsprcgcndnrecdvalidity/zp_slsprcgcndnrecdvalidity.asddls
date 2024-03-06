/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* DEREVOLE     | 21.10.2022 | T4MTEMP-846 [Build] BE -                 *
*              |            | Pricing Mass Upload Tool                 *
*              |            | DS4K929425, Change number 13489          *
*----------------------------------------------------------------------*
* BOBRULA      | 07.11.2023 | 26564 : Pricing Mass Upload Tool         *
*              |            | DS4K969470                               *
*----------------------------------------------------------------------*/
@AbapCatalog:
{
  sqlViewName: 'ZPSLSPRCGCNDNVA',
  compiler.compareFilter: true
}
@AccessControl:
{
  authorizationCheck: #CHECK
}
@VDM:
{ 
  private:true,
  viewType: #BASIC
}
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Pricing Condition Validity'
define view ZP_SlsPrcgCndnRecdValidity  as select from P_PrcgCndnRecdValidity
{
  key ConditionRecord,
      @Semantics.businessDate.to: true
  key ConditionValidityEndDate,
      @Semantics.businessDate.from: true
      ConditionValidityStartDate,
      ConditionApplication,
      ConditionType,
      cast( '' as kfrst )                     as ConditionReleaseStatus,
      cast( '' as aland )                     as DepartureCountry,
      cast( '' as vbeln_va )                  as SalesDocument,
      cast( '' as posnr_va )                  as SalesDocumentItem,
      cast( '' as bemot )                     as BillableControl,
      cast( '' as brsch )                     as Industry,
      cast( '' as cityc )                     as CityCode,
      cast( '' as wcb_coco_num )              as ConditionContract,
      cast( '' as counc )                     as County,
      cast( '' as /cpd/mp_id )                as EngagementProject,
      cast( '' as cuobj )                     as ConfigurationNumber,
      cast( '' as j_1bdoctyp )                as BR_NFDocumentType,
      cast( '' as j_1bdynkey1 )               as BRSpcfcFreeDefinedField1,
      cast( '' as j_1bdynkey2 )               as BRSpcfcFreeDefinedField2,
      cast( '' as j_1bdynkey3 )               as BRSpcfcFreeDefinedField3,
      cast( '' as ean11 )                     as InternationalArticleNumber,
      cast( '' as eqart )                     as TechnicalObjectType,
      cast( '' as equnr )                     as Equipment,
      cast( '' as kunnr_kh )                  as CustomerHierarchy,
      cast( '' as inco1 )                     as IncotermsClassification,
      cast( '' as inco2 )                     as IncotermsTransferLocation,
      cast( '' as j_1afitp_d )                as AccountTaxType,
      cast( '' as j_1atxrel_ )                as TxRlvnceClassfctnForArgentina,
      cast( '' as j_1btxsdc_ )                as BR_TaxCode,
      cast( '' as j_1istcode )                as LocalSalesTaxApplicabilityCode,
      cast( '' as kdgrp )                     as CustomerGroup,
      cast( '' as konda_v )                   as CustomerPriceGroup,
      cast( '' as kondm_v )                   as MaterialPricingGroup,
      cast( '' as kunag )                     as SoldToParty,
      cast( '' as bu_partner )                as BPForSoldToParty,
      cast( '' as kunnr_v )                   as Customer,
      cast( '' as bu_partner )                as BPForCustomer,
      cast( '' as kunrg )                     as PayerParty,
      cast( '' as bu_partner )                as BPForPayerParty,
      cast( '' as kunwe )                     as ShipToParty,
      cast( '' as bu_partner )                as BPForShipToParty,
      cast( '' as elifn )                     as Supplier,
      cast( '' as bu_partner )                as BPForSupplier,
      cast( '' as lland )                     as DestinationCountry,
      cast( '' as matkl )                     as MaterialGroup,
      cast( '' as matnr )                     as Material,
      cast( '' as msr_returns_refund_code )   as ReturnsRefundExtent,
      cast( '' as mvgr1 )                     as AdditionalMaterialGroup1,
      cast( '' as mvgr2 )                     as AdditionalMaterialGroup2,
      cast( '' as mvgr3 )                     as AdditionalMaterialGroup3,
      cast( '' as mvgr4 )                     as AdditionalMaterialGroup4,
      cast( '' as mvgr5 )                     as AdditionalMaterialGroup5,
      cast( '' as pernr_d )                   as Personnel,
      cast( '' as pltyp )                     as PriceListType,
      cast( '' as pstlz )                     as PostalCode,
      cast( '' as regio )                     as Region,
      cast( '' as /cpd/pws_ws_org_unit_id )   as EngagementProjectServiceOrg,
      cast( '' as sgt_rcat )                  as RequirementSegment,
      cast( '' as sgt_scat )                  as StockSegment,
      cast( '' as spart )                     as Division,
      cast( '' as stawn )                     as CommodityCode,
      cast( '' as steuc )                     as ConsumptionTaxCtrlCode,
      cast( '' as taxbs )                     as BRSpcfcTaxBasePercentageCode,
      cast( '' as j_1btxgrp )                 as BRSpcfcTxGrpDynTaxExceptions,
      cast( '' as taxk1 )                     as CustomerTaxClassification1,
      cast( '' as taxk2 )                     as CustomerTaxClassification2,
      cast( '' as taxk3 )                     as CustomerTaxClassification3,
      cast( '' as taxk4 )                     as CustomerTaxClassification4,
      cast( '' as taxm1 )                     as ProductTaxClassification1,
      cast( '' as taxm2 )                     as ProductTaxClassification2,
      cast( '' as taxm3 )                     as ProductTaxClassification3,
      cast( '' as taxm4 )                     as ProductTaxClassification4,
      cast( '' as tkonn )                     as TradingContract,
      cast( '' as tposn )                     as TradingContractItem,
      cast( '' as txjcd )                     as TaxJurisdiction,
      cast( '' as j_1btxshpf )                as BRSpcfcTaxDepartureRegion,
      cast( '' as j_1btxshpt )                as BRSpcfcTaxDestinationRegion,
      cast( '' as ukonm )                     as MainItemMaterialPricingGroup,
      cast( '' as upmat )                     as MainItemPricingRefMaterial,
      cast( '' as varcond )                   as VariantCondition,
      cast( '' as fsh_vas_chrg_code )         as ValueAddedServiceChargeCode,
      cast( '' as vbeln )                     as SDDocument,
      cast( '' as vgbel )                     as ReferenceSDDocument,
      cast( '' as vgpos )                     as ReferenceSDDocumentItem,
      cast( '' as vkbur )                     as SalesOffice,
      cast( '' as vkgrp )                     as SalesGroup,
      cast( '' as vkorg )                     as SalesOrganization,
      cast( '' as vkorg_auft )                as SalesOrderSalesOrganization,
      cast( '' as vrkme )                     as OrderQuantityUnit,
      cast( '' as vtweg )                     as DistributionChannel,
      cast( '' as waerk )                     as TransactionCurrency,
      cast( '' as /cpd/s_sc_wbs_bill_element )as WBSElementInternalID,
      cast( '' as ps_posid_edit )             as WBSElementExternalID,
      cast( '' as /cpd/s_sc_wbs_workpackage ) as WorkPackage,
      cast( '' as werks_d )                   as Plant,
      cast( '' as wkreg )                     as PlantRegion,
      cast( '' as /cpd/pfp_workitem_id )      as WorkItem,
      cast( '' as kbstat )                    as ConditionProcessingStatus,
      cast( '' as kdatu )                     as PricingDate,
      cast( '' as kexcl )                     as ConditionIsExclusive,
      cast( '' as kstaf )                     as ConditionScaleBasisValue,
      cast( '' as mwskz )                     as TaxCode,
      cast( '' as crmt_object_id_db )         as ServiceDocument,
      cast( '' as crms4_number_int )          as ServiceDocumentItem,
      cast( '' as cats_overtime_category )    as TimeSheetOvertimeCategory, 
      cast( '' as vbtypl )                    as SalesSDDocumentCategory,
      cast( '' as msr_returns_reason )        as ReturnReason, 
      cast( '' as vkon_prod_hier_node_value)  as ProductHierarchyNode,
      cast( '' as kdkgr)                      as CustomerConditionGroup,
      cast( '' as versart)                    as ShippingType,
      cast( '' as crmt_prov_duration)         as SubscriptionContractDuration,
      cast( '' as crmt_prov_duration_unit)    as SubscrpnContrDurationUnit,
      cast( '' as ist_lock_reason)            as SubscriptionContractLockReason,
      cast( '' as ist_price_vrs)              as CrsCtlgMappgPriceVersionNumber,
//----------- Added field -----------------------------------------------------------//      
      cast('' as auart)                       as AUART_SD,
      cast('' as zz1_auartsd)                 as ZZ1_AUARTSD_PCH,
      cast('' as zz1_auart_ref)               as ZZ1_AUART_REF_PCI,
      cast('' as augru)                       as AUGRU,
      cast('' as bzirk)                       as BZIRK,
      cast('' as fsh_collection)              as FSH_COLLECTION,
      cast('' as fsh_saiso)                   as FSH_SEASON,
      cast('' as fsh_saisj)                   as FSH_SEASON_YEAR,
      cast('' as knuma_ag)                    as KNUMA_AG,
      cast('' as kunre)                       as KUNRE,
      cast('' as provg)                       as PROVG,
      cast('' as vstel)                       as VSTEL,
      cast('' as zz1_bsart)                   as ZZ1_BSART_PCH,
      cast('' as zmm_bsg)                     as ZZBSG,
      cast('' as fsh_kvgr7)                   as ZZFSH_KVGR7,
      cast('' as fsh_kvgr8)                   as ZZFSH_KVGR8,
      cast('' as  katr1)                      as ZZKATR1,
      cast('' as  katr9)                      as ZZKATR9,
      cast('' as  kvgr2)                      as ZZKVGR2,
      cast('' as  kvgr4)                      as ZZKVGR4,
      cast('' as  zmm_last_sale_season)       as ZZLASTSEASON,
      cast('' as  vmsta)                      as ZZVMSTA,
      cast('' as  waktion)                    as AKTNR,
      cast('' as zz1_m3season )               as ZZ1_M3SEASON_PCI,
      cast('' as zz1_mm_fsh_mg_at1 )          as ZZ1_MM_FSH_MG_AT1_PCI      
}
