@AbapCatalog.sqlViewName: 'ZHA_ITQ_PRTNRS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for item ZHA_I_PARTNERS'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_PARTNERS',
    semanticKey: ['kunnr'],
    representativeKey: 'kunnr',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_PARTNERS
  as select from ZHA_I_PARTNERS
{
  key kunnr,
      land1,
      landx,
      name1,
      name2,
      ort01,
      pstlz, 
   //   regio,
      bland,
      sortl,
      stras,
      telf1,
      smtp_addr,
      kdgrp,
      ktext,
      adrnr,
      bankl,
      iban,
      banka
   //   Partner

}
