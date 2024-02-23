@AbapCatalog.sqlViewAppendName: 'XRFMIAUGGDSMVSEG'
@EndUserText.label: 'Ext. view I_AugmentedGoodsMovement'
@VDM.viewExtension: true
extend view I_AugmentedGoodsMovement with X_RFM_I_AugmentedGoodsMvtSgmt 

{
  StockSegment
}
