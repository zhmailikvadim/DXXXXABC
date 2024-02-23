// Product Valuation  Basic
@AbapCatalog.sqlViewName: 'IPRDVALBASIC'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Valuation'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.sizeCategory: #XL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true
@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #EXTRACTION_DATA_SOURCE ]


@Analytics:{
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        mapping:
        [ { table: 'MBEW',
            role: #MAIN,
            viewElement: ['Product','ValuationArea','ValuationType'],
            tableElement: ['MATNR','BWKEY','BWTAR'] },

          { table: 'T001K',
            role: #LEFT_OUTER_TO_ONE_JOIN,
            viewElement: ['ValuationArea'],
            tableElement: ['BWKEY']
          },

          { table: 'MARV',
            role: #LEFT_OUTER_TO_ONE_JOIN,
            viewElement: ['CompanyCode'],
            tableElement: ['BUKRS']
          },

          { table: 'T001',
            role: #LEFT_OUTER_TO_ONE_JOIN,
            viewElement: ['CompanyCode'],
            tableElement: ['BUKRS']
          },
          { table: 'MARA',
            role: #LEFT_OUTER_TO_ONE_JOIN,
            viewElement: ['Product'],
            tableElement: ['MATNR']

          }
       ]
    }
  }
}

define view I_ProductValuationBasic
  as select from P_ProductValuationBasic as Valuation
    inner join   t001k on Valuation.ValuationArea = t001k.bwkey
    inner join   marv  on marv.bukrs = t001k.bukrs
    inner join   t001  on t001.bukrs = t001k.bukrs


  association [1..1] to I_Product                   as _Product                   on  $projection.Product = _Product.Product

  association [0..1] to I_Prodvaluationclass        as _ValuationClass            on  $projection.ValuationClass = _ValuationClass.ValuationClass
  association [0..1] to I_Prodvaluationclass        as _ValnClassSalesOrderStock  on  $projection.ValuationClassSalesOrderStock = _ValnClassSalesOrderStock.ValuationClass
  association [0..1] to I_Prodvaluationclass        as _ValnClassProjectStock     on  $projection.ProjectStockValuationClass = _ValnClassProjectStock.ValuationClass
  association [0..1] to I_ProdValnPriceControl      as _InventoryValnProcedure    on  $projection.InventoryValuationProcedure = _InventoryValnProcedure.InventoryValuationProcedure
  association [0..1] to I_PriceDeterminationControl as _PriceDeterminationControl on  $projection.PriceDeterminationControl = _PriceDeterminationControl.PriceDeterminationControl
  association [0..1] to I_BR_MaterialUsage          as _BR_MaterialUsage          on  $projection.ProductUsageType = _BR_MaterialUsage.BR_MaterialUsage
  association [0..1] to I_BR_MaterialOrigin         as _BR_MaterialOrigin         on  $projection.ProductOriginType = _BR_MaterialOrigin.BR_MaterialOrigin

  association [0..1] to E_Productvaluation          as _ProdValuationExt          on  $projection.Product       = _ProdValuationExt.Product
                                                                                  and $projection.ValuationArea = _ProdValuationExt.ValuationArea
                                                                                  and $projection.ValuationType = _ProdValuationExt.ValuationType

  association [0..1] to I_InventoryValuationType    as _InventoryValuationType    on  $projection.ValuationType = _InventoryValuationType.InventoryValuationType
  association [1..1] to I_UnitOfMeasure             as _BaseUnitOfMeasure         on  $projection.baseunit = _BaseUnitOfMeasure.UnitOfMeasure

{
  key Valuation.Product,
  key Valuation.ValuationArea,
      @ObjectModel.foreignKey.association: '_InventoryValuationType'
  key Valuation.ValuationType,
      @ObjectModel.foreignKey.association: '_ValuationClass'
      @ObjectModel.sapObjectNodeTypeReference:'ProductValuationClass'
      Valuation.ValuationClass,
      @ObjectModel.foreignKey.association: '_PriceDeterminationControl'
      Valuation.PriceDeterminationControl,
      marv.lfmon                                      as FiscalMonthCurrentPeriod,
      marv.lfgja                                      as FiscalYearCurrentPeriod,
      @Semantics.amount.currencyCode: 'Currency'
      Valuation.StandardPrice,
      Valuation.PriceUnitQty,
      @ObjectModel.foreignKey.association: '_InventoryValnProcedure'
      @ObjectModel.sapObjectNodeTypeReference:'ProductPriceControl'
      Valuation.InventoryValuationProcedure,
      Valuation.FuturePriceValidityStartDate,
      @Semantics.amount.currencyCode: 'Currency'
      Valuation.PrevInvtryPriceInCoCodeCrcy,
      @Semantics.amount.currencyCode: 'Currency'
      Valuation.MovingAveragePrice,
      @ObjectModel.sapObjectNodeTypeReference:'ProductValuationCategory'
      Valuation.ValuationCategory,
      @ObjectModel.foreignKey.association: '_BR_MaterialUsage'
      Valuation.ProductUsageType,
      @ObjectModel.foreignKey.association: '_BR_MaterialOrigin'
      Valuation.ProductOriginType,
      Valuation.IsProducedInhouse,
      Valuation.ProdCostEstNumber,
      Valuation.IsMarkedForDeletion,
      //Retail field
      Valuation.ValuationMargin,
      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity, // to enbale extensibility in Draft 2.0

      //ML fields
      t001k.bukrs                                     as CompanyCode,
      @ObjectModel.foreignKey.association: '_ValnClassSalesOrderStock'
      @ObjectModel.sapObjectNodeTypeReference:'ProductValuationClass'
      Valuation.ValuationClassSalesOrderStock,
      @ObjectModel.foreignKey.association: '_ValnClassProjectStock'
      @ObjectModel.sapObjectNodeTypeReference:'ProductValuationClass'
      Valuation.ProjectStockValuationClass,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      Valuation.TaxBasedPricesPriceUnitQty,
      Valuation.PriceLastChangeDate,
      @Semantics.amount.currencyCode: 'Currency'
      Valuation.FuturePrice,
      Valuation.MaintenanceStatus,
      @Semantics.currencyCode: true
      t001.waers                                      as Currency,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnitOfMeasure'
      _Product.BaseUnit,
      Valuation.MLIsActiveAtProductLevel,
      _Product,
      _ValuationClass,
      _ValnClassSalesOrderStock,
      _ValnClassProjectStock,
      _InventoryValnProcedure,
      _PriceDeterminationControl,
      _BR_MaterialUsage,
      _BR_MaterialOrigin,
      _InventoryValuationType,
      _BaseUnitOfMeasure





}
