@AbapCatalog: {
                sqlViewName: 'IMATDOCREC',
                preserveKey: true,
                compiler.compareFilter: true
              }
@EndUserText.label: 'Basis view for MATDOC table'
@AccessControl: {
                  authorizationCheck: #CHECK,
                  personalData.blocking: #BLOCKED_DATA_EXCLUDED
                }
@ObjectModel: {
                usageType: {
                             sizeCategory: #XXL,
                             serviceQuality: #A,
                             dataClass:#TRANSACTIONAL
                           }
              }
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM: {
        private: false,
        viewType: #BASIC,
        lifecycle.contract.type: #SAP_INTERNAL_API           
        }

define view I_MaterialDocumentRecord
  as select from matdoc

  association [0..1] to I_Material                  as _Material                      on  $projection.Material = _Material.Material
  association [0..1] to I_Material                  as _StockIdentifyingMaterial      on  $projection.StockIdentifyingMaterial = _StockIdentifyingMaterial.Material
  association [0..1] to I_Material                  as _IssgOrRcvgMaterial            on  $projection.IssgOrRcvgMaterial = _IssgOrRcvgMaterial.Material
//  association [0..1] to I_Product                   as _Product                       on  $projection.Material = _Product.Product
//  association [0..1] to I_Product                   as _StockIdentifyingProduct       on  $projection.StockIdentifyingMaterial = _StockIdentifyingProduct.Product
//  association [0..1] to I_Product                   as _IssgOrRcvgProduct             on  $projection.IssgOrRcvgMaterial = _IssgOrRcvgProduct.Product

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

  association [0..1] to I_SupplierCompanyByPlant    as _SupplierCompanyByPlant      on  $projection.Supplier = _SupplierCompanyByPlant.Supplier
                                                                                    and $projection.Plant = _SupplierCompanyByPlant.Plant
  association [0..1] to I_CustomerCompanyByPlant    as _CustomerCompanyByPlant      on  $projection.Customer = _CustomerCompanyByPlant.Customer
                                                                                    and $projection.Plant    = _CustomerCompanyByPlant.Plant

  association [0..1] to I_Supplier                  as _BPStockOwner                  on  $projection.StockOwner = _BPStockOwner.Supplier
  association [0..1] to I_Supplier                  as _SpecialStockIdfgStockOwner    on  $projection.SpecialStockIdfgStockOwner = _SpecialStockIdfgStockOwner.Supplier

  association [0..1] to I_InventorySpecialStockType as _InventorySpecialStockType     on  $projection.InventorySpecialStockType = _InventorySpecialStockType.InventorySpecialStockType
  association [0..1] to I_InventorySpecialStockType as _IssgOrRcvgSpclStockInd        on  $projection.IssgOrRcvgSpclStockInd = _IssgOrRcvgSpclStockInd.InventorySpecialStockType
  association [0..1] to I_InventoryStockType        as _InventoryStockType            on  $projection.InventoryStockType = _InventoryStockType.InventoryStockType
  association [0..1] to I_InventoryStockType        as _IssuingOrReceivingStockType   on  $projection.IssuingOrReceivingStockType = _IssuingOrReceivingStockType.InventoryStockType
  association [0..1] to I_InventoryValuationType    as _InventoryValuationType        on  $projection.InventoryValuationType = _InventoryValuationType.InventoryValuationType

  association [0..1] to I_GoodsMovementType         as _GoodsMovementType             on  $projection.GoodsMovementType = _GoodsMovementType.GoodsMovementType
  association [0..1] to I_PhysInvtryReasonCode      as _GoodsMovementReasonCode       on  $projection.GoodsMovementType = _GoodsMovementReasonCode.GoodsMovementType
                                                                                      and $projection.GoodsMovementReasonCode = _GoodsMovementReasonCode.ReasonForPhysInvtryDifference

  association [0..1] to I_DebitCreditCode           as _DebitCreditCode               on  $projection.DebitCreditCode = _DebitCreditCode.DebitCreditCode
  -- View I_StockType is deprecated; I_StockType_2 is the successor
  association [0..1] to I_StockType                 as _StockType                     on  $projection.InventoryUsabilityCode = _StockType.StockType
  association [0..1] to I_StockType_2               as _StockType_2                   on  $projection.InventoryUsabilityCode = _StockType_2.StockType

  association [0..1] to I_UnitOfMeasure             as _MaterialBaseUnit              on  $projection.MaterialBaseUnit = _MaterialBaseUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure             as _EntryUnit                     on  $projection.EntryUnit = _EntryUnit.UnitOfMeasure

  association [0..1] to I_GLAccount                 as _GLAccount                     on  $projection.GLAccount   = _GLAccount.GLAccount
                                                                                      and $projection.CompanyCode = _GLAccount.CompanyCode

  association [0..*] to I_CostCenter                as _CostCenter                    on  $projection.CostCenter      = _CostCenter.CostCenter
                                                                                      and $projection.ControllingArea = _CostCenter.ControllingArea
                                                                                      and $projection.PostingDate    <= _CostCenter.ValidityEndDate
                                                                                      and $projection.PostingDate    >= _CostCenter.ValidityStartDate

  --valid date range not included, multiple entries can be returned
  association [0..*] to I_ProfitCenter              as _ProfitCenter                  on  $projection.ControllingArea = _ProfitCenter.ControllingArea
                                                                                      and $projection.ProfitCenter    = _ProfitCenter.ProfitCenter
                                                                                      and $projection.PostingDate    <= _ProfitCenter.ValidityEndDate
                                                                                      and $projection.PostingDate    >= _ProfitCenter.ValidityStartDate

  association [0..1] to I_BusinessPartner           as _BusinessPartner               on  $projection.ServicePerformer = _BusinessPartner.BusinessPartner
  association [0..1] to I_Employment                as _Employment                    on  $projection.EmploymentInternalID = _Employment.EmploymentInternalID
  association [0..1] to I_PersonWorkAgreement_1     as _PersonWorkAgreement           on  $projection.PersonWorkAgreement = _PersonWorkAgreement.PersonWorkAgreement
  association [0..1] to I_AccountAssignmentCategory as _AccountAssignmentCategory     on  $projection.AccountAssignmentCategory = _AccountAssignmentCategory.AccountAssignmentCategory
  association [0..1] to I_WorkItem                  as _WorkItem                      on  $projection.WorkItem = _WorkItem.WorkItem

  association [0..1] to I_MasterFixedAsset          as _MasterFixedAsset              on  $projection.CompanyCode      = _MasterFixedAsset.CompanyCode
                                                                                      and $projection.MasterFixedAsset = _MasterFixedAsset.MasterFixedAsset
  association [0..1] to I_FixedAsset                as _FixedAsset                    on  $projection.CompanyCode = _FixedAsset.CompanyCode
                                                                                      and $projection.MasterFixedAsset = _FixedAsset.MasterFixedAsset
                                                                                      and $projection.FixedAsset       = _FixedAsset.FixedAsset

  association [0..1] to I_CompanyCode               as _CompanyCode                   on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_BusinessArea              as _BusinessArea                  on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [0..1] to I_ControllingArea           as _ControllingArea               on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association [0..1] to I_FunctionalArea            as _FunctionalArea                on  $projection.FunctionalArea = _FunctionalArea.FunctionalArea

  // CE2111 service document for aac R
  association [0..1] to I_ServiceDocumentType       as _ServiceDocumentType           on  $projection.ServiceDocumentType = _ServiceDocumentType.ServiceDocumentType

  association [0..1] to I_SalesOrder                as _SalesOrder                    on  $projection.SalesOrder = _SalesOrder.SalesOrder
  association [0..1] to I_SalesOrder                as _SpecialStockIdfgSalesOrder    on  $projection.SpecialStockIdfgSalesOrder = _SpecialStockIdfgSalesOrder.SalesOrder

  association [0..1] to I_SalesOrderItem            as _SalesOrderItem                on  $projection.SalesOrder     = _SalesOrderItem.SalesOrder
                                                                                      and $projection.SalesOrderItem = _SalesOrderItem.SalesOrderItem
  association [0..1] to I_SalesOrderItem            as _SpecialStockIdfgSalesOrderItm on  $projection.SpecialStockIdfgSalesOrder     = _SpecialStockIdfgSalesOrderItm.SalesOrder
                                                                                      and $projection.SpecialStockIdfgSalesOrderItem = _SpecialStockIdfgSalesOrderItm.SalesOrderItem
  association [0..1] to I_SalesOrderScheduleLine    as _SalesOrderScheduleLine        on  $projection.SalesOrder     = _SalesOrderScheduleLine.SalesOrder
                                                                                      and $projection.SalesOrderItem = _SalesOrderScheduleLine.SalesOrderItem
                                                                                      and $projection.SalesOrderScheduleLine = _SalesOrderScheduleLine.ScheduleLine
