/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZUJSKAS      | 06.12.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDEPURDOCIT'
@EndUserText.label: 'I_PurchasingDocumentItem Extend view'
extend view I_PurchasingDocumentItem with ZSD_E_PurchasingDocumentItem {
    ekpo.zz1_mm_exfactorydt_pdi as ExFactoryDate,
    ekpo.zz1_delay_pln_conf_pdi as DelayReasonCodeConf,
    ekpo.zz1_delay_po_pdi as DelayReasonCodePODelD,
    ekpo.zz1_fexfct_da_pdi as FirstConfExFDt,
    ekpo.zz1_lexfct_da_pdi as LastConfExFDt,
    ekpo.zz1_mdd_da_pdi as MarketDeliveryDate,
    
    ekpo.creationdate as CreationDate
}
