@Metadata.ignorePropagatedAnnotations: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Reconciliation Summary'

define view entity zsd_i_stock_recon_summ
  as select distinct from I_MaterialDocumentItem_2
  association [1..*] to zsd_i_stock_recon_summ_sap_amt as _sale on  _sale.PostingDate    = $projection.WmsSnapshotDate
                                                                and _sale.Plant           = $projection.Plant
                                                                and _sale.StorageLocation = $projection.StorageLocation
                                                                and _sale.amttype         = 'sale'

{
  key PostingDate                  as WmsSnapshotDate,
  key Plant,
  key StorageLocation,
  MaterialBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum(_sale.QuantityInBaseUnit) as saleamt
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
group by
  PostingDate,
  Plant,
  StorageLocation,
  MaterialBaseUnit