// Deprecated view; replaced by I_WBSElementBasicData
  association [0..1] to I_WBSElementByInternalKey   as _SpecialStockIdfgWBSElement    on  $projection.SpecialStockIdfgWBSElement = _SpecialStockIdfgWBSElement.WBSElementInternalID
// Deprecated view; replaced by I_WBSElementBasicData 
  association [0..1] to I_WBSElementByInternalKey   as _WBSElement                    on  $projection.WBSElementInternalID = _WBSElement.WBSElementInternalID
  association [0..1] to I_WBSElementBasicData       as _SpclStkIdfgWBSElmntBasicData  on  $projection.SpecialStockIdfgWBSElement = _SpclStkIdfgWBSElmntBasicData.WBSElementInternalID
  association [0..1] to I_WBSElementBasicData       as _WBSElementBasicData           on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID


  association [0..1] to I_PurchaseOrder             as _PurchaseOrder                 on  $projection.PurchaseOrder = _PurchaseOrder.PurchaseOrder
  association [0..1] to I_PurchaseOrderItem         as _PurchaseOrderItem             on  $projection.PurchaseOrder     = _PurchaseOrderItem.PurchaseOrder
                                                                                      and $projection.PurchaseOrderItem = _PurchaseOrderItem.PurchaseOrderItem
  association [0..1] to I_ProjectNetwork            as _ProjectNetwork                on  $projection.ProjectNetwork = _ProjectNetwork.ProjectNetwork
