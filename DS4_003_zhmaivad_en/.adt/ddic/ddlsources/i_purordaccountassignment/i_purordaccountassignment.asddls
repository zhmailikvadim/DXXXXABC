@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Purchase Order Account Assignment'
@VDM.viewType: #COMPOSITE
@AbapCatalog.sqlViewName: 'IMMPUROACCASS'
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.type: #INHERITED
@ClientHandling.algorithm: #SESSION_VARIABLE

@UI.headerInfo: {
    typeName: 'Account Assignment Details',
    typeNamePlural: 'Accounts',
    description.label: 'Account Assignment Number',
    description.value: 'AccountAssignmentNumber',
    title.label: 'Purchasing Order',
    title.value: 'PurchasingOrder'
}

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

define view I_PurOrdAccountAssignment

  as select from I_PurgDocAccountAssignment as AccAss
    inner join   I_PurchaseOrderItem on  AccAss.PurchasingDocument     = I_PurchaseOrderItem.PurchaseOrder
                                     and AccAss.PurchasingDocumentItem = I_PurchaseOrderItem.PurchaseOrderItem
  association [1..1] to I_PurchaseOrder     as _PurchaseOrder     on  $projection.PurchaseOrder = _PurchaseOrder.PurchaseOrder

  association [1..1] to I_PurchaseOrderItem as _PurchaseOrderItem on  $projection.PurchaseOrder     = _PurchaseOrderItem.PurchaseOrder
                                                                  and $projection.PurchaseOrderItem = _PurchaseOrderItem.PurchaseOrderItem


{
  key AccAss.PurchasingDocument                            as PurchaseOrder,

  key AccAss.PurchasingDocumentItem                        as PurchaseOrderItem,

  key AccAss.AccountAssignmentNumber,

      PurchasingDocument, //obsolete
      PurchasingDocumentItem, //obsolete

      AccAss.CostCenter,
      AccAss.MasterFixedAsset,
      AccAss.ProjectNetwork,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      cast ('   ' as ps_s4_vornr)                                as NetworkActivity,

      AccAss.OrderQuantityUnit,
      AccAss.Quantity,
      AccAss.MultipleAcctAssgmtDistrPercent,
      @Semantics.currencyCode: true
      @ObjectModel.readOnly
      AccAss.DocumentCurrency,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      AccAss.PurgDocNetAmount,

      AccAss.IsDeleted,
      AccAss.GLAccount,
      AccAss.BusinessArea,
      AccAss.SalesOrder,
      AccAss.SalesOrderItem,
      AccAss.SalesOrderScheduleLine,
      AccAss.FixedAsset,
      AccAss.OrderID,
      cast ('' as vdm_vornr )                               as OrderOperation,
      AccAss.UnloadingPointName,
      AccAss.ControllingArea,
      AccAss.CostObject,
      
      @API.element.releaseState: #DEPRECATED
      @API.element.successor:    'ProfitabilitySegment_2'
      cast( AccAss.ProfitabilitySegment as rkeobjnr_numc ) as ProfitabilitySegment,
      cast( AccAss.ProfitabilitySegment as rkeobjnr_char ) as ProfitabilitySegment_2,

      //  AccAss.ProfitabilitySegment,
      AccAss.ProfitCenter,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'WBSElementInternalID_2' 
      AccAss.WBSElementInternalID,
      cast (AccAss.WBSElementInternalID as ps_s4_pspnr preserving type )   as WBSElementInternalID_2,
      AccAss._WBSElement.WBSElementExternalID,
      AccAss.ProjectNetworkInternalID,
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'CommitmentItemShortID'
      AccAss.CommitmentItem,
      AccAss.CommitmentItemShortID,
      AccAss.FundsCenter,
      AccAss.Fund,
      AccAss.FunctionalArea,
      AccAss.LastChangedDate,
      AccAss.GoodsRecepientName                            as GoodsRecipientName,
      AccAss.IsFinallyInvoiced,
     
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'REInternalFinNumber'     
      cast   ( AccAss.REInternalFinNumber as imkey preserving type ) as RealEstateObject,
      AccAss.REInternalFinNumber,
      AccAss.NetworkActivityInternalID,
      AccAss.PartnerAccountNumber,
      AccAss.JointVentureRecoveryCode,
      AccAss.SettlementReferenceDate,
      AccAss.OrderInternalID,
      AccAss.OrderIntBillOfOperationsItem,
      AccAss.TaxCode,
      AccAss.TaxJurisdiction,
      AccAss.NonDeductibleInputTaxAmount,
      AccAss.CostCtrActivityType,
      AccAss.BusinessProcess,
      AccAss.GrantID,
      AccAss.BudgetPeriod,
      AccAss.EarmarkedFundsDocument,
      AccAss.EarmarkedFundsItem, //  deprecated, use EarmarkedFundsDocumentItem
      AccAss.EarmarkedFundsDocumentItem,
      AccAss.ValidityDate,
      AccAss.ChartOfAccounts,
      AccAss.ServiceDocumentType,
      AccAss.ServiceDocument,
      AccAss.ServiceDocumentItem,
      AccAss.PubSecSplitBatchNumberID,
      AccAss.PubSecSplitAuthznGroup,

      // Field added for R_*TP development
      AccAss.CreationDate,
      AccAss.IsAcctLineFinal,
      AccAss.AcctLineFinalReason,

      // Fild doesn't exist in DB Table, but exists in BAPI POACCOUNT
      // ActivityNumber - ACTIVITY

      // Associations
      _PurchaseOrder.CompanyCode                           as CompanyCode,
      //_CostCenterValueHelp,
      _CostCenter,
      _BusinessArea,
      _ProfitCenter,
      _SalesOrderItem,
      _SalesOrder,
      _ControllingArea,
      _GLAccount,
      _SalesDocumentScheduleLine, // new, added
      _WBSElementByInternalKey, // new, added
      _WBSElement,
      _CommitmentItemShortID,
      _FunctionalArea, // new, added
      _CostCenterActivityType, // new, added
      _BusinessProcess, // new, added
      _TaxCode, // new, added
      _TaxJurisdiction, //new, added
      //_CompanyCode, // new, added
      _FixedAssetWorklist, // new, added
      _CostCenterText, // new, added
      _GLAccountText, //new, added
      _BusinessAreaText, //new, added
      _ProfitCenterText, //new, added
      _FunctionalAreaText, //new, added
      _CostCenterActivityTypeText, //new, added
      _BusinessProcessText, // new, added
      _TaxCodeText, //new, added
      _TaxJurisdictionText, // new, added
      _AcctgServiceDocumentTypeVH, // new, added
      _AcctgServiceDocumentVH, // new, added
      _AcctgServiceDocumentItemVH, // new, added
      _PurchaseOrderItem,
      _PurchaseOrder
}
