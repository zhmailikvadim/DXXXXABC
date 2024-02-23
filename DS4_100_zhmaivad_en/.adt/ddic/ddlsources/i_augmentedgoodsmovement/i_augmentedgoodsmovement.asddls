@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'IAUGMGOODSMVMT'
@EndUserText.label: 'Augmented view of Goods Movement'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass:#TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM.private: false
@VDM.viewType: #COMPOSITE

define view I_AugmentedGoodsMovement 
as select from I_GoodsMovementDocument
// Associations required for authorization checks
left outer to one join I_StorageLocation as _AuthStorageLocation on I_GoodsMovementDocument.Plant = _AuthStorageLocation.Plant
                                                                and I_GoodsMovementDocument.StorageLocation = _AuthStorageLocation.StorageLocation
                                                                and _AuthStorageLocation.IsStorLocAuthznCheckActive = 'X'
left outer to one join I_StorageLocation as _AuthStorageLocationTr on IssuingOrReceivingPlant = _AuthStorageLocationTr.Plant
                                                                  and IssuingOrReceivingStorageLoc = _AuthStorageLocationTr.StorageLocation
                                                                  and _AuthStorageLocationTr.IsStorLocAuthznCheckActive = 'X'
                                                                  
{
      @Semantics.calendar.year: true
  key MaterialDocumentYear,
  key MaterialDocument,
  key MaterialDocumentItem,
  key MaterialDocumentRecordType,

      I_GoodsMovementDocument.Plant,
      I_GoodsMovementDocument.StorageLocation,
      Material,
      Batch,
      InventorySpecialStockType,
      InventoryStockType,
      StockOwner,
      CompanyCode,
      InventorySpecialStockValnType,
      @Semantics.currencyCode: true
      CompanyCodeCurrency,
      @Semantics.unitOfMeasure: true
      MaterialBaseUnit,
      IsReversalMovementType,
      
      // Stock Transfers
      IssuingOrReceivingPlant,
      IssuingOrReceivingStorageLoc,
      IssgOrRcvgMaterial,
      IssgOrRcvgBatch,
      IssgOrRcvgSpclStockInd,
      IssuingOrReceivingStockType,
      
      ResourceID,
      IssgOrRcvgResourceID,
      
      // Cancellation information
      GoodsMovementIsCancelled,
      
      // Periods & Times
      @Semantics.businessDate.at: true
      DocumentDate,
      @Semantics.businessDate.createdAt: true
      PostingDate,
      @Semantics.fiscal.yearVariant: true
      FiscalYearVariant,
      FiscalYear,
      @Semantics.fiscal.yearPeriod: true
      FiscalYearPeriod,
      YearDay,
      @Semantics.calendar.yearWeek: true
      YearWeek,
      @Semantics.calendar.yearMonth: true
      YearMonth,
      @Semantics.calendar.yearQuarter: true
      YearQuarter,
      @Semantics.calendar.quarter: true
      CalendarQuarter,
      @Semantics.calendar.month: true
      CalendarMonth,
      @Semantics.calendar.week: true
      CalendarWeek,
      @Semantics.calendar.dayOfYear: true
      CalendarDay,
      WeekDay,      
      
      // Reference Documents
      SalesOrder,
      SalesOrderItem,
      SalesOrderScheduleLine,
      PurchaseOrder,
      PurchaseOrderItem,
      DeliveryDocument,
      DeliveryDocumentItem,
      WBSElementInternalID,
      ManufacturingOrder,
      ManufacturingOrderItem,
      
      // Other
      GoodsMovementType,
      GoodsMovementReasonCode,
      InventoryValuationType,
      Supplier,
      Customer,
      
      AccountAssignmentCategory,
      CostObject,
      CostCenter,
      ControllingArea, // required to fulfill requirement to expose the full key (for cost center association)
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'ProfitabilitySegment_2'
      ProfitabilitySegment,
      ProfitabilitySegment_2,

      ProfitCenter,
      GLAccount,
      FunctionalArea,
      
      // Amounts
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      case when GoodsMovementStkAmtInCCCrcy <> 0 then
      cast(GoodsMovementStkAmtInCCCrcy as nsdm_stk_chg_amount preserving type) end as GoodsMovementStkAmtInCCCrcy,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      case when GoodsMvtCnsmpnAmtInCCCrcy <> 0 then
      cast(GoodsMvtCnsmpnAmtInCCCrcy as nsdm_cons_amount preserving type) end as GoodsMvtCnsmpnAmtInCCCrcy,
      
      // Quantities
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      case when MatlStkChangeQtyInBaseUnit <> 0 then
      cast(MatlStkChangeQtyInBaseUnit as nsdm_stk_chg_qty preserving type) end as MatlStkChangeQtyInBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      case when MatlCnsmpnQtyInMatlBaseUnit <> 0 then
      cast(MatlCnsmpnQtyInMatlBaseUnit as nsdm_cons_qty preserving type) end as MatlCnsmpnQtyInMatlBaseUnit,

      
      // Classifications
      @ObjectModel.foreignKey.association: '_StockChangeCategory'
      StockChangeCategory,
      IsEffectiveGoodsMovement,
      IsConsumptionMovement,
      IsCrossPlantTransfer,
      IsStorageLocChangeByTransf,
      IsMaterialChangeByTransf,
      IsBatchChangeByTransf,
      IsSpclStkTypeChangeByTransf,
      IsStockTypeChangeByTransf,
      
      // Derived Count Key Figures
      cast ( 1 as nsdm_number_of_gds_mvt) as NumberOfGoodsMovements,
      
      cast ( case when StockChangeCategory = 'GI' then 1
                  else 0
      end as nsdm_number_of_gi_mvt ) as NumberOfGoodsIssues,
      
      cast ( case when StockChangeCategory = 'GR' then 1
           else 0
      end as nsdm_number_of_gr_mvt ) as NumberOfGoodsReceipts,
      
      cast ( case when IsReversalMovementType = 'X' then 1
           else 0
      end as nsdm_number_of_rev_mvt ) as NumberOfReversalMovements,
      
      // Derived Quantity Key Figures
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      cast ( case when IsEffectiveGoodsMovement = 'X' and IsConsumptionMovement = 'X' then MatlCnsmpnQtyInMatlBaseUnit
      end as nsdm_effctv_cons_qty preserving type) as EffectiveCnsmpnQtyInBaseUnit,
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      cast ( case when IsEffectiveGoodsMovement = 'X' and StockChangeCategory = 'GI' then 
        case when MatlStkChangeQtyInBaseUnit < 0  then MatlStkChangeQtyInBaseUnit * -1 else MatlStkChangeQtyInBaseUnit end
      end as nsdm_effctv_gi_qty preserving type) as EffctvGdsIssueQtyInBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      cast ( case when StockChangeCategory = 'GI' then MatlStkChangeQtyInBaseUnit * -1
        -- case when MatlStkChangeQtyInBaseUnit < 0  then MatlStkChangeQtyInBaseUnit * -1 else MatlStkChangeQtyInBaseUnit end
      end as nsdm_gi_qty preserving type) as GoodsIssueQtyInBaseUnit,
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      cast ( case when IsEffectiveGoodsMovement = 'X' and StockChangeCategory = 'GR' then 
        case when MatlStkChangeQtyInBaseUnit < 0  then MatlStkChangeQtyInBaseUnit * -1 else MatlStkChangeQtyInBaseUnit end
      end as nsdm_effctv_gr_qty preserving type) as EffctvGdsReceiptQtyInBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      cast ( case when StockChangeCategory = 'GR' then MatlStkChangeQtyInBaseUnit
        -- case when MatlStkChangeQtyInBaseUnit < 0  then MatlStkChangeQtyInBaseUnit * -1 else MatlStkChangeQtyInBaseUnit end
      end as nsdm_gr_qty preserving type) as GoodsReceiptQtyInBaseUnit,
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      cast ( case when StockChangeCategory = 'GI' 
           then MatlStkChangeQtyInBaseUnit * -1 -- case when MatlStkChangeQtyInBaseUnit < 0  then MatlStkChangeQtyInBaseUnit * -1 else MatlStkChangeQtyInBaseUnit end
           else case when StockChangeCategory = 'GR' 
           then MatlStkChangeQtyInBaseUnit end --case when MatlStkChangeQtyInBaseUnit < 0  then MatlStkChangeQtyInBaseUnit * -1 else MatlStkChangeQtyInBaseUnit end end
      end as nsdm_gds_mvt_qty preserving type) as TotalGdsMvtQtyInBaseUnit,
      
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      cast( case when StockChangeCategory = 'GR' then GoodsMovementStkAmtInCCCrcy end
        as nsdm_gr_amount preserving type) as GoodsReceiptAmountInCoCodeCrcy,      
      
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      cast( case when StockChangeCategory = 'GI' then GoodsMovementStkAmtInCCCrcy * -1 end
        as nsdm_gi_amount) as GoodsIssueAmountInCoCodeCrcy,   
    
    // Authorization relevant fields
    _AuthStorageLocation.IsStorLocAuthznCheckActive as IsStorLocAuthznCheckActive,
    _AuthStorageLocationTr.IsStorLocAuthznCheckActive as IsIssgOrRcvgStorLocAuthChkActv,
    
    // Associations
    I_GoodsMovementDocument._Plant,
    I_GoodsMovementDocument._StorageLocation,
    _Material,
    _InventorySpecialStockType,
    _InventoryStockType,
    _BPStockOwner,
    _IssgOrRcvgMaterial,
    _IssuingOrReceivingPlant,
    _IssuingOrReceivingStorageLoc,
    _IssgOrRcvgSpclStockInd,
    _IssuingOrReceivingStockType,
    _CostCenter,
    _ControllingArea,
    _AccountAssignmentCategory,
    _ProfitCenter,
    _GLAccount,
    _FunctionalArea,              

    _GoodsMovementType,
    _GoodsMovementReasonCode,
    _InventoryValuationType,
    _CompanyCode,
    _SalesOrder,
    _SalesOrderItem,
    _SalesOrderScheduleLine,
    _PurchaseOrder,
    _PurchaseOrderItem,
    _DeliveryDocument,
    _DeliveryDocumentItem,
    _MfgOrder,
    _MfgOrderItem,
    _Supplier,
    _Customer,
    _SupplierCompanyByPlant,
    _CustomerCompanyByPlant,
    _Currency,
    _MaterialBaseUnit,
    _StockChangeCategory,
    _ResourceBasic,
    _IssgOrRcvgResourceBasic      
}