// Deprecated view; replaced by I_ManufacturingOrder
  association [0..1] to I_MfgOrder                  as _MfgOrder                      on  $projection.ManufacturingOrder = _MfgOrder.ManufacturingOrder
// Deprecated view; replaced by I_ManufacturingOrderItem
  association [0..1] to I_MfgOrderItem              as _MfgOrderItem                  on  $projection.ManufacturingOrder     = _MfgOrderItem.ManufacturingOrder
                                                                                      and $projection.ManufacturingOrderItem = _MfgOrderItem.ManufacturingOrderItem

  association [0..1] to I_ManufacturingOrder        as _ManufacturingOrder            on  $projection.ManufacturingOrder = _ManufacturingOrder.ManufacturingOrder
  association [0..1] to I_ManufacturingOrderItem    as _ManufacturingOrderItem        on  $projection.ManufacturingOrder     = _ManufacturingOrderItem.ManufacturingOrder
                                                                                      and $projection.ManufacturingOrderItem = _ManufacturingOrderItem.ManufacturingOrderItem

  association [0..1] to I_LogisticsOrder            as _LogisticsOrder                on  $projection.OrderID = _LogisticsOrder.OrderID
// The field AUFPS is not assigned to the field POSNR of table AFPO, AUFPS is only filled in case of a goods receipt to a Production Order
//  association [0..1] to I_OrderItem                 as _OrderItem                     on  $projection.OrderID = _OrderItem.OrderID
//                                                                                      and $projection.OrderItem = _OrderItem.OrderItem
  association [0..1] to I_DeliveryDocument          as _DeliveryDocument              on  $projection.DeliveryDocument = _DeliveryDocument.DeliveryDocument
  association [0..1] to I_DeliveryDocumentItem      as _DeliveryDocumentItem          on  $projection.DeliveryDocument     = _DeliveryDocumentItem.DeliveryDocument
                                                                                      and $projection.DeliveryDocumentItem = _DeliveryDocumentItem.DeliveryDocumentItem
  association [0..1] to I_DeliveryDocument          as _DeliveryInMatlDocumentHeader  on  $projection.DeliveryInMatlDocumentHeader = _DeliveryInMatlDocumentHeader.DeliveryDocument

  association [0..1] to I_User                      as _User                          on  $projection.CreatedByUser = _User.UserID
  association [0..1] to I_AccountingDocumentType    as _AccountingDocumentType        on  $projection.AccountingDocumentType = _AccountingDocumentType.AccountingDocumentType
  association [0..1] to I_InventoryTransactionType  as _InventoryTransactionType      on  $projection.InventoryTransactionType = _InventoryTransactionType.InventoryTransactionType
                                                                                      and _InventoryTransactionType.IsMaterialDocumentRelevant = 'X'
  association [0..1] to I_Currency                  as _Currency                      on  $projection.CompanyCodeCurrency = _Currency.Currency
  
  association [0..*] to I_GoodsMvtTypeBySpclStkIndT as _GoodsMvtTypeBySpclStkIndT     on  $projection.GoodsMovementType         = _GoodsMvtTypeBySpclStkIndT.GoodsMovementType
                                                                                      and $projection.InventorySpecialStockType = _GoodsMvtTypeBySpclStkIndT.InventorySpecialStockType
                                                                                      and $projection.GoodsMovementRefDocType   = _GoodsMvtTypeBySpclStkIndT.GoodsMovementRefDocType
                                                                                      and $projection.GoodsReceiptType          = _GoodsMvtTypeBySpclStkIndT.GoodsReceiptType
                                                                                      and $projection.ConsumptionPosting        = _GoodsMvtTypeBySpclStkIndT.ConsumptionPosting 
  association [0..*] to I_ResourceBasic             as _ResourceBasic                 on  $projection.ResourceID                = _ResourceBasic.ResourceID
  association [0..*] to I_ResourceBasic             as _IssgOrRcvgResourceBasic       on  $projection.IssgOrRcvgResourceID      = _IssgOrRcvgResourceBasic.ResourceID

