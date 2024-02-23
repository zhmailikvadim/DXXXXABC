@AbapCatalog.sqlViewAppendName: 'XRFMIMATERIAL'
@EndUserText.label: 'Ext. view for I_Material'
@VDM.viewExtension: true
extend view I_Material with X_RFM_I_Material
{
  satnr              as CrossPlantConfigurableProduct,
  attyp              as ProductCategory,
  color              as ProductCharacteristic1,
  size1              as ProductCharacteristic2,
  size2              as ProductCharacteristic3,
  @UI.hidden: true
  @Consumption.filter.hidden: true
  color_atinn        as ProdCharc1InternalNumber,
  @UI.hidden: true
  @Consumption.filter.hidden: true
  size1_atinn        as ProdCharc2InternalNumber,
  @UI.hidden: true
  @Consumption.filter.hidden: true
  size2_atinn        as ProdCharc3InternalNumber
}
