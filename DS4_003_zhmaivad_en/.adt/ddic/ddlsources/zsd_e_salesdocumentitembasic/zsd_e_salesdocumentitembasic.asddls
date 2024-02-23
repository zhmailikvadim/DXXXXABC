/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.11.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDESDSLSDOCITMB'
@EndUserText.label: 'I_SalesDocumentItemBasic Extend View'
extend view I_SalesDocumentItemBasic with ZSD_E_SalesDocumentItemBasic
{
  vbap.eannr as EAN,
  vbap.wgru1 as MaterialGroup1Text
}
