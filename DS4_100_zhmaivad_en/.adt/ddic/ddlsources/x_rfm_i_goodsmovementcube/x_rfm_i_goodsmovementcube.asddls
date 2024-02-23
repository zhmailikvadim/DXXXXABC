@AbapCatalog.sqlViewAppendName: 'XRFMIGDSMVECUBE'
@EndUserText.label: 'Ext. view I_GoodsMovementCube'
@VDM.viewExtension: true
extend view I_GoodsMovementCube with X_RFM_I_GoodsMovementCube

{
  ProductSeasonYear,
  ProductSeason,
  ProductCollection,
  ProductTheme,
  @ObjectModel.foreignKey.association: '_CrossPlantConfigurableProduct'
  CrossPlantConfigurableProduct,
//  cast(CrossPlantConfigurableProduct as z_rfm_generic_product) as CrossPlantConfigurableProduct,
  ProductCharacteristic1, 
  ProductCharacteristic2,
  ProductCharacteristic3,
  
  _CrossPlantConfigurableProduct
}
