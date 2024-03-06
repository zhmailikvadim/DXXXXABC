/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.03.2024 | 29314     : [Feature] [Build] - Stock re *
*              |            | DS4K982092                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 28.03.2024 | 30550     : [Feature] [Build] - Stock re -
"              |            | DS4K985335                                -
" ----------------------------------------------------------------------*/
@EndUserText.label: 'Errors Inventory Postings Batch WMS->S4'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity zsd_i_errors_inventory_pst_asc
  as select from zsd_i_errors_inventory_pst_bas
{
  key Msgguid,
      Product,
      Plant,
      StockType,
      Quantity,
      MovementType,
      Batch,
      WmsDate,
      Wmstime,
      WmsTimeStamp,
      BaseUnit,
      CostCenter,
      CostObject,
      InvtryMgmtRefe,
      ReferenceDocume,
      Glaccount,
      GlobalTradeIte,
      SerialIdcreate,
      Ns,
      Ifname,
      Ifver,
      InvtryMgmtRef,
      ManufacturingOr,
      Manufacturing2,
      MaterialDocum3,
      ProfitCenter,
      ProfitabilitySe,
      ReceivingStorageLocation,
      SalesOrder,
      SalesOrderIt2,
      SalesOrderItem
}
