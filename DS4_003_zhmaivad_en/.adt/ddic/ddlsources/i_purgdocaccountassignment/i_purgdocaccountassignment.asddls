@AbapCatalog.preserveKey: true
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Purchasing Document Account Assignment'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IPDACCTASSGMT'
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@ClientHandling.algorithm: #SESSION_VARIABLE

@UI.headerInfo: {
    typeName: 'Account Assignment Details',
    typeNamePlural: 'Accounts',
    description.label: 'Account Assignment Number',
    description.value: 'AccountAssignmentNumber',
    title.label: 'Purchasing Document',
    title.value: 'PurchasingDocument'
}

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #MIXED
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API   

define view I_PurgDocAccountAssignment //with parameters P_CompanyCode:BUKRS , P_ChartOfAccounts:KTOPL

  as select from ekkn
  
    association [1..1] to I_PurchasingDocument as _PurchasingDocument on  $projection.PurchasingDocument     = _PurchasingDocument.PurchasingDocument
    association [1..1] to I_PurchasingDocumentItem as _PurchasingDocumentItem on  $projection.PurchasingDocument         = _PurchasingDocumentItem.PurchasingDocument
                                                                              and $projection.PurchasingDocumentItem     = _PurchasingDocumentItem.PurchasingDocumentItem
