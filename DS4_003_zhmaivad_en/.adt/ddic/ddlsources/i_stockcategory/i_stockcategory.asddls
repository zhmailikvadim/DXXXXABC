@AbapCatalog.sqlViewName: 'ILESTOCKCTGY'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck:#NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'WarehouseStockCategory'
@ObjectModel.usageType.dataClass: #META
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: false }
@VDM.viewType: #BASIC
@EndUserText.label: 'Stock Category in Warehouse'
@Metadata.allowExtensions: true

define view I_StockCategory as select from dd07l 

association [0..*] to I_StockCategoryText as _Text on $projection.WarehouseStockCategory = _Text.WarehouseStockCategory
{
    @ObjectModel.text.association: '_Text'
    key SUBSTRING(dd07l.domvalue_l, 1, 1) as WarehouseStockCategory,
    _Text  
}
where (dd07l.domname = 'BESTQ') and (dd07l.as4local = 'A');  
