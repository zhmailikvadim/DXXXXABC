/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Inventory Posting Errors Storage Plus'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_errors_inventory_btw_art
  as select from zsd_i_errors_inventory_pst_bas as Errors
    join         zsd_i_move_types               as MoveTypes on  MoveTypes.MoveTypeDecrease = Errors.MovementType
                                                             and MoveTypes.MoveNature       = 'A'

{
  key Errors.Msgguid,
      Errors.WmsDate,
      Errors.Plant,
      Errors.StorageLocation,
      Errors.Product,
      Errors.SalesOrder,
      Errors.SalesOrderItem,
      Errors.StockType,
      Errors.MovementType,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      Errors.Quantity,
      Errors.ReceivingArticle,
      Errors.BaseUnit
}
