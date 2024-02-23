@AbapCatalog.sqlViewAppendName: 'XRFMIGOODSMVDOC'
@EndUserText.label: 'Ext. view I_GoodsMovementDocument'
@VDM.viewExtension: true
extend view I_GoodsMovementDocument with X_RFM_I_GoodsMovementDocument
{
  ProductSeasonYear,
  ProductSeason,
  ProductCollection,
  ProductTheme,
  CrossPlantConfigurableProduct,
  ProductCharacteristic1,
  ProductCharacteristic2,
  ProductCharacteristic3
//  ProdCharc1InternalNumber,
//  ProdCharc2InternalNumber,
//  ProdCharc3InternalNumber
 
}
