@AbapCatalog.sqlViewAppendName: 'XISALDOCBASIC'
@EndUserText.label: 'Ext. view for I_SalesDocumentBasic'
@VDM.viewExtension:true   
extend view I_SalesDocumentBasic with X_RFM_I_SalesDocumentBasic
{
  fsh_kvgr6  as RetailAdditionalCustomerGrp6,
  fsh_kvgr7  as RetailAdditionalCustomerGrp7,
  fsh_kvgr8  as RetailAdditionalCustomerGrp8,
  fsh_kvgr9  as RetailAdditionalCustomerGrp9,
  fsh_kvgr10 as RetailAdditionalCustomerGrp10
}
