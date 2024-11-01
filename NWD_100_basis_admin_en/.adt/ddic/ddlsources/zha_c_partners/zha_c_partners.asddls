@AbapCatalog.sqlViewName: 'ZHA_CQ_PRTNRS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for item ZHA_I_T_PARTNER'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['kunnr'],
    representativeKey: 'kunnr'
//    updateEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'kunnr',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Партнёр',typeNamePlural: 'Партнёры'}
@Search.searchable: true

define view ZHA_C_PARTNERS
  as select from ZHA_I_T_PARTNERS

{
      @UI.lineItem: { position: 10, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
  key kunnr,

      @UI.hidden: true
      land1,

      @UI.lineItem: { position: 20, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      name1,

      @UI.lineItem: {label:'Страна', position: 30, importance: #HIGH }
      landx,

      @UI.hidden: true
      name2,

      @UI.lineItem: { position: 40, importance: #HIGH }
      pstlz,

      @UI.lineItem: { position: 50, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      ort01,

      @UI.lineItem: { position: 60, importance: #HIGH }
      bland,

      @UI.lineItem: { position: 70, importance: #HIGH }
      stras,

      @UI.lineItem: { position: 80, importance: #LOW }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      sortl,

      @UI.lineItem: { position: 90, importance: #HIGH }
      bankl,

      @UI.lineItem: { position: 100, importance: #HIGH }
      iban,

      @UI.lineItem: { position: 110, importance: #HIGH }
      banka,

      @UI.lineItem: { position: 120, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      ktext,

      @UI.lineItem: { position: 130, importance: #HIGH }
      telf1,

      @UI.lineItem: { position: 140, importance: #HIGH }
      smtp_addr,

      @UI.hidden: true
      kdgrp,

      @UI.hidden: true
      adrnr

    /*  @UI.hidden: true
      @UI.lineItem: { label: 'Партнёр' }
      Partner*/

}
