@AbapCatalog.sqlViewAppendName: 'XRFMIGOODSMVESEG'
@EndUserText.label: 'Ext. view I_GoodsMovementDocument'
@VDM.viewExtension: true
extend view I_GoodsMovementDocument with X_RFM_I_GoodsMovementDocSgmt
{
  StockSegment,
  IssgOrRcvgStockSegment
}
