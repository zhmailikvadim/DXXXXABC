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
@EndUserText.label: 'Stock Reconciliation Summary'

define root view entity zsd_i_stock_recon_summ
  as select distinct from I_MaterialDocumentItem_2     as _mdocitem
    join                  zsd_i_stock_recon_summ_bwart as _bwart on _bwart.goodsmovementtype = _mdocitem.GoodsMovementType

  association [1..1] to I_CompanyCode                  as _companycode     on  _companycode.CompanyCode = $projection.CompanyCode

  association [1..1] to I_Plant                        as _plant           on  _plant.Plant = $projection.Plant

  association [1..1] to I_StorageLocation              as _storagelocation on  _storagelocation.Plant           = $projection.Plant
                                                                           and _storagelocation.StorageLocation = $projection.StorageLocation

  association [1..1] to zsd_i_stock_recon_summ_stk     as _stk             on  _stk.wmssnapshotdate  = $projection.wmssnapshotdate
                                                                           and _stk.CompanyCode      = $projection.CompanyCode
                                                                           and _stk.plant            = $projection.Plant
                                                                           and _stk.storagelocation  = $projection.StorageLocation
                                                                           and _stk.materialbaseunit = $projection.MaterialBaseUnit

  association [1..1] to zsd_i_stock_recon_summ_amt     as _pos             on  _pos.wmssnapshotdate  = $projection.wmssnapshotdate
                                                                           and _pos.CompanyCode      = $projection.CompanyCode
                                                                           and _pos.plant            = $projection.Plant
                                                                           and _pos.materialbaseunit = $projection.MaterialBaseUnit

  association [1..1] to zsd_i_stock_recon_summ_sap_amt as _sales           on  _sales.PostingDate               = $projection.wmssnapshotdate
                                                                           and _sales.CompanyCode               = $projection.CompanyCode
                                                                           and _sales.Plant                     = $projection.Plant
                                                                           and _sales.StorageLocation           = $projection.StorageLocation
                                                                           and _sales.MaterialBaseUnit          = $projection.MaterialBaseUnit
                                                                           and _sales.goodsmovementtypecategory = 'SLS'

  association [1..1] to zsd_i_stock_recon_summ_sap_amt as _return          on  _return.PostingDate               = $projection.wmssnapshotdate
                                                                           and _return.CompanyCode               = $projection.CompanyCode
                                                                           and _return.Plant                     = $projection.Plant
                                                                           and _return.StorageLocation           = $projection.StorageLocation
                                                                           and _return.MaterialBaseUnit          = $projection.MaterialBaseUnit
                                                                           and _return.goodsmovementtypecategory = 'RTR'

  association [1..1] to zsd_i_stock_recon_summ_sap_amt as _gi              on  _gi.PostingDate               = $projection.wmssnapshotdate
                                                                           and _gi.CompanyCode               = $projection.CompanyCode
                                                                           and _gi.Plant                     = $projection.Plant
                                                                           and _gi.StorageLocation           = $projection.StorageLocation
                                                                           and _gi.MaterialBaseUnit          = $projection.MaterialBaseUnit
                                                                           and _gi.goodsmovementtypecategory = 'GI'

  association [1..1] to zsd_i_stock_recon_summ_sap_amt as _gr              on  _gr.PostingDate               = $projection.wmssnapshotdate
                                                                           and _gr.CompanyCode               = $projection.CompanyCode
                                                                           and _gr.Plant                     = $projection.Plant
                                                                           and _gr.StorageLocation           = $projection.StorageLocation
                                                                           and _gr.MaterialBaseUnit          = $projection.MaterialBaseUnit
                                                                           and _gr.goodsmovementtypecategory = 'GR'
{
  key _mdocitem.PostingDate                   as wmssnapshotdate,
  key _mdocitem.CompanyCode,
  key _mdocitem.Plant,
  key _mdocitem.StorageLocation,
  key _mdocitem.MaterialBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      _stk.rfidstock,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      _stk.sapstock,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      abs(_stk.rfidstock - _stk.sapstock)     as stockdeltadiff,
      cast(case when _stk.rfidstock > _stk.sapstock
                then (_stk.rfidstock - _stk.sapstock) / _stk.rfidstock * 100
                when _stk.rfidstock < _stk.sapstock
                then (_stk.sapstock - _stk.rfidstock) / _stk.sapstock * 100
                else 0 end as abap.dec(5, 2)) as stockdeltadiffperc,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      _pos.possales,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      _pos.posreturn,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      _pos.posgi,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      _pos.posgr,

      _sales.quantityinbaseunit               as sapsales,
      _return.quantityinbaseunit              as sapreturn,
      _gi.quantityinbaseunit                  as sapgi,
      _gr.quantityinbaseunit                  as sapgr,

      0                                       as idocerrors,
      0                                       as interfaceerrors,

      _plant.PlantName,

      case when _stk.rfidstock - _stk.sapstock != 0
           then 1 else 0 end                  as stockdeltadiffcrit,

      case when $projection.idocerrors > 0
           then 1 else 0 end                  as idocerrorscrit,

      case when $projection.interfaceerrors > 0
           then 1 else 0 end                  as interfaceerrorscrit,

      case when _stk.rfidstock - _stk.sapstock != 0
           or $projection.idocerrorscrit = 1
           or $projection.interfaceerrorscrit = 1
           then 1 else 0 end                  as rowcrit,

      _companycode,
      _storagelocation
}
