@AbapCatalog.sqlViewAppendName: 'XRFMIAUGGOODSMVE'
@EndUserText.label: 'Ext. view I_AugmentedGoodsMovement'
@VDM.viewExtension: true
extend view I_AugmentedGoodsMovement with X_RFM_I_AugmentedGoodsMovement 
           
association [0..1] to I_Material                  as _CrossPlantConfigurableProduct  on  $projection.crossplantconfigurableproduct = _CrossPlantConfigurableProduct.Material

{
  ProductSeasonYear,
  ProductSeason,
  ProductCollection,
  ProductTheme,
  CrossPlantConfigurableProduct,
  ProductCharacteristic1,
  ProductCharacteristic2,
  ProductCharacteristic3,
  _CrossPlantConfigurableProduct

}
