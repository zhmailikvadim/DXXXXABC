/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Errors(SUM) Inventory Postings WMS to S4'
@AccessControl.authorizationCheck: #CHECK
define view entity zsd_i_errors_inventory_pst_sum
  as select from zsd_i_errors_inventory_pst_aif
{
  key Plant,
  key StorageLocation,
  key Product,
  key StockType,
      BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum(Quantity) as Quantity
}
group by
  Plant,
  StorageLocation,
  Product,
  StockType,
  BaseUnit
