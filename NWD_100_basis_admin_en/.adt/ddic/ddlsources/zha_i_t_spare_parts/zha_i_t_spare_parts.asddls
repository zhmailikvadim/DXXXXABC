@AbapCatalog.sqlViewName: 'ZHA_ITQ_SPR_PRT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_SPARE_PARTS'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_SPARE_PARTS',
    semanticKey: ['matnr','werks','lgort'],
    representativeKey: ['matnr','werks','lgort']
//    createEnabled: true,
//    updateEnabled: true,
//    deleteEnabled: true
}

define view ZHA_I_T_SPARE_PARTS
  as select from ZHA_I_SPARE_PARTS
{
  key     matnr,
//          maktx_lower,
//          maktx_upper,
  key     werks,
  key     lgort,
          maktx,
          name1,
          lgobe,
          amount,
          meins,
          cost,
          waers
}
