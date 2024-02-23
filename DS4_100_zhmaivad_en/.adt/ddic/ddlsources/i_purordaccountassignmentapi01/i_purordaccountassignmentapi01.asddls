@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: 'IMMPURORDAAAPI01'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType : #COMPOSITE
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@EndUserText.label: 'Account Assignment in Purchase Order'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET ]
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@Metadata.ignorePropagatedAnnotations:true

define view I_PurOrdAccountAssignmentAPI01 
    as select from I_PurOrdAccountAssignment

    association [1..1] to I_PurchaseOrderAPI01           as _PurchaseOrder          on  $projection.PurchaseOrder     = _PurchaseOrder.PurchaseOrder
    association [1..1] to I_PurchaseOrderItemAPI01       as _PurchaseOrderItem      on  $projection.PurchaseOrder     = _PurchaseOrderItem.PurchaseOrder
                                                                                    and $projection.PurchaseOrderItem = _PurchaseOrderItem.PurchaseOrderItem
                                                                                    


{
    key PurchaseOrder,
    key PurchaseOrderItem,
    key AccountAssignmentNumber,
        
        CostCenter,
        MasterFixedAsset,
        ProjectNetwork,
        @Semantics: { quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit' }
        Quantity,
        @Semantics.unitOfMeasure: true
        OrderQuantityUnit as PurchaseOrderQuantityUnit,
        MultipleAcctAssgmtDistrPercent,
        @Semantics: { amount.currencyCode: 'DocumentCurrency' }
        PurgDocNetAmount,
        @Semantics.currencyCode: true
        DocumentCurrency,
        IsDeleted,
        GLAccount,
        BusinessArea,
        SalesOrder,
        SalesOrderItem,
        SalesOrderScheduleLine,
        FixedAsset,
        OrderID,
        UnloadingPointName,
        ControllingArea,
        CostObject,
        @API.element.releaseState: #DEPRECATED
        @API.element.successor:    'ProfitabilitySegment_2'
        cast( ProfitabilitySegment as rkeobjnr_numc ) as ProfitabilitySegment,
        cast( ProfitabilitySegment as rkeobjnr_char ) as ProfitabilitySegment_2, 
        ProfitCenter,
        @API.element.releaseState: #DEPRECATED
        @API.element.successor:    'WBSElementInternalID_2'
        WBSElementInternalID,
        WBSElementInternalID_2,
        ProjectNetworkInternalID,
        @API.element.releaseState: #DEPRECATED
        @API.element.successor:    'CommitmentItemShortID'
        CommitmentItem,
        CommitmentItemShortID,
        FundsCenter,
        Fund,
        FunctionalArea,
        GoodsRecipientName,
        IsFinallyInvoiced,
        @API.element.releaseState: #DEPRECATED
        @API.element.successor: 'REInternalFinNumber'     
        cast   (REInternalFinNumber as imkey preserving type ) as RealEstateObject,
        REInternalFinNumber,
        NetworkActivityInternalID,
        PartnerAccountNumber,
        JointVentureRecoveryCode,
        SettlementReferenceDate,
        OrderInternalID,
        OrderIntBillOfOperationsItem,
        TaxCode,
        TaxJurisdiction,
        @Semantics: { amount.currencyCode: 'DocumentCurrency' }
        NonDeductibleInputTaxAmount,
        CostCtrActivityType,
        BusinessProcess,
        GrantID,
        BudgetPeriod,
        EarmarkedFundsDocument,
        @API.element.releaseState: #DEPRECATED
        @API.element.successor: 'EarmarkedFundsDocumentItem'
        EarmarkedFundsItem,
        EarmarkedFundsDocumentItem,
        ServiceDocumentType,
        ServiceDocument,
        ServiceDocumentItem,
        
    _PurchaseOrder,
    _PurchaseOrderItem
}
