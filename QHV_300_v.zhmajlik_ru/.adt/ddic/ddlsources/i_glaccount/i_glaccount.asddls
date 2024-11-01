@EndUserText.label: 'General Ledger Account'
@Analytics: {dataCategory: #DIMENSION, dataExtraction.enabled: true}
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IFIGLACCOUNT'
@ObjectModel.representativeKey: 'GLAccount'
@AbapCatalog.buffering.status: #NOT_ALLOWED
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass:  #MASTER
@ObjectModel.usageType.serviceQuality: #C
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true
//--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
@AccessControl.privilegedAssociations: ['_ChartOfAccountsText']
// ]--GENERATED

define view I_GLAccount

  as select from I_GLAccountInChartOfAccounts as GLAccountInChartOfAccounts
    inner join   P_Glacct_In_Cc               as GLAccountInCompanyCode on  GLAccountInChartOfAccounts.GLAccount       = GLAccountInCompanyCode.GLAccount
                                                                        and GLAccountInChartOfAccounts.ChartOfAccounts = GLAccountInCompanyCode.ChartOfAccounts


  //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
  association [0..*] to I_ChartOfAccountsText        as _ChartOfAccountsText        on  $projection.ChartOfAccounts = _ChartOfAccountsText.ChartOfAccounts
  // ]--GENERATED
  association [0..1] to I_GLAccountInCompanyCode     as _GLAccountInCompanyCode     on  $projection.GLAccount   = _GLAccountInCompanyCode.GLAccount
                                                                                    and $projection.CompanyCode = _GLAccountInCompanyCode.CompanyCode

  association [1..1] to I_GLAccountInChartOfAccounts as _GLAccountInChartOfAccounts on  $projection.ChartOfAccounts = _GLAccountInChartOfAccounts.ChartOfAccounts
                                                                                    and $projection.GLAccount       = _GLAccountInChartOfAccounts.GLAccount

  association [0..1] to I_ChartOfAccounts            as _ChartOfAccounts            on  $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts

  association [0..*] to I_GlAccountTextInCompanycode as _Text                       on  $projection.CompanyCode = _Text.CompanyCode
                                                                                    and $projection.GLAccount   = _Text.GLAccount

  association [0..1] to I_CompanyCode                as _CompanyCode                on  $projection.CompanyCode = _CompanyCode.CompanyCode

  association [0..1] to I_FunctionalArea             as _FunctionalArea             on  $projection.FunctionalArea = _FunctionalArea.FunctionalArea

{
      @ObjectModel.text.association: '_Text'
      @Search.defaultSearchElement:true
      @Search.fuzzinessThreshold:0.8
      @Search.ranking:#HIGH

  key GLAccountInChartOfAccounts.GLAccount                              as GLAccount,
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_CompanyCodeStdVH',
                     element: 'CompanyCode' }
        }]
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CompanyCode'
  key GLAccountInCompanyCode.CompanyCode                                as CompanyCode,
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ChartOfAccountsStdVH',
                     element: 'ChartOfAccounts' }
        }]
      @ObjectModel.text.association: '_ChartOfAccountsText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ChartOfAccounts'
      GLAccountInChartOfAccounts.ChartOfAccounts,
      GLAccountInChartOfAccounts.GLAccountGroup,
      GLAccountInChartOfAccounts.CorporateGroupAccount,
      GLAccountInChartOfAccounts.AccountIsBlockedForPosting,
      GLAccountInChartOfAccounts.AccountIsBlockedForPlanning,
      GLAccountInChartOfAccounts.AccountIsBlockedForCreation,
      GLAccountInChartOfAccounts.IsBalanceSheetAccount,
      GLAccountInChartOfAccounts.AccountIsMarkedForDeletion,
      GLAccountInChartOfAccounts.PartnerCompany,
      @ObjectModel.foreignKey.association: '_FunctionalArea'
      GLAccountInChartOfAccounts.FunctionalArea,
      GLAccountInChartOfAccounts.CreationDate,
      GLAccountInChartOfAccounts.SampleGLAccount,
      @EndUserText.label: 'Balance Sheet Account'
      GLAccountInChartOfAccounts.IsProfitLossAccount,
      GLAccountInChartOfAccounts.CreatedByUser,
      GLAccountInChartOfAccounts.ProfitLossAccountType,
      GLAccountInCompanyCode.ReconciliationAccountType,
      GLAccountInCompanyCode.LineItemDisplayIsEnabled,
      GLAccountInCompanyCode.IsOpenItemManaged,
      GLAccountInCompanyCode.AlternativeGLAccount,
      GLAccountInCompanyCode.AcctgDocItmDisplaySequenceRule,
      cast( GLAccountInChartOfAccounts.GLAccountExternal as fac_sakan ) as GLAccountExternal,
      GLAccountInCompanyCode.CountryChartOfAccounts,
      GLAccountInCompanyCode.AuthorizationGroup,
      GLAccountInCompanyCode.TaxCategory,
      GLAccountInCompanyCode.IsAutomaticallyPosted,
      _CompanyCode,
      _Text,
      _GLAccountHierarchyNode,
      _ChartOfAccounts,
      _FunctionalArea,
      _GLAccountInCompanyCode,
      _GLAccountInChartOfAccounts,
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.hidden: true
      _ChartOfAccountsText
      // ]--GENERATED

};
