@AbapCatalog.sqlViewAppendName: 'XISALESDOCUMENT'
@EndUserText.label: 'Ext. view for I_SalesDocument'
@VDM.viewExtension:true 
extend view I_SalesDocument with X_RFM_I_SalesDocument
{
  RetailAdditionalCustomerGrp6,
  RetailAdditionalCustomerGrp7,
  RetailAdditionalCustomerGrp8,
  RetailAdditionalCustomerGrp9,
  RetailAdditionalCustomerGrp10
}
