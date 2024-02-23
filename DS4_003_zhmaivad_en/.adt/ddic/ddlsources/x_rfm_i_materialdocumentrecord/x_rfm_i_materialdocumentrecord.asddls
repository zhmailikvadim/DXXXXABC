@AbapCatalog.sqlViewAppendName: 'XRFMIMATDOCREC'
@EndUserText.label: 'Ext. view I_MaterialDocumentRecord'
@VDM.viewExtension: true
extend view I_MaterialDocumentRecord with X_RFM_I_MaterialDocumentRecord
{
  fsh_season_year as ProductSeasonYear,
  fsh_season      as ProductSeason,
  fsh_collection  as ProductCollection, 
  fsh_theme       as ProductTheme,
  _Material.CrossPlantConfigurableProduct as CrossPlantConfigurableProduct,
//  cast(_Material.CrossPlantConfigurableProduct as z_rfm_generic_product preserving type) as CrossPlantConfigurableProduct,    
  _Material.ProductCharacteristic1 as ProductCharacteristic1,
  _Material.ProductCharacteristic2 as ProductCharacteristic2,
  _Material.ProductCharacteristic3 as ProductCharacteristic3 
}
