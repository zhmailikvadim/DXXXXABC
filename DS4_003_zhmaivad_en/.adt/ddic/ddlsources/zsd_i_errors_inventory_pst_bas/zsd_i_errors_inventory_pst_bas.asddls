/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.03.2024 | 29314     : [Feature] [Build] - Stock re *
*              |            | DS4K982092                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Errors Inventory Postings Batch WMS->S4'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity zsd_i_errors_inventory_pst_bas
  as select from zsd_t_mdreq_mate as AifPersistentTable
    join         zsd_t_aif_mdreq  as _AifMessagesIndexTable on AifPersistentTable.msgguid = _AifMessagesIndexTable.msgguid
    join         I_Product        as Product                on AifPersistentTable.material = Product.Product
  association to zsd_i_move_types_rows as _MoveTypesAndStockTypes on _MoveTypesAndStockTypes.MoveType = $projection.MovementType
{
  key                  AifPersistentTable.msgguid                                                                                                          as Msgguid,
                       AifPersistentTable.zz1_wmsdate_mmi                                                                                                  as WmsDate,
                       AifPersistentTable.plant                                                                                                            as Plant,
                       AifPersistentTable.storage_location                                                                                                 as StorageLocation,
                       cast(left(AifPersistentTable.material,40)  as matnr preserving type )                                                               as Product,
                       AifPersistentTable.sales_order                                                                                                      as SalesOrder,
                       cast(cast(case when AifPersistentTable.sales_order_item = ''
                          then '000000' else AifPersistentTable.sales_order_item end as abap.numc( 6 )) as zsd_snapshot_sales_order_item preserving type ) as SalesOrderItem,
                       case when  coalesce(_MoveTypesAndStockTypes.StockType, '' ) = '' then
                         case when  AifPersistentTable.stock_type = 'F' or AifPersistentTable.stock_type = '' then 'UU'
                              when  AifPersistentTable.stock_type = 'S' or AifPersistentTable.stock_type = '3' then 'BL'
                              when  AifPersistentTable.stock_type = 'X' or AifPersistentTable.stock_type = '2' then 'QI'
                              else '' end else _MoveTypesAndStockTypes.StockType end                                                                       as StockType,
                       AifPersistentTable.goods_movement_t                                                                                                 as MovementType,
                       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
                       cast(AifPersistentTable.content  as abap.quan( 13, 3 ))                                                                             as Quantity,
                       AifPersistentTable.issuing_or_recei                                                                                                 as ReceivingPlant,
                       AifPersistentTable.issuing_or_rec_2                                                                                                 as ReceivingStorageLocation,
                       AifPersistentTable.issg_or_rcvg_mat                                                                                                 as ReceivingArticle,
                       _AifMessagesIndexTable.status,
                       AifPersistentTable.delivery                                                                                                         as ReceivingSalesOrder,
                       AifPersistentTable.delivery_item                                                                                                    as ReceivingSalesOrderItem,
                       AifPersistentTable.version                                                                                                          as PersistTableVersion,
                       AifPersistentTable.counter                                                                                                          as PersistTableCounter,
                       AifPersistentTable.ns                                                                                                               as AifNameSpace,
                       AifPersistentTable.ifname                                                                                                           as AifInterfaceName,
                       AifPersistentTable.ifver                                                                                                            as AifInterfaceVersion,
                       AifPersistentTable.sapunit_code                                                                                                     as SapunitCode,
                       AifPersistentTable.unit_code_2                                                                                                      as UnitCode2,
                       AifPersistentTable.sapunit_code_2                                                                                                   as SapunitCode2,
                       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
                       cast(AifPersistentTable.content_2  as abap.quan( 13, 3 ))                                                                           as Quantity2,
                       Product.BaseUnit,
                       AifPersistentTable.goods_recipient                                                                                                  as GoodsRecipient,
                       AifPersistentTable.material_documen                                                                                                 as MaterialDocumen,
                       AifPersistentTable.parent_material                                                                                                  as ParentMaterial,
                       AifPersistentTable.global_trade_ite                                                                                                 as GlobalTradeIte,
                       AifPersistentTable.batch                                                                                                            as Batch,
                       AifPersistentTable.purchase_order                                                                                                   as PurchaseOrder,
                       AifPersistentTable.purchase_order_i                                                                                                 as PurchaseOrderI,
                       AifPersistentTable.sales_order_it_2                                                                                                 as SalesOrderIt2,
                       AifPersistentTable.zzwms_timestamp                                                                                                  as ZzwmsTimestamp,
                       AifPersistentTable.version                                                                                                          as Version,
                       AifPersistentTable.counter                                                                                                          as Counter,
                       AifPersistentTable.ns                                                                                                               as Ns,
                       AifPersistentTable.ifname                                                                                                           as Ifname,
                       AifPersistentTable.ifver                                                                                                            as Ifver,
                       AifPersistentTable.parent_id                                                                                                        as ParentId,
                       AifPersistentTable.material                                                                                                         as Material,
                       AifPersistentTable.serial_idcreate                                                                                                  as SerialIdcreate,
                       AifPersistentTable.shelf_life_expir                                                                                                 as ShelfLifeExpir,
                       AifPersistentTable.manufacture_date                                                                                                 as ManufactureDate,
                       AifPersistentTable.batch_by_supplie                                                                                                 as BatchBySupplie,
                       AifPersistentTable.inventory_specia                                                                                                 as InventorySpecia,
                       AifPersistentTable.inventory_valuat                                                                                                 as InventoryValuat,
                       AifPersistentTable.customer                                                                                                         as Customer,
                       AifPersistentTable.supplier                                                                                                         as Supplier,
                       AifPersistentTable.manufacturing_or                                                                                                 as ManufacturingOr,
                       AifPersistentTable.manufacturing_2                                                                                                  as Manufacturing2,
                       AifPersistentTable.delivery                                                                                                         as Delivery,
                       AifPersistentTable.delivery_item                                                                                                    as DeliveryItem,
                       AifPersistentTable.is_compeletely_d                                                                                                 as IsCompeletelyD,
                       AifPersistentTable.reservation                                                                                                      as Reservation,
                       AifPersistentTable.reservation_item                                                                                                 as ReservationItem,
                       AifPersistentTable.reservation_is_f                                                                                                 as ReservationIsF,
                       AifPersistentTable.project_network                                                                                                  as ProjectNetwork,
                       AifPersistentTable.glaccount                                                                                                        as Glaccount,
                       AifPersistentTable.cost_center                                                                                                      as CostCenter,
                       AifPersistentTable.cost_object                                                                                                      as CostObject,
                       AifPersistentTable.profit_center                                                                                                    as ProfitCenter,
                       AifPersistentTable.profitability_se                                                                                                 as ProfitabilitySe,
                       AifPersistentTable.functional_area                                                                                                  as FunctionalArea,
                       AifPersistentTable.wbselement                                                                                                       as Wbselement,
                       AifPersistentTable.unloading_point                                                                                                  as UnloadingPoint,
                       AifPersistentTable.material_docum_2                                                                                                 as MaterialDocum2,
                       AifPersistentTable.goods_movement_r                                                                                                 as GoodsMovementR,
                       AifPersistentTable.goods_movement_2                                                                                                 as GoodsMovement2,
                       AifPersistentTable.issg_or_rcvg_bat                                                                                                 as IssgOrRcvgBat,
                       AifPersistentTable.issuing_or_rec_3                                                                                                 as IssuingOrRec3,
                       AifPersistentTable.master_fixed_ass                                                                                                 as MasterFixedAss,
                       AifPersistentTable.fixed_asset                                                                                                      as FixedAsset,
                       AifPersistentTable.funds_management                                                                                                 as FundsManagement,
                       AifPersistentTable.funds_manageme_2                                                                                                 as FundsManageme2,
                       AifPersistentTable.commitment_item                                                                                                  as CommitmentItem,
                       AifPersistentTable.grant_2                                                                                                          as Grant2,
                       AifPersistentTable.invtry_mgmt_refe                                                                                                 as InvtryMgmtRefe,
                       AifPersistentTable.reference_docume                                                                                                 as ReferenceDocume,
                       AifPersistentTable.invtry_mgmt_ref                                                                                                  as InvtryMgmtRef,
                       AifPersistentTable.material_docum_3                                                                                                 as MaterialDocum3,
                       AifPersistentTable.special_stock_id                                                                                                 as SpecialStockId,
                       AifPersistentTable.unit_code                                                                                                        as UnitCode,
                       AifPersistentTable.content                                                                                                          as Content,
                       AifPersistentTable.content_2                                                                                                        as Content2,
                       AifPersistentTable.zzwms_timestamp                                                                                                  as WmsTimeStamp,
                       AifPersistentTable.zz1_wmstime_mmi                                                                                                  as Wmstime,
                       replace_regexpr(pcre => '[^1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ]',
                       value => AifPersistentTable.msgguid,
                       with => '00000000000000000000000000000000',
                       result_length => 32  )                                                                                                              as MsgGuidRegex
}
where
  _AifMessagesIndexTable.status = 'E'
