@AbapCatalog.sqlViewName: 'IMATSTOCKAGGR'
@EndUserText.label: 'Aggreg. of material stock on low level'

@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass:#TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM: {
        private: false,
        viewType: #COMPOSITE,
        lifecycle.contract.type: #SAP_INTERNAL_API
        }

@Analytics.dataCategory:#FACT

define view I_MaterialStock_Aggr
  as select from I_MaterialDocumentRecord
  association [1..1] to I_UnitOfMeasure          as _UnitOfMeasure          on $projection.MaterialBaseUnit = _UnitOfMeasure.UnitOfMeasure
{
      // All fields have to be defined as key field and quantity/value have to be summarized on this lowest level
      // in addition to the annotation for aggregation (#SUM)
      // This is especiall required for consumption views used by users with restricted authorization to get the right results
      // (just because right now an INNER JOIN is created which may multiply the result set and hence the aggregate is wrong)

      // Stock Identifier
  key StockIdentifyingMaterial                                                                                                        as Material,
  key Plant                                                                                                                           as Plant,
  key cast(StockIdfgStorageLocation as lgort_d)                                                                                       as StorageLocation,
  key StockIdentifyingBatch                                                                                                           as Batch,
  key SpecialStockIdfgSupplier                                                                                                        as Supplier,
  key SpecialStockIdfgSalesOrder                                                                                                      as SDDocument,
  key SpecialStockIdfgSalesOrderItem                                                                                                  as SDDocumentItem,
  key SpecialStockIdfgWBSElement                                                                                                      as WBSElementInternalID,
  key SpecialStockIdfgCustomer                                                                                                        as Customer,
  key SpecialStockIdfgStockOwner, 
  key InventoryStockType                                                                                                              as InventoryStockType,
  key InventorySpecialStockType                                                                                                       as InventorySpecialStockType,
      // Further Stock Groups
      @Semantics.fiscal.yearVariant: true
  key FiscalYearVariant                                                                                                               as FiscalYearVariant,
      @Semantics.businessDate.at: true
  key PostingDate                                                                                                                     as MatlDocLatestPostgDate,
      // Units
      @Semantics.unitOfMeasure: true
  key MaterialBaseUnit                                                                                                                as MaterialBaseUnit,
  key CostEstimate,

      CompanyCode                                                                                                                     as CompanyCode,

      // Quantities
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      cast(sum(MatlStkChangeQtyInBaseUnit) as nsdm_stock_qty preserving type)                                                                         as MatlWrhsStkQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      cast(sum(MatlCnsmpnQtyInMatlBaseUnit) as nsdm_consumption_qty preserving type)                                                                  as MatlCnsmpnQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      cast(sum(case when  MatlStkChangeQtyInBaseUnit > 0 then MatlStkChangeQtyInBaseUnit else 0 end) as nsdm_stock_increase_qty preserving type)      as MatlStkIncrQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation : #SUM
      cast(sum(case when  MatlStkChangeQtyInBaseUnit < 0 then abs(MatlStkChangeQtyInBaseUnit) else 0 end) as nsdm_stock_decrease_qty preserving type) as MatlStkDecrQtyInMatlBaseUnit,

      _UnitOfMeasure
}
where
  MaterialBaseUnit <> ''
group by
  StockIdentifyingMaterial,
  Plant,
  StockIdfgStorageLocation,
  StockIdentifyingBatch,
  SpecialStockIdfgSupplier,
  SpecialStockIdfgSalesOrder,
  SpecialStockIdfgSalesOrderItem,
  SpecialStockIdfgWBSElement,
  SpecialStockIdfgCustomer,
  SpecialStockIdfgStockOwner,
  InventoryStockType,
  InventorySpecialStockType,
  CompanyCode,
  FiscalYearVariant,
  PostingDate,
  MaterialBaseUnit,
  CostEstimate

