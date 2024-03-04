@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Sales Document Schedule Line'
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}
@AbapCatalog.sqlViewName: 'ISDSLSDOCSCHEDLN'
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck:#CHECK
@ObjectModel: {
   representativeKey: 'ScheduleLine',
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XL
   },
   supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ],
   modelingPattern: [ #ANALYTICAL_DIMENSION ]
}
@Metadata.ignorePropagatedAnnotations: true
@Analytics:{dataCategory:#DIMENSION}
@Metadata.allowExtensions: true

define view I_SalesDocumentScheduleLine
  as select from vbep
  association [1..1] to I_SalesDocument           as _SalesDocument                 on  $projection.SalesDocument = _SalesDocument.SalesDocument
  association [1..1] to I_SalesDocumentItem       as _SalesDocumentItem             on  $projection.SalesDocumentItem = _SalesDocumentItem.SalesDocumentItem
                                                                                    and $projection.SalesDocument     = _SalesDocumentItem.SalesDocument
  association [0..1] to I_ScheduleLineCategory    as _ScheduleLineCategory          on  $projection.ScheduleLineCategory = _ScheduleLineCategory.ScheduleLineCategory
  association [0..1] to I_ProdAvailyCheckRqmtType as _ProdAvailabilityCheckRqmtType on  $projection.ProdAvailabilityCheckRqmtType = _ProdAvailabilityCheckRqmtType.ProdAvailabilityCheckRqmtType
                                                                                    and $projection.ProdAvailyCheckPlanningType   = _ProdAvailabilityCheckRqmtType.ProdAvailyCheckPlanningType
  association [0..1] to I_ScheduleLineConfStatus  as _ScheduleLineConfStatus        on  $projection.ScheduleLineConfirmationStatus = _ScheduleLineConfStatus.ScheduleLineConfirmationStatus
  association [0..1] to I_MfgOrder                as _OrderID                       on  $projection.OrderID = _OrderID.ManufacturingOrder
  association [0..1] to I_UnitOfMeasure           as _OrderQuantityUnit             on  $projection.OrderQuantityUnit = _OrderQuantityUnit.UnitOfMeasure
  //Todo:association[0..1] to I_PurchaseOrderTypeName
  association [0..1] to I_UnitOfMeasure           as _BaseUnit                      on  $projection.BaseUnit = _BaseUnit.UnitOfMeasure
  association [0..1] to I_DeliveryBlockReason     as _DelivBlockReasonForSchedLine  on  $projection.DelivBlockReasonForSchedLine = _DelivBlockReasonForSchedLine.DeliveryBlockReason
  association [0..1] to I_GoodsMovementType       as _GoodsMovementType             on  $projection.GoodsMovementType = _GoodsMovementType.GoodsMovementType
  association [0..1] to I_Currency                as _TransactionCurrency           on  $projection.TransactionCurrency = _TransactionCurrency.Currency
  association [0..1] to I_TradeCmplncLegalCtrlChkSts as _TradeCmplncLegalCtrlChkSts  on  $projection.TradeCmplncLegalCtrlChkSts = _TradeCmplncLegalCtrlChkSts.TradeCmplncLegalCtrlChkSts
{
      //Key
      @ObjectModel.foreignKey.association: '_SalesDocument'
  key vbep.vbeln       as SalesDocument,
      @ObjectModel.foreignKey.association: '_SalesDocumentItem'
  key posnr            as SalesDocumentItem,
  key etenr            as ScheduleLine,

      //category
      @ObjectModel.foreignKey.association: '_ScheduleLineCategory'
      ettyp            as ScheduleLineCategory,

      //sales
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_OrderQuantityUnit'
      vrkme            as OrderQuantityUnit,
      umvkn            as OrderToBaseQuantityDnmntr,
      umvkz            as OrderToBaseQuantityNmrtr,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnit'
      meins            as BaseUnit,
      edatu            as DeliveryDate,
      prgrs            as DelivDateCategory,

      //requested
      case when
          vbep.wmeng != 0
      then
          'X'
      else
          ''
      end              as IsRequestedDelivSchedLine,
      case when
          vbep.wmeng != 0
      then
          vbep.edatu
      --else
      --    ''    -- to enforce a NULL-value, that is needed by ODATA
      end              as RequestedDeliveryDate,
      case when
          vbep.wmeng != 0
      then
          vbep.ezeit
      --else
      --    ''    -- to enforce a NULL-value, that is needed by ODATA
      end              as RequestedDeliveryTime,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbep.wmeng       as ScheduleLineOrderQuantity,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbep.cmeng       as CorrectedQtyInOrderQtyUnit,

      //confrimed
      case when
          vbep.bmeng != 0
      then
          'X'
      else
          ''
      end              as IsConfirmedDelivSchedLine,
      case when
          vbep.bmeng != 0
      then
          vbep.edatu
      --else
      --    ''  -- to enforce a NULL-value, that is needed by ODATA
      end              as ConfirmedDeliveryDate,
      case when
          vbep.bmeng != 0
      then
          vbep.ezeit
      --else
      --    ''  -- to enforce a NULL-value, that is needed by ODATA
       end             as ConfirmedDeliveryTime,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      vbep.bmeng       as ConfdOrderQtyByMatlAvailCheck,
      vbep.req_dlvdate as ConfdSchedLineReqdDelivDate,
      //availibity
      mbdat            as ProductAvailabilityDate,

      //Availibility
      mbuhr            as ProductAvailabilityTime,
      bddat            as ProductAvailCheckRqmtDate,
      bdart            as ProdAvailabilityCheckRqmtType,
      plart            as ProdAvailyCheckPlanningType,
      @ObjectModel.foreignKey.association: '_ScheduleLineConfStatus'
      wepos            as ScheduleLineConfirmationStatus,
      bedar            as RequirementsClass,

      //InternalProcurement
      plnum            as PlannedOrder,
      @ObjectModel.foreignKey.association: '_OrderID'
      vbep.aufnr       as OrderID,

      //SchedulingAgreement
      abart            as SchedulingAgreementReleaseType,
      abruf            as ScheduleLineByForecastDelivery,
      fsh_os_id        as OrderSchedulingGroup,
      aeskd            as CustEngineeringChgStatus,

      //Purchasing
      banfn            as PurchaseRequisition,
      bnfpo            as PurchaseRequisitionItem,
      bsart            as PurchasingOrderType,
      bstyp            as PurchasingDocumentCategory,

      //shipping
      crea_dlvdate     as DeliveryCreationDate,
      tddat            as TransportationPlanningDate,
      tduhr            as TransportationPlanningTime,
      wadat            as GoodsIssueDate,
      lddat            as LoadingDate,
      wauhr            as GoodsIssueTime,
      lduhr            as LoadingTime,
      lfrel            as ItemIsDeliveryRelevant,
      @ObjectModel.foreignKey.association: '_DelivBlockReasonForSchedLine'
      lifsp            as DelivBlockReasonForSchedLine,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      ordqty_su        as OpenReqdDelivQtyInOrdQtyUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      ordqty_bu        as OpenReqdDelivQtyInBaseUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      ocdqty_su        as OpenConfdDelivQtyInOrdQtyUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      ocdqty_bu        as OpenConfdDelivQtyInBaseUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      dlvqty_su        as DeliveredQtyInOrderQtyUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      dlvqty_bu        as DeliveredQuantityInBaseUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      rrqqty_bu        as RequestedRqmtQtyInBaseUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      crqqty_bu        as ConfirmedRqmtQtyInBaseUnit,
      @DefaultAggregation: #SUM
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      vbep.lmeng       as MRPRequiredQuantityInBaseUnit,
      
      @ObjectModel.foreignKey.association: '_GoodsMovementType'
      bwart            as GoodsMovementType,
      aulwe            as RouteSchedule,

      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      odn_amount       as OpenDeliveryNetAmount,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_TransactionCurrency'
      vbep.waerk       as TransactionCurrency,
      @ObjectModel.foreignKey.association: '_TradeCmplncLegalCtrlChkSts'
      vbep.lccst       as TradeCmplncLegalCtrlChkSts,

      @ObjectModel.association.type: [#TO_COMPOSITION_ROOT]
      _SalesDocument,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT]
      _SalesDocumentItem,
      _ScheduleLineCategory,
      _ProdAvailabilityCheckRqmtType,
      _ScheduleLineConfStatus,
      _TransactionCurrency,
      _OrderID,
      _OrderQuantityUnit,
      _BaseUnit,
      _DelivBlockReasonForSchedLine,
      _GoodsMovementType,
      _TradeCmplncLegalCtrlChkSts
};
