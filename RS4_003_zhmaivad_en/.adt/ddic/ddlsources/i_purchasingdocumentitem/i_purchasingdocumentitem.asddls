@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Purchasing Document Item'
@AccessControl.authorizationCheck:#CHECK
@AccessControl.privilegedAssociations:  [ '_ManualDeliveryAddress', '_ReferenceDeliveryAddress' ]
@AccessControl.personalData.blocking:#REQUIRED
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IMMPURGDOCITEM'
@AbapCatalog.preserveKey: true
@ObjectModel.representativeKey: 'PurchasingDocumentItem'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.compiler.compareFilter:true

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL

define view I_PurchasingDocumentItem
  as select from ekpo

  association [1..1] to I_PurchasingDocument         as _PurchasingDocument        on  $projection.PurchasingDocument = _PurchasingDocument.PurchasingDocument

  association [0..*] to I_PurgDocScheduleLine        as _ScheduleLine              on  $projection.PurchasingDocument     = _ScheduleLine.PurchasingDocument
                                                                                   and $projection.PurchasingDocumentItem = _ScheduleLine.PurchasingDocumentItem

  association [0..1] to I_Purchaserequisition        as _PurchaseRequisition       on  $projection.PurchaseRequisition = _PurchaseRequisition.PurchaseRequisition

  association [0..1] to I_Purchaserequisitionitem    as _PurchaseRequisitionItem   on  $projection.PurchaseRequisition     = _PurchaseRequisitionItem.PurchaseRequisition
                                                                                   and $projection.PurchaseRequisitionItem = _PurchaseRequisitionItem.PurchaseRequisitionItem

  association [0..1] to I_PurchaseContract           as _PurchaseContract          on  $projection.PurchaseContract = _PurchaseContract.PurchaseContract

  association [0..1] to I_PurchaseContractItem       as _PurchaseContractItem      on  $projection.PurchaseContract     = _PurchaseContractItem.PurchaseContract
                                                                                   and $projection.PurchaseContractItem = _PurchaseContractItem.PurchaseContractItem

  association [0..1] to I_PurchasingInfoRecordApi01  as _PurchasingInfoRecord      on  $projection.PurchasingInfoRecord = _PurchasingInfoRecord.PurchasingInfoRecord


  association [0..1] to I_CompanyCode                as _CompanyCode               on  $projection.CompanyCode = _CompanyCode.CompanyCode

  association [0..1] to I_Plant                      as _Plant                     on  $projection.Plant = _Plant.Plant

  association [0..1] to I_StorageLocation            as _StorageLocation           on  $projection.Plant           = _StorageLocation.Plant
                                                                                   and $projection.StorageLocation = _StorageLocation.StorageLocation

  association [0..1] to I_Material                   as _Material                  on  $projection.Material = _Material.Material

  association [0..1] to I_Material                   as _ManufacturerMaterial      on  $projection.ManufacturerMaterial = _ManufacturerMaterial.Material

  association [0..1] to I_Material                   as _ConfigurableProduct       on  $projection.CrossPlantConfigurableProduct = _ConfigurableProduct.Material

  association [0..1] to I_MaterialGroup              as _MaterialGroup             on  $projection.MaterialGroup = _MaterialGroup.MaterialGroup

  association [0..1] to I_UnitOfMeasure              as _BaseUnit                  on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure

  association [0..1] to I_UnitOfMeasure              as _OrderQuantityUnit         on  $projection.OrderQuantityUnit = _OrderQuantityUnit.UnitOfMeasure

  association [0..1] to I_UnitOfMeasure              as _VolumeUnit                on  $projection.VolumeUnit = _VolumeUnit.UnitOfMeasure

  association [0..1] to I_UnitOfMeasure              as _WeightUnit                on  $projection.WeightUnit = _WeightUnit.UnitOfMeasure

  association [0..1] to I_UnitOfMeasure              as _OrderPriceUnit            on  $projection.OrderPriceUnit = _OrderPriceUnit.UnitOfMeasure

  association [0..1] to I_Address                    as _ManualDeliveryAddress     on  $projection.ManualDeliveryAddressID = _ManualDeliveryAddress.AddressID

  association [0..1] to I_Address                    as _ReferenceDeliveryAddress  on  $projection.ReferenceDeliveryAddressID = _ReferenceDeliveryAddress.AddressID

  association [0..1] to I_PurchasingDocumentCategory as _PurgDocumentCategory      on  $projection.PurchasingDocumentCategory = _PurgDocumentCategory.PurchasingDocumentCategory

  association [0..1] to I_PurgDocumentItemCategory   as _PurgDocumentItemCategory  on  $projection.PurchasingDocumentItemCategory = _PurgDocumentItemCategory.PurchasingDocumentItemCategory

  association [0..1] to I_Supplier                   as _Manufacturer              on  $projection.Manufacturer = _Manufacturer.Supplier

  association [0..1] to I_Supplier                   as _Subcontractor             on  $projection.Subcontractor = _Subcontractor.Supplier

  association [0..1] to I_Supplier                   as _PriorSupplier             on  $projection.PriorSupplier = _PriorSupplier.Supplier

  association [0..1] to I_Customer                   as _Customer                  on  $projection.Customer = _Customer.Customer

  association [0..1] to I_IncotermsClassification    as _IncotermsClassification   on  $projection.IncotermsClassification = _IncotermsClassification.IncotermsClassification

  association [0..1] to I_BusinessPartner            as _ServicePerformer          on  $projection.ServicePerformer = _ServicePerformer.BusinessPartner

  association [0..1] to I_ProductTypeCode            as _ProductType               on  $projection.ProductType = _ProductType.ProductTypeCode

  association [0..1] to I_ProductCategory            as _ProductCategory           on  $projection.ArticleCategory = _ProductCategory.ProductCategory

  association [0..1] to I_AccountAssignmentCategory  as _AccountAssignmentCategory on  $projection.AccountAssignmentCategory = _AccountAssignmentCategory.AccountAssignmentCategory

  association [0..1] to I_ConsumptionPosting         as _ConsumptionPosting        on  $projection.ConsumptionPosting = _ConsumptionPosting.ConsumptionPosting

  association [0..1] to I_AllocationTable            as _AllocationTable           on  $projection.AllocationTable = _AllocationTable.AllocationTable

  association [0..1] to I_AllocationTableItem        as _AllocationTableItem       on  $projection.AllocationTableItem = _AllocationTableItem.AllocationTableItem
                                                                                   and $projection.AllocationTable     = _AllocationTableItem.AllocationTable

  association [0..1] to I_RetailPromotion            as _RetailPromotion           on  $projection.RetailPromotion = _RetailPromotion.RetailPromotion

  association [0..1] to E_PurchasingDocumentItem     as _ItemExtension             on  $projection.PurchasingDocument     = _ItemExtension.PurchasingDocument
                                                                                   and $projection.PurchasingDocumentItem = _ItemExtension.PurchasingDocumentItem

  ----Brazil Extension Associations
  association [0..1] to I_BR_MaterialOrigin          as _BR_MaterialOrigin         on  _BR_MaterialOrigin.BR_MaterialOrigin = $projection.BR_MaterialOrigin

  association [0..1] to I_BR_MaterialUsage           as _BR_MaterialUsage          on  _BR_MaterialUsage.BR_MaterialUsage = $projection.BR_MaterialUsage

  association [0..1] to I_BR_CFOPCategory            as _BR_CFOPCategory           on  _BR_CFOPCategory.BR_CFOPCategory = $projection.BR_CFOPCategory

  association [0..1] to I_BR_NCM                     as _BR_NCM                    on  _BR_NCM.CountryCode = 'BR'
                                                                                   and _BR_NCM.BR_NCM      = $projection.BR_NCM


