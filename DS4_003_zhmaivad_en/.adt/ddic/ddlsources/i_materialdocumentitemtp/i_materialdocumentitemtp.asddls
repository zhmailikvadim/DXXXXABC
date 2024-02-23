@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Documentitem Interface - TP'
@ObjectModel.usageType: {
    serviceQuality: #C, 
    sizeCategory  : #XXL, 
    dataClass     : #TRANSACTIONAL }

@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #TRANSACTIONAL
@ObjectModel.supportedCapabilities: [#TRANSACTIONAL_PROVIDER]
@ObjectModel.modelingPattern: #TRANSACTIONAL_PROJECTED_ENTITY
@Metadata.ignorePropagatedAnnotations: true
define view entity I_MaterialDocumentItemTP 
as projection on R_MaterialDocumentItemTP as _MaterialDocumentItem {
  key MaterialDocumentYear,
  key MaterialDocument,
  key MaterialDocumentItem,
  
      MaterialDocumentLine,
      MaterialDocumentParentLine,
//      HierarchyNodeLevel, //todo: check if needed, ATC
      
      GoodsMovementType,
      Material,
      Plant,
      StorageLocation,
//      StorageType, todo: check old wm still supported
//      StorageBin,  todo: check old wm still supported
      InventoryUsabilityCode,
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      QuantityInEntryUnit,// todo: check if they can differ
      EntryUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      QuantityInBaseUnit,//todo: check if they can differ
      MaterialBaseUnit,
      Batch,
      ShelfLifeExpirationDate,
      ManufactureDate,
      InventorySpecialStockType,
//      InventoryStockType,  todo: check if needed
      Customer,
      Supplier,
      
      IssgOrRcvgMaterial,
      IssuingOrReceivingPlant,
      IssuingOrReceivingStorageLoc,
      IssgOrRcvgBatch,
      IssgOrRcvgSpclStockInd,
      IssuingOrReceivingValType,
//      IssgOrRcvgStockSegment,
      
      WBSElementInternalID,
      Reservation,
      ReservationItem,

      GoodsMovementRefDocType, // todo: check if can be determined based on goodsmvtcode
      GoodsMovementReasonCode,

      PurchaseOrder,
      PurchaseOrderItem,
      IsCompletelyDelivered,  
      
      SerialNumbersAreCreatedAutomly,
      
      CostCenter,
      GLAccount,
//      CostObject, // todo: check if needed
      

//      ProfitabilitySegment, ATC
      ProfitCenter,
      
//      BusinessArea,
      
      SalesOrder,
      SalesOrderItem,
      SalesOrderScheduleLine,
      
//      ReferenceDocumentFiscalYear,
//      InvtryMgmtRefDocumentItem,
//      InvtryMgmtReferenceDocument, //todo: check if needed (avilable in bapi and odata, usage unclear)
      
      DeliveryDocument,
      DeliveryDocumentItem,
      
      GoodsRecipientName,
      
      UnloadingPointName,
      
      ReservationIsFinallyIssued,
      
      ManufacturingOrder,
      ManufacturingOrderItem,
      
      SpecialStockIdfgSalesOrder,
      SpecialStockIdfgSalesOrderItem,
      
      MaterialDocumentItemText,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      GdsMvtExtAmtInCoCodeCrcy,
      ProductStandardID,
//      StockSegment,
      CompanyCodeCurrency,
      
     _MaterialDocumentHeader : redirected to parent I_MaterialDocumentTP,
     _SerialNumber : redirected to composition child I_MaterialDocItemSerialNoTP
}
