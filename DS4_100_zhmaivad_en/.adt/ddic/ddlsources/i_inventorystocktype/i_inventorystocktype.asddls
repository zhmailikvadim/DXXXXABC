@AbapCatalog: {
                sqlViewName: 'IINVSTOCKTYPE',
                preserveKey: true,
                compiler.compareFilter: true
              }
@EndUserText.label: 'Inventory Stock Type'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
                usageType: {
                             sizeCategory: #S,
                             serviceQuality: #A,
                             dataClass:#CUSTOMIZING
                           },
                representativeKey: 'InventoryStockType',
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

define view I_InventoryStockType
  as select from dd07l
  association [0..*] to I_InventoryStockTypeT as _Text on $projection.InventoryStockType = _Text.InventoryStockType
{
      @ObjectModel.text.association: '_Text'
  key cast(substring( domvalue_l, 1, 2 ) as nsdm_lbbsa) as InventoryStockType, //casting to have the right label for consumers
      _Text
}
where
      domname  = 'NSDM_LBBSA'
  and as4local = 'A'  

