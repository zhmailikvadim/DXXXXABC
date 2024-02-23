/*
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* DZESHKAT     | 28.04.2023 | 19919_FI_Setting up 5 credit limi        *
*              |            | DS4K949471                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZFISALESDOCUMENT'
@EndUserText.label: 'Extension for I_SalesDocument'
extend view I_SalesDocument with ZFI_E_SALESDOCUMENT association [1..1] to vbak 
on $projection.salesdocumentbasic = vbak.vbeln {
    vbak.trvog as ZZ_TransactionGroup,
    vbak.bstnk as ZZ_PurchaseOrderByCustomer
}