{

// The technical key fields from table MATDOC are only inserted here to make them available for the CDS based BW extraction via CDC
// GTNC field names are alligned with R.D. and centrally approved
  @Consumption.hidden: true
  cast(key1 as nsdm_key1 preserving type ) as MaterialDocumentKey1,
  @Consumption.hidden: true
  cast(key2 as nsdm_key2 preserving type ) as MaterialDocumentKey2,
  @Consumption.hidden: true
  cast(key3 as nsdm_key3 preserving type ) as MaterialDocumentKey3,
  @Consumption.hidden: true
  cast(key4 as nsdm_key4 preserving type ) as MaterialDocumentKey4,
  @Consumption.hidden: true
  cast(key5 as nsdm_key5 preserving type ) as MaterialDocumentKey5,
  @Consumption.hidden: true
  cast(key6 as nsdm_key6 preserving type ) as MaterialDocumentKey6,
  
  cast(mjahr as nsdm_mjahr preserving type) as MaterialDocumentYear,
  mblnr             as MaterialDocument,
  cast(zeile as nsdm_mblpo preserving type) as MaterialDocumentItem,

  matbf             as StockIdentifyingMaterial,
  werks             as Plant,
  lgort_sid         as StockIdfgStorageLocation,
  charg_sid         as StockIdentifyingBatch,
  lifnr_sid         as SpecialStockIdfgSupplier,
  mat_kdauf         as SpecialStockIdfgSalesOrder,
  mat_kdpos         as SpecialStockIdfgSalesOrderItem,
  mat_pspnr         as SpecialStockIdfgWBSElement,
  kunnr_sid         as SpecialStockIdfgCustomer,
  cast(sobkz as nsdm_spcl_stock_type preserving type) as InventorySpecialStockType,
  lbbsa_sid         as InventoryStockType,
  cast(disub_owner_sid as nsdm_disub_owner_sid preserving type)   as SpecialStockIdfgStockOwner,
  resourcename_sid  as ResourceID,

  ummab_cid         as IssgOrRcvgStkIdfgMaterial,     //v2834623
  cast(umwrk_cid as nsdm_plant_cid preserving type)         as IssgOrRcvgStkIdfgPlant,
  cast(lgort_cid as nsdm_lgort_cid preserving type)         as IssgOrRcvgStkIdfgStorLoc,
  cast(charg_cid as nsdm_batch_cid preserving type)         as IssgOrRcvgStkIdfgBatch,
  cast(lifnr_cid as nsdm_lifnr_cid preserving type)         as IssgOrRcvgSpclStkIdfgSupplier,
  mat_kdauf_cid     as IssgOrRcvgSalesOrder,
  mat_kdpos_cid     as IssgOrRcvgSalesOrderItem,
  mat_pspnr_cid     as IssgOrRcvgWBSElement,
  cast(kunnr_cid as nsdm_kunnr_cid preserving type)         as IssgOrRcvgSpclStkIdfgCustomer,
  cast(umsok_cid as nsdm_sobkz_cid preserving type)         as IssgOrRcvgStkIdfgSpclStkType,
  cast(lbbsa_cid as nsdm_lbbsa_cid preserving type)         as IssuingOrReceivingStockType,
  cast(disub_owner_cid as nsdm_disub_owner_cid preserving type)  as IssgOrRcvgSpclStkIdfgStkOwner, //^2834623,
  resourcename_cid  as IssgOrRcvgResourceID,
  kzzug             as GoodsReceiptType,


  -- with records of type MDOC_CP, AG_MDOC_CF etc there is no unique key except the technical GUID key, so we don't use any key fields at all

  matnr             as Material,
  lgort             as StorageLocation,
  charg             as Batch,
  lifnr             as Supplier,
  kdauf             as SalesOrder,
  cast(kdpos as nsdm_sales_order_item preserving type) as SalesOrderItem,
  cast(kdein as nsdm_kdein preserving type)         as SalesOrderScheduleLine,
  kunnr             as Customer,
  cast(disub_owner as nsdm_add_spcl_stock_supplier preserving type)  as StockOwner,
  cast(ps_psp_pnr as nsdm_wbs_internal_id preserving type)           as WBSElementInternalID,

  cast(ummat as nsdm_umat preserving type)          as IssgOrRcvgMaterial,
  cast(umwrk as nsdm_plant preserving type)         as IssuingOrReceivingPlant,
  umlgo             as IssuingOrReceivingStorageLoc,
  cast(umcha as nsdm_umcha preserving type)         as IssgOrRcvgBatch,
  umsok             as IssgOrRcvgSpclStockInd,
  umbar             as IssuingOrReceivingValType,

  cast(kzbew as nsdm_kzbew preserving type)         as GoodsMovementRefDocType,
  kzvbr             as ConsumptionPosting,
  grund             as GoodsMovementReasonCode,
  weanz             as NumberOfSlipsToBePrinted,
  bwart             as GoodsMovementType,
  shkzg             as DebitCreditCode,
  cast(insmk as nsdm_insmk preserving type)         as InventoryUsabilityCode,
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
  cast ( kzbws as nsdm_separate_valn_type preserving type ) as InventorySpecialStockValnType,
  xobew             as IsSupplierStockValuation,

  cpudt             as CreationDate,
  cputm             as CreationTime,
  usnam             as CreatedByUser,
  bktxt             as MaterialDocumentHeaderText,
  sgtxt             as MaterialDocumentItemText,
  cast(le_vbeln as nsdm_delivery_on_header preserving type) as DeliveryInMatlDocumentHeader,
  frbnr             as BillOfLading,

  vfdat             as ShelfLifeExpirationDate,
  hsdat             as ManufactureDate,

  @Semantics.quantity.unitOfMeasure: 'EntryUnit'
  @DefaultAggregation: #NONE
  erfmg             as QuantityInEntryUnit,
  @Semantics.unitOfMeasure: true
  erfme             as EntryUnit,
  bwtar             as InventoryValuationType,

  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'   //v2813353
  @DefaultAggregation: #NONE
  bstmg             as GoodsReceiptQtyInOrderUnit,
  @Semantics.unitOfMeasure: true
  bstme             as OrderQuantityUnit,                  //^2813353

  ebeln             as PurchaseOrder,
  ebelp             as PurchaseOrderItem,
  nplnr             as ProjectNetwork,
  cast(aufnr as nsdm_manufacturing_order preserving type) as ManufacturingOrder,
  cast(aufps as nsdm_manufacturing_order_item preserving type) as ManufacturingOrderItem,
  aufnr             as OrderID,
  cast(aufps as nsdm_co_posnr preserving type) as OrderItem,
  rsnum             as Reservation,
  cast(rspos as nsdm_rspos preserving type ) as ReservationItem,
  cast(kzear as nsdm_kzear preserving type ) as ReservationIsFinallyIssued,
  vbeln_im          as DeliveryDocument,
  cast(vbelp_im as nsdm_delivery_document_item preserving type) as DeliveryDocumentItem,
  elikz             as IsCompletelyDelivered,

  cast(sjahr as nsdm_sjahr preserving type) as ReversedMaterialDocumentYear,
  cast(smbln as nsdm_smbln preserving type) as ReversedMaterialDocument,
  cast(smblp as nsdm_smblp preserving type) as ReversedMaterialDocumentItem,
  xwsbr             as RvslOfGoodsReceiptIsAllowed,
  cast(reversal_movement as nsdm_xstbw preserving type) as IsReversalMovementType,
  cancelled         as GoodsMovementIsCancelled,
  cancellation_type as GoodsMovementCancellationType,

  wempf             as GoodsRecipientName,
  ablad             as UnloadingPointName,
  kostl             as CostCenter,
  sakto             as GLAccount,
  kstrg             as CostObject,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: 'ProfitabilitySegment_2'
  cast(paobjnr as nsdm_rkeobjnr) as ProfitabilitySegment,
  cast(paobjnr as rkeobjnr_char) as ProfitabilitySegment_2,
  prctr             as ProfitCenter,
  kalnr             as CostEstimate,

  xblnr             as ReferenceDocument,
  serviceperformer  as ServicePerformer,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: 'PersonWorkAgreement'
  cast(pernr as nsdm_employment_id preserving type) as EmploymentInternalID,
  pernr             as PersonWorkAgreement,
  cast(knttp_gr as nsdm_knttp preserving type) as AccountAssignmentCategory,
  work_item_id      as WorkItem,
  fbuda             as ServicesRenderedDate,

  bukrs             as CompanyCode,
  gsber             as BusinessArea,
  kokrs             as ControllingArea,
  fkber             as FunctionalArea,
  urzei             as OriginalMaterialDocumentItem,
  maa_urzei         as MultiAcctAssgmtOriglMatlDocItm,
  weunb             as GoodsReceiptIsNonValuated,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: 'MultipleAccountAssignmentCode'
  xmacc             as HasMultipleAccountAssignment,
  cast(xmacc        as nsdm_xmacc preserving type ) as MultipleAccountAssignmentCode,
  anln1             as MasterFixedAsset,
  anln2             as FixedAsset,
  @Semantics.businessDate.at: true
  budat             as PostingDate,
  @Semantics.fiscal.yearPeriod: true
  cast(gjper as nsdm_jahrper preserving type) as FiscalYearPeriod,
  @Semantics.fiscal.yearVariant: true
  periv             as FiscalYearVariant,

  fistl             as FundsCenter,
  geber             as Fund,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: 'CommitmentItemShortID'  
  fipos             as CommitmentItem,
  cast(fipos as fmis_ci_internalname preserving type) as CommitmentItemShortID,
  grant_nbr         as GrantID,

  lgtyp             as StorageType,
  lgpla             as StorageBin,
  bfwms             as CtrlPostgForExtWhseMgmtSyst,
  
  --Reference Fields
  lfbja             as ReferenceDocumentFiscalYear,
  lfbnr             as InvtryMgmtReferenceDocument,
  lfpos             as InvtryMgmtRefDocumentItem, 

  --EWM Fields
  ewm_lgnum         as EWMWarehouse,
  ewm_lgpla         as EWMStorageBin,

  --Service Document Fields
  service_doc_id    as ServiceDocument,
  service_doc_item_id as ServiceDocumentItem,
  service_doc_type  as ServiceDocumentType,
  
  --Fields for print documents
  aufpl             as MaintOrderRoutingNumber,
  aplzl             as MaintOrderOperationCounter,
  ematn             as ManufacturerMaterial,
  xblvs             as ActivityInWarehouseIsPending,
  lgnum             as WarehouseNumber,
  tbnum             as TransferRequirementNumber,
  tbpri             as TransferPriority,
  wever             as VersionForPrintingSlip,  
  xprint            as ManualPrintIsTriggered,   
  evers             as ShippingInstruction,
  evere             as ShipgInstrnSupplierCompliance,
  @Semantics.quantity.unitOfMeasure: 'OrderPriceUnit'
  bpmng             as QtyInPurchaseOrderPriceUnit,
  @Semantics.unitOfMeasure: true
  bprme             as OrderPriceUnit,

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
  cast(day_budat as nsdm_day_of_year preserving type)     as CalendarDay,
  cast(weekday_budat as nsdm_day_of_week preserving type) as WeekDay,
  gjahr             as FiscalYear,
  cast(gjper_curr_per as fins_fyearperiod preserving type) as YearPeriod,

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
  cast(waers as nsdm_comp_code_currency preserving type)  as CompanyCodeCurrency,

  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @DefaultAggregation: #NONE
  exbwr             as GdsMvtExtAmtInCoCodeCrcy,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @DefaultAggregation: #NONE
  vkwrt             as SlsPrcAmtInclVATInCoCodeCrcy,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  @DefaultAggregation: #NONE
  exvkw             as EnteredSlsAmtInCoCodeCrcy,
  
  xabln             as GoodsIssueOrReceiptSlipNumber,

  @Consumption.hidden: true
  tcode2            as TransactionCode,

  @Consumption.hidden: true
  cast(xauto as nsdm_xauto preserving type) as IsAutomaticallyCreated,
  @Consumption.hidden: true
  cast(line_id as nsdm_mb_line_id preserving type) as MaterialDocumentLine,
  @Consumption.hidden: true
  parent_id         as MaterialDocumentParentLine,
  @Consumption.hidden: true
  line_depth        as HierarchyNodeLevel,

  @Consumption.hidden: true
  record_type       as MaterialDocumentRecordType,
  @Consumption.hidden: true
  header_counter    as IsMaterialDocumentHeader,
  
  @DefaultAggregation: #NONE  
  cast(rsart as nsdm_reservation_record_type preserving type ) as ReservationRecordType,
  
  xsaut             as SerialNumbersAreCreatedAutomly,
  xstor             as MaterialDocumentPostingType,

  _Material,
  _StockIdentifyingMaterial,
  _IssgOrRcvgMaterial,
//  _Product,
//  _StockIdentifyingProduct,
//  _IssgOrRcvgProduct,

  _Plant,
  _IssuingOrReceivingPlant,
  _StorageLocation,
  _IssuingOrReceivingStorageLoc,
  _StockIdfgStorageLocation,

  _Supplier,
  _SpecialStockIdfgSupplier,

  _Customer,
  _SpecialStockIdfgCustomer,

  @Consumption.hidden: true
  _SupplierCompanyByPlant,
  @Consumption.hidden: true
  _CustomerCompanyByPlant,

  _BPStockOwner,
  _SpecialStockIdfgStockOwner,

  _InventorySpecialStockType,
  _IssgOrRcvgSpclStockInd,
  _InventoryStockType,
  _IssuingOrReceivingStockType,
  _InventoryValuationType,

  _GoodsMovementType,
  _GoodsMovementReasonCode,
  _DebitCreditCode,
  @API.element.releaseState: #DEPRECATED
  @API.element.successor: '_StockType_2'
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: '_StockType_2'
  _StockType,
  _StockType_2,

  _MaterialBaseUnit,
  _EntryUnit,

  _BusinessPartner,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: '_PersonWorkAgreement'
  _Employment,
  _PersonWorkAgreement,
  _AccountAssignmentCategory,
  _WorkItem,
  _MasterFixedAsset,
  _FixedAsset,
  _CompanyCode,
  _BusinessArea,
  _ControllingArea,
  _GLAccount,
  _CostCenter,
  _FunctionalArea,
  _ProfitCenter,

  _ServiceDocumentType,

  _SalesOrder,
  _SpecialStockIdfgSalesOrder,

  _SalesOrderItem,
  _SpecialStockIdfgSalesOrderItm,

  _SalesOrderScheduleLine,

  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: '_WBSElementBasicData'
  _WBSElement,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: '_SpclStkIdfgWBSElmntBasicData'
  _SpecialStockIdfgWBSElement,
  _WBSElementBasicData,
  _SpclStkIdfgWBSElmntBasicData,

  _PurchaseOrder,
  _PurchaseOrderItem,
  _ProjectNetwork,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: '_ManufacturingOrder'
  _MfgOrder,
  @VDM.lifecycle.status: #DEPRECATED
  @VDM.lifecycle.successor: '_ManufacturingOrderItem'
  _MfgOrderItem,
  _ManufacturingOrder,
  _ManufacturingOrderItem,
  _LogisticsOrder,
  _DeliveryDocument,
  _DeliveryDocumentItem,
  _DeliveryInMatlDocumentHeader,

  _User,
  _AccountingDocumentType,
  _InventoryTransactionType,
  _Currency,
  _GoodsMvtTypeBySpclStkIndT,
  
  _ResourceBasic,
  _IssgOrRcvgResourceBasic  
}

