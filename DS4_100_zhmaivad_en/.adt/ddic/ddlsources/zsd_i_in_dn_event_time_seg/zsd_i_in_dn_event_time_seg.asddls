/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 31.08.2022 |    13574  :  FB_13574_SD_Build - [BE] - Supply Demand Overview (S*
*              |            |    DS4K929761                           *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Supply,Demand Overview Inbound DN Events'
define view entity zsd_i_in_dn_event_time_seg
  as select distinct from vttp as _ShipmentItems
    inner join            vttk as _ShipmentHeaders        on _ShipmentItems.tknum = _ShipmentHeaders.tknum
    inner join            ZPE_I_HM( iv_id: '0000000485' ) on _ShipmentHeaders.shtyp = ZPE_I_HM.field1
  association [1..*] to zsd_i_tevents_for_inb_delivery as _Events on _ShipmentHeaders.handle = _Events.HandlerTimeEventSegment
{
  key _ShipmentItems.vbeln                                                                                                                          as InboundDeliveryNumber,
      _ShipmentHeaders.tknum                                                                                                                        as ShipmentNumber,

      //Vessel Departure
      cast(_Events[1:EventAlias = 'V_DEPT' and EventVersionType = '1'].EventTimeStartFromUTC   as zsd_actual_v_dept_eventstfr     preserving type ) as actual_v_dept_eventstfr,
      cast(_Events[1:EventAlias = 'V_DEPT' and EventVersionType = '1'].EventTimeStartFromTimeZone   as zsd_actual_v_dept_zonfr    preserving type ) as actual_v_dept_zonfr,

      //Vessel Arrival
      cast(_Events[1:EventAlias = 'V_ARR' and EventVersionType = '1'].EventTimeStartFromUTC    as zsd_actual_v_arr_eventstfr      preserving type ) as actual_v_arr_eventstfr,
      cast(_Events[1:EventAlias = 'V_ARR' and EventVersionType = '1'].EventTimeStartFromTimeZone    as zsd_actual_v_arr_zonfr     preserving type ) as actual_v_arr_zonfr,
      cast(_Events[1:EventAlias = 'V_ARR' and EventVersionType = '0'].EventTimeStartFromUTC    as zsd_plan_v_arr_eventstfr        preserving type ) as plan_v_arr_eventstfr,
      cast(_Events[1:EventAlias = 'V_ARR' and EventVersionType = '0'].EventTimeStartFromTimeZone    as zsd_plan_v_arr_zonfr       preserving type ) as plan_v_arr_zonfr,

      //Customs Release
      cast(_Events[1:EventAlias = 'C_RELEA' and EventVersionType = '1'].EventTimeStartFromUTC  as zsd_actual_c_relea_eventstfr    preserving type ) as actual_c_relea_eventstfr,
      cast(_Events[1:EventAlias = 'C_RELEA' and EventVersionType = '1'].EventTimeStartFromTimeZone  as zsd_actual_c_relea_zonfr   preserving type ) as actual_c_relea_zonfr,

      //Rail Loaded
      cast(_Events[1:EventAlias = 'R_LOAD' and EventVersionType = '1'].EventTimeStartFromUTC   as zsd_actual_r_load_eventstfr     preserving type ) as actual_r_load_eventstfr,
      cast(_Events[1:EventAlias = 'R_LOAD' and EventVersionType = '1'].EventTimeStartFromTimeZone   as zsd_actual_r_load_zonfr    preserving type ) as actual_r_load_zonfr,

      //Rail Unloaded
      cast(_Events[1:EventAlias = 'R_UNL' and EventVersionType = '1'].EventTimeStartFromUTC    as zsd_actual_r_unl_eventstfr      preserving type ) as actual_r_unl_eventstfr,
      cast(_Events[1:EventAlias = 'R_UNL' and EventVersionType = '1'].EventTimeStartFromTimeZone    as zsd_actual_r_unl_zonfr     preserving type ) as actual_r_unl_zonfr,
      cast(_Events[1:EventAlias = 'R_UNL' and EventVersionType = '0'].EventTimeStartFromUTC    as zsd_plan_r_unl_eventstfr        preserving type ) as plan_r_unl_eventstfr,
      cast(_Events[1:EventAlias = 'R_UNL' and EventVersionType = '0'].EventTimeStartFromTimeZone    as zsd_plan_r_unl_zonfr       preserving type ) as plan_r_unl_zonfr,

      //Truck Loaded
      cast(_Events[1:EventAlias = 'T_LOAD' and EventVersionType = '1'].EventTimeStartFromUTC   as zsd_actual_t_load_eventstfr     preserving type ) as actual_t_load_eventstfr,
      cast(_Events[1:EventAlias = 'T_LOAD' and EventVersionType = '1'].EventTimeStartFromTimeZone   as zsd_actual_t_load_zonfr    preserving type ) as actual_t_load_zonfr,

      //Truck Unloaded
      cast(_Events[1:EventAlias = 'T_UNL' and EventVersionType = '1'].EventTimeStartFromUTC    as zsd_actual_t_unl_eventstfr      preserving type ) as actual_t_unl_eventstfr,
      cast(_Events[1:EventAlias = 'T_UNL' and EventVersionType = '1'].EventTimeStartFromTimeZone    as zsd_actual_t_unl_zonfr     preserving type ) as actual_t_unl_zonfr,
      cast(_Events[1:EventAlias = 'T_UNL' and EventVersionType = '0'].EventTimeStartFromUTC    as zsd_plan_t_unl_eventstfr        preserving type ) as plan_t_unl_eventstfr,
      cast(_Events[1:EventAlias = 'T_UNL' and EventVersionType = '0'].EventTimeStartFromTimeZone    as zsd_plan_t_unl_zonfr       preserving type ) as plan_t_unl_zonfr,

      //Air Departure
      cast(_Events[1:EventAlias = 'AIR' and EventVersionType = '1'].EventTimeStartFromUTC      as zsd_actual_air_eventstfr        preserving type ) as actual_air_eventstfr,
      cast(_Events[1:EventAlias = 'AIR' and EventVersionType = '1'].EventTimeStartFromTimeZone      as zsd_actual_air_zonfr       preserving type ) as actual_air_zonfr,

      //Air Arrival
      cast(_Events[1:EventAlias = 'AIR_ARR' and EventVersionType = '1'].EventTimeStartFromUTC  as zsd_actual_air_arr_eventstfr    preserving type ) as actual_air_arr_eventstfr,
      cast(_Events[1:EventAlias = 'AIR_ARR' and EventVersionType = '1'].EventTimeStartFromTimeZone  as zsd_actual_air_arr_zonfr   preserving type ) as actual_air_arr_zonfr,
      cast(_Events[1:EventAlias = 'AIR_ARR' and EventVersionType = '0'].EventTimeStartFromUTC  as zsd_plan_air_arr_eventstfr      preserving type ) as plan_air_arr_eventstfr,
      cast(_Events[1:EventAlias = 'AIR_ARR' and EventVersionType = '0'].EventTimeStartFromTimeZone  as zsd_plan_air_arr_zonfr     preserving type ) as plan_air_arr_zonfr,

      //Arrival Container Yard
      cast(_Events[1:EventAlias = 'CNT_ARR' and EventVersionType = '1'].EventTimeStartFromUTC  as zsd_actual_cnt_arr_eventstfr    preserving type ) as actual_cnt_arr_eventstfr,
      cast(_Events[1:EventAlias = 'CNT_ARR' and EventVersionType = '1'].EventTimeStartFromTimeZone  as zsd_actual_cnt_arr_zonfr   preserving type ) as actual_cnt_arr_zonfr,
      cast(_Events[1:EventAlias = 'CNT_ARR' and EventVersionType = '0'].EventTimeStartFromUTC  as zsd_plan_cnt_arr_eventstfr      preserving type ) as plan_cnt_arr_eventstfr,
      cast(_Events[1:EventAlias = 'CNT_ARR' and EventVersionType = '0'].EventTimeStartFromTimeZone  as zsd_plan_cnt_arr_zonfr     preserving type ) as plan_cnt_arr_zonfr,

      //Departure Container Yard
      cast(_Events[1:EventAlias = 'CNT_DEP' and EventVersionType = '1'].EventTimeStartFromUTC  as zsd_actual_cnt_dep_eventstfr    preserving type ) as actual_cnt_dep_eventstfr,
      cast(_Events[1:EventAlias = 'CNT_DEP' and EventVersionType = '1'].EventTimeStartFromTimeZone  as zsd_actual_cnt_dep_zonfr   preserving type ) as actual_cnt_dep_zonfr,

      //mi adidas customer delivered
      cast(_Events[1:EventAlias = 'CUS_ARR' and EventVersionType = '1'].EventTimeStartFromUTC  as zsd_actual_cus_arr_eventstfr    preserving type ) as actual_cus_arr_eventstfr,
      cast(_Events[1:EventAlias = 'CUS_ARR' and EventVersionType = '1'].EventTimeStartFromTimeZone  as zsd_actual_cus_arr_zonfr   preserving type ) as actual_cus_arr_zonfr,

      //Rail Departure
      cast(_Events[1:EventAlias = 'R_DEPT' and EventVersionType = '1'].EventTimeStartFromUTC   as zsd_actual_r_dep_eventstfr      preserving type ) as actual_r_dep_eventstfr,
      cast(_Events[1:EventAlias = 'R_DEPT' and EventVersionType = '1'].EventTimeStartFromTimeZone   as zsd_actual_r_dep_zonfr     preserving type ) as actual_r_dep_zonfr,

      //Rail Arrival
      cast(_Events[1:EventAlias = 'R_ARR' and EventVersionType = '1'].EventTimeStartFromUTC    as zsd_actual_r_arr_eventstfr      preserving type ) as actual_r_arr_eventstfr,
      cast(_Events[1:EventAlias = 'R_ARR' and EventVersionType = '1'].EventTimeStartFromTimeZone    as zsd_actual_r_arr_zonfr     preserving type ) as actual_r_arr_zonfr,
      cast(_Events[1:EventAlias = 'R_ARR' and EventVersionType = '0'].EventTimeStartFromUTC    as zsd_plan_r_arr_eventstfr        preserving type ) as plan_r_arr_eventstfr,
      cast(_Events[1:EventAlias = 'R_ARR' and EventVersionType = '0'].EventTimeStartFromTimeZone    as zsd_plan_r_arr_zonfr       preserving type ) as plan_r_arr_zonfr,

      //Warehouse arrival
      cast(_Events[1:EventAlias = 'WHSE_ARR' and EventVersionType = '1'].EventTimeStartFromUTC as zsd_actual_whse_arr_eventstfr   preserving type ) as actual_whse_arr_eventstfr,
      cast(_Events[1:EventAlias = 'WHSE_ARR' and EventVersionType = '1'].EventTimeStartFromTimeZone as zsd_actual_whse_arr_zonfr  preserving type ) as actual_whse_arr_zonfr,
      cast(_Events[1:EventAlias = 'WHSE_ARR' and EventVersionType = '0'].EventTimeStartFromUTC as zsd_plan_whse_arr_eventstfr     preserving type ) as plan_whse_arr_eventstfr,
      cast(_Events[1:EventAlias = 'WHSE_ARR' and EventVersionType = '0'].EventTimeStartFromTimeZone as zsd_plan_whse_arr_zonfr    preserving type ) as plan_whse_arr_zonfr,

      //User manually assigned ETA
      cast(_Events[1:EventAlias = 'USER_ETA' and EventVersionType = '0'].EventTimeStartFromUTC as zsd_plan_user_eta_eventstfr     preserving type ) as plan_user_eta_eventstfr,
      cast(_Events[1:EventAlias = 'USER_ETA' and EventVersionType = '0'].EventTimeStartFromTimeZone as zsd_plan_user_eta_zonfr    preserving type ) as plan_user_eta_zonfr
}
