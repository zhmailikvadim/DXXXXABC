@AbapCatalog.sqlViewName: 'IMATDOCREC'
@EndUserText.label: 'Basis view for MATDOC table'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass:#TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM.private: false
@VDM.viewType: #BASIC

define view I_MaterialDocumentRecord
  as select from matdoc

  association [0..1] to I_Material                  as _Material                      on  $projection.Material = _Material.Material
  association [0..1] to I_Material                  as _StockIdentifyingMaterial      on  $projection.StockIdentifyingMaterial = _StockIdentifyingMaterial.Material
  association [0..1] to I_Material                  as _IssgOrRcvgMaterial            on  $projection.IssgOrRcvgMaterial = _IssgOrRcvgMaterial.Material

  association [0..1] to I_Plant                     as _Plant                         on  $projection.Plant = _Plant.Plant
  association [0..1] to I_Plant                     as _IssuingOrReceivingPlant       on  $projection.IssuingOrReceivingPlant = _IssuingOrReceivingPlant.Plant
  association [0..1] to I_StorageLocation           as _StorageLocation               on  $projection.StorageLocation = _StorageLocation.StorageLocation
                                                                                      and $projection.Plant           = _StorageLocation.Plant
  association [0..1] to I_StorageLocation           as _IssuingOrReceivingStorageLoc  on  $projection.IssuingOrReceivingStorageLoc = _IssuingOrReceivingStorageLoc.StorageLocation
                                                                                      and $projection.IssuingOrReceivingPlant      = _IssuingOrReceivingStorageLoc.Plant
  association [0..1] to I_StorageLocation           as _StockIdfgStorageLocation      on  $projection.StockIdfgStorageLocation = _StockIdfgStorageLocation.StorageLocation
                                                                                      and $projection.Plant                    = _StockIdfgStorageLocation.Plant

  association [0..1] to I_Supplier                  as _Supplier                      on  $projection.Supplier = _Supplier.Supplier
  association [0..1] to I_Supplier                  as _SpecialStockIdfgSupplier      on  $projection.SpecialStockIdfgSupplier = _SpecialStockIdfgSupplier.Supplier

  association [0..1] to I_Customer                  as _Customer                      on  $projection.Customer = _Customer.Customer
  association [0..1] to I_Customer                  as _SpecialStockIdfgCustomer      on  $projection.SpecialStockIdfgCustomer = _SpecialStockIdfgCustomer.Customer

  association [0..1] to I_Supplier                  as _BPStockOwner                  on  $projection.StockOwner = _BPStockOwner.Supplier
  association [0..1] to I_Supplier                  as _SpecialStockIdfgStockOwner    on  $projection.SpecialStockIdfgStockOwner = _SpecialStockIdfgStockOwner.Supplier

  association [0..1] to I_InventorySpecialStockType as _InventorySpecialStockType     on  $projection.InventorySpecialStockType = _InventorySpecialStockType.InventorySpecialStockType
  association [0..1] to I_InventorySpecialStockType as _IssgOrRcvgSpclStockInd        on  $projection.IssgOrRcvgSpclStockInd = _IssgOrRcvgSpclStockInd.InventorySpecialStockType
  association [0..1] to I_InventoryStockType        as _InventoryStockType            on  $projection.InventoryStockType = _InventoryStockType.InventoryStockType
  association [0..1] to I_InventoryStockType        as _IssuingOrReceivingStockType   on  $projection.IssuingOrReceivingStockType = _IssuingOrReceivingStockType.InventoryStockType
  association [0..1] to I_InventoryValuationType    as _InventoryValuationType        on  $projection.InventoryValuationType = _InventoryValuationType.InventoryValuationType

  association [0..1] to I_GoodsMovementType         as _GoodsMovementType             on  $projection.GoodsMovementType = _GoodsMovementType.GoodsMovementType
  association [0..1] to I_DebitCreditCode           as _DebitCreditCode               on  $projection.DebitCreditCode = _DebitCreditCode.DebitCreditCode
  association [0..1] to I_StockType                 as _StockType                     on  $projection.InventoryUsabilityCode = _StockType.StockType

  association [0..1] to I_UnitOfMeasure             as _MaterialBaseUnit              on  $projection.MaterialBaseUnit = _MaterialBaseUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure             as _EntryUnit                     on  $projection.EntryUnit = _EntryUnit.UnitOfMeasure

  association [0..1] to I_GLAccount                 as _GLAccount                     on  $projection.GLAccount   = _GLAccount.GLAccount
                                                                                      and $projection.CompanyCode = _GLAccount.CompanyCode

  association [0..*] to I_CostCenter                as _CostCenter                    on  $projection.CostCenter      = _CostCenter.CostCenter
                                                                                      and $projection.ControllingArea = _CostCenter.ControllingArea
  --valid date range not included, multiple entries can be returned

  association [0..1] to I_BusinessPartner           as _BusinessPartner               on  $projection.ServicePerformer = _BusinessPartner.BusinessPartner
  association [0..*] to I_Employment                as _Employment                    on  $projection.EmploymentInternalID = _Employment.EmploymentInternalID
  association [0..1] to I_AccountAssignmentCategory as _AccountAssignmentCategory     on  $projection.AccountAssignmentCategory = _AccountAssignmentCategory.AccountAssignmentCategory
  association [0..1] to I_WorkItem                  as _WorkItem                      on  $projection.WorkItem = _WorkItem.WorkItem

  association [0..1] to I_CompanyCode               as _CompanyCode                   on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_BusinessArea              as _BusinessArea                  on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [0..1] to I_ControllingArea           as _ControllingArea               on  $projection.ControllingArea = _ControllingArea.ControllingArea

  association [0..1] to I_SalesOrder                as _SalesOrder                    on  $projection.SalesOrder = _SalesOrder.SalesOrder
  association [0..1] to I_SalesOrder                as _SpecialStockIdfgSalesOrder    on  $projection.SpecialStockIdfgSalesOrder = _SpecialStockIdfgSalesOrder.SalesOrder

  association [0..1] to I_SalesOrderItem            as _SalesOrderItem                on  $projection.SalesOrder     = _SalesOrderItem.SalesOrder
                                                                                      and $projection.SalesOrderItem = _SalesOrderItem.SalesOrderItem
  association [0..1] to I_SalesOrderItem            as _SpecialStockIdfgSalesOrderItm on  $projection.SpecialStockIdfgSalesOrder     = _SpecialStockIdfgSalesOrderItm.SalesOrder
                                                                                      and $projection.SpecialStockIdfgSalesOrderItem = _SpecialStockIdfgSalesOrderItm.SalesOrderItem
  association [0..1] to I_SalesOrderScheduleLine    as _SalesOrderScheduleLine        on  $projection.SalesOrder     = _SalesOrderScheduleLine.SalesOrder
                                                                                      and $projection.SalesOrderItem = _SalesOrderScheduleLine.SalesOrderItem
                                                                                      and $projection.SalesOrderScheduleLine = _SalesOrderScheduleLine.ScheduleLine

  association [0..1] to I_WBSElementByInternalKey   as _SpecialStockIdfgWBSElement    on  $projection.SpecialStockIdfgWBSElement = _SpecialStockIdfgWBSElement.WBSElementInternalID
  association [0..1] to I_WBSElementByInternalKey   as _WBSElement                    on  $projection.WBSElementInternalID = _WBSElement.WBSElementInternalID


  association [0..1] to I_PurchaseOrder             as _PurchaseOrder                 on  $projection.PurchaseOrder = _PurchaseOrder.PurchaseOrder
  association [0..1] to I_PurchaseOrderItem         as _PurchaseOrderItem             on  $projection.PurchaseOrder     = _PurchaseOrderItem.PurchaseOrder
                                                                                      and $projection.PurchaseOrderItem = _PurchaseOrderItem.PurchaseOrderItem
  association [0..1] to I_ProjectNetwork            as _ProjectNetwork                on  $projection.ProjectNetwork = _ProjectNetwork.ProjectNetwork
  association [0..1] to I_MfgOrder                  as _MfgOrder                      on  $projection.ManufacturingOrder = _MfgOrder.ManufacturingOrder
  association [0..1] to I_MfgOrderItem              as _MfgOrderItem                  on  $projection.ManufacturingOrder     = _MfgOrderItem.ManufacturingOrder
                                                                                      and $projection.ManufacturingOrderItem = _MfgOrderItem.ManufacturingOrderItem
  association [0..1] to I_DeliveryDocument          as _DeliveryDocument              on  $projection.DeliveryDocument = _DeliveryDocument.DeliveryDocument
  association [0..1] to I_DeliveryDocumentItem      as _DeliveryDocumentItem          on  $projection.DeliveryDocument     = _DeliveryDocumentItem.DeliveryDocument
                                                                                      and $projection.DeliveryDocumentItem = _DeliveryDocumentItem.DeliveryDocumentItem
  association [0..1] to I_DeliveryDocument          as _DeliveryInMatlDocumentHeader  on  $projection.DeliveryInMatlDocumentHeader = _DeliveryInMatlDocumentHeader.DeliveryDocument

  association [0..1] to I_User                      as _User                          on  $projection.CreatedByUser = _User.UserID
  association [0..1] to I_AccountingDocumentType    as _AccountingDocumentType        on  $projection.AccountingDocumentType = _AccountingDocumentType.AccountingDocumentType
  association [0..1] to I_InventoryTransactionType  as _InventoryTransactionType      on  $projection.InventoryTransactionType = _InventoryTransactionType.InventoryTransactionType
                                                                                      and _InventoryTransactionType.IsMaterialDocumentRelevant = 'X'
  association [0..1] to I_Currency                  as _Currency                      on  $projection.CompanyCodeCurrency = _Currency.Currency
{
  mjahr             as MaterialDocumentYear,
  mblnr             as MaterialDocument,
  zeile             as MaterialDocumentItem,

  matbf             as StockIdentifyingMaterial,
  werks             as Plant,
  lgort_sid         as StockIdfgStorageLocation,
  charg_sid         as StockIdentifyingBatch,
  lifnr_sid         as SpecialStockIdfgSupplier,
  mat_kdauf         as SpecialStockIdfgSalesOrder,
  mat_kdpos         as SpecialStockIdfgSalesOrderItem,
  mat_pspnr         as SpecialStockIdfgWBSElement,
  kunnr_sid         as SpecialStockIdfgCustomer,
  sobkz             as InventorySpecialStockType,
  lbbsa_sid         as InventoryStockType,
  disub_owner_sid   as SpecialStockIdfgStockOwner,

  -- with records of type MDOC_CP, AG_MDOC_CF etc there is no unique key except the technical GUID key, so we don't use any key fields at all

  matnr             as Material,
  lgort             as StorageLocation,
  charg             as Batch,
  lifnr             as Supplier,
  kdauf             as SalesOrder,
  kdpos             as SalesOrderItem,
  kdein             as SalesOrderScheduleLine,
  kunnr             as Customer,
  disub_owner       as StockOwner,
  ps_psp_pnr        as WBSElementInternalID,

  ummat             as IssgOrRcvgMaterial,
  umwrk             as IssuingOrReceivingPlant,
  umlgo             as IssuingOrReceivingStorageLoc,
  umcha             as IssgOrRcvgBatch,
  umsok             as IssgOrRcvgSpclStockInd,
  lbbsa_cid         as IssuingOrReceivingStockType,

  bwart             as GoodsMovementType,
  shkzg             as DebitCreditCode,
  insmk             as InventoryUsabilityCode,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  @DefaultAggregation: #NONE
  menge             as QuantityInBaseUnit,
  @Semantics.unitOfMeasure: true
  meins             as MaterialBaseUnit,

  @DefaultAggregation:#NONE
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  stock_qty         as MatlStkChangeQtyInBaseUnit,

  @DefaultAggregation:#NONE
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  consumption_qty   as MatlCnsmpnQtyInMatlBaseUnit,

  @Semantics.businessDate.at: true
  bldat             as DocumentDate,
  blart             as AccountingDocumentType,
  vgart             as InventoryTransactionType,
  cast ( kzbws as inventoryspecialstockvalntype preserving type ) as InventorySpecialStockValnType,

  usnam             as CreatedByUser,
  bktxt             as MaterialDocumentHeaderText,
  le_vbeln          as DeliveryInMatlDocumentHeader,
  frbnr             as BillOfLading,

  @Semantics.quantity.unitOfMeasure: 'EntryUnit'
  @DefaultAggregation: #NONE
  erfmg             as QuantityInEntryUnit,
  @Semantics.unitOfMeasure: true
  erfme             as EntryUnit,
  bwtar             as InventoryValuationType,
  kzear             as ReservationIsFinallyIssued,

  ebeln             as PurchaseOrder,
  ebelp             as PurchaseOrderItem,
  nplnr             as ProjectNetwork,
  aufnr             as ManufacturingOrder,
  aufps             as ManufacturingOrderItem,
  rsnum             as Reservation,
  rspos             as ReservationItem,
  vbeln_im          as DeliveryDocument,
  vbelp_im          as DeliveryDocumentItem,

  sjahr             as ReversedMaterialDocumentYear,
  smbln             as ReversedMaterialDocument,
  smblp             as ReversedMaterialDocumentItem,
  xwsbr             as RvslOfGoodsReceiptIsAllowed,
  reversal_movement as IsReversalMovementType,
  cancelled         as GoodsMovementIsCancelled,
  cancellation_type as GoodsMovementCancellationType,

  wempf             as GoodsRecipientName,
  ablad             as UnloadingPointName,
  kostl             as CostCenter,
  sakto             as GLAccount,

  serviceperformer  as ServicePerformer,
  pernr             as EmploymentInternalID,
  knttp_gr          as AccountAssignmentCategory,
  work_item_id      as WorkItem,
  fbuda             as ServicesRenderedDate,

  bukrs             as CompanyCode,
  gsber             as BusinessArea,
  kokrs             as ControllingArea,
  @Semantics.businessDate.createdAt: true
  budat             as PostingDate,
  @Semantics.fiscal.yearPeriod: true
  gjper             as FiscalYearPeriod,
  @Semantics.fiscal.yearVariant: true
  periv             as FiscalYearVariant,

  yearday_budat     as YearDay,
  @Semantics.calendar.yearWeek: true
  yearweek_budat    as YearWeek,
  @Semantics.calendar.yearMonth: true
  yearmonth_budat   as YearMonth,
  @Semantics.calendar.yearQuarter: true
  yearquarter_budat as YearQuarter,
  @Semantics.calendar.year: true
  year_budat        as DocumentYear,
  @Semantics.calendar.quarter: true
  quarter_budat     as CalendarQuarter,
  @Semantics.calendar.month: true
  month_budat       as CalendarMonth,
  @Semantics.calendar.week: true
  week_budat        as CalendarWeek,
  @Semantics.calendar.dayOfYear: true
  day_budat         as CalendarDay,
  weekday_budat     as WeekDay,
  gjahr             as FiscalYear,
  gjper_curr_per    as YearPeriod,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @DefaultAggregation: #NONE
  dmbtr             as TotalGoodsMvtAmtInCCCrcy,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @DefaultAggregation: #NONE
  dmbtr_stock       as GoodsMovementStkAmtInCCCrcy,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @DefaultAggregation: #NONE
  dmbtr_cons        as GoodsMvtCnsmpnAmtInCCCrcy,
  @Semantics.currencyCode: true
  waers             as CompanyCodeCurrency,

  @Consumption.hidden: true
  record_type       as MaterialDocumentRecordType,
  @Consumption.hidden: true
  header_counter    as IsMaterialDocumentHeader,

  _Material,
  _StockIdentifyingMaterial,
  _IssgOrRcvgMaterial,
  _Plant,
  _IssuingOrReceivingPlant,
  _StorageLocation,
  _IssuingOrReceivingStorageLoc,
  _StockIdfgStorageLocation,

  _Supplier,
  _SpecialStockIdfgSupplier,

  _Customer,
  _SpecialStockIdfgCustomer,

  _BPStockOwner,
  _SpecialStockIdfgStockOwner,

  _InventorySpecialStockType,
  _IssgOrRcvgSpclStockInd,
  _InventoryStockType,
  _IssuingOrReceivingStockType,
  _InventoryValuationType,

  _GoodsMovementType,
  _DebitCreditCode,
  _StockType,

  _MaterialBaseUnit,
  _EntryUnit,

  _GLAccount,
  _CostCenter,

  _BusinessPartner,
  _Employment,
  _AccountAssignmentCategory,
  _WorkItem,

  _CompanyCode,
  _BusinessArea,
  _ControllingArea,

  _SalesOrder,
  _SpecialStockIdfgSalesOrder,

  _SalesOrderItem,
  _SpecialStockIdfgSalesOrderItm,

  _SalesOrderScheduleLine,

  _WBSElement,
  _SpecialStockIdfgWBSElement,

  _PurchaseOrder,
  _PurchaseOrderItem,
  _ProjectNetwork,
  _MfgOrder,
  _MfgOrderItem,
  _DeliveryDocument,
  _DeliveryDocumentItem,
  _DeliveryInMatlDocumentHeader,

  _User,
  _AccountingDocumentType,
  _InventoryTransactionType,
  _Currency
}
























