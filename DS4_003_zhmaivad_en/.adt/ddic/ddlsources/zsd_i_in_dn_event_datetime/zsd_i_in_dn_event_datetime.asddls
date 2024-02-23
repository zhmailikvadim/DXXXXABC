/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 20.09.2022 |    13574  :  FB_13574_SD_Build - [BE] - Supply Demand Overview (S*
*              |            |    DS4K929761                            *
* ZUJSKAS      | 09.03.2022 |    15340  :  FB_15340_SD_Build - Supply Demand Overview (SDO) Enh
*              |            |    DS4K935546                            *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SD OverVw - Inbound Events Date and Time'
define view entity zsd_i_in_dn_event_datetime
  as select from zsd_i_in_dn_event_time_seg
{
  key InboundDeliveryNumber,
      ShipmentNumber,

      cast(tstmp_to_dats(actual_v_dept_eventstfr, actual_v_dept_zonfr, $session.client, 'INITIAL')      as zsd_act_vess_depart_start_date preserving type )  as actual_v_dept_eventstfr_date,
      cast(tstmp_to_tims( actual_v_dept_eventstfr,actual_v_dept_zonfr, $session.client, 'INITIAL')      as zsd_act_vess_depart_start_time preserving type )  as actual_v_dept_eventstfr_time,
      cast(actual_v_dept_zonfr as zsd_act_vess_depart_start_tz preserving type )                                                                             as actual_v_dept_zonfr,
      actual_v_dept_eventstfr,

      cast(tstmp_to_dats(actual_v_arr_eventstfr, actual_v_arr_zonfr, $session.client, 'INITIAL')        as zsd_act_vess_arriv_start_date preserving type )   as actual_v_arr_eventstfr_date,
      cast(tstmp_to_tims( actual_v_arr_eventstfr,actual_v_arr_zonfr, $session.client, 'INITIAL')        as zsd_act_vess_arriv_start_time preserving type )   as actual_v_arr_eventstfr_time,
      cast(actual_v_arr_zonfr as zsd_act_vess_arr_start_tz preserving type )                                                                                 as actual_v_arr_zonfr,
      actual_v_arr_eventstfr,

      cast(tstmp_to_dats(plan_v_arr_eventstfr, plan_v_arr_zonfr, $session.client, 'INITIAL')            as zsd_plan_vess_arriv_start_date preserving type )  as plan_v_arr_eventstfr_date,
      cast(tstmp_to_tims( plan_v_arr_eventstfr,plan_v_arr_zonfr, $session.client, 'INITIAL')            as zsd_plan_vess_arriv_start_time preserving type )  as plan_v_arr_eventstfr_time,
      cast(plan_v_arr_zonfr as zsd_plan_vess_arriv_start_tz preserving type )                                                                                as plan_v_arr_zonfr,
      plan_v_arr_eventstfr,

      cast(tstmp_to_dats(actual_c_relea_eventstfr, actual_c_relea_zonfr, $session.client, 'INITIAL')    as zsd_act_cust_releas_start_date preserving type )  as actual_c_relea_eventstfr_date,
      cast(tstmp_to_tims( actual_c_relea_eventstfr,actual_c_relea_zonfr, $session.client, 'INITIAL')    as zsd_act_cust_releas_start_time preserving type )  as actual_c_relea_eventstfr_time,
      cast(plan_v_arr_zonfr as zsd_act_cust_releas_start_tz preserving type )                                                                                as actual_c_relea_zonfr,
      actual_c_relea_eventstfr,

      cast(tstmp_to_dats(actual_r_load_eventstfr, actual_r_load_zonfr, $session.client, 'INITIAL')      as zsd_act_rail_load_start_date preserving type )    as actual_r_load_eventstfr_date,
      cast(tstmp_to_tims( actual_r_load_eventstfr,actual_r_load_zonfr, $session.client, 'INITIAL')      as zsd_act_rail_load_start_time preserving type )    as actual_r_load_eventstfr_time,
      cast(actual_r_load_zonfr as zsd_act_rail_load_start_tz preserving type )                                                                               as actual_r_load_zonfr,
      actual_r_load_eventstfr,

      cast(tstmp_to_dats(actual_r_unl_eventstfr, actual_r_unl_zonfr, $session.client, 'INITIAL')        as zsd_act_rail_unload_start_date preserving type )  as actual_r_unload_eventstfr_date,
      cast(tstmp_to_tims( actual_r_unl_eventstfr,actual_r_unl_zonfr, $session.client, 'INITIAL')        as zsd_act_rail_unload_start_time preserving type )  as actual_r_unload_eventstfr_time,
      cast(actual_r_unl_zonfr as zsd_act_rail_unload_start_tz preserving type )                                                                              as actual_r_unl_zonfr,
      actual_r_unl_eventstfr,

      cast(tstmp_to_dats(plan_r_unl_eventstfr, plan_r_unl_zonfr, $session.client, 'INITIAL')            as zsd_plan_rail_unld_start_date preserving type )   as plan_r_unl_eventstfr_date,
      cast(tstmp_to_tims( plan_r_unl_eventstfr,plan_r_unl_zonfr, $session.client, 'INITIAL')            as zsd_plan_rail_unld_start_time preserving type )   as plan_r_unl_eventstfr_time,
      cast(plan_r_unl_zonfr as zsd_plan_rail_unld_start_tz preserving type )                                                                                 as plan_r_unl_zonfr,
      plan_r_unl_eventstfr,

      cast(tstmp_to_dats(actual_t_load_eventstfr, actual_t_load_zonfr, $session.client, 'INITIAL')      as zsd_act_truck_load_start_date preserving type )   as actual_t_load_eventstfr_date,
      cast(tstmp_to_tims( actual_t_load_eventstfr,actual_t_load_zonfr, $session.client, 'INITIAL')      as zsd_act_truck_load_start_time preserving type )   as actual_t_load_eventstfr_time,
      cast(actual_t_load_zonfr as zsd_act_truck_load_start_tz preserving type )                                                                              as actual_t_load_zonfr,
      actual_t_load_eventstfr,

      cast(tstmp_to_dats(actual_t_unl_eventstfr, actual_t_unl_zonfr, $session.client, 'INITIAL')        as zsd_act_trck_unload_start_date preserving type )  as actual_t_unl_eventstfr_date,
      cast(tstmp_to_tims( actual_t_unl_eventstfr,actual_t_unl_zonfr, $session.client, 'INITIAL')        as zsd_act_trck_unload_start_time preserving type )  as actual_t_unl_eventstfr_time,
      cast(actual_t_unl_zonfr as zsd_act_trck_unload_start_tz preserving type )                                                                              as actual_t_unl_zonfr,
      actual_t_unl_eventstfr,

      cast(tstmp_to_dats(plan_t_unl_eventstfr, plan_t_unl_zonfr, $session.client, 'INITIAL')            as zsd_plan_truck_unl_start_date preserving type )   as plan_t_unl_eventstfr_date,
      cast(tstmp_to_tims( plan_t_unl_eventstfr,plan_t_unl_zonfr, $session.client, 'INITIAL')            as zsd_plan_truck_unl_start_time preserving type )   as plan_t_unl_eventstfr_time,
      cast(actual_t_unl_zonfr as zsd_plan_truck_unl_start_tz preserving type )                                                                               as plan_t_unl_zonfr,
      plan_t_unl_eventstfr,

      cast(tstmp_to_dats(actual_air_eventstfr, actual_air_zonfr, $session.client, 'INITIAL')            as zsd_act_air_depart_start_date preserving type )   as actual_air_eventstfr_date,
      cast(tstmp_to_tims( actual_air_eventstfr,actual_air_zonfr, $session.client, 'INITIAL')            as zsd_act_air_depart_start_time preserving type )   as actual_air_eventstfr_time,
      cast(actual_air_zonfr as zsd_act_air_depart_start_tz preserving type )                                                                                 as actual_air_zonfr,
      actual_air_eventstfr,

      cast(tstmp_to_dats(actual_air_arr_eventstfr, actual_air_arr_zonfr, $session.client, 'INITIAL')    as zsd_actual_air_arr_start_date preserving type )   as actual_air_arr_eventstfr_date,
      cast(tstmp_to_tims( actual_air_arr_eventstfr,actual_air_arr_zonfr, $session.client, 'INITIAL')    as zsd_actual_air_arr_start_time preserving type )   as actual_air_arr_eventstfr_time,
      cast(actual_air_arr_zonfr as zsd_actual_air_arr_start_tz preserving type )                                                                             as actual_air_arr_zonfr,
      actual_air_arr_eventstfr,

      cast(tstmp_to_dats(plan_air_arr_eventstfr, plan_air_arr_zonfr, $session.client, 'INITIAL')        as zsd_plan_air_arriv_start_date preserving type )   as plan_air_arr_eventstfr_date,
      cast(tstmp_to_tims( plan_air_arr_eventstfr,plan_air_arr_zonfr, $session.client, 'INITIAL')        as zsd_plan_air_arriv_start_time preserving type )   as plan_air_arr_eventstfr_time,
      cast(plan_air_arr_zonfr as zsd_plan_air_arriv_start_tz preserving type )                                                                               as plan_air_arr_zonfr,
      plan_air_arr_eventstfr,

      cast(tstmp_to_dats(actual_cnt_arr_eventstfr, actual_cnt_arr_zonfr, $session.client, 'INITIAL')    as zsd_act_cont_arriv_start_date preserving type )   as actual_cnt_arr_eventstfr_date,
      cast(tstmp_to_tims( actual_cnt_arr_eventstfr,actual_cnt_arr_zonfr, $session.client, 'INITIAL')    as zsd_act_cont_arriv_start_time preserving type )   as actual_cnt_arr_eventstfr_time,
      cast(plan_air_arr_zonfr as zsd_act_cont_arriv_start_tz preserving type )                                                                               as actual_cnt_arr_zonfr,
      actual_cnt_arr_eventstfr,

      cast(tstmp_to_dats(plan_cnt_arr_eventstfr, plan_cnt_arr_zonfr, $session.client, 'INITIAL')        as zsd_plan_cnt_arr_start_date preserving type )     as plan_cnt_arr_eventstfr_date,
      cast(tstmp_to_tims( plan_cnt_arr_eventstfr,plan_cnt_arr_zonfr, $session.client, 'INITIAL')        as zsd_plan_cnt_arr_start_time preserving type )     as plan_cnt_arr_eventstfr_time,
      cast(plan_cnt_arr_zonfr as zsd_plan_cnt_arr_start_tz preserving type )                                                                                 as plan_cnt_arr_zonfr,
      plan_cnt_arr_eventstfr,

      cast(tstmp_to_dats(actual_cnt_dep_eventstfr, actual_cnt_dep_zonfr, $session.client, 'INITIAL')    as zsd_actual_cnt_dep_start_date preserving type )   as actual_cnt_dep_eventstfr_date,
      cast(tstmp_to_tims( actual_cnt_dep_eventstfr,actual_cnt_dep_zonfr, $session.client, 'INITIAL')    as zsd_actual_cnt_dep_start_time preserving type )   as actual_cnt_dep_eventstfr_time,
      cast(actual_cnt_dep_zonfr as zsd_actual_cnt_dep_start_tz preserving type )                                                                             as actual_cnt_dep_zonfr,
      actual_cnt_dep_eventstfr,

      cast(tstmp_to_dats(actual_cus_arr_eventstfr, actual_cus_arr_zonfr, $session.client, 'INITIAL')     as zsd_act_customr_arr_start_date preserving type ) as actual_cus_arr_eventstfr_date,
      cast(tstmp_to_tims( actual_cus_arr_eventstfr,actual_cus_arr_zonfr, $session.client, 'INITIAL')     as zsd_act_customr_arr_start_time preserving type ) as actual_cus_arr_eventstfr_time,
      cast(actual_cus_arr_zonfr as zsd_act_customr_arr_start_tz preserving type )                                                                            as actual_cus_arr_zonfr,
      actual_cus_arr_eventstfr,

      cast(tstmp_to_dats(actual_r_dep_eventstfr, actual_r_dep_zonfr, $session.client, 'INITIAL')         as zsd_act_rail_depart_start_date preserving type ) as actual_r_dep_eventstfr_date,
      cast(tstmp_to_tims( actual_r_dep_eventstfr,actual_r_dep_zonfr, $session.client, 'INITIAL')         as zsd_act_rail_depart_start_time preserving type ) as actual_r_dep_eventstfr_time,
      cast(actual_r_dep_zonfr as zsd_act_rail_depart_start_tz preserving type )                                                                              as actual_r_dep_zonfr,
      actual_r_dep_eventstfr,

      cast(tstmp_to_dats(actual_r_arr_eventstfr, actual_r_arr_zonfr, $session.client, 'INITIAL')         as zsd_act_rail_arriv_start_date preserving type )  as actual_r_arr_eventstfr_date,
      cast(tstmp_to_tims( actual_r_arr_eventstfr,actual_r_arr_zonfr, $session.client, 'INITIAL')         as zsd_act_rail_arriv_start_time preserving type )  as actual_r_arr_eventstfr_time,
      cast(actual_r_arr_zonfr as zsd_act_rail_arriv_start_tz preserving type )                                                                               as actual_r_arr_zonfr,
      actual_r_arr_eventstfr,

      cast(tstmp_to_dats(plan_r_arr_eventstfr, plan_r_arr_zonfr, $session.client, 'INITIAL')             as zsd_plan_rail_arriv_start_date preserving type ) as plan_r_arr_eventstfr_date,
      cast(tstmp_to_tims( plan_r_arr_eventstfr,plan_r_arr_zonfr, $session.client, 'INITIAL')             as zsd_plan_rail_arriv_start_time preserving type ) as plan_r_arr_eventstfr_time,
      cast(plan_r_arr_zonfr as zsd_plan_rail_arriv_start_tz preserving type )                                                                                as plan_r_arr_zonfr,
      plan_r_arr_eventstfr,

      cast(tstmp_to_dats(actual_whse_arr_eventstfr, actual_whse_arr_zonfr, $session.client, 'INITIAL')   as zsd_act_whse_arriv_start_date preserving type )  as actual_whse_arr_eventstfr_date,
      cast(tstmp_to_tims( actual_whse_arr_eventstfr,actual_whse_arr_zonfr, $session.client, 'INITIAL')   as zsd_act_whse_arriv_start_time preserving type )  as actual_whse_arr_eventstfr_time,
      cast(actual_whse_arr_zonfr as zsd_act_whse_arriv_start_tz preserving type )                                                                            as actual_whse_arr_zonfr,
      actual_whse_arr_eventstfr,

      cast(tstmp_to_dats(plan_whse_arr_eventstfr, plan_whse_arr_zonfr, $session.client, 'INITIAL')       as zsd_plan_whse_arriv_start_date preserving type ) as plan_whse_arr_eventstfr_date,
      cast(tstmp_to_tims( plan_whse_arr_eventstfr,plan_whse_arr_zonfr, $session.client, 'INITIAL')       as zsd_plan_whse_arriv_start_time preserving type ) as plan_whse_arr_eventstfr_time,
      cast(plan_whse_arr_zonfr as zsd_plan_whse_arriv_start_tz preserving type )                                                                             as plan_whse_arr_zonfr,
      plan_whse_arr_eventstfr,

      cast(tstmp_to_dats(plan_user_eta_eventstfr, plan_user_eta_zonfr, $session.client, 'INITIAL')       as zsd_plan_user_eta_start_date preserving type )   as plan_user_eta_eventstfr_date,
      cast(tstmp_to_tims( plan_user_eta_eventstfr,plan_user_eta_zonfr, $session.client, 'INITIAL')       as zsd_plan_user_eta_start_time preserving type )   as plan_user_eta_eventstfr_time,
      cast(plan_user_eta_zonfr as zsd_plan_user_eta_start_tz preserving type )                                                                               as plan_user_eta_zonfr,
      plan_user_eta_eventstfr
}
