@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Reconciliation Summary - SAP amt'

define view entity zsd_i_stock_recon_summ_sap_amt
  as select from I_MaterialDocumentItem_2
{
  PostingDate,
  Plant,
  StorageLocation,
  
  case when GoodsMovementType = '251' then 'sale'
  
       when GoodsMovementType = '252' then 'return'
       
       when GoodsMovementType = '641'
       or GoodsMovementType = '643'
       or GoodsMovementType = '905'
       or GoodsMovementType = '551'
       or GoodsMovementType = '161'
       or GoodsMovementType = '702' then 'gi'
       
       when GoodsMovementType = '101'
       or GoodsMovementType = '552'
       or GoodsMovementType = '701' then 'gr'
  end as amttype,
  
  QuantityInBaseUnit,
  MaterialBaseUnit
}
where
     GoodsMovementType = '251'
  or GoodsMovementType = '252'
  or GoodsMovementType = '641'
  or GoodsMovementType = '643'
  or GoodsMovementType = '905'
  or GoodsMovementType = '551'
  or GoodsMovementType = '161'
  or GoodsMovementType = '702'
  or GoodsMovementType = '101'
  or GoodsMovementType = '552'
  or GoodsMovementType = '701'
