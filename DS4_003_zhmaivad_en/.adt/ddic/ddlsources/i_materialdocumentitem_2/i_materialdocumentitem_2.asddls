@AbapCatalog: {
                sqlViewName: 'IMATDOCITEM2',
                preserveKey: true,
                compiler.compareFilter: true
              }
@EndUserText.label: 'Material Document Item'

@AccessControl: {
                   authorizationCheck: #CHECK,
                   personalData.blocking: #NOT_REQUIRED
                }
                
@ClientHandling.algorithm: #SESSION_VARIABLE

@ObjectModel: {
                usageType: {
                             sizeCategory: #XXL,
                             serviceQuality: #C,
                             dataClass:#TRANSACTIONAL
                           },
                representativeKey: 'MaterialDocumentItem',
                semanticKey: ['MaterialDocumentYear', 'MaterialDocument', 'MaterialDocumentItem'],
                modelingPattern: #ANALYTICAL_DIMENSION,
                supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE]
} 

@Search.searchable: true

@VDM: {
        viewType: #COMPOSITE,
        lifecycle.contract.type: #PUBLIC_LOCAL_API
      }
      
@Analytics: {
               dataCategory: #DIMENSION,
               internalName:#LOCAL
             }
             
@Metadata: {
             ignorePropagatedAnnotations: true,
             allowExtensions: true
           }

-- This view is the successor view for the view I_MaterialDocumentItem
define view I_MaterialDocumentItem_2
  as select from I_MaterialDocumentRecord
  association [1..1] to I_MaterialDocumentYear   as _MaterialDocumentYear   on  $projection.MaterialDocumentYear         = _MaterialDocumentYear.MaterialDocumentYear
  association [1..1] to I_MaterialDocumentHeader_2 as _MaterialDocumentHeader on  $projection.MaterialDocumentYear         = _MaterialDocumentHeader.MaterialDocumentYear
                                                                            and $projection.MaterialDocument             = _MaterialDocumentHeader.MaterialDocument
  association [0..1] to I_MaterialDocumentHeader_2 as _ReversedMatDoc         on  $projection.ReversedMaterialDocumentYear = _ReversedMatDoc.MaterialDocumentYear
                                                                            and $projection.ReversedMaterialDocument     = _ReversedMatDoc.MaterialDocument
  association [0..1] to I_MaterialDocumentItem_2  as _ReversedMatDocItem     on  $projection.ReversedMaterialDocumentYear = _ReversedMatDocItem.MaterialDocumentYear
                                                                            and $projection.ReversedMaterialDocument     = _ReversedMatDocItem.MaterialDocument
                                                                            and $projection.ReversedMaterialDocumentItem = _ReversedMatDocItem.MaterialDocumentItem
{
      @ObjectModel.foreignKey.association: '_MaterialDocumentYear'
  key MaterialDocumentYear,
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
               }
      @ObjectModel.foreignKey.association: '_MaterialDocumentHeader'
  key MaterialDocument,
  key MaterialDocumentItem,

      @Search: {
                    defaultSearchElement: true,                    
                    fuzzinessThreshold: 0.7,
                    ranking: #HIGH
               }
      Material,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
               }
      Plant,
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
               }
      StorageLocation,
      StorageType,
      StorageBin,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      Batch,
      ShelfLifeExpirationDate,
      ManufactureDate,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      Supplier,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      SalesOrder,
      SalesOrderItem,
      SalesOrderScheduleLine,      

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }

