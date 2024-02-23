/*" -----------------------------------------------------------------------
"  R E V I S I O N   H I S T O R Y                                     -
" -----------------------------------------------------------------------
" AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              -
"              |            | TRANSPORT REQUESTS                       -
" -----------------------------------------------------------------------
" ZHMAIVAD     | 15.11.2023 | 22859     : Feature - Stock reconciliati -
"              |            | DS4K957133                               -
" -----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Document Data Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsd_i_mdreq_mate
  as select from zsd_t_mdreq_mate
{
  key msgguid,
  key version,
  key counter,
  key ns,
  key ifname,
  key ifver,
      parent_id,
      goods_movement_t,
      goods_recipient,
      material_documen,
      parent_material,
      material,
      global_trade_ite,
      batch,
      serial_idcreate,
      plant,
      storage_location,
      shelf_life_expir,
      manufacture_date,
      batch_by_supplie,
      stock_type,
      inventory_specia,
      inventory_valuat,
      customer,
      supplier,
      purchase_order,
      purchase_order_i,
      sales_order,
      sales_order_item,
      sales_order_it_2,
      manufacturing_or,
      manufacturing_2,
      delivery,
      delivery_item,
      is_compeletely_d,
      reservation,
      reservation_item,
      reservation_is_f,
      project_network,
      glaccount,
      cost_center,
      cost_object,
      profit_center,
      profitability_se,
      functional_area,
      wbselement,
      unloading_point,
      material_docum_2,
      goods_movement_r,
      goods_movement_2,
      issg_or_rcvg_mat,
      issg_or_rcvg_bat,
      issuing_or_recei,
      issuing_or_rec_2,
      issuing_or_rec_3,
      master_fixed_ass,
      fixed_asset,
      funds_management,
      funds_manageme_2,
      commitment_item,
      grant_2,
      invtry_mgmt_refe,
      reference_docume,
      invtry_mgmt_ref,
      material_docum_3,
      special_stock_id,
      zz1_sourcesaleso,
      zz1_wmstime_mmi,
      zz1_sourcesale_2,
      zz1_wmsdate_mmi,
      zzwms_timestamp,
      unit_code,
      sapunit_code,
      content,
      unit_code_2,
      sapunit_code_2,
      content_2
}
