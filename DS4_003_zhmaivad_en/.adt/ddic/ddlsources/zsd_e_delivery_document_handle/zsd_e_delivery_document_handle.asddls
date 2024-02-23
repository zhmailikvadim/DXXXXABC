/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KALSHZHA     | 05.04.2023 | 19666     : Feature - [Platform] - DN AP *
*              |            | DS4K949079                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZILEDELIVDOC_HDL'
@EndUserText.label: 'Extenshion of delivery document for TSEGE based entities'
extend view I_DeliveryDocument with zsd_e_delivery_document_handle {
    likp.handle as Handle
}
