@AbapCatalog: {
                sqlViewName: 'IMATERIALSTOCK',
                preserveKey: true,
                compiler.compareFilter: true
              }
@EndUserText.label: 'Material Stock Calculation'
@AccessControl: {
                  authorizationCheck: #CHECK,
                  personalData.blocking: #NOT_REQUIRED   --there are no BP references in table MATDOC with an EndOfPurpose state
                }
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
                usageType: {
                             sizeCategory: #XXL,
                             serviceQuality: #D,
                             dataClass:#TRANSACTIONAL
                           },
                modelingPattern: #ANALYTICAL_CUBE,
                supportedCapabilities: [#ANALYTICAL_PROVIDER, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE]
              }
@VDM: {
        viewType: #COMPOSITE,
        lifecycle.contract.type: #PUBLIC_LOCAL_API
      }
@Analytics.dataCategory:#CUBE
@Metadata: {
             allowExtensions: true,
             ignorePropagatedAnnotations: true
           }

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ] } */

define view I_MaterialStock
  as select from I_MaterialStock_Aggr

  association [1..1] to I_Material                  as _Material                      on  $projection.Material = _Material.Material
  association [1..1] to I_CompanyCode               as _CompanyCode                   on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [1..1] to I_Plant                     as _Plant                         on  $projection.Plant = _Plant.Plant
  association [0..1] to I_StorageLocation           as _StorageLocation               on  $projection.Plant           = _StorageLocation.Plant
                                                                                      and $projection.StorageLocation = _StorageLocation.StorageLocation
  association [0..1] to I_Supplier                  as _Supplier                      on  $projection.Supplier = _Supplier.Supplier
  association [0..1] to I_Customer                  as _Customer                      on  $projection.Customer = _Customer.Customer
  association [0..1] to I_Supplier                  as _SpecialStockIdfgStockOwner    on  $projection.SpecialStockIdfgStockOwner = _SpecialStockIdfgStockOwner.Supplier
  association [1..1] to I_InventoryStockType        as _InventoryStockType            on  $projection.InventoryStockType = _InventoryStockType.InventoryStockType
  association [1..1] to I_InventorySpecialStockType as _InventorySpecialStockType     on  $projection.InventorySpecialStockType = _InventorySpecialStockType.InventorySpecialStockType
  association [1..1] to I_UnitOfMeasure             as _UnitOfMeasure                 on  $projection.MaterialBaseUnit = _UnitOfMeasure.UnitOfMeasure
-- View I_InvtryPrcBasicByKeyDate deliveres the same data as I_InventoryPriceByKeyDate but is performance optimized for stock value calculation from quantities
-- View I_InventoryPriceByKeyDate has to stay for compatibility reasons (I_MaterialStock is C1 released)
  association [0..1] to I_InvtryPrcBasicByKeyDate   as _InvtryPrcBasicByPeriodEndDate on  $projection.CostEstimate = _InvtryPrcBasicByPeriodEndDate.CostEstimate
  association [0..1] to I_InventoryPriceByKeyDate   as _InventoryPriceByPeriodEndDate on  $projection.CostEstimate = _InventoryPriceByPeriodEndDate.CostEstimate
                                                                                      and _InventoryPriceByPeriodEndDate.CurrencyRole = '10'
  association [0..1] to I_CurrentMatlPriceByCostEst as _CurrentInvtryPrice            on  $projection.CostEstimate = _CurrentInvtryPrice.CostEstimate
{
      // Stock Identifier
      @ObjectModel.foreignKey.association: '_Material'
  key Material,
      @ObjectModel.foreignKey.association: '_Plant'
  key Plant,
      @ObjectModel.foreignKey.association: '_StorageLocation'
  key StorageLocation,
  key Batch,
      @ObjectModel.foreignKey.association: '_Supplier'
  key Supplier,
  key SDDocument,
  key SDDocumentItem,
  key WBSElementInternalID,
      @ObjectModel.foreignKey.association: '_Customer'
  key Customer,
      @ObjectModel.foreignKey.association: '_SpecialStockIdfgStockOwner'
  key SpecialStockIdfgStockOwner,    
      @ObjectModel.foreignKey.association: '_InventoryStockType'
  key InventoryStockType,
      @ObjectModel.foreignKey.association: '_InventorySpecialStockType'
  key InventorySpecialStockType,
      // Further Stock Groups
      @Semantics.fiscal.yearVariant: true
  key FiscalYearVariant,
      @Semantics.businessDate.at: true
  key MatlDocLatestPostgDate,
      // Units
      @Semantics.unitOfMeasure: true
  key MaterialBaseUnit,
      CostEstimate,
      @ObjectModel.foreignKey.association: '_CompanyCode'
      CompanyCode,

      // Quantities
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      MatlWrhsStkQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      MatlCnsmpnQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      MatlStkIncrQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      MatlStkDecrQtyInMatlBaseUnit,

      // Associations for names and descriptions
      _UnitOfMeasure,
      _Material,
      _CompanyCode,
      _Plant,
      _StorageLocation,
      _Supplier,
      _Customer,
      _SpecialStockIdfgStockOwner,
      _InventoryStockType,
      _InventorySpecialStockType,
      _InvtryPrcBasicByPeriodEndDate,
      _InventoryPriceByPeriodEndDate,
      _CurrentInvtryPrice
}                              
  
  
  
  
 