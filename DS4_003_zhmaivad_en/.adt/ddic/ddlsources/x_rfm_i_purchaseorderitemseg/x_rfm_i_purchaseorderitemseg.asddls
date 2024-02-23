@AbapCatalog.sqlViewAppendName: 'XRFMIPURCHORDITS'
@EndUserText.label: 'Exte. view for I_PurchaseOrderItem'
@VDM.viewExtension:true 
extend view I_PurchaseOrderItem with X_RFM_I_PurchaseOrderItemSeg
{
// Segmentation
@Feature:'SW:RFM_SEGMTN_UI'
  StockSegment 
}
