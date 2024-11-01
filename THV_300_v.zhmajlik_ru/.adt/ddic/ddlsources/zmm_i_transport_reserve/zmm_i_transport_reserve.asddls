@AbapCatalog.sqlViewName: 'zmmitrreserve'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reserve For PK Transport'
@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    compositionRoot: true,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZMM_RESB',
    semanticKey: ['uuid'],
    representativeKey: 'uuid'
}
define view ZMM_I_TRANSPORT_RESERVE as select from zmm_resb {
      key uuid,
      rsnum,
      rspos,
      matnr,
      werks,
      lgort,
      charg,
      bdter,
      bwart,
      umwrk,
      umlgo,
      @Semantics.quantity.unitOfMeasure : 'meins'
      menge,
      meins,
      created
}


 