/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* PISHCALI     | 13.09.2022 | 13391: FI_BE BUILD - Limit Custom Report *
*              |            | DS4K929386                               *
*----------------------------------------------------------------------*/
@AbapCatalog.dataMaintenance : #NOT_ALLOWED
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #CONSUMPTION
@EndUserText.label: 'Cons. View for Limit Custom Report'

@UI: { lineItem: [{criticality: 'DifferenceCriticality'}] ,
       headerInfo: {typeName: 'IHB Limit Report',
                    typeNamePlural: 'IHB Limit Report'}}

@UI.chart: [{
              chartType:         #BULLET ,
              measures:          ['BALANCEFORCHART'],
              measureAttributes: [{ measure:     'BalanceForChart',
                                    role:        #AXIS_1 ,
                                    asDataPoint: true }] }]

define root view entity ZFI_C_LIM_REP
  with parameters
    @EndUserText.label: 'Key Date'
    @Semantics.dateTime: true
    @Environment.systemField: #SYSTEM_DATE
    p_date : dats

  as select from ZFI_I_LIM_REP(p_date: $parameters.p_date) as LimitReport
{
         @UI.lineItem: [{ position: 10,
                          importance: #HIGH,
                          label: 'Bank Area' } ]
         @UI.selectionField: [{position: 10 }]
         @ObjectModel.text.element: ['BankAreaDescription']
         @Consumption.filter:{ multipleSelections: true }
         @Consumption.valueHelpDefinition: [{ entity: { name: 'ZFI_I_LIM_BANK_AREA_VH', element: 'BankArea' }  }]
  key    LimitReport.BankArea,

         @UI.lineItem: [{ position: 20,
                          importance: #HIGH,
                          label: 'Business Partner' }]
         @UI.selectionField: [{position: 20 }]
         @ObjectModel.text.element: ['BusinessPartnerName']
         @Consumption.filter:{ multipleSelections: true }
         @Consumption.valueHelpDefinition: [{ entity: { name: 'ZFI_I_LIM_BUSINESS_PARTNER_VH', element: 'BusinessPartnerNumber' } }]
  key    LimitReport.BusinessPartnerNumber,

         @UI.hidden: true
         LimitReport.BusinessPartnerName,

         @UI.hidden: true
         LimitReport.BankAreaDescription,

         @UI.hidden: true
         LimitReport.CurrentDate,

         @UI.hidden: true
         LimitReport.TargetCurrency,

         @UI.lineItem: [{ position: 30,
                          importance: #HIGH,
                          label: 'Value Date Balance' }]
         @Semantics.amount.currencyCode: 'TargetCurrency'
         LimitReport.Balance,


         @UI.lineItem: [{ position: 40,
                          importance: #HIGH,
                          label: 'Limit' }]
         @Semantics.amount.currencyCode: 'TargetCurrency'

         LimitReport.AccountLimit,

         @UI.lineItem: [{ position: 50, importance: #HIGH,
                          label: 'Difference',
                          criticality: 'DifferenceCriticality',
                          criticalityRepresentation: #WITHOUT_ICON }]
         @Semantics.amount.currencyCode: 'TargetCurrency'
         LimitReport.Difference,

         @UI.hidden: true
         @EndUserText.label: 'Difference Crit.'
         LimitReport.DifferenceCriticality,

         @UI:{ lineItem: [{ position: 60 ,
                            type: #AS_CHART,
                            label: 'Limit Chart' }] }

         @UI.dataPoint: { title: 'Balance For Chart' ,
                          targetValueElement: 'AccountLimit',
                          minimumValue: 0 ,
                          criticalityCalculation: {
                            improvementDirection: #MINIMIZE,
                            toleranceRangeHighValueElement: 'AccountLimit',
                            deviationRangeHighValueElement: 'AccountLimit' }
                         }
         @UI.hidden: true
         LimitReport.BalanceForChart
}
