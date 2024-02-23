@AbapCatalog.sqlViewAppendName: 'XRFMIMATDOCSEG'
@EndUserText.label: 'Ext. view I_MaterialDocumentRecord'
@VDM.viewExtension: true
extend view I_MaterialDocumentRecord with X_RFM_I_MaterialDocRecordSgmt
{
  sgt_scat        as StockSegment, 
  sgt_umscat      as IssgOrRcvgStockSegment 
}
