/*
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* IAPRYALE     | 30.08.2022 | 24751     : Business Clearance           *
*              |            | DS4K962325                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZFISALESDOCBASIC'
@EndUserText.label: 'Extension for I_SalesDocumentBasic'
extend view I_SalesDocumentBasic with ZFI_E_SALESDOCUMENTBASIC
  association [1..1] to vbak on $projection.SalesDocument = vbak.vbeln
{
  vbak.bstnk as ZZ_PurchaseOrderByCustomer
}
