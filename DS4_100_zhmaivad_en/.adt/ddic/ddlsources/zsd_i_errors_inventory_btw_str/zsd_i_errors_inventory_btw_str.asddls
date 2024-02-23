@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Inventory Posting Errors Storage Plus'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_errors_inventory_btw_str
  as select from zsd_i_errors_inventory_pst_bas as Errors
    join         zsd_i_move_types               as MoveTypes on  MoveTypes.MoveTypeDecrease = Errors.MovementType
                                                             and MoveTypes.MoveNature       = 'S'

{
  key Errors.Plant,
  key Errors.StorageLocation,
  key Errors.Product,
  key Errors.SalesOrder,
  key Errors.SalesOrderItem,
  key Errors.StockType,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum(Errors.Quantity) as Quantity,
      Errors.ReceivingLgort,
      Errors.BaseUnit
}
group by
  Errors.Plant,
  Errors.StorageLocation,
  Errors.Product,
  Errors.SalesOrder,
  Errors.SalesOrderItem,
  Errors.StockType,
  Errors.ReceivingLgort,
  Errors.BaseUnit