/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.11.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDESDSALESDOC1'
@EndUserText.label: 'I_SalesDocumentBasic Extend View'
extend view I_SalesDocument with ZSD_E_SALESDOCUMENT1
{
  vbkd.bsark     as SoldToPartyPoType
}
