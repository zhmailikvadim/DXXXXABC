@EndUserText.label: 'Sum of IDOC Errors'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zsd_i_idoc_errors_sum
  as select from zsd_i_idoc_errors
  association to I_Product as _Product on zsd_i_idoc_errors.Article = _Product.Product
{
  key    IdocCreateDate,
  key    Article,
  key    Plant,
  key    StorageLocation,
         _Product.BaseUnit                                                      as BaseUnit,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         sum (cast(cast(Quantity as abap.numc( 17 ) ) as abap.quan( 17, 0 ) ) ) as Quantity
}
group by
  IdocCreateDate,
  Plant,
  StorageLocation,
  Article,
  _Product.BaseUnit,
  StorageLocation