// casting of the WBSElementInternalID to a NSDM data element to get rid of the conversion exit behind the original data element MAT_PSPNR
// required for the Reservation RAP object which does associate this view
      cast(WBSElementInternalID as nsdm_wbselement_internal_id preserving type) as WBSElementInternalID,
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      Customer,
      InventorySpecialStockType,
      InventoryStockType,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      StockOwner,

      GoodsMovementType,
      DebitCreditCode,
      InventoryUsabilityCode,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #SUM
      QuantityInBaseUnit,
      @Semantics.unitOfMeasure: true
      MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      @DefaultAggregation: #SUM
      QuantityInEntryUnit,
      @Semantics.unitOfMeasure: true
      EntryUnit,

      @Semantics.businessDate.at: true
      PostingDate,
      @Semantics.businessDate.at: true
      DocumentDate,
      
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      TotalGoodsMvtAmtInCCCrcy,
      @Semantics.currencyCode: true
      CompanyCodeCurrency,

      InventoryValuationType,
      ReservationIsFinallyIssued,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
                }
      PurchaseOrder,
      PurchaseOrderItem,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      ProjectNetwork,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      OrderID,
      OrderItem,
      
      MaintOrderRoutingNumber,
      MaintOrderOperationCounter,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      Reservation,
      ReservationItem,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      DeliveryDocument,
      DeliveryDocumentItem,

      ReversedMaterialDocumentYear,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      ReversedMaterialDocument,
      ReversedMaterialDocumentItem,

      RvslOfGoodsReceiptIsAllowed,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.7,
                    ranking: #MEDIUM
               }
      GoodsRecipientName,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.7,
                    ranking: #MEDIUM
               }
      UnloadingPointName,
      CostCenter,
      GLAccount,

      ServicePerformer,
      PersonWorkAgreement,
      AccountAssignmentCategory,
      WorkItem,
      ServicesRenderedDate,

      IssgOrRcvgMaterial,
      IssuingOrReceivingPlant,
      IssuingOrReceivingStorageLoc,
      IssgOrRcvgBatch,
      IssgOrRcvgSpclStockInd,

      CompanyCode,
      BusinessArea,
      ControllingArea,
      @Semantics.fiscal.yearPeriod: true
      FiscalYearPeriod,
      @Semantics.fiscal.yearVariant: true
      FiscalYearVariant,

      GoodsMovementRefDocType,
      IsCompletelyDelivered,
      MaterialDocumentItemText,
      @Semantics.booleanIndicator 
      IsAutomaticallyCreated,
      
      @Consumption.hidden: true
      GoodsReceiptType,
      @Consumption.hidden: true
      ConsumptionPosting,
      
      @Consumption.hidden: true
      MultiAcctAssgmtOriglMatlDocItm,
      @Consumption.hidden: true
      MultipleAccountAssignmentCode,

      _MaterialDocumentYear,
      @ObjectModel.association.type:[#TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT]
      _MaterialDocumentHeader,

      _Material,
      _IssgOrRcvgMaterial,
      
      //search model
      _Plant,
      _IssuingOrReceivingPlant,
      _StorageLocation,
      _IssuingOrReceivingStorageLoc,

      _Supplier,
      _Customer,
      
      @Consumption.hidden: true
      _SupplierCompanyByPlant,
      @Consumption.hidden: true
      _CustomerCompanyByPlant,      
      
      _BPStockOwner,

      _InventorySpecialStockType,
      _IssgOrRcvgSpclStockInd,
      _InventoryStockType,
      _InventoryValuationType,

      _GoodsMovementType,
      _DebitCreditCode,
       @API.element.releaseState: #DEPRECATED
       @API.element.successor: '_StockType_2'
       @VDM.lifecycle.status: #DEPRECATED
       @VDM.lifecycle.successor: '_StockType_2'
      _StockType,
      _StockType_2,

      _MaterialBaseUnit,
      _EntryUnit,

      _GLAccount,
      _CostCenter,

      _BusinessPartner,
      _PersonWorkAgreement,
      _AccountAssignmentCategory,
      _WorkItem,

      _CompanyCode,
      _BusinessArea,
      _ControllingArea,

      _SalesOrder,
      _SalesOrderItem,
      _SalesOrderScheduleLine,
      _WBSElement,

      _PurchaseOrder,
      _PurchaseOrderItem,
      _ProjectNetwork,
      _LogisticsOrder,
      _DeliveryDocument,
      _DeliveryDocumentItem,

      _ReversedMatDoc,
      _ReversedMatDocItem,
      _GoodsMvtTypeBySpclStkIndT,
      _Currency

}
where
  MaterialDocumentRecordType = 'MDOC'                                                                                                                                                                        

