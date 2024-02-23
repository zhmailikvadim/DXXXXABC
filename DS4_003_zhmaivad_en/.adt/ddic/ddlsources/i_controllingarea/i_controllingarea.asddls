@EndUserText.label: 'Controlling Area'
@Analytics:{
    dataCategory: #DIMENSION,
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IFICONTAREA'
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'ControllingArea'
@ClientHandling.algorithm: #SESSION_VARIABLE

@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@ObjectModel.modelingPattern: [ #ANALYTICAL_DIMENSION ]

@ObjectModel.usageType: {
  dataClass: #CUSTOMIZING,
  serviceQuality: #A,
  sizeCategory: #S
}

@Search.searchable: true

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

//--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//@AccessControl.privilegedAssociations: ['_ChartOfAccountsText']
// ]--GENERATED

define view I_ControllingArea
  as select from    tka01
    left outer join I_SAPClient on tka01.mandt = I_SAPClient.sapclient


  //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
  association [0..*] to I_ChartOfAccountsText    as _ChartOfAccountsText       on $projection.ChartOfAccounts = _ChartOfAccountsText.ChartOfAccounts
  // ]--GENERATED
  association [0..*] to I_FinancialStatementHier as _FinancialStatementVersion on $projection.CtrlgStdFinStatementVersion = _FinancialStatementVersion.FinancialStatementHierarchy
  association [0..*] to I_FinancialStatementHierT as _FinancialStatementVersionText  on $projection.CtrlgStdFinStatementVersion = _FinancialStatementVersionText.FinancialStatementHierarchy
  
  association [1]    to I_Currency               as _Currency                  on $projection.ControllingAreaCurrency = _Currency.Currency
  association [1]    to I_ChartOfAccounts        as _ChartOfAccounts           on $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts

{

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['ControllingAreaName']
  key cast( tka01.kokrs as fis_kokrs preserving type )              as ControllingArea,
      cast( tka01.lmona as fis_periv preserving type )              as FiscalYearVariant,
      @Semantics.text: true
      cast( tka01.bezei as fis_kokrs_name preserving type )         as ControllingAreaName,
      @ObjectModel.foreignKey.association: '_Currency'
      cast( tka01.waers as fis_kwaer preserving type )              as ControllingAreaCurrency,
      _Currency,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ChartOfAccountsStdVH',
                     element: 'ChartOfAccounts' }
        }]
      @ObjectModel.text.association: '_ChartOfAccountsText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ChartOfAccounts'
      cast( tka01.ktopl as fis_ktopl preserving type )              as ChartOfAccounts,
      _ChartOfAccounts,
      cast( tka01.khinr as fis_ksthi preserving type )              as CostCenterStandardHierarchy,
      tka01.erkrs                                                   as OperatingConcern,
      cast( tka01.phinr as fis_prctr_std_hier preserving type )     as ProfitCenterStandardHierarchy,
      cast( tka01.bphinr as fis_co_bphinr preserving type )         as BusinessProcessStandardHier,
      cast( tka01.kstar_fin as fis_kstar_fin preserving type )      as CreditDownPaymentDefaultGLAcct,
      cast( tka01.kstar_fid as fis_kstar_fid preserving type )      as DebitDownPaymentDefaultGLAcct,
      cast( tka01.ctyp as fis_co_ctyp preserving type )             as ControllingAreaCurrencyRole,
      tka01.fikrs                                                   as FinancialManagementArea,
      cast( tka01.vname as fis_co_vname preserving type )           as ControllingAreaResponsibleUser,
      cast( tka01.defprctr as fis_defprctr preserving type )        as DefaultProfitCenter,
      @ObjectModel.text.association: '_FinancialStatementVersionText'
      @ObjectModel.foreignKey.association: '_FinancialStatementVersion'
      cast( tka01.leading_fsv as fis_leading_fsv preserving type )  as CtrlgStdFinStatementVersion,
      @Consumption.filter.businessDate.at: true
      _FinancialStatementVersion,
      @Consumption.filter.businessDate.at: true
      _FinancialStatementVersionText,
      //tka01.xwbuk as CoCodeCrcyIsDifferent,

      //t000.mwaer as PCACUR30,
      //tka01.pcacur as PCACUR90,
      //tka01.waers as PCACUR20,
      //tka01.pcacurtp as CurrencyRole

      case
      pcacurtp
      when '20' then
        cast( tka01.waers as fis_pcacur preserving type )
      when '30' then
        cast( I_SAPClient.GroupCurrency as fis_pcacur preserving type )
      else
        cast( tka01.pcacur as fis_pcacur preserving type )
      end                                                        as ProfitCenterAccountingCurrency,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.hidden: true
      _ChartOfAccountsText
      // ]--GENERATED


};
