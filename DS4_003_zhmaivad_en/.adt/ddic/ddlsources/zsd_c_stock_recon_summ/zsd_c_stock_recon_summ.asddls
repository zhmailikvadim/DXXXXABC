/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SUFIYKON     | 13.04.2023 | 20028 Stock Reconciliation Summary       *
*              |            | DS4K949671                               *
************************************************************************/

@VDM.viewType: #CONSUMPTION
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.semanticKey: ['Plant', 'wmssnapshotdate']
@Metadata.allowExtensions: true
@EndUserText.label: 'Stock Reconciliation Summary'

define root view entity zsd_c_stock_recon_summ
  provider contract transactional_query
  as projection on zsd_i_stock_recon_summ
{
  key wmssnapshotdate,
      @ObjectModel.foreignKey.association: '_companycode'
  key CompanyCode,
      @ObjectModel.text.element: ['PlantName']
  key Plant,
      @ObjectModel.foreignKey.association: '_storagelocation'
  key StorageLocation,
  key MaterialBaseUnit,

      rfidstock,
      sapstock,
      stockdeltadiff,
      stockdeltadiffperc,

      possales,
      posreturn,
      posgi,
      posgr,

      sapsales,
      sapreturn,
      sapgi,
      sapgr,

      idocerrors,
      interfaceerrors,

      PlantName,

      stockdeltadiffcrit,
      idocerrorscrit,
      interfaceerrorscrit,
      rowcrit,

      _companycode,
      _storagelocation
}