//  association [0..1] to I_MM_CostCenterValueHelp     as _CostCenterValueHelp        on  $projection.CostCenter      =  _CostCenterValueHelp.CostCenter
//                                                                                    and $projection.ControllingArea =  _CostCenterValueHelp.ControllingArea
//                                                                                    and $projection.ValidityDate    <= _CostCenterValueHelp.ValidityEndDate
//                                                                                    and $projection.ValidityDate    >= _CostCenterValueHelp.ValidityStartDate
  association [0..1] to I_CostCenter                 as _CostCenter                 on  $projection.CostCenter      =  _CostCenter.CostCenter
                                                                                    and $projection.ControllingArea =  _CostCenter.ControllingArea
                                                                                    and $projection.ValidityDate    <= _CostCenter.ValidityEndDate
                                                                                    and $projection.ValidityDate    >= _CostCenter.ValidityStartDate

  association [0..*] to I_CostCenterText             as _CostCenterText             on  $projection.CostCenter      =  _CostCenterText.CostCenter
                                                                                    and $projection.ControllingArea =  _CostCenterText.ControllingArea
                                                                                    and $projection.ValidityDate    <= _CostCenterText.ValidityEndDate
                                                                                    and $projection.ValidityDate    >= _CostCenterText.ValidityStartDate

  association [0..*] to I_GLAccount                  as _GLAccount                  on  $projection.GLAccount = _GLAccount.GLAccount
  //and $projection.CompanyCode = _GLAccount.CompanyCode    // to change cardinality to [0..1] when uncommenting this

  association [0..*] to I_GLAccountText              as _GLAccountText              on  $projection.GLAccount       = _GLAccountText.GLAccount
                                                                                    and $projection.ChartOfAccounts = _GLAccountText.ChartOfAccounts


  association [0..1] to I_BusinessArea               as _BusinessArea               on  $projection.BusinessArea = _BusinessArea.BusinessArea

  association [0..*] to I_BusinessAreaText           as _BusinessAreaText           on  $projection.BusinessArea = _BusinessAreaText.BusinessArea

  association [0..1] to I_ProfitCenter               as _ProfitCenter               on  $projection.ControllingArea =  _ProfitCenter.ControllingArea
                                                                                    and $projection.ProfitCenter    =  _ProfitCenter.ProfitCenter
                                                                                    and $projection.ValidityDate    <= _ProfitCenter.ValidityEndDate
                                                                                    and $projection.ValidityDate    >= _ProfitCenter.ValidityStartDate

  association [0..*] to I_ProfitCenterText           as _ProfitCenterText           on  $projection.ControllingArea =  _ProfitCenterText.ControllingArea
                                                                                    and $projection.ProfitCenter    =  _ProfitCenterText.ProfitCenter
                                                                                    and $projection.ValidityDate    <= _ProfitCenterText.ValidityEndDate

  association [0..1] to I_SalesOrder                 as _SalesOrder                 on  $projection.SalesOrder = _SalesOrder.SalesOrder

  association [0..1] to I_SalesOrderItem             as _SalesOrderItem             on  $projection.SalesOrderItem = _SalesOrderItem.SalesOrderItem
                                                                                    and $projection.SalesOrder     = _SalesOrderItem.SalesOrder

  association [0..1] to I_ControllingArea            as _ControllingArea            on  $projection.ControllingArea = _ControllingArea.ControllingArea

  association [0..1] to I_SalesDocumentScheduleLine  as _SalesDocumentScheduleLine  on  $projection.SalesOrder             = _SalesDocumentScheduleLine.SalesDocument
                                                                                    and $projection.SalesOrderItem         = _SalesDocumentScheduleLine.SalesDocumentItem
                                                                                    and $projection.SalesOrderScheduleLine = _SalesDocumentScheduleLine.ScheduleLine

  association [0..1] to I_WBSElementByInternalKey    as _WBSElementByInternalKey    on  $projection.WBSElementInternalID = _WBSElementByInternalKey.WBSElementInternalID
  
  association [0..1] to I_WBSElementBasicData        as _WBSElement                 on  _WBSElement.WBSElementInternalID = $projection.WBSElementInternalID

  association [0..1] to I_FunctionalArea             as _FunctionalArea             on  $projection.FunctionalArea = _FunctionalArea.FunctionalArea
  
  association [0..1] to I_CommitmentItemShortID      as _CommitmentItemShortID    on  $projection.CommitmentItemShortID = _CommitmentItemShortID.CommitmentItemShortID

  association [0..*] to I_FunctionalAreaText         as _FunctionalAreaText         on  $projection.FunctionalArea = _FunctionalAreaText.FunctionalArea

  association [0..1] to I_CostCenterActivityType     as _CostCenterActivityType     on  $projection.ControllingArea     =  _CostCenterActivityType.ControllingArea
                                                                                    and $projection.CostCtrActivityType =  _CostCenterActivityType.CostCtrActivityType
                                                                                    and $projection.ValidityDate        <= _CostCenterActivityType.ValidityEndDate
                                                                                    and $projection.ValidityDate        >= _CostCenterActivityType.ValidityStartDate

  association [0..*] to I_CostCenterActivityTypeText as _CostCenterActivityTypeText on  $projection.ControllingArea     =  _CostCenterActivityTypeText.ControllingArea
                                                                                    and $projection.CostCtrActivityType =  _CostCenterActivityTypeText.CostCtrActivityType
                                                                                    and $projection.ValidityDate        <= _CostCenterActivityTypeText.ValidityEndDate

  association [0..1] to I_BusinessProcess            as _BusinessProcess            on  $projection.ControllingArea = _BusinessProcess.ControllingArea
                                                                                    and $projection.BusinessProcess = _BusinessProcess.BusinessProcess

  association [0..*] to I_BusinessProcessText        as _BusinessProcessText        on  $projection.ControllingArea =  _BusinessProcessText.ControllingArea
                                                                                    and $projection.BusinessProcess =  _BusinessProcessText.BusinessProcess
                                                                                    and $projection.ValidityDate    <= _BusinessProcessText.ValidityEndDate

  association [0..*] to I_TaxCode                    as _TaxCode                    on  $projection.TaxCode = _TaxCode.TaxCode

  association [0..*] to I_TaxCodeText                as _TaxCodeText                on  $projection.TaxCode = _TaxCodeText.TaxCode

  association [0..*] to I_TaxJurisdiction            as _TaxJurisdiction            on  $projection.TaxJurisdiction = _TaxJurisdiction.TaxJurisdiction

  association [0..*] to I_TaxJurisdictionText        as _TaxJurisdictionText        on  $projection.TaxJurisdiction = _TaxJurisdictionText.TaxJurisdiction

  //association[0..1] to I_CompanyCode as _CompanyCode                               on $projection.CompanyCode = _CompanyCode.CompanyCode

   association [0..*] to I_FixedAsset                as _FixedAssetWorklist         on  $projection.MasterFixedAsset =  _FixedAssetWorklist.MasterFixedAsset
                                                                                    and $projection.FixedAsset       =  _FixedAssetWorklist.FixedAsset
  // and $projection.CompanyCode = _FixedAssetWorklist.CompanyCode // to change cardinality to [0..1] when uncommenting this                                                                                    
                                                                                    
  association [0..*] to I_FixedAsset                 as _FixedAsset                 on  $projection.MasterFixedAsset = _FixedAsset.MasterFixedAsset
                                                                                    and $projection.FixedAsset       = _FixedAsset.FixedAsset
  // and $projection.CompanyCode = _FixedAssetWorklist.CompanyCode  // to change cardinality to [0..1] when uncommenting this

   association [0..*] to I_FundStdVH                  as  _FundStdVH                on _FundStdVH.Fund = $projection.Fund
  
  association [0..1] to I_BudgetPeriodStdVH           as _BudgetPeriodStdVH         on _BudgetPeriodStdVH.BudgetPeriod = $projection.BudgetPeriod
  
