@AbapCatalog.sqlViewName: 'ZEHS_CIDEN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Identified inconsistencies'
@Analytics.query: true
@VDM.viewType: #CONSUMPTION
@OData.publish: true
define view zehs_c_identif_inconsist
  as select from zehs_i_inconsist_data
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
  ContrDate,
  @EndUserText.label: 'Число'
  @AnalyticsDetails.query.axis: #COLUMNS
  ya_rday,
  @EndUserText.label: 'Неделя'
  @AnalyticsDetails.query.axis: #COLUMNS
  ya_sweek,
  @EndUserText.label: 'Месяц'
  @AnalyticsDetails.query.axis: #COLUMNS
  yb_month,
  @EndUserText.label: 'Квартал'
  @AnalyticsDetails.query.axis: #COLUMNS
  yc_quarter,
  @EndUserText.label: 'Год'
  @AnalyticsDetails.query.axis: #COLUMNS
  @Consumption.filter.multipleSelections: true
  yd_year
} 
 