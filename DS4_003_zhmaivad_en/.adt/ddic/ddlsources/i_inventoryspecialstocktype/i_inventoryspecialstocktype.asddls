@AbapCatalog: {
                sqlViewName: 'IINVSPECSTOCKTY',
                preserveKey: true,
                compiler.compareFilter: true
              }
@EndUserText.label: 'Inventory Special Stock Type'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
                usageType: {
                             sizeCategory: #S,
                             serviceQuality: #A,
                             dataClass:#CUSTOMIZING
                           },
                representativeKey: 'InventorySpecialStockType',
                modelingPattern: #ANALYTICAL_DIMENSION,
                supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE]
              }
@VDM: {
        viewType: #BASIC,
        lifecycle.contract.type: #PUBLIC_LOCAL_API
      }
@Analytics.dataCategory: #DIMENSION
@Metadata: {
             ignorePropagatedAnnotations: true
           }

define view I_InventorySpecialStockType
  as select from t148
  association [0..*] to I_InventorySpecialStockTypeT as _Text on $projection.InventorySpecialStockType = _Text.InventorySpecialStockType
{
      @ObjectModel.text.association: '_Text'
  key sobkz as InventorySpecialStockType,
      _Text
}      