//  association [0..1] to I_FundedProgramStdVH as _FundedProgramStdVH on _FundedProgramStdVH.FundedProgram = $projection.fundedprogram
  
  association [0..*] to I_FundsCenterStdVH             as _FundsCenterStdVH         on _FundsCenterStdVH.FundsCenter = $projection.FundsCenter
  
  association[0..*] to I_CommitmentItemStdVH          as _CommitmentItemStdVH       on _CommitmentItemStdVH.CommitmentItem = $projection.CommitmentItem
  
  association[0..*] to I_EmrkdFndsDocumentItemStdVH         as _EarmarkedFundsStdVH       on _EarmarkedFundsStdVH.EarmarkedFundsDocument = $projection.EarmarkedFundsDocument
  
  association[0..1] to I_FndsMgmtFuncnlAreaStdVH      as _FndsMgmtFuncnlAreaStdVH   on _FndsMgmtFuncnlAreaStdVH.FunctionalArea = $projection.FunctionalArea
  
  association [0..*] to I_MM_CostCenterValueHelp      as _MM_CostCenterValueHelp        on  $projection.CostCenter = _MM_CostCenterValueHelp.CostCenter
  
  association [0..1] to I_WBSElementByInternalKey       as _WBSElementByInternalKeyVH   on  $projection.WBSElementInternalID = _WBSElementByInternalKeyVH.WBSElementInternalID
  
  association [0..*] to I_MM_GLAccountVH               as _MM_GLAccountVH               on  $projection.GLAccount = _MM_GLAccountVH.GLAccount                                                                                    

  association [0..1] to I_AcctgServiceDocumentTypeVH   as _AcctgServiceDocumentTypeVH   on  $projection.ServiceDocumentType = _AcctgServiceDocumentTypeVH.ServiceDocumentType                                                                                    

  association [0..*] to I_AcctgServiceDocumentVH       as _AcctgServiceDocumentVH       on  $projection.ServiceDocument = _AcctgServiceDocumentVH.ServiceDocument

  association [0..*] to I_AcctgServiceDocumentItemVH   as _AcctgServiceDocumentItemVH   on  $projection.ServiceDocumentItem = _AcctgServiceDocumentItemVH.ServiceDocumentItem
                                                                                        and $projection.ServiceDocument     = _AcctgServiceDocumentItemVH.ServiceDocument


