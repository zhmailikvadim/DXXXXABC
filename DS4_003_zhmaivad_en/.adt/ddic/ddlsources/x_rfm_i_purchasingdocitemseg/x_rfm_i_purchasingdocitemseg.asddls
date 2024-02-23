@AbapCatalog.sqlViewAppendName: 'XRFMIPURCHDOCITS'
@EndUserText.label: 'Exte. view for I_PurchasingDocumentItem'
@VDM.viewExtension: true
extend view I_PurchasingDocumentItem with X_RFM_I_PurchasingDocItemSeg
{
  @Feature:'SW:RFM_SEGMTN_UI'
  sgt_scat        as StockSegment
}