{
      @ObjectModel.foreignKey.association: '_PurchasingDocument'
  key ekpo.ebeln                                                as PurchasingDocument,
  key ekpo.ebelp                                                as PurchasingDocumentItem,
      ekpo.uniqueid                                             as PurchasingDocumentItemUniqueID,

      @ObjectModel.foreignKey.association: '_PurgDocumentCategory'
      ekpo.bstyp                                                as PurchasingDocumentCategory,

      ekpo.loekz                                                as PurchasingDocumentDeletionCode,

      @ObjectModel.foreignKey.association: '_Material'
      ekpo.matnr                                                as Material,

      ekpo.idnlf                                                as SupplierMaterialNumber,

      @ObjectModel.foreignKey.association: '_ManufacturerMaterial'
      ekpo.ematn                                                as ManufacturerMaterial,

      ekpo.mfrpn                                                as ManufacturerPartNmbr,

      @ObjectModel.foreignKey.association: '_Manufacturer'
      ekpo.mfrnr                                                as Manufacturer,

      @Semantics.text: true
      ekpo.txz01                                                as PurchasingDocumentItemText,

      @ObjectModel.foreignKey.association: '_CompanyCode'
      ekpo.bukrs                                                as CompanyCode,

      @ObjectModel.foreignKey.association: '_Plant'
      ekpo.werks                                                as Plant,

      @ObjectModel.foreignKey.association: '_ManualDeliveryAddress'
      ekpo.adrnr                                                as ManualDeliveryAddressID,

      @ObjectModel.foreignKey.association: '_ReferenceDeliveryAddress'
      ekpo.adrn2                                                as ReferenceDeliveryAddressID,

      @ObjectModel.foreignKey.association: '_Customer'
      ekpo.kunnr                                                as Customer,

      @ObjectModel.foreignKey.association: '_Subcontractor'
      ekpo.emlif                                                as Subcontractor,

      ekpo.lblkz                                                as SupplierIsSubcontractor,

      @ObjectModel.foreignKey.association: '_ConfigurableProduct'
      ekpo.satnr                                                as CrossPlantConfigurableProduct,

      @ObjectModel.foreignKey.association: '_ProductCategory'
      ekpo.attyp                                                as ArticleCategory,

      ekpo.kanba                                                as PlndOrderReplnmtElmntType,

      @Semantics.unitOfMeasure: true
      ekpo.punei                                                as ProductPurchasePointsQtyUnit,

      @Semantics.quantity.unitOfMeasure: 'ProductPurchasePointsQtyUnit'
      @DefaultAggregation: #NONE
      ekpo.anzpu                                                as ProductPurchasePointsQty,

      //_Plant.AddressID as PlantAddressID,
      @ObjectModel.foreignKey.association: '_StorageLocation'
      cast (ekpo.lgort as vdm_storage_location preserving type) as StorageLocation,

      @ObjectModel.foreignKey.association: '_MaterialGroup'
      ekpo.matkl                                                as MaterialGroup,

      @Semantics.unitOfMeasure: true
      ekpo.meins                                                as OrderQuantityUnit,

      ekpo.umrez                                                as OrderItemQtyToBaseQtyNmrtr,

      ekpo.umren                                                as OrderItemQtyToBaseQtyDnmntr,

      @Semantics.quantity.unitOfMeasure: 'OrderPriceUnit'
      @DefaultAggregation: #NONE
      cast (ekpo.peinh as vdm_price_unit preserving type)       as NetPriceQuantity,

      ekpo.elikz                                                as IsCompletelyDelivered,

      ekpo.erekz                                                as IsFinallyInvoiced,

      ekpo.wepos                                                as GoodsReceiptIsExpected,

      ekpo.repos                                                as InvoiceIsExpected,

      ekpo.eglkz                                                as OutwardDeliveryIsComplete,

      ekpo.webre                                                as InvoiceIsGoodsReceiptBased,

      ekpo.weunb                                                as GoodsReceiptIsNonValuated,

      ekpo.banfn                                                as PurchaseRequisition,

      //      @ObjectModel.foreignKey.association: '_PurchaseRequisitionItem'
      ekpo.bnfpo                                                as PurchaseRequisitionItem,

      ekpo.packno                                               as ServicePackage,

      @ObjectModel.foreignKey.association: '_ServicePerformer'
      ekpo.serviceperformer                                     as ServicePerformer,

      @ObjectModel.foreignKey.association: '_ProductType'
      ekpo.producttype                                          as ProductType,

      ekpo.mtart                                                as MaterialType,

      @ObjectModel.foreignKey.association: '_PurchaseContractItem'
      ekpo.ktpnr                                                as PurchaseContractItem,

      @ObjectModel.foreignKey.association: '_PurchaseContract'
      ekpo.konnr                                                as PurchaseContract,

      //  @ObjectModel.foreignKey.association: '_RequestForQuotation'
      ekpo.requestforquotation                                  as RequestForQuotation,

      //     @ObjectModel.foreignKey.association: '_RequestForQuotationItem'
      ekpo.requestforquotationitem                              as RequestForQuotationItem,

      ekpo.xersy                                                as EvaldRcptSettlmtIsAllowed,

      ekpo.uebtk                                                as UnlimitedOverdeliveryIsAllowed,

      ekpo.uebto                                                as OverdelivTolrtdLmtRatioInPct,

      ekpo.untto                                                as UnderdelivTolrtdLmtRatioInPct,

      ekpo.afnam                                                as RequisitionerName,

      ekpo.berid                                                as MRPArea,

      @ObjectModel.foreignKey.association: '_IncotermsClassification'
      ekpo.inco1                                                as IncotermsClassification,

      ekpo.inco2                                                as IncotermsTransferLocation,

      ekpo.inco2_l                                              as IncotermsLocation1,

      ekpo.inco3_l                                              as IncotermsLocation2,

      @ObjectModel.foreignKey.association: '_PriorSupplier'
      ekpo.kolif                                                as PriorSupplier,

      ekpo.ean11                                                as InternationalArticleNumber,

      ekpo.bstae                                                as SupplierConfirmationControlKey,

      ekpo.prsdr                                                as PriceIsToBePrinted,

      @Semantics.unitOfMeasure: true
      ekpo.lmein                                                as BaseUnit,

      @ObjectModel.foreignKey.association: '_PurgDocumentItemCategory'
      ekpo.pstyp                                                as PurchasingDocumentItemCategory,

      ekpo.ko_prctr                                             as ProfitCenter,

      @Semantics.unitOfMeasure: true
      ekpo.bprme                                                as OrderPriceUnit,

      @Semantics.unitOfMeasure: true
      ekpo.voleh                                                as VolumeUnit,

      @Semantics.unitOfMeasure: true
      ekpo.gewei                                                as WeightUnit,

      ekpo.vrtkz                                                as MultipleAcctAssgmtDistribution,

      ekpo.twrkz                                                as PartialInvoiceDistribution,

      ekpo.meprf                                                as PricingDateControl,

      ekpo.stapo                                                as IsStatisticalItem,

      ekpo.uebpo                                                as PurchasingParentItem,

      ekpo.lewed                                                as GoodsReceiptLatestCreationDate,

      ekpo.retpo                                                as IsReturnsItem,

      ekpo.bsgru                                                as PurchasingOrderReason,

      ekpo.knttp                                                as AccountAssignmentCategory,

      @ObjectModel.foreignKey.association: '_PurchasingInfoRecord'
      ekpo.infnr                                                as PurchasingInfoRecord,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.netwr                                                as NetAmount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.brtwr                                                as GrossAmount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.effwr                                                as EffectiveAmount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.kzwi1                                                as Subtotal1Amount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.kzwi2                                                as Subtotal2Amount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.kzwi3                                                as Subtotal3Amount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.kzwi4                                                as Subtotal4Amount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.kzwi5                                                as Subtotal5Amount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.kzwi6                                                as Subtotal6Amount,

      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      @DefaultAggregation: #NONE
      ekpo.ktmng                                                as TargetQuantity,

      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      @DefaultAggregation: #NONE
      ekpo.menge                                                as OrderQuantity,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.netpr                                                as NetPriceAmount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.zwert                                                as TargetAmount,

      @Semantics.quantity.unitOfMeasure: 'VolumeUnit'
      @DefaultAggregation: #NONE
      ekpo.volum                                                as ItemVolume,

      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      @DefaultAggregation: #NONE
      ekpo.brgew                                                as ItemGrossWeight,

      @Semantics.quantity.unitOfMeasure: 'WeightUnit'
      @DefaultAggregation: #NONE
      ekpo.ntgew                                                as ItemNetWeight,

      ekpo.bpumz                                                as OrderPriceUnitToOrderUnitNmrtr,

      ekpo.bpumn                                                as OrdPriceUnitToOrderUnitDnmntr,

      ekpo.abdat                                                as SchedAgrmtCumQtyReconcileDate,

      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      ekpo.abftz                                                as SchedAgrmtAgreedCumQty,

      ekpo.drdat                                                as ItemLastTransmissionDate,

      ekpo.etfz1                                                as ScheduleLineFirmOrderInDays,

      ekpo.etfz2                                                as SchedLineSemiFirmOrderInDays,

      ekpo.mahn1                                                as NoDaysReminder1,

      ekpo.mahn2                                                as NoDaysReminder2,

      ekpo.mahn3                                                as NoDaysReminder3,

      ekpo.bednr                                                as RequirementTracking,

      ekpo.kzabs                                                as IsOrderAcknRqd,

      ekpo.insmk                                                as StockType,

      ekpo.mwskz                                                as TaxCode,

      ekpo.txjcd                                                as TaxJurisdiction,

      ekpo.evers                                                as ShippingInstruction,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      ekpo.navnw                                                as NonDeductibleInputTaxAmount,

      ekpo.bwtar                                                as ValuationType,

      ekpo.bwtty                                                as ValuationCategory,

      ekpo.abskz                                                as ItemIsRejectedBySupplier,

      ekpo.prdat                                                as PurgDocPriceDate,

      ekpo.spinf                                                as IsInfoRecordUpdated,

      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      ekpo.abmng                                                as PurgDocReleaseOrderQuantity,

      ekpo.labnr                                                as PurgDocOrderAcknNumber,

      ekpo.schpr                                                as PurgDocEstimatedPrice,

      @Semantics.booleanIndicator: true
      ekpo.borgr_miss                                           as IsInfoAtRegistration,

      ekpo.ltsnr                                                as SupplierSubrange,

      ekpo.kostl                                                as CostCenter,

      ekpo.sakto                                                as GLAccount,

      ekpo.ps_psp_pnr                                           as WBSElementInternalID,

      ekpo.geber                                                as Fund,

      ekpo.budget_pd                                            as BudgetPeriod,

      ekpo.fistl                                                as FundsCenter,

      ekpo.fipos                                                as CommitmentItem,

      ekpo.fkber                                                as FunctionalArea,

      ekpo.grant_nbr                                            as GrantID,

      ekpo.kblnr                                                as EarmarkedFunds,
      ekpo.kblnr                                                as EarmarkedFundsDocument,

      ekpo.kblpos                                               as EarmarkedFundsItem,
      ekpo.kblpos                                               as EarmarkedFundsDocumentItem,

      ekpo.plifz                                                as PlannedDeliveryDurationInDays,

      ekpo.webaz                                                as GoodsReceiptDurationInDays,

      ekpo.kztlf                                                as PartialDeliveryIsAllowed,

      @ObjectModel.foreignKey.association: '_ConsumptionPosting'
      ekpo.kzvbr                                                as ConsumptionPosting,

      ekpo.abueb                                                as SchedgAgrmtRelCreationProfile,

      ekpo.spe_cq_ctrltype                                      as SchedAgrmtCumulativeQtyControl,

      ekpo.spe_cq_nocq                                          as CumulativeQuantityIsNotSent,

      ekpo.mhdrz                                                as MinRemainingShelfLife,

      cast (ekpo.iprkz as vdm_dattp preserving type)            as ShelfLifeExpirationDatePeriod, //Data element without conversion exit

      ekpo.ssqss                                                as QualityMgmtCtrlKey,

      ekpo.sobkz                                                as InventorySpecialStockType,

      ekpo.fabkz                                                as IsRelevantForJITDelivSchedule,

      ekpo.nfabd                                                as NextJITDelivSchedSendingDate,

      ekpo.nlabd                                                as NextFcstDelivSchedSendingDate,

      ekpo.kzstu                                                as FirmTradeOffZoneBindMRP,

      ekpo.zgtyp                                                as QualityCertificateType,

      ekpo.anfnr                                                as SupplierQuotation,

      ekpo.anfps                                                as SupplierQuotationItem,

      ekpo.isvco                                                as IntrastatServiceCode,

      ekpo.stawn                                                as CommodityCode,

      ekpo.lfret                                                as DeliveryDocumentType,

      ekpo.mfrgr                                                as MaterialFreightGroup,

      ekpo.nrfhg                                                as DiscountInKindEligibility,

      ekpo.novet                                                as PurgItemIsBlockedForDelivery,

      ekpo.reslo                                                as IssuingStorageLocation,

      @ObjectModel.foreignKey.association: '_AllocationTable'
      ekpo.abeln                                                as AllocationTable,

      @ObjectModel.foreignKey.association: '_AllocationTableItem'
      ekpo.abelp                                                as AllocationTableItem,

      @ObjectModel.foreignKey.association: '_RetailPromotion'
      ekpo.aktnr                                                as RetailPromotion,


      // Down Payment
      ekpo.dptyp                                                as DownPaymentType,

      ekpo.dppct                                                as DownPaymentPercentageOfTotAmt,

      @Semantics.amount.currencyCode: 'DocumentCurrency'    
      ekpo.dpamt                                                as DownPaymentAmount,

      ekpo.dpdat                                                as DownPaymentDueDate,


      // S/4 Limit
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ekpo.expected_value                                       as ExpectedOverallLimitAmount,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      ekpo.limit_amount                                         as OverallLimitAmount,

      ekpo.contract_for_limit                                   as PurContractForOverallLimit,

      ekpo.sgt_rcat                                             as RequirementSegment,

      //Brazil Extension
      @ObjectModel.foreignKey.association: '_BR_MaterialOrigin'
      ekpo.j_1bmatorg                                           as BR_MaterialOrigin,

      @ObjectModel.foreignKey.association: '_BR_MaterialUsage'
      ekpo.j_1bmatuse                                           as BR_MaterialUsage,

      @ObjectModel.foreignKey.association: '_BR_CFOPCategory'
      ekpo.j_1bindust                                           as BR_CFOPCategory,

      @ObjectModel.foreignKey.association: '_BR_NCM'
      ekpo.j_1bnbm                                              as BR_NCM,

      ekpo.j_1bnbm                                              as ConsumptionTaxCtrlCode,

      ekpo.j_1bownpro                                           as BR_IsProducedInHouse,

      ekpo.extmaterialforpurg                                   as PurchasingCentralMaterial,

      @Semantics.amount.currencyCode: 'DocumentCurrency'      
      ekpo.target_value                                         as PurgDocItmTargetAmount,

      ekpo.spe_crm_ref_so                                       as ThirdPtyOrdProcgExtReference,

      ekpo.spe_crm_ref_item                                     as ThirdPtyOrdProcgExtRefItem,
      
      ekpo.blk_reason_id                                        as PurgDocItmBlkRsnCode,

      _PurchasingDocument.IsEndOfPurposeBlocked,


      @Semantics.currencyCode: true
      _PurchasingDocument.DocumentCurrency,



      _PurchasingDocument._DocumentCurrency,
      _CompanyCode,
      _Plant,
      _StorageLocation,
      _Material,
      _ManufacturerMaterial,
      _ConfigurableProduct,
      //_deletionTypeCode
      _MaterialGroup,

      _BaseUnit,
      _OrderQuantityUnit,
      //   _PurchasingDocumentItemCategory,
      //   _ProfitCenter,
      _VolumeUnit,
      _WeightUnit,
      _OrderPriceUnit,
      _ManualDeliveryAddress,
      _ReferenceDeliveryAddress,
      //    _DisplayDeliveryAddress,
      _PurgDocumentCategory,
      _PurgDocumentItemCategory,
      _ProductCategory,

      _IncotermsClassification,

      _PurchasingDocument,
      //   _ServicePackage,
      //   _AccountAssignment,
      _ScheduleLine,
      //    _PurchaseContractItem,
      _PurchaseRequisitionItem,
      _PurchasingInfoRecord,

      _Manufacturer,
      _Customer,
      _Subcontractor,
      _PriorSupplier,
      _PurchaseRequisition,
      _PurchaseContract,
      _PurchaseContractItem,

      _ServicePerformer,
      _ProductType,
      _AccountAssignmentCategory,
      _ConsumptionPosting,
      _AllocationTable,
      _AllocationTableItem,
      _RetailPromotion,

      //      Brazilian fields
      _BR_MaterialOrigin,
      _BR_MaterialUsage,
      _BR_CFOPCategory,
      _BR_NCM

}
