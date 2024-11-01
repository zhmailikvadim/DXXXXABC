@AbapCatalog.sqlViewName: 'ZHA_I_Q_PRTNRS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZZHA_D_PARTNERS DB table'

define view ZHA_I_PARTNERS
  as select from zha_d_partners
{
  key kunnr,
      land1,
      landx,
      name1,
      name2,
      ort01,
      pstlz,
    //  regio,
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
      banka,
      @UI: {
      lineItem: [ { label: 'Партнёр' } ],
      selectionField: [ { position: 10 }  ],
      identification:[ { position: 30, label: 'Партнёр' } ] }
      @EndUserText.label: 'Партнёр'  
      upper(name1) as Partner
}
