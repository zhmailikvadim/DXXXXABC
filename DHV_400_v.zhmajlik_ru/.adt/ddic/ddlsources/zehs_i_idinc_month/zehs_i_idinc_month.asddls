@AbapCatalog.sqlViewName: 'ZEHS_IMON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Identified inconsistencies'
@Analytics.dataCategory: #CUBE
define view zehs_i_idinc_month
  as select from zehs_d_log_tc      as log_tc
    inner join   zehs_d_acc_check   as acc_check on  acc_check.mandt = log_tc.client
                                                 and acc_check.bukrs = log_tc.Bukrs
                                                 and acc_check.orgeh = log_tc.OrgUnit
    inner join   zehs_d_hierarchy   as hierarch  on  hierarch.mandt = log_tc.client
                                                 and hierarch.bukrs = log_tc.Bukrs
                                                 and hierarch.orgeh = log_tc.OrgUnit
    inner join   zehs_d_datedetails as date      on  calendardate             = $session.system_date
                                                 and date.Firstdayofmonthdate <= log_tc.ContrDate
                                                 and date.Lastdayofmonthdate  >= log_tc.ContrDate
  association [0..1] to zehs_d_task_i as _Task_i on  $projection.client        = _Task_i.client
                                                 and $projection.TaskId        = _Task_i.TaskId
                                                 and $projection.EhfndLocation = _Task_i.LocationId
                                                 and $projection.CntrlPoint    = _Task_i.CntrlPointId
{
  key client,
  key Id,
  key EhfndLocation,
  key CntrlPoint,
      LocationText,
      TaskId,
      log_tc.Bukrs,
      Butxt,
      OrgUnit,
      OrgUnitText,
      hierarch.stext1     as OrgUnitText1,
      hierarch.stext2     as OrgUnitText2,
      hierarch.stext3     as OrgUnitText3,
      hierarch.stext4     as OrgUnitText4,
      CtrlType,
      CntrlDescr,
      Bname,
      Fio,
      Workr,
      WorkrText,
      ContrDate,
      Typev,
      ViolationDesc,
      ViolationEndda,
      Levels,
      SeverityDesc,
      CntrlPenT,
      _Task_i.Description as TaskDescr,
      CntrlPointDescr,
      /** MEASURES **/
      @DefaultAggregation: #SUM
      1                   as count_rec,

      /* Associations */
      _Task_i
} 
 