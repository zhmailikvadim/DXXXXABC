@EndUserText.label: 'General Ledger Account in Company Code'
@Analytics: {dataCategory: #DIMENSION, dataExtraction.enabled: true}
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IFIGLACCINCCODE'
@ObjectModel.entityChangeStateId: 'LastChangeDateTime'
@ObjectModel.representativeKey: 'GLAccount'
@AbapCatalog.buffering.status: #NOT_ALLOWED
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass:  #MASTER
@ObjectModel.usageType.serviceQuality: #C
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
@AbapCatalog.preserveKey:true
define view I_GLAccountInCompanyCode
  as select from skb1
  association [0..1] to I_CompanyCode                as _CompanyCode             on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..*] to I_GlAccountTextInCompanycode as _Text                    on  $projection.CompanyCode = _Text.CompanyCode
                                                                                 and $projection.GLAccount   = _Text.GLAccount
  association [1..1] to I_User                       as _User                    on  $projection.CreatedByUser = _User.UserID
  association [0..1] to I_Reconciliationaccttype     as _Reconciliationaccttype  on  $projection.ReconciliationAccountType = _Reconciliationaccttype.ReconciliationAccountType
  association [0..1] to I_JointVentureRecovery       as _JointVentureRecovery    on  $projection.CompanyCode              = _JointVentureRecovery.CompanyCode
                                                                                 and $projection.JointVentureRecoveryCode = _JointVentureRecovery.JointVentureRecoveryCode
  association [0..1] to I_MultiCurrencyAccounting    as _MultiCurrencyAccounting on  $projection.MultiCurrencyAccountingCode = _MultiCurrencyAccounting.MultiCurrencyAccountingCode

  association [0..1] to I_TaxCategory                as _TaxCategory             on  $projection.CompanyCode = _TaxCategory.CompanyCode
                                                                                 and $projection.TaxCategory = _TaxCategory.TaxCategory

{
      @ObjectModel.text.association: '_Text'
      @Search.defaultSearchElement:true
      @Search.fuzzinessThreshold:0.8
      @Search.ranking:#HIGH
  key skb1.saknr                                                    as GLAccount,
      @ObjectModel.foreignKey.association: '_CompanyCode' //Inserted by VDM CDS Suite Plugin
  key skb1.bukrs                                                    as CompanyCode,
      skb1.begru                                                    as AuthorizationGroup,
      skb1.busab                                                    as AccountingClerk,
      skb1.datlz                                                    as LastInterestCalcRunDate,
      skb1.erdat                                                    as CreationDate,
      skb1.ernam                                                    as CreatedByUser,
      cast(case
        when skb1.last_changed_ts    = 0 then cast( '19700101010101' as timestamp )
        else skb1.last_changed_ts
      end as timestamp)                                             as LastChangeDateTime,
      skb1.fdlev                                                    as PlanningLevel,
      skb1.hbkid                                                    as HouseBank,
      skb1.hktid                                                    as HouseBankAccount,
      skb1.kdfsl                                                    as ExchRateDifferencesAccountDetn,
      @ObjectModel.foreignKey.association: '_Reconciliationaccttype'
      skb1.mitkz                                                    as ReconciliationAccountType,
      @ObjectModel.foreignKey.association: '_TaxCategory'
      skb1.mwskz                                                    as TaxCategory,
      skb1.vzskz                                                    as InterestCalculationCode,
      skb1.waers                                                    as GLAccountCurrency,
      skb1.xmitk                                                    as ReconciliationAcctIsChangeable,
      //skb1.wmeth as IsManagedExternally,
      cast( substring(skb1.wmeth, 1, 1) as fac_gl_acct_extern_ind ) as IsManagedExternally,
      skb1.xintb                                                    as IsAutomaticallyPosted,
      skb1.xkres                                                    as LineItemDisplayIsEnabled,
      skb1.xnkon                                                    as SupplementIsAllowed,
      skb1.xopvw                                                    as IsOpenItemManaged,
      skb1.zindt                                                    as InterestCalculationDate,
      skb1.zinrt                                                    as IntrstCalcFrequencyInMonths,
      skb1.zuawa                                                    as AcctgDocItmDisplaySequenceRule,
      skb1.altkt                                                    as AlternativeGLAccount,
      skb1.recid                                                    as JointVentureRecoveryCode,
      skb1.fipos                                                    as CommitmentItem,
      skb1.xmwno                                                    as TaxCodeIsRequired,
      skb1.xsalh                                                    as BalanceHasLocalCurrency,
      skb1.bewgp                                                    as ValuationGroup,
      skb1.togru                                                    as APARToleranceGroup,
      skb1.xspeb                                                    as AccountIsBlockedForPosting,
      skb1.xloeb                                                    as AccountIsMarkedForDeletion,
      skb1.xlgclr                                                   as ClearingIsLedgerGroupSpecific,
      skb1.fdgrv                                                    as CashPlanningGroup,
      skb1.xgkon                                                    as IsCashFlowAccount,
      skb1.infky                                                    as GLAcctInflationKey,
      skb1.fstag                                                    as FieldStatusGroup,
      skb1.mcakey                                                   as MultiCurrencyAccountingCode,

      _User,
      _CompanyCode,
      _Text,
      _Reconciliationaccttype,
      _JointVentureRecovery,
      _MultiCurrencyAccounting,
      _TaxCategory
};
