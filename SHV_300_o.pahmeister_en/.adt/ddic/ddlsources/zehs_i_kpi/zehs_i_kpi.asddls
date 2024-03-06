@AbapCatalog.sqlViewName: 'ZEHS_IKPI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Кол-ые показатели состояния охраны труда'
@Analytics.dataCategory: #CUBE
define view zehs_i_kpi
  as select from zehs_d_kpi       as kpi
    inner join   zehs_d_acc_check as acc_check on  acc_check.bukrs = kpi.Bukrs
                                               and acc_check.orgeh = kpi.OrgUnit
{
  key kpi.Bukrs,
  key kpi.OrgUnit,
      Butxt,
      OrgUnitText,
      yd_year,
      yc_quarter,
      yb_month,

      /** MEASURES **/
      @DefaultAggregation: #SUM
      Kinc*100   as K1,
      @DefaultAggregation: #SUM
      Ktskdiv    as C1,
      @DefaultAggregation: #SUM
      Krep*100   as K2,
      @DefaultAggregation: #SUM
      Kinc       as C2,
      @DefaultAggregation: #SUM
      Ktick*100  as K3,
      @DefaultAggregation: #SUM
      Ktickdiv   as C3,
      @DefaultAggregation: #SUM
      Kdis*100   as K4,
      @DefaultAggregation: #SUM
      Kdisdiv    as C4,
      @DefaultAggregation: #SUM
      Ksan*100   as K5,
      @DefaultAggregation: #SUM
      Ksandiv    as C5,
      @DefaultAggregation: #SUM
      Kexe*100   as K6,
      @DefaultAggregation: #SUM
      Ktskdiv    as C6,
      @DefaultAggregation: #SUM
      Kstrt*100  as K7,
      @DefaultAggregation: #SUM
      Kstop      as C7,
      @DefaultAggregation: #SUM
      Kincid*100 as K8,
      @DefaultAggregation: #SUM
      Kinciddiv  as C8,
      @DefaultAggregation: #SUM
      Kgross*100 as K9,
      @DefaultAggregation: #SUM
      Kinc       as C9
} 
 