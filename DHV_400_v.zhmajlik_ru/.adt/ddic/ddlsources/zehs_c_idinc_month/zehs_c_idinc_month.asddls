@AbapCatalog.sqlViewName: 'ZEHS_CMON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Identified inconsistencies'
@Analytics.query: true
@VDM.viewType: #CONSUMPTION
@OData.publish: true
define view zehs_c_idinc_month
  as select from zehs_i_idinc_month
{
  @EndUserText.label: 'Обособленное подразделение'
  @AnalyticsDetails.query.axis: #COLUMNS
  Butxt,
  @EndUserText.label: 'Структурное подразделение'
  @AnalyticsDetails.query.axis: #COLUMNS
  OrgUnitText,
  @EndUserText.label: 'Структурное подразделение>'
  @AnalyticsDetails.query.axis: #COLUMNS
  OrgUnitText1,
  @EndUserText.label: 'Структурное подразделение>>'
  @AnalyticsDetails.query.axis: #COLUMNS
  OrgUnitText2,
  @EndUserText.label: 'Структурное подразделение>>>'
  @AnalyticsDetails.query.axis: #COLUMNS
  OrgUnitText3,
  @EndUserText.label: 'Структурное подразделение>>>>'
  @AnalyticsDetails.query.axis: #COLUMNS
  OrgUnitText4,
  @EndUserText.label: 'Вид контроля'
  @AnalyticsDetails.query.axis: #COLUMNS
  CntrlDescr,
  @EndUserText.label: 'Должность'
  @AnalyticsDetails.query.axis: #COLUMNS
  WorkrText,
  @EndUserText.label: 'ФИО'
  @AnalyticsDetails.query.axis: #COLUMNS
  Fio,
  @EndUserText.label: 'Виды нарушений'
  @AnalyticsDetails.query.axis: #COLUMNS
  ViolationDesc,
  @EndUserText.label: 'Объект мониторинга'
  @AnalyticsDetails.query.axis: #COLUMNS
  LocationText,
  @EndUserText.label: 'Степень тяжести'
  @AnalyticsDetails.query.axis: #COLUMNS
  SeverityDesc,
  @EndUserText.label: 'Вид ответственности'
  @AnalyticsDetails.query.axis: #COLUMNS
  CntrlPenT,
  @EndUserText.label: 'Точка контроля'
  @AnalyticsDetails.query.axis: #COLUMNS
  CntrlPointDescr,
  @EndUserText.label: 'Комментарий'
  @AnalyticsDetails.query.axis: #COLUMNS
  TaskDescr,
  @EndUserText.label: 'Количество несоответствий'
  count_rec,
  @EndUserText.label: 'Дата контроля'
  @AnalyticsDetails.query.axis: #COLUMNS
  ContrDate
} 
 