/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZUJSKAS      | 06.12.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDEPURORDIT'
@EndUserText.label: 'I_PurchaseOrderItem Extend view'
extend view I_PurchaseOrderItem with ZSD_E_PURCHASEORDERITEM {
    ExFactoryDate,
    DelayReasonCodeConf,
    DelayReasonCodePODelD,
    FirstConfExFDt,
    LastConfExFDt,
    MarketDeliveryDate,
    CreationDate
}
