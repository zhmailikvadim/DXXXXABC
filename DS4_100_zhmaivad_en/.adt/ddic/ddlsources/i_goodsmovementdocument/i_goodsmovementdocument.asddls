@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'IGOODSMVMTDOC'
@EndUserText.label: 'Goods Movements'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass:#TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM.private: false
@VDM.viewType: #BASIC

define view I_GoodsMovementDocument 
  as select from I_MaterialDocumentRecord 
  association[1..1] to I_StockChangeCategory as _StockChangeCategory on $projection.StockChangeCategory = _StockChangeCategory.StockChangeCategory
  // The following associations are only required because of the CAST workaround below. Can be removed once MATDOC uses the correct data type.
  association [0..1] to I_Plant                     as _IssuingOrReceivingPlant       on  $projection.IssuingOrReceivingPlant = _IssuingOrReceivingPlant.Plant
  association [0..1] to I_InventorySpecialStockType as _IssgOrRcvgSpclStockInd        on  $projection.IssgOrRcvgSpclStockInd = _IssgOrRcvgSpclStockInd.InventorySpecialStockType
  association [0..1] to I_InventoryStockType        as _IssuingOrReceivingStockType   on  $projection.IssuingOrReceivingStockType = _IssuingOrReceivingStockType.InventoryStockType  
{
  
  @Semantics.calendar.year: true
  key MaterialDocumentYear,
  key MaterialDocument,
  key MaterialDocumentItem,
  key MaterialDocumentRecordType,
    
      Plant,
      StorageLocation,
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
      @Semantics.unitOfMeasure: true
      EntryUnit,
      IsReversalMovementType,
      MaterialDocumentPostingType,
      InventoryTransactionType,
      ConsumptionPosting,       //2908362
      GoodsReceiptType,         //2908362
      
      // Stock Transfers
      cast(IssuingOrReceivingPlant as nsdm_umwrk preserving type) as IssuingOrReceivingPlant, // remove cast once MATDOC data type is changed
      IssuingOrReceivingStorageLoc,
      IssgOrRcvgMaterial,
      IssgOrRcvgBatch,
      cast (IssgOrRcvgSpclStockInd as nsdm_umsok preserving type) as IssgOrRcvgSpclStockInd, // remove cast once MATDOC data type is changed
      cast (IssuingOrReceivingStockType as nsdm_lbbsa_cid preserving type) as IssuingOrReceivingStockType,
      IssuingOrReceivingValType,
      
      cast(ResourceID           as nsdm_resourcename          preserving type ) as ResourceID,
      cast(IssgOrRcvgResourceID as nsdm_transfer_resourcename preserving type ) as IssgOrRcvgResourceID,
      
      // Cancellation information
      GoodsMovementIsCancelled,
      ReversedMaterialDocument,
      ReversedMaterialDocumentItem,
      ReversedMaterialDocumentYear,
      
      // Periods & Times
      @Semantics.businessDate.at: true
      DocumentDate,
      AccountingDocumentType,
      CreationDate,
      CreationTime,
      
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
      cast(PurchaseOrderItem as nsdm_ebelp preserving type) as PurchaseOrderItem,
      ProjectNetwork,
      DeliveryDocument,
      cast(DeliveryDocumentItem as nsdm_posnr_vl preserving type) as DeliveryDocumentItem,
      WBSElementInternalID,
      ManufacturingOrder,
      ManufacturingOrderItem,
      SpecialStockIdfgSalesOrder,
      SpecialStockIdfgSalesOrderItem,
      SpecialStockIdfgWBSElement,
      ReferenceDocument,
      GoodsIssueOrReceiptSlipNumber,
      
      ReferenceDocumentFiscalYear,
      InvtryMgmtRefDocumentItem,
      InvtryMgmtReferenceDocument, 
      
      // Stock Type
      InventoryUsabilityCode,
 
      // EWM Data
      EWMWarehouse,
      EWMStorageBin,
      
      // Other
      GoodsMovementType,
      InventoryValuationType,
      CreatedByUser,
      Supplier,
      Customer,
      IsMaterialDocumentHeader,
      MaterialDocumentHeaderText,
      MaterialDocumentItemText,
      IsCompletelyDelivered,
      GoodsRecipientName,
      UnloadingPointName,
      GoodsMovementRefDocType,
      GoodsMovementReasonCode,
      ShelfLifeExpirationDate,
      ManufactureDate,
      SerialNumbersAreCreatedAutomly,
      VersionForPrintingSlip,
      ManualPrintIsTriggered,
      CtrlPostgForExtWhseMgmtSyst,     

      // Accounting information
      AccountAssignmentCategory,
      CostCenter,
      ControllingArea, // required to fulfill requirement to expose the full key (for cost center association)
      CostObject,
      GLAccount,
      FunctionalArea,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'ProfitabilitySegment_2'
      ProfitabilitySegment,
      ProfitabilitySegment_2,
      ProfitCenter,
      
      MasterFixedAsset,
      FixedAsset,
      FundsCenter,
      Fund,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'CommitmentItemShortID'      
      CommitmentItem,
      CommitmentItemShortID,
      GrantID,
      
      // Reservation
      Reservation,
      ReservationItem,
      ReservationIsFinallyIssued,
      
      DebitCreditCode,
      
      // Amounts
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      TotalGoodsMvtAmtInCCCrcy,      
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      GoodsMovementStkAmtInCCCrcy,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      GoodsMvtCnsmpnAmtInCCCrcy,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      GdsMvtExtAmtInCoCodeCrcy,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      SlsPrcAmtInclVATInCoCodeCrcy,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #NONE
      EnteredSlsAmtInCoCodeCrcy,
      
      // Quantities
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      MatlStkChangeQtyInBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      MatlCnsmpnQtyInMatlBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #NONE
      QuantityInBaseUnit,
      @DefaultAggregation: #NONE
      QuantityInEntryUnit,
      @DefaultAggregation: #NONE         //2813353 
      GoodsReceiptQtyInOrderUnit,        //2813353
      
      @Consumption.hidden: true
      TransactionCode,      
      @Consumption.hidden: true
      IsAutomaticallyCreated,
      @Consumption.hidden: true
      MaterialDocumentLine,
      @Consumption.hidden: true
      MaterialDocumentParentLine,
      @Consumption.hidden: true
      HierarchyNodeLevel,
  
      // Classifications
      @ObjectModel.foreignKey.association: '_StockChangeCategory'
      cast(case when MatlStkChangeQtyInBaseUnit > 0 and IsReversalMovementType = '' or
                MatlStkChangeQtyInBaseUnit < 0 and IsReversalMovementType = 'X'
        then 'GR' 
        else case 
           when MatlStkChangeQtyInBaseUnit < 0 and IsReversalMovementType = '' or
                MatlStkChangeQtyInBaseUnit > 0 and IsReversalMovementType = 'X'
           then 'GI'
           else '' end 
      end as nsdm_stock_change_category preserving type) as StockChangeCategory,

      cast( case when GoodsMovementIsCancelled <> 'X' and 
                      GoodsMovementCancellationType <> '2' and 
                      GoodsMovementCancellationType <> '3'
                 then 'X'
                 else ''
      end as nsdm_is_effective_goods_mvt preserving type) as IsEffectiveGoodsMovement,

      cast(case when MatlCnsmpnQtyInMatlBaseUnit > 0 and IsReversalMovementType = '' or
                MatlCnsmpnQtyInMatlBaseUnit < 0 and IsReversalMovementType = 'X'
        then 'X' 
        else '' 
      end as nsdm_is_consumption_mvt preserving type) as IsConsumptionMovement,

      cast(case when IssuingOrReceivingPlant <> '' and IssuingOrReceivingPlant <> Plant 
        then 'X' 
        else '' 
      end as nsdm_cross_plant_transfer preserving type) as IsCrossPlantTransfer,
      
      cast(case when IssuingOrReceivingPlant <> '' and IssuingOrReceivingStorageLoc <> StorageLocation
        then 'X'
        else ''
      end as nsdm_sloc_change_by_transfer preserving type) as IsStorageLocChangeByTransf,
      
      cast(case when IssuingOrReceivingPlant <> '' and IssgOrRcvgMaterial <> Material
        then 'X'
        else ''
      end as nsdm_material_change_by_trans preserving type) as IsMaterialChangeByTransf,
      
      cast(case when IssuingOrReceivingPlant <> '' and IssgOrRcvgBatch <> Batch
        then 'X'
        else ''
      end as nsdm_batch_change_by_transf preserving type) as IsBatchChangeByTransf,
      
      cast(case when IssuingOrReceivingPlant <> '' and IssgOrRcvgSpclStockInd <> InventorySpecialStockType
        then 'X'
        else ''
      end as nsdm_sobkz_change_by_transf preserving type) as IsSpclStkTypeChangeByTransf,
      
      cast(case when IssuingOrReceivingStockType <> '' and IssuingOrReceivingStockType <> InventoryStockType
        then 'X'
        else ''
      end as nsdm_lbbsa_change_by_transf preserving type) as IsStockTypeChangeByTransf,
    
    // Associations
    _Plant,
    _StorageLocation,
    _Material,
    _InventorySpecialStockType,
    _InventoryStockType,
    _Supplier,
    _Customer,
    @Consumption.hidden: true
    _SupplierCompanyByPlant,
    @Consumption.hidden: true
    _CustomerCompanyByPlant,
    _BPStockOwner,
    _IssgOrRcvgMaterial,
    _IssuingOrReceivingPlant,
    _IssuingOrReceivingStorageLoc,
    _IssgOrRcvgSpclStockInd,
    _IssuingOrReceivingStockType,
    _CostCenter,
    _ControllingArea,
    _AccountAssignmentCategory,
    _FunctionalArea,
    _ProfitCenter,
    _GLAccount,
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
    _WBSElement,
    _MfgOrder,      
    _MfgOrderItem,  
    _SpecialStockIdfgWBSElement,
    _Currency,
    _MaterialBaseUnit,
    _StockChangeCategory,
    _AccountingDocumentType,
    _ResourceBasic,
    _IssgOrRcvgResourceBasic      
}
where
     MaterialDocumentRecordType = 'MDOC'
  or MaterialDocumentRecordType = 'MDOC_CP'
  

