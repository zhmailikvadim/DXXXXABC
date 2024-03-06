/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SUFIYKON     | 13.04.2023 | 20028 Stock Reconciliation Summary       *
*              |            | DS4K949671                               *
************************************************************************/

@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Stock Reconciliation Summary SAP amounts'

define view entity zsd_i_stock_recon_summ_sap_amt
  as select from I_MaterialDocumentItem_2     as _mdocitem
    join         zsd_i_stock_recon_summ_bwart as _bwart on _bwart.goodsmovementtype = _mdocitem.GoodsMovementType
{
  key _mdocitem.PostingDate,
  key _mdocitem.CompanyCode,
  key _mdocitem.Plant,
  key _mdocitem.StorageLocation,
  key _mdocitem.MaterialBaseUnit,
  key _bwart.goodsmovementtypecategory,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(_mdocitem.QuantityInBaseUnit) as quantityinbaseunit
}
group by
  _mdocitem.PostingDate,
  _mdocitem.CompanyCode,
  _mdocitem.Plant,
  _mdocitem.StorageLocation,
  _mdocitem.MaterialBaseUnit,
  _bwart.goodsmovementtypecategory