{
  key ebeln                                                                                         as PurchasingDocument,

  key ebelp                                                                                         as PurchasingDocumentItem,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
  key zekkn                                                                                         as AccountAssignmentNumber,
      --@Consumption: { valueHelp: '_CostCenterValueHelp', semanticObject: 'CostCenter' }
      
      @ObjectModel.foreignKey.association: '_CostCenter' -- to be clarified --
      @ObjectModel.text.association: '_CostCenterText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_MM_CostCenterValueHelp'      
      kostl                                                                                         as CostCenter,

      @ObjectModel.foreignKey.association: '_FixedAsset'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      anln1                                                                                         as MasterFixedAsset,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      nplnr                                                                                         as ProjectNetwork,
      
     
      @Semantics.unitOfMeasure: true
     _PurchasingDocumentItem.OrderQuantityUnit,
     
     @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      menge                                                                                         as Quantity,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      vproz                                                                                         as MultipleAcctAssgmtDistrPercent,
      
      @Semantics.currencyCode: true
      _PurchasingDocument.DocumentCurrency,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      netwr                                                                                         as PurgDocNetAmount,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      loekz                                                                                         as IsDeleted,

      @ObjectModel.foreignKey.association: '_GLAccount'
      //@ObjectModel.text.association: '_GLAccountText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined' 
      @Consumption.valueHelp: '_MM_GLAccountVH'
      sakto                                                                                         as GLAccount,

      @ObjectModel.foreignKey.association: '_BusinessArea'
      @ObjectModel.text.association: '_BusinessAreaText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      gsber                                                                                         as BusinessArea,

      @ObjectModel.foreignKey.association: '_SalesOrder'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      vbeln                                                                                         as SalesOrder,

      @ObjectModel.foreignKey.association: '_SalesOrderItem'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      vbelp                                                                                         as SalesOrderItem,

      @ObjectModel.foreignKey.association: '_SalesDocumentScheduleLine'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      veten                                                                                         as SalesOrderScheduleLine,

      @ObjectModel.foreignKey.association: '_FixedAsset'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      anln2                                                                                         as FixedAsset,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      aufnr                                                                                         as OrderID,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      ablad                                                                                         as UnloadingPointName,
      
      @ObjectModel.foreignKey.association: '_ControllingArea'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      kokrs                                                                                         as ControllingArea,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      kstrg                                                                                         as CostObject,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      paobjnr                                                                                       as ProfitabilitySegment,

      @ObjectModel.foreignKey.association: '_ProfitCenter'
      @ObjectModel.text.association: '_ProfitCenterText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      prctr                                                                                         as ProfitCenter,

      @ObjectModel.foreignKey.association: '_WBSElementByInternalKey'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      ps_psp_pnr                                                                                    as WBSElementInternalID,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      aufpl                                                                                         as ProjectNetworkInternalID,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_CommitmentItemStdVH'
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'CommitmentItemShortID'
      fipos                                                                                         as CommitmentItem,


      cast( fipos as fmis_ci_internalname )                                                         as CommitmentItemShortID,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_FundsCenterStdVH'
      fistl                                                                                         as FundsCenter,

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_FundStdVH'
      geber                                                                                         as Fund,

      //@ObjectModel.readOnly: 'undefined'
      //@ObjectModel.mandatory: 'undefined'
      //geber as Funds,//Deprectaed . Please use AssetFund

      @ObjectModel.foreignKey.association: '_FunctionalArea'
      @ObjectModel.text.association: '_FunctionalAreaText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_FndsMgmtFuncnlAreaStdVH'
      fkber                                                                                         as FunctionalArea,

      cast('' as erdat )                                                                            as LastChangedDate, // obsolete, do not use

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      aedat                                                                                         as CreationDate, //new , modified


      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      wempf                                                                                         as GoodsRecepientName, //obsolete, use GoodsRecipientName instead

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      wempf                                                                                         as GoodsRecipientName, //new , added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      erekz                                                                                         as IsFinallyInvoiced, //new , added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @VDM.lifecycle.status: #DEPRECATED
      @VDM.lifecycle.successor: 'REInternalFinNumber'
      imkey                                                                                         as RealEstateObject, //new , added
      
      
      cast ( imkey as recaimkeyfi preserving type )                                                 as REInternalFinNumber,
      

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      aplzl                                                                                         as NetworkActivityInternalID, //new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      vptnr                                                                                         as PartnerAccountNumber, //new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      recid                                                                                         as JointVentureRecoveryCode, // new, added


      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      dabrz                                                                                         as SettlementReferenceDate, // new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      aufpl_ord                                                                                     as OrderInternalID, // new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      aplzl_ord                                                                                     as OrderIntBillOfOperationsItem, // new, added

      @ObjectModel.foreignKey.association: '_TaxCode'
      @ObjectModel.text.association: '_TaxCodeText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      mwskz                                                                                         as TaxCode, // new, added

      @ObjectModel.foreignKey.association: '_TaxJurisdiction'
      @ObjectModel.text.association: '_TaxJurisdictionText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      txjcd                                                                                         as TaxJurisdiction, // new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      navnw                                                                                         as NonDeductibleInputTaxAmount, //new, added

      @ObjectModel.foreignKey.association: '_CostCenterActivityType'
      @ObjectModel.text.association: '_CostCenterActivityTypeText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      lstar                                                                                         as CostCtrActivityType, // new, added

      @ObjectModel.foreignKey.association: '_BusinessProcess'
      @ObjectModel.text.association: '_BusinessProcessText'
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      prznr                                                                                         as BusinessProcess, // new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_BudgetPeriodStdVH'
      grant_nbr                                                                                     as GrantID, // new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
   //   @Consumption.valueHelp: ' '
      budget_pd                                                                                     as BudgetPeriod, // new, added

      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_EarmarkedFundsStdVH'
      kblnr                                                                                         as EarmarkedFundsDocument, // new, added

      @Semantics.businessDate.at: true
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @EndUserText.label: 'Validity Date'
      $session.system_date  as ValidityDate, // new, added
      _ControllingArea.ChartOfAccounts                                                              as ChartOfAccounts,

      kblpos                                                                                        as EarmarkedFundsItem, // new, added
      kblpos                                                                                        as EarmarkedFundsDocumentItem, // new, added

      fm_split_batch                                                                                as PubSecSplitBatchNumberID, // new, added
      fm_split_begru                                                                                as PubSecSplitAuthznGroup, // new, added

      aa_final_ind                                                                                  as IsAcctLineFinal, // new, added

      aa_final_reason                                                                               as AcctLineFinalReason, // new, added
      
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_AcctgServiceDocumentTypeVH'
      service_doc_type                                                                              as ServiceDocumentType, // new, added
      
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_AcctgServiceDocumentVH'
      service_doc_id                                                                                as ServiceDocument, // new, added
      
      @ObjectModel.readOnly: 'undefined'
      @ObjectModel.mandatory: 'undefined'
      @Consumption.valueHelp: '_AcctgServiceDocumentItemVH'
      service_doc_item_id                                                                           as ServiceDocumentItem, // new, added

      //@ObjectModel.foreignKey.association: '_CompanyCode'
      //@UI:{
      //    fieldGroup: {qualifier: 'ThirdGroup', position: 10, importance: #HIGH}
      // }
      //@ObjectModel.readOnly: 'undefined'
      //@ObjectModel.mandatory: 'undefined'
      //_GLAccount.CompanyCode  as CompanyCode, //new, added
      
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
      _FixedAssetWorklist,
      _FixedAsset,
      _CostCenterText, // new, added
      _GLAccountText, //new, added
      _BusinessAreaText, //new, added
      _ProfitCenterText, //new, added
      _FunctionalAreaText, //new, added
      _CostCenterActivityTypeText, //new, added
      _BusinessProcessText, // new, added
      _TaxCodeText, //new, added
      _TaxJurisdictionText, // new, added
      _FundStdVH,
      _BudgetPeriodStdVH,  
      _FundsCenterStdVH,
      _CommitmentItemStdVH,
      _EarmarkedFundsStdVH,
      _FndsMgmtFuncnlAreaStdVH,
      _MM_CostCenterValueHelp,
      _WBSElementByInternalKeyVH,
      _MM_GLAccountVH,
      _AcctgServiceDocumentTypeVH,
      _AcctgServiceDocumentVH,
      _AcctgServiceDocumentItemVH 
       
} 
  
 