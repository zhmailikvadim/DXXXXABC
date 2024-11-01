@AbapCatalog.sqlViewName: 'PFIGLACCTINCC'
@VDM.viewType: #BASIC
@VDM.private:true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.buffering.status: #NOT_ALLOWED
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.preserveKey:true
define view P_Glacct_In_Cc 
as select from I_GLAccountInCompanyCode {
  key GLAccount,
  key CompanyCode,
      AuthorizationGroup,
      AccountingClerk,
      LastInterestCalcRunDate,
      CreationDate,
      CreatedByUser,
      LastChangeDateTime,
      PlanningLevel,
      HouseBank,
      HouseBankAccount,
      ExchRateDifferencesAccountDetn,
      
      ReconciliationAccountType,
      
      TaxCategory,
      InterestCalculationCode,
      GLAccountCurrency,
      ReconciliationAcctIsChangeable,
      
      IsManagedExternally,
      IsAutomaticallyPosted,
      LineItemDisplayIsEnabled,
      SupplementIsAllowed,
      IsOpenItemManaged,
      InterestCalculationDate,
      IntrstCalcFrequencyInMonths,
      AcctgDocItmDisplaySequenceRule,
      AlternativeGLAccount,
      JointVentureRecoveryCode,
      CommitmentItem,
      TaxCodeIsRequired,
      BalanceHasLocalCurrency,
      ValuationGroup,
      APARToleranceGroup,
      AccountIsBlockedForPosting,
      AccountIsMarkedForDeletion,
      ClearingIsLedgerGroupSpecific,
      CashPlanningGroup,
      IsCashFlowAccount,
      GLAcctInflationKey,
      
      FieldStatusGroup,
      MultiCurrencyAccountingCode,
      
      _CompanyCode.ChartOfAccounts,
      _CompanyCode.CountryChartOfAccounts,

      _User,
      _CompanyCode,
      _Text,
      _Reconciliationaccttype,
      _JointVentureRecovery,
      _MultiCurrencyAccounting,
      _TaxCategory
}
